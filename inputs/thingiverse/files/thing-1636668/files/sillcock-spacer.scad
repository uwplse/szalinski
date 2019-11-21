// Sillcock Spacer --  Version 1.0
// (C) 2016 by Matthew Nielsen
// Home page: https://github.com/xunker/sillcock_spacer
// License: "Creative Commons -- Attribution -- Non-Commercial -- Share Alike"

// Thickness of the spacer. The default of 12mm is about 1/2 inch.
thickness = 12.0;

// Diameter of the main pipe opening. NOTE: since this spacer slides length-wise down the pipe, this opening must be big enough to pass anything else on the pipe like the integrated nut. The default of 29mm gives clearance for a 26mm pipe, the integrated nut.
pipe_diameter = 29.0;

// Many sillcocks have welds around the flange. Set a opening taper to make the pipe opening be a cone so the spacer can go around the welds and set flush with the flange. If
opening_taper_diameter = 37.0;

// Diameter of the screw holes on either side of the opening.
screw_d = 6.5;

// The beginnin offset of the screw holes *from the center of the object*.
screw_x_offset = 20.0;

// To create an elongated screw hole (recommended), use this to specify how wide the screw hole will be.
screw_x_width = 6.5;

// Length of the spacer. You should not need to change this.
length = 45.0;

// Width of the spacer. You should not need to change this.
width = 65.0;

// Facets: Increasing this will make for smoother circles but will also increase the rendering time. You should not need to change this.
facets = 32;

module screw_hole() {
  hull() {
    translate([screw_x_offset, 0, -0.1]) cylinder(d=screw_d, h=thickness+0.2, $fn=facets);
    translate([screw_x_offset+screw_x_width, 0, -0.1]) cylinder(d=screw_d, h=thickness+0.2, $fn=facets);
  }
}

difference() {
  scale([1,length/width,1]) cylinder(d=width, h=thickness, $fn=facets);
  translate([0,0,-0.1]) cylinder(d1=pipe_diameter, d2=opening_taper_diameter, h=thickness+0.2, $fn=facets);
  screw_hole();
  mirror([1,0,0]) screw_hole();
}
