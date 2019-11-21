// Pass box for a hall passes
// by Kevin McCormack

// The length of the inside of the box in mm
inside_length = 240; 
// The width of the inside of the box in mm
inside_width = 40; 
// Height of the box in mm
height = 80; 
outside_length = inside_length + 6;
outside_width = inside_width + 6;

// The text for the first line of the label
label_text = "Your Label Here"; 
// The size of the label text scaling
label_size = 1.8; 


module boxBase() {
    difference() {
        translate([0,0,height/2]) cube([outside_length,outside_width,height],center=true);
        translate([0,0,(height/2)+4]) cube([inside_length,inside_width,height],center=true);
        
    }
}

module label(the_text) {
    translate([0,-(outside_width/2)+1,height/2]) rotate([90,0,0]) scale([label_size,label_size,1]) linear_extrude(height=2) text(the_text, halign="center", valign="center");
}

difference() {
    boxBase();
    label(label_text);
}