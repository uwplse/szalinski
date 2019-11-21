// Arduino Mega / 2020 mount
// Designed by Marius Gheorghescu, December 2017

// thickness of the braces
brace_width = 2.4;

// thickness of the attachment pads
attach_thick = 3;

// extrusion size in mm
extrusion_size = 20;

// mount screw diameter (use 3.3 for M3, 4.3 for M4, 6.75 for 1/4-20)
screw_dia = 3.3;

/* [Advanced] */

support_dia = 5.0;

/* [Hidden] */

wall_thick = extrusion_size-5;

support_h = wall_thick+3;


epsilon = 0.01;
$fn=50;

module nub(neg=0)
{
    translate([0,0,support_h/2])
    if (neg)        
        cylinder(r=2.6/2, h=support_h+epsilon, center=true);
    else 
        cylinder(r=support_dia/2, h=support_h, center=true);
}

module holes(neg)
{
    translate([13.97, 2.54, 0]) nub(neg);    
    translate([15.24, 50.8, 0]) nub(neg);    
   
    translate([66.04, 7.62, 0]) nub(neg);
    translate([66.04, 35.56, 0]) nub(neg);
        
    translate([90.17, 50.8, 0]) nub(neg); 
    translate([96.52, 2.54, 0]) nub(neg);    
}

module plate()
{
    translate([14, 53/2,0])
        cube([brace_width, 53, wall_thick], center=true);
    
    translate([66, 53/2,0])
        cube([brace_width, 53, wall_thick], center=true);

    translate([96.5 + support_dia/2, 53/2,0])
        cube([brace_width, 53, wall_thick], center=true);
    
    translate([(96.5++ support_dia/2)/2, brace_width/2, 0])
        cube([96.5 + support_dia/2, brace_width, wall_thick], center=true);

    translate([(96.5 + support_dia/2)/2, 53 - brace_width/2,0])
        cube([96.5 + + support_dia/2, brace_width, wall_thick], center=true);
    
}

module mega()
{
    difference() {
        union() {
            holes();
            translate([0,0,wall_thick/2])
                plate();
        }
        
        holes(1);
    }
}




difference() {
    union() {

        translate([0, -53/2, -extrusion_size/2])
        mega();            
        
        translate([-attach_thick/2,0,0])
            cube([attach_thick, 53, extrusion_size], center=true);
        
        translate([extrusion_size/2 - attach_thick, 0, -extrusion_size/2 + attach_thick/2])
            cube([extrusion_size, 53, attach_thick], center=true);
    }

    translate([0,15,0])
    rotate([0,90,0])
        cylinder(r=screw_dia/2, h=500, center=true);
    
    translate([0,-15,0])
    rotate([0,90,0])
        cylinder(r=screw_dia/2, h=500, center=true);
    
    translate([extrusion_size/2 - attach_thick, 15,0])
        cylinder(r=screw_dia/2, h=100, center=true);
    
    translate([extrusion_size/2 - attach_thick, -15,0])
        cylinder(r=screw_dia/2, h=100, center=true);
    
}