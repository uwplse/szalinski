// Customizable Coaster
// by Kevin McCormack

// Diameter of the inside in millimeters.
inside_diameter = 110; //[50:250]

// Tickness of the walls and floor in millimeters.
thickness = 2; //[1:10]

// The height of the lip of the coaster (0 for just a flat disc).
lip_height = 5; //[0:20]

// The message to be inscribed on the first line.
message_text_line1 = "First LIne";
// The message to be inscribed on the second line (blank for no second line).
message_text_line2 = "Second Line";
// The scale factor for the message (0 for no message).
message_scale = 1.3; //[0:0.1:5]

outside_diameter = inside_diameter + (thickness * 2);

module coaster() {
  difference() {
    cylinder(d=outside_diameter, h=(thickness + lip_height));
    
    if (lip_height > 0) {
      translate([0,0,thickness])
      cylinder(d=inside_diameter, h=(lip_height+1));
    }
  }
}

module message(the_text) {
    scale([message_scale,message_scale,1]) linear_extrude(height=thickness) text(the_text, halign="center", valign="center");
}

module engrave_message() {
  yoffset= (message_text_line2=="") ? 0 : 7;
  
  difference() {
    coaster();
    translate([0,(message_scale * yoffset),thickness/2]) message(message_text_line1);
    translate([0,(message_scale * (-yoffset)),thickness/2]) message(message_text_line2);
  }
}

// Make the coaster!
if (message_scale > 0) { engrave_message(); }
else { coaster(); }