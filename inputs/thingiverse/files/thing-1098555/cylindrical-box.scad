// preview[view:south west, tilt:top diagonal]

/* [Container] */
// Inner diameter
diameter = 32;
// Bottom and top thickness
bottom = 0.6;
// Wall thickess
wall = 0.6;
// Container Height
height = 17;
// Height of the lid
lidHeight = 5;
// Clearance between container and lid
clearance = 0.1;

/* [View] */
// Which parts would you like to see?
part = "all"; // [all:Container and Lid, container:Container Only, lid:Lid Only]

/* [HIDDEN] */
radius = diameter / 2;
total = height + bottom;

printPart();

module printPart() {
  if(part == "container") container();
  else if(part == "lid") lid();
  else {
    container();
    translate([diameter + clearance * 2 + 5, 0, 0])
      lid();
  }
}

module container() {
    difference() {
        cylinder(r=(radius + wall), h=total, $fn=360);
        
        translate([0, 0, bottom])
            cylinder(r=radius, h=total, $fn=360);
    }
}

module lid() {
    difference() {
        cylinder(r=(radius + wall * 2 + clearance), h=lidHeight, $fn=360);
        
        translate([0, 0, bottom])
            cylinder(r=(radius + wall + clearance), h=lidHeight, $fn=360);
    }
}