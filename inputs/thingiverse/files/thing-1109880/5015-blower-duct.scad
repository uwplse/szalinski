/* [Fan Duct General] */
// Dimensions of fan duct outlet
tipLength = 30;
tipWidth = 3;
// How far from elbow is the tip?
tipDistance = 30;

// Choose duct angle
elbowAngle = 90;
elbowInnerRadius = 0.01;

// thickess of printed duct
thickness = 1.2;

/* [Fan Duct Advanced] */
// Length and width of the outlet on the fan itself
outerLength = 20;
outerWidth = 15.15;

// Location and dimensions of notch for snap fit.  Don't change unless different fan type
notchLength = 10.85; 
notchWidth = 1.9;
// Notch is not centered, this value represents how far from center it is
notchOffset = 0.91; 
notchFromEdge = 1;
notchClearance = 0.5;

// Offsets for center of fan for relief cut into fan duct
cy = 25;
cz = 25;
r = 22.5;

// Level of detail
$fn=200;


/* [Mount Settings] */
// Total thickness
mountThickness = 6;
// Distance between fan bolt and base bolt
separation = 25;

// Circle on base side
baseMountDiameter = 20;
// Bolt hole with some clearance
baseBoltDiameter = 5.4;
// Thickness under bolt head
baseBoltHeight = 3;
// Bolt head diameter plus clearance
baseBoltCounterbore = 10;

// Circle on fan side
fanMountDiameter = 11;
// Bolt hole with some clearance
fanBoltDiameter = 4.4;
// Distance between flats
nutDiameter = 7;
// Thickness under nut
nutHeight = 2;


tipAngle = asin((outerWidth - tipWidth) / tipDistance);


fanDuct();
translate([0,-50]) fanMount();


module ductInner() {
  square([outerWidth, outerLength]);  
}

module ductOuter() {
  translate([-thickness,-thickness]) square([outerWidth + thickness*2, outerLength + thickness * 2]);  
}

module nozzleTipInner() {
  translate([-tipWidth/2,0]) square([tipWidth, tipLength]);  
}

module nozzleTipOuter() {
  th = thickness / cos(tipAngle);
  translate([-tipWidth/2-th,-thickness]) square([tipWidth + th*2, tipLength + thickness*2]);  
}

module snapFit() {
  difference(){
    translate([-outerWidth/2,0]) 
      linear_extrude(notchFromEdge+notchClearance/2+notchLength+2) 
        difference() {
          ductOuter();
          ductInner();
        }
    translate([-(notchWidth+notchClearance)/2-notchOffset,-notchLength/2,notchFromEdge-notchClearance/2]) 
      cube([notchWidth+notchClearance,outerLength/2,notchLength+notchClearance]);
    translate([0,cy,cz]) 
      rotate([0,90,0]) cylinder(r=r, h=outerWidth*2,center=true);
  }
}

module elbow() {
  x = (outerWidth+thickness*2+elbowInnerRadius)*2;
  translate([-elbowInnerRadius-outerWidth/2-thickness,0]) 
    difference() {
      rotate([-90,0,0])
        rotate_extrude(convexity=10) 
          translate([elbowInnerRadius+thickness,0,0]) difference() {
              ductOuter();
              ductInner();
            }
      translate([0,0,x/2]) cube([x,(outerLength+thickness*2)*2,x], center=true);
      rotate([0,elbowAngle-90,0]) translate([-x/2,0,0]) cube([x,(outerLength+thickness*2)*2,x], center=true);
    }
}

module nozzle() {
  translate([-elbowInnerRadius-thickness-outerWidth/2,0]) 
  rotate([0,elbowAngle,0])
  translate([elbowInnerRadius+thickness,0,0])   
  difference() {
    hull() {
      linear_extrude(0.02) ductOuter();
      translate([outerWidth-cos(tipAngle)*(tipWidth)/2,(outerLength-tipLength)/2,-tipDistance]) 
        rotate([0,-tipAngle,0]) 
          linear_extrude(0.02) nozzleTipOuter();
    }
    hull() {
      linear_extrude(0.02) ductInner();
      translate([outerWidth-cos(tipAngle)*tipWidth/2,(outerLength-tipLength)/2,-tipDistance]) 
        rotate([0,-tipAngle,0]) // angle the tip
          translate([0,0,-0.01]) linear_extrude(0.02) nozzleTipInner();
    }
  }
}


module fanDuct() {
  rotate([0,90-elbowAngle,0]) {
    snapFit();
    elbow();
    nozzle();
  }
}

module fanMount() { 
  difference() {
    linear_extrude(mountThickness)
    difference() {
      hull() {
        circle(d=baseMountDiameter);
        translate([separation,0]) circle(d=fanMountDiameter);
      }
      circle(d=baseBoltDiameter);
      translate([separation,0]) circle(d=fanBoltDiameter);
    }
    translate([separation,0,-nutHeight]) rotate([0,0,0]) cylinder(d=nutDiameter*2/sqrt(3), h=mountThickness, $fn=6);
    translate([0,0,baseBoltHeight]) cylinder(d=baseBoltCounterbore, h=mountThickness);
  }
}




