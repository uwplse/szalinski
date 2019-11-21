// Diameter of the wire hoop which the cat tunnel is made of
tunnelDiameter = 330;
// Detail ($fn, number of vertices) of the tunnel diameter
tunnelDetail = 800;

// Stand Width (need to be able to fit diagonally on build plate)
standWidth = 254;
// Thickness of vertical piece
standThickness = 5;
// Thickness of bottom platform
platformThickness = 2;
// Radius of curved edges on bottom platform
platformRadius = 20;

// Split with rectangular profile allows flexing for inserting the wire ring
splitGrooveWidth = 1.5;
// How far beyond circular wire groove does the split extend
splitGrooveDepth = 4;

// Thickness of the wire itself which the cat tunnel is made of
wireGrooveDiameter = 3;
// How far below edge should the wire groove sit
wireGrooveExtraDepth = 1;
// Detail ($fn, number of vertices) of the small wire groove
wireGrooveDetail = 30;


s2 = standWidth/2-platformRadius;
pr2 = platformRadius / sqrt(2);

r0 = tunnelDiameter/2 - (wireGrooveExtraDepth + wireGrooveDiameter / 2);
r1 = tunnelDiameter/2 + wireGrooveDiameter/2 + splitGrooveDepth;
r2 = r1 - sqrt(pow(r1,2) - pow(standWidth/2-platformRadius+standThickness*sqrt(2), 2));

rotate([0,0,45]) {
  difference() {
    union() {
      translate([0,0,tunnelDiameter/4])                     
        cube([standWidth, standThickness, tunnelDiameter / 2], center=true); // vertical stand plate
      translate([standWidth/2 - platformRadius,0,0]) rotate([0,0,45]) 
        translate([-standThickness/2,0,0]) 
          cube([standThickness,sqrt(2)*r2, tunnelDiameter/2]); // support rib
      translate([-standWidth/2 + platformRadius,0,0]) rotate([0,0,-45]) 
        translate([-standThickness/2,0,0]) 
          cube([standThickness,sqrt(2)*r2, tunnelDiameter/2]); // support rib
      linear_extrude(height = platformThickness) {          // bottom platform
        difference() {
          union() {
            polygon([[-s2 - pr2, pr2],[-pr2, s2 + pr2],[pr2, s2 + pr2], [s2 + pr2, pr2], [s2,0], [-s2,0]]);
            translate([s2,0,0]) circle(r = platformRadius, $fn=tunnelDetail/4);
            translate([-s2,0,0]) circle(r = platformRadius,$fn=tunnelDetail/4);
            translate([0,s2,0]) circle(r = platformRadius, $fn=tunnelDetail/4);
          }
          translate([0,-(standWidth+.02)/2]) square(standWidth+.02, center=true);
        }
      }
    }
    translate([0,0,r2+platformThickness+0.02] )rotate([0,90,0]) // radius on support rib
      translate([0,r2 + standThickness/2 + 0.02,0]) cylinder(h = standWidth, r = r2, center=true, $fn=tunnelDetail/4);
    rotate([90,0,0]) translate([0,r1-splitGrooveDepth+1,0]) {
      union() {
        cylinder(h = splitGrooveWidth, r = r1, center=true, $fn=tunnelDetail); // rectangular split groove 
        cylinder(h = standWidth*2, r = r0, center=true, $fn=tunnelDetail);  // tunnel profile cutout
        rotate_extrude(convexity = 10, $fn=tunnelDetail)                    // circular wire groove
          translate([tunnelDiameter/2,0,0]) circle(d = wireGrooveDiameter, $fn=wireGrooveDetail);
      }
    }
  }
}