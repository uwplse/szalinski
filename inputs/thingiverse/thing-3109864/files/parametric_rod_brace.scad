//Parametric Rod Brace, by ggroloff 9.19.2018
//Use this to make a rod brace of any length and springiness to prevent unwanted rod motion.

//All units in mm

//the distance between the rod and whatever surface to brace against,(round up by ~0.5)
rod_distance=31.5;

//The diameter of the rod
rod_diameter = 8;

//Width of the support
support_width = 6;

//Thickness of the support
support_thickness = 2;

//Thickness of the base
base_plate_thickness = 3;

//Width of the base
base_plate_width = 12;

//Length of the base
base_plate_length = 6;

//Offset of the base from the support
base_plate_offset = 0;

//Length of the spring, related to spring travel distance (set to 0 for no spring)
spring_length = 8;

//Thickness of the spring walls, related to spring constant K
spring_thickness = 1.0;

//Position of the spring 1 on the support
spring1_height = 10;

//Position of spring 2 on the support (set to the same as spring 1 for 1 spring)
spring2_height = 20;


/*[Hidden]*/
//code starts here

module body() {
    translate ([-base_plate_width/2+base_plate_offset,0,0]) cube ([base_plate_width,base_plate_thickness,base_plate_length]);
    translate ([-support_width/2,0,0]) cube ([support_width,rod_distance+rod_diameter/2,support_thickness]);
    translate ([0,spring1_height, support_thickness/2]) rotate ([0,0,45]) cube ([spring_length/1.41421356237+spring_thickness*2,spring_length/1.41421356237+spring_thickness*2,support_thickness], center=true);
    translate ([0,spring2_height, support_thickness/2]) rotate ([0,0,45]) cube ([spring_length/1.41421356237+spring_thickness*2,spring_length/1.41421356237+spring_thickness*2,support_thickness], center=true);
}
//body();

module spring() {
        translate ([0,0,spring_height]) rotate ([0,0,45]) cube ([spring_length/1.41421356237,spring_length/1.41421356237,support_thickness], center=true);
}
//spring();


module rod() {
        cylinder (d=1.41421356237*rod_diameter,h=50,center=true,$fn=4);//render square rod of rod_diameter width
}


difference() {
 body();
translate ([0,rod_distance+rod_diameter/2,0]) rotate ([0,0,0]) rod();//drill out rod
translate ([0,spring1_height,support_thickness/2-.01]) rotate ([0,0,45]) cube ([spring_length/1.41421356237,spring_length/1.41421356237,support_thickness+1], center=true);
translate ([0,spring2_height,support_thickness/2-.01]) rotate ([0,0,45]) cube ([spring_length/1.41421356237,spring_length/1.41421356237,support_thickness+1], center=true);
}
