/*
  RC plane wheel wedge
  
  (c) 2018 Janne Mäntyharju
*/

// Thickness of support plate
thickness = 2;

// Diameter of support disk
middle_disk_diameter = 25;

// Tire diameter
tire_diameter = 69;

// Tire width
tire_width = 22;

// Tire rounding
tire_rounding = 8;

// Diameter of center hole to leave space for wheel collar
center_hole_diameter = 15;

// Width of support arms
arm_width = 15;

// ignore variable values
$fn = 30;
wedge_size_multiplier = 2.5;
outer_radius = (tire_diameter / 2) + thickness * wedge_size_multiplier * 0.8;

x = ((tire_diameter /2) / cos(60)) - arm_width;

// EMBEDDED rcube.scad MODULE

// Rounded primitives for openscad
// (c) 2013 Wouter Robers 

// Syntax example for a rounded block
//translate([-15,0,10]) rcube([20,20,20],2);

// Syntax example for a rounded cylinder
//translate([15,0,10]) rcylinder(r1=15,r2=10,h=20,b=2);

module rcube(Size=[20,20,20],b=2)
{hull(){for(x=[-(Size[0]/2-b),(Size[0]/2-b)]){for(y=[-(Size[1]/2-b),(Size[1]/2-b)]){for(z=[-(Size[2]/2-b),(Size[2]/2-b)]){ translate([x,y,z]) sphere(b);}}}}}


module rcylinder(r1=10,r2=10,h=10,b=2)
{translate([0,0,-h/2]) hull(){rotate_extrude() translate([r1-b,b,0]) circle(r = b); rotate_extrude() translate([r2-b, h-b, 0]) circle(r = b);}}

module arm(angle) {
    rotate([0,0,angle]) {
        union() {
            translate([0,arm_width * -0.5,0]) cube([tire_diameter / 2, arm_width, thickness]);
            translate([(tire_diameter / 2) - thickness, arm_width * -0.5, 0]) cube([x - ((tire_diameter / 2) - thickness), arm_width, thickness + tire_width]);
        }
    }
}

intersection() {
    difference() {
        union() {
            cylinder(thickness, middle_disk_diameter / 2, middle_disk_diameter / 2);
            arm(0);
            arm(120);
            arm(-120);
        }
        cylinder(thickness * 2, center_hole_diameter / 2, center_hole_diameter / 2);
        #translate([0,0,thickness + tire_width /2]) rcylinder(tire_diameter /2 , tire_diameter / 2, tire_width, tire_rounding);
    }
    translate([0,0,(tire_width + thickness) /2]) rcylinder(x , x, tire_width + thickness, 5);
}