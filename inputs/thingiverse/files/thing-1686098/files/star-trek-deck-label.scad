// preview[view:south, tilt:top]

part = "both"; // [both:Backplate and Text, back:Backplate, text:Text]

/* [Backplate] */

// Thickness of the backplate
base_thickness = 1; // [1:3]

// Width of the backplate
base_width = 150; // [25:150]

// Height of the backplate
base_height = 25;

/* [Text] */

text_height = 1; // [0.5:0.1:2]

//found on google.com/fonts
font = "Russo One";

deck = "10";
section = "01";

title_text = "Ten Forward";

description_line_1 = "";
description_line_2 = "";

print_part();

module print_part() {
    if (part == "back") {
        color("red")
        backplate();
    } else if (part == "text") {
        color("white")
        top();
    } else {
        color("red")
        backplate();
        
        color("white")
        top();
    }
}    
    
module top() {
    translate([-(base_width + base_height)/2 + 3, base_height/4, base_thickness - 0.5])
    union() {
        linear_extrude(height=(text_height + 0.5))
        text(str(deck), font=font, size=(base_height * 0.5), valign="top");
                
        deck_offset = len(str(deck)) * base_height * 0.5;
        
        translate([deck_offset - 3, -base_height * 0.75, 0])
        cube([1, base_height, (text_height + 0.5)]);
                
        translate([deck_offset + 1, 0, 0])
        linear_extrude(height=(text_height + 0.5))
        text(str(section), font=font, size=(base_height * 0.5), valign="top");
        section_offset = (len(str(section))) * base_height * 0.5;
        
        translate([deck_offset + section_offset, 0, 0])
        linear_extrude(height=(text_height + 0.5))
        if (description_line_1 == "") {
            text(str(title_text), font=font, size=(base_height * 0.5), valign="top");
        } else {
            translate([0,(base_height/6), 0])
            text(str(title_text), font=font, size=(base_height * 0.3), valign="top");
            
            translate([0,-(base_height/6), 0])
            text(str(description_line_1), font=font, size=(base_height * 0.15), valign="top");
            
            translate([0,-(base_height/3), 0])
            text(str(description_line_2), font=font, size=(base_height * 0.15), valign="top");
        }
    };
}

module backplate() {
    difference() {
        hull() {
            translate([base_width/2, 0, 0])
                cylinder(h=base_thickness, r=(base_height/2));
            
            translate([-base_width/2, 0, 0])
                cylinder(h=base_thickness, r=(base_height/2));
        };
        top();
    };
}
