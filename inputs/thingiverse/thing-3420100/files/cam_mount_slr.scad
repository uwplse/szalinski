// Diamter of the piping
diameter = 22;

// Diameter of the mounting screw
screwDiameter = 4.2;
// Padding around the screw holws
screwPadding = 2.8;
// Offset for the back (wingnut)
screwOffset = 3.15;
// Diamter for the nut Hole
nutDiameter = 8;
// Depth of the nut hole
nutHeight = 4;
// Length of the moun (adjust in such a way that you canstill open your cameras door)
length = 46;
// Height of the mount
height = 57;

// Diameter of the hole for the cam screw
camScrewDiameter = 7.1;
// Cam screw offset from the top
camScrewOffset = -10;
// Thickness of the cam mount
mountThickness = 5;

// Width of the cutout
cutoutWidth = 5;

/* [Hidden] */
bracketWidth = screwPadding * 2 + screwDiameter;
walls= screwPadding * 2 + screwDiameter;
nutRadius = nutDiameter / 2;
screwRadius = screwDiameter / 2;
camScrewRadius = camScrewDiameter / 2;
radius = diameter / 2;
outerRadius = radius + walls;

$fn = 50;

rotate([90, 0, 0]) {
  difference() {
    group() {
      cylinder(r = outerRadius, h = length);

      hull() {
        translate([-outerRadius + walls, -outerRadius + walls / 2, walls / 2])
          rotate([0, 270, 0])
            cylinder(r = walls / 2, h = mountThickness);
        
        translate([-outerRadius + walls, -outerRadius + walls / 2, length - walls / 2])
          rotate([0, 270, 0])
            cylinder(r = walls / 2, h = mountThickness);
        
        translate([-outerRadius + walls, -outerRadius - walls / 2 + height, walls / 2])
          rotate([0, 270, 0])
            cylinder(r = walls / 2, h = mountThickness);
        
        translate([-outerRadius + walls, -outerRadius - walls / 2 + height, length - walls / 2])
          rotate([0, 270, 0])
            cylinder(r = walls / 2, h = mountThickness);
      }
      
      translate([-outerRadius + (walls-mountThickness), radius + screwPadding + screwRadius, bracketWidth / 2])
        rotate([0, 90, 0])
          cylinder(r = bracketWidth / 2, h = outerRadius * 2 - screwOffset - (walls-mountThickness));
      
      translate([-outerRadius + (walls-mountThickness), -radius - screwPadding - screwRadius, bracketWidth / 2])
        rotate([0, 90, 0])
          cylinder(r = bracketWidth / 2, h = outerRadius * 2 - screwOffset);
      
      translate([-outerRadius + (walls-mountThickness), radius + screwPadding + screwRadius, length - bracketWidth / 2])
        rotate([0, 90, 0])
          cylinder(r = bracketWidth / 2, h = outerRadius * 2 - screwOffset);
      
      translate([-outerRadius + (walls-mountThickness), -radius - screwPadding - screwRadius, length - bracketWidth / 2])
        rotate([0, 90, 0])
          cylinder(r = bracketWidth / 2, h = outerRadius * 2 - screwOffset);
    }

    translate([0, 0, -1])
      cylinder(r = radius, h = length + 2);
    translate([-outerRadius + walls, -outerRadius, bracketWidth])
      cube([outerRadius * 2 + 2, outerRadius * 2 + 2, length - bracketWidth * 2]);
    
    translate([-outerRadius + (walls-mountThickness) - 1, radius + screwPadding + screwRadius, bracketWidth / 2])
    rotate([0, 90, 0]) {
      cylinder(r = screwRadius, h = outerRadius * 2 + 2);
      cylinder(r = nutRadius, h = nutHeight + 1, $fn = 6);
    }

    translate([-outerRadius + (walls-mountThickness) - 1, -radius - screwPadding - screwRadius, bracketWidth / 2])
    rotate([0, 90, 0]) {
      cylinder(r = screwRadius, h = outerRadius * 2 + 2);
      cylinder(r = nutRadius, h = nutHeight + 1, $fn = 6);
    }
    
    translate([-outerRadius + (walls-mountThickness) - 1, radius + screwPadding + screwRadius, length - bracketWidth / 2])
    rotate([0, 90, 0]) {
      cylinder(r = screwRadius, h = outerRadius * 2 + 2);
      cylinder(r = nutRadius, h = nutHeight + 1, $fn = 6);
    }

    translate([-outerRadius + (walls-mountThickness) - 1, -radius - screwPadding - screwRadius, length - bracketWidth / 2])
    rotate([0, 90, 0]) {
      cylinder(r = screwRadius, h = outerRadius * 2 + 2);
      cylinder(r = nutRadius, h = nutHeight + 1, $fn = 6);
    }

    translate([-outerRadius + (walls-mountThickness) - 1, -outerRadius + height + camScrewOffset, length/2])
    rotate([0, 90, 0]) {
      cylinder(r = camScrewRadius, h = mountThickness + 2);
    }
    
    translate([-cutoutWidth / 2, -outerRadius - 1, -1])
      cube([cutoutWidth, outerRadius * 2 + 2, length + 2]);
    
    translate([-outerRadius * 2 + (walls-mountThickness), -outerRadius - 1, -1])
      cube([outerRadius, height + 2, length + 2]);
  }
}