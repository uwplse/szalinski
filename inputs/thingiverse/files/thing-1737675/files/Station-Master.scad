//  Oblong Nameplate
//  Single line of text
//  Peter Griffiths 2016

plate_length = 180;
plate_width = 40;
plate_thickness = 4.5;
letter_depth = 2;
surround_width = 4;
hole_diameter = 4; // zero removes holes
counter_sink = 0; // zero removes countersink
f_ont = "roboto condensed";
font_size = 16;
letter_space = 1;
text1 = "STATION MASTER";

module plate()
    difference(){
        cube([plate_length,plate_width,plate_thickness]);
        translate([surround_width,surround_width,plate_thickness - letter_depth])
            cube([plate_length - surround_width*2, plate_width - surround_width*2,plate_thickness - letter_depth]);
    }

module plate_main(){
 plate();
 translate([surround_width,surround_width,0])
        cylinder(r=surround_width,h=plate_thickness);
 translate([plate_length - surround_width,surround_width,0])
        cylinder(r=surround_width,h=plate_thickness);
 translate([surround_width,plate_width - surround_width,0])
        cylinder(r=surround_width,h=plate_thickness);
 translate([plate_length - surround_width,plate_width - surround_width,0])
        cylinder(r=surround_width,h=plate_thickness);
}        
 if (hole_diameter >0){
     difference(){
         plate_main();
         $fn=40;
         translate([surround_width, surround_width, -0.5])
            cylinder(d=hole_diameter , h= plate_thickness+1);
         translate([plate_length - surround_width,surround_width, -0.5])
            cylinder(d=hole_diameter, h=plate_thickness+1);
         translate([surround_width, plate_width - surround_width, -0.5])
            cylinder(d=hole_diameter, h=plate_thickness+1);
         translate([plate_length - surround_width,plate_width - surround_width, -0.5])
            cylinder(d=hole_diameter, h=plate_thickness+1);
         
         if (counter_sink >0){
             translate([surround_width,surround_width, plate_thickness- counter_sink])
             cylinder(h=counter_sink, d1=hole_diameter, d2=hole_diameter + counter_sink*2);
             translate([plate_length - surround_width, surround_width,plate_thickness - counter_sink])
             cylinder(h=counter_sink, d1=hole_diameter,   d2=hole_diameter + counter_sink*2);
             translate([surround_width, plate_width - surround_width, plate_thickness - counter_sink])
             cylinder(h=counter_sink, d1=hole_diameter, d2=hole_diameter + counter_sink*2);
             translate([plate_length - surround_width,plate_width - surround_width, plate_thickness - counter_sink])
             cylinder(h=counter_sink, d1=hole_diameter, d2=hole_diameter + counter_sink*2);
         }
     }   
 }
// Text line 1
 translate([plate_length/2, plate_width/2 - font_size/2, plate_thickness - letter_depth]) {
     $fn=60;
     linear_extrude(height = letter_depth){
        text(text1, font = f_ont, size = font_size, halign = "center", spacing = letter_space);
     }
 }