// "Normal" Venturi for flow measurement, etc
// Copyright <senorjp@gmail.com> April 2019
//
// Outside (unrestricted) diameter
inlet_outlet_diameter=75; // [2:300]
// Inlet angle
inlet_angle=23; // [19:23]
// Outlet angle
outlet_angle=15; // [5:15]
// Area ratio. Higher number = smaller throat
area_ratio=3; // [1.1:20]
// Length of throat section
throat_length=20; // [0:100]
// Diameter of tap in throat
tap_diameter=15; // [0:100]
// Tolerance of mating pins
mating_pin_tolerance=1; // [0.5:2]
// Single part, or split for printing?
split=1; // [0:Whole,1:Split]
//
$fn=100;

/* [Hidden] */

pi=3.141592;
inlet_xs_area=pi*pow((inlet_outlet_diameter/2),2);
throat_xs_area=inlet_xs_area/area_ratio;
throat_diameter=sqrt((throat_xs_area/pi))*2;
//throat_diameter=80;
throat_width=(inlet_outlet_diameter-throat_diameter)/2;

inlet_length=(inlet_outlet_diameter-throat_diameter/2)/tan(inlet_angle);

outlet_length=(inlet_outlet_diameter-throat_diameter/2)/tan(outlet_angle);

total_length=inlet_length+throat_length+outlet_length;

module venturi() {
    difference() {
        translate([0,0,total_length/2-outlet_length-throat_length/2])
        cylinder(r=inlet_outlet_diameter/2, h=total_length, center=true);
        
        translate([0,0,inlet_length/2+throat_length/2+.1])
        cylinder(r2=inlet_outlet_diameter/2, r1=throat_diameter/2, h=inlet_length+.1, center=true);
        
        cylinder(r=throat_diameter/2, h=throat_length+2, center=true);
        
        translate([0,0,-outlet_length/2-throat_length/2-.1])
        cylinder(r1=inlet_outlet_diameter/2, r2=throat_diameter/2, h=outlet_length+.1, center=true);
        
        translate([-inlet_outlet_diameter,0,0])
        rotate(90,[0,1,0])
        cylinder(r=tap_diameter/2, h=inlet_outlet_diameter*2, center=true);
    }
}

module venturi_top() {
    difference() {
        venturi();
        translate([inlet_outlet_diameter,0,0])
        cube([inlet_outlet_diameter*2,inlet_outlet_diameter*2,total_length*2],center=true);
    }
    
    translate([0,throat_diameter/2+throat_width/2,0])
    rotate(90,[0,1,0])
    cylinder(r=throat_width/4, h=4, center=true);
    
    translate([0,-throat_diameter/2-throat_width/2,0])
    rotate(90,[0,1,0])
    cylinder(r=throat_width/4, h=4, center=true);
    
    translate([0,throat_diameter/2+throat_width/2+throat_width/4,inlet_length/2+throat_length/2])
    rotate(90,[0,1,0])
    cylinder(r=throat_width/8, h=4, center=true);
    
    translate([0,-throat_diameter/2-throat_width/2-throat_width/4,inlet_length/2+throat_length/2])
    rotate(90,[0,1,0])
    cylinder(r=throat_width/8, h=4, center=true);

    translate([0,throat_diameter/2+throat_width/2+throat_width/4,-outlet_length/2-throat_length/2])
    rotate(90,[0,1,0])
    cylinder(r=throat_width/8, h=4, center=true);
    
    translate([0,-throat_diameter/2-throat_width/2-throat_width/4,-outlet_length/2-throat_length/2])
    rotate(90,[0,1,0])
    cylinder(r=throat_width/8, h=4, center=true);
}

module venturi_bottom() {
    difference() {
        venturi();
        translate([-inlet_outlet_diameter,0,0])
        cube([inlet_outlet_diameter*2,inlet_outlet_diameter*2,total_length*2],center=true);
        
    translate([0,throat_diameter/2+throat_width/2,0])
    rotate(90,[0,1,0])
    cylinder(r=throat_width/4, h=4+mating_pin_tolerance, center=true);
    
    translate([0,-throat_diameter/2-throat_width/2,0])
    rotate(90,[0,1,0])
    cylinder(r=throat_width/4+mating_pin_tolerance, h=4+mating_pin_tolerance, center=true);
    
    translate([0,throat_diameter/2+throat_width/2+throat_width/4,inlet_length/2+throat_length/2])
    rotate(90,[0,1,0])
    cylinder(r=throat_width/8+mating_pin_tolerance, h=4+mating_pin_tolerance, center=true);
    
    translate([0,-throat_diameter/2-throat_width/2-throat_width/4,inlet_length/2+throat_length/2])
    rotate(90,[0,1,0])
    cylinder(r=throat_width/8+mating_pin_tolerance, h=4+mating_pin_tolerance, center=true);

    translate([0,throat_diameter/2+throat_width/2+throat_width/4,-outlet_length/2-throat_length/2])
    rotate(90,[0,1,0])
    cylinder(r=throat_width/8+mating_pin_tolerance, h=4+mating_pin_tolerance, center=true);
    
    translate([0,-throat_diameter/2-throat_width/2-throat_width/4,-outlet_length/2-throat_length/2])
    rotate(90,[0,1,0])
    cylinder(r=throat_width/8+mating_pin_tolerance, h=4+mating_pin_tolerance, center=true);
    
    }
}
module venturi_split() {
    translate([-throat_length/2-outlet_length+total_length/2,inlet_outlet_diameter/2+2,inlet_outlet_diameter/2])
    rotate(-90,[0,1,0])
    venturi_top();
    
    translate([-throat_length/2-outlet_length+total_length/2,-inlet_outlet_diameter/2-2,inlet_outlet_diameter/2])
    rotate(180,[0,0,1])
    rotate(90,[0,1,0])
    venturi_bottom();
}
//venturi();
//venturi_top();
//venturi_bottom();
if(split == 1) {
venturi_split();
}
else {
    venturi();
}