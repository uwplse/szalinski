holeDiameter = 2;
innerDiameter = 20.5;
innerHeight = 5;

topDiameter = 140;
topHeight = 5;

/* [Hidden] */

$fn = 360;

holeRadius = holeDiameter / 2;
innerRadius = innerDiameter / 2;
topRadius = topDiameter / 2;

difference() {
  group() {
    cylinder(r=topRadius, h=topHeight);
    cylinder(r=innerRadius, h=topHeight + innerHeight);
  }
  
  translate([0, 0, -1])
    cylinder(r=holeRadius, topHeight + innerHeight + 2);
  
  /*
  translate([0, 0, 2])
    cylinder(r=innerRadius - 2, topRingHeight + innerHeight + 2);
  */
  
  translate([0, 0, -1])
  intersection() {
    translate([innerRadius - 2.5, innerRadius - 2.5, 0])
      rotate([0, 0, 0])
        cube([topRadius, topRadius, topHeight + 2]);

    translate([innerRadius - 2.5, innerRadius - 2.5, 0])
      rotate([0, 0, 20])
        cube([topRadius, topRadius, topHeight + 2]);
    
    translate([innerRadius - 2.5, innerRadius - 2.5, 0])
      rotate([0, 0, -20])
        cube([topRadius, topRadius, topHeight + 2]);
  }
  
  for(i=[90:45:360]) {
    rotate([0, 0, i]) {
      translate([innerRadius + 10 + 1, 0, -1])
        cylinder(r=6, h=topHeight + 2);
    
      translate([innerRadius + 8 + 1 + 20 + 10, 0, -1])
        cylinder(r=16, h=topHeight + 2);
    }
  }
}
