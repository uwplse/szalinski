/* Sunglass holder for car vent fins w/ball and socket */
/* Created by Solarmax (Thingiverse) */

/* Parameters */

// Width of car vent fin 
vent_fin_width = 3.2; // [0.2:0.1:8] 
// Length of the fingers of clamp 
length_of_fingers = 15; // [10:40] 
// Inner Diameter to fit sunglass temple (arm)
inner_diameter = 18; // [5:50]

/* *********************************************************** */

// ignore variable values
inner_radius = inner_diameter / 2; 
$fn = 50;

/* draw the main cylinder for sunglass holder */
union() {
    difference() {
        cylinder(h=10, r=inner_radius+2);
        translate([0,0,-0.5])
        cylinder(h=11, r=inner_radius);
    }

    /* post for ball in socket */
    translate([inner_radius,0,5])
    rotate([0,90,0])
    cylinder (h=7,d=4);

    /* ball for socket */
    translate([inner_radius+8,0,5])
    sphere(d=5.5);
}

difference() {
    
    /* structure for socket */
    union() {
        translate([inner_radius+8,0,5])
        cube(10, center=true);
        translate([inner_radius+8,(vent_fin_width/2),0])
        cube([length_of_fingers+5,1.5,10]);
        translate([inner_radius+8,-(vent_fin_width/2)-1.5,0])
        cube([length_of_fingers+5,1.5,10]);
    }
    
    /* socket */
    translate([inner_radius+8,0,5])
    sphere(d=7.5);

    /* hole for post for ball */
    translate([inner_radius+2,0,5])
    rotate([0,90,0])
    cylinder(h=4,d=5);
}
