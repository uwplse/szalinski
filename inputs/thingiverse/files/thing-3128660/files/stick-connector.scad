/* [General] */
// Select the part to be viewed
part = "both"; // [corner: Corner Piece, magnetMount: Magnet Mount, both: Corner and Magnet Mount]

// Amount of Corners
corners = 6;

// Width of the cutout
width = 10;
// Height of the cutout
height = 5;
// Length of the cutout
length= 14;

// Wall thickness
walls = 1.6;
wallsInner = 0.5;
/* [Magnet Holder] */
// Magnet Diameter (I chouse this to be slightly smaller than the actual diameter so the magnet fits snuggly)
magnetDiameter = 16;
// Magnet Height
magnetHeight = 3;
// Thickness of the piece that holds the magnet (it should be thick enough to hold the structure but thin enough to have enough magnetic force)
outerWall = 0.6;

/* [Hidden] */
degrees = 360 / corners;
hull = 0.2;

outerHeight = height + walls * 2;
outerWidth = width + walls * 2;
outerLength = length + wallsInner;

magnetRadius = magnetDiameter / 2;
magnetOuterWidth = width + walls * 2 + magnetHeight + outerWall;
magnetHolderLength = magnetDiameter + walls * 2;

if(part == "corner") {
  corner();
}
if(part == "magnetMount") {
  magnetMount();
}
if(part == "both") {
  corner();
  translate([outerLength - magnetHolderLength, -magnetOuterWidth - 5, 0])
  magnetMount();
}


module magnetMount() {
  difference() {
    cube([magnetHolderLength, magnetOuterWidth, outerHeight]);
    translate([-1, walls, walls])
      cube([magnetHolderLength + 2, width, height]);
    
    translate([magnetHolderLength / 2, walls * 2 + width, outerHeight / 2])
      rotate([-90,0,0])
        cylinder(r = magnetRadius, h = magnetHeight);
  }
}

module corner() {
  part();
  translate([0, outerWidth, 0])
    rotate([0, 0, 180 - degrees])
      part();

  hull() {
    translate([0, outerWidth, 0])
      rotate([0, 0, 180 - degrees])
        translate([-hull, 0, 0])
          cube([hull, outerWidth, outerHeight]);

    translate([-hull, 0, 0])
      cube([hull, outerWidth, outerHeight]);
  }

  module part() {
    difference() {
      cube([outerLength, outerWidth, outerHeight]);
      translate([wallsInner, walls, walls])
        cube([outerLength, width, height]);
    }
  }
}