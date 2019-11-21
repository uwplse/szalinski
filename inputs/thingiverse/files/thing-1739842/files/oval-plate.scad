//  Oval Nameplate
//  Up to three lines of text
//  Peter Griffiths 2016

oval_height = 70;
oval_width = 105;
plate_thickness = 4;
letter_depth = 1.5;
surround_width = 3;
hole_diameter = 4; // zero removes holes
hole_spacing = 92;
counter_sink = 0; // zero removes countersink

font_1 = "unna";
font_size_1 = 15;
font_2 = "libre baskerville";
font_size_2 = 18;
font_3 = "libre baskerville";
font_size_3 = 8;

letter_space = 1;

text_1="2";
height_adjust_1 = -4;
text_2="L M S";
height_adjust_2 = -3;
text_3="";
height_adjust_3 = 0;

module plate()
    difference(){
        hull() {
            $fn=60;
            resize([oval_width, oval_height, plate_thickness])        cylinder(r=10,h=1);
        }
        hull() {
            $fn=60;
            translate([0,0,plate_thickness - letter_depth])
            resize([oval_width - surround_width*2, oval_height - surround_width*2]) cylinder(r=10,h=letter_depth+0.1);
        }
        if (hole_diameter >0){
            $fn=40;
            translate([hole_spacing/2,0,0])
            cylinder(d=hole_diameter , h=plate_thickness);
            translate([-hole_spacing/2,0,0])
            cylinder(d=hole_diameter, h=plate_thickness);
            if (counter_sink >0){
                $fn=40;
                translate([hole_spacing/2,0,  plate_thickness- letter_depth - counter_sink])
                cylinder(h=counter_sink, d1=hole_diameter, d2=hole_diameter + counter_sink*2);
                translate([-hole_spacing/2,0,plate_thickness - letter_depth - counter_sink])
                cylinder(h=counter_sink, d1=hole_diameter,   d2=hole_diameter + counter_sink*2);
            }
        }
    }

 plate();
 $fn=60;
 // Logo or first line of text
 translate([0,font_size_2*1 + height_adjust_1,plate_thickness - letter_depth]){
     linear_extrude(height = letter_depth){
        text(text_1, font = font_1, size = font_size_1+1, halign="center", spacing = letter_space);
     }
 }
// Text line 2
 translate([ 0,- font_size_2/2 + height_adjust_2, plate_thickness - letter_depth]) {
     linear_extrude(height = letter_depth){
        text(text_2, font = font_2, size = font_size_2, halign = "center", spacing = letter_space);
     }
 }
 // Text line 3
  translate([ 0,-font_size_3*2 + height_adjust_3, plate_thickness - letter_depth]) {
     linear_extrude(height = letter_depth){
        text(text_3, font = font_3, size = font_size_3, halign = "center",spacing = letter_space);
     }
 }