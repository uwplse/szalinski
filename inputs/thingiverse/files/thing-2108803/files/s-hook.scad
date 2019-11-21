// Crafted by HarlemSquirrel
// harlemsquirrel@gmail.com

full_length = 80; // Length in mm
thickness = 5; // Thickness in mm

module s_hook() {
  linear_extrude(height=thickness, center=true)
  resize([0,full_length,0], auto=true) 
  text("S", font="Nimbus Sans Narrow:style=Regular", halign="center", valign="center");
}

$fn=100;
translate([0,0,thickness/2])
s_hook();
