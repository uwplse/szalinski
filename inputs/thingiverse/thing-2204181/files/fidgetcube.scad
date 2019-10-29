/*
@author: matt@misbach.org
@date: 3/25/2017

Description: Fidget ball cube
*/

hole_size = 30; // [2:35]
sphere_diameter = 40; // [10:44]

$fn=50;

// Inner Sphere
sphere(d=sphere_diameter); 

//Subtract cylinders from outer sphere
difference() {
    sphere(d=50);
    sphere(d=50*.9);
    
    cylinder(d=hole_size, h=60, center=true);
    rotate([90, 0, 0])  cylinder(d=hole_size, h=60, center=true);
    rotate([0, 90, 0])  cylinder(d=hole_size, h=60, center=true);
}