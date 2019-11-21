//  Oblong Nameplate
//  Peter Griffiths

plate_length = 180;
plate_width = 100;
plate_thickness = 4.5;
letter_depth = 2;
surround_width = 4; // Border Thickness
hole_diameter = 3.8; // zero removes holes
counter_sink = 0; // zero removes countersink
f_ont = "roboto";
f_size = 30; // Letter Size
f_space = 1.1; // Letter spacing
text1 = "ENGINE";
text2 = "SHED";

module plate()
    difference(){
        cube([plate_length,plate_width,plate_thickness]);
        translate([surround_width,surround_width,plate_thickness - letter_depth])
            cube([plate_length - surround_width*2, plate_width - surround_width*2,letter_depth+1]);
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
         translate([surround_width,surround_width,-0.5])
            cylinder(d=hole_diameter , h= plate_thickness+1);
         translate([plate_length - surround_width,surround_width,-0.5])
            cylinder(d=hole_diameter, h=plate_thickness+1);
         translate([surround_width,plate_width - surround_width,-0.5])
            cylinder(d=hole_diameter, h=plate_thickness+1);
         translate([plate_length - surround_width,plate_width - surround_width,-0.5])
            cylinder(d=hole_diameter, h=plate_thickness+1);
         
         if (counter_sink >0){
             translate([surround_width,surround_width, plate_thickness- counter_sink])
             cylinder(h=counter_sink, d1=hole_diameter, d2=hole_diameter + counter_sink*2);
             translate([plate_length - surround_width,surround_width,plate_thickness-counter_sink])
             cylinder(h=counter_sink, d1=hole_diameter,   d2=hole_diameter + counter_sink*2);
             translate([surround_width,plate_width -surround_width, plate_thickness- counter_sink])
             cylinder(h=counter_sink, d1=hole_diameter, d2=hole_diameter + counter_sink*2);
             translate([plate_length - surround_width,plate_width - surround_width, plate_thickness- counter_sink])
             cylinder(h=counter_sink, d1=hole_diameter, d2=hole_diameter + counter_sink*2);
         }
     }   
 }
// Text line 1
 translate([plate_length/2,plate_width/2+f_size/6, plate_thickness - letter_depth]) {
     linear_extrude(height = letter_depth){
        text(text1, font = f_ont, size = f_size, halign = "center", spacing= f_space);
     }
 }
 // Text line 2
  translate([ plate_length/2,plate_width/2-f_size*1.08, plate_thickness - letter_depth]) {
     linear_extrude(height = letter_depth){
        text(text2, font = f_ont, size = f_size, halign = "center",spacing= f_space);
     }
 }