// Snake Puzzle
// Written by Marius Gheorghescu (@mgx3d)

// edge length in mm (15 .. 150mm)
size = 20;

/* [Hidden] */

// depth of the coupler (1.0 .. 3.0mm)
coupler_depth = min(5, size/10);
clip_ring_depth = coupler_depth/1.5;
connector_dia = size*0.95 - 6*clip_ring_depth - 1.0;

clearance = 0.25;
epsilon = 0.01;

$fn = 50;

debug = 0;



module prism(size)
{
    intersection() {
        translate([0,0, size])
            cube([size*2, size*2, size*2], center=true);
        
        rotate([45, 0, 0])
            cube([size, size, size], center=true);
    }
}


module piece()
{
    chamfer = 0.5;
    difference()
    {
        prism(size);

        if (0) {
            // save material ?
            translate([0,0,coupler_depth/2*0])
                difference() {
                    prism(size-2*coupler_depth);
                    cube([2*size, 2*size, 2*coupler_depth], center=true);
                }
        }
        
        
        rotate([45,0,0])
        translate([0,0,size - coupler_depth - epsilon]) {
            cylinder(r=connector_dia/2, h=size, center=true);
            translate([0,0, - size/2 + 0*coupler_depth/2])
                cylinder(r1=connector_dia/2 + clip_ring_depth, r2=connector_dia/2, h=coupler_depth, center=true);
        }

        rotate([-45,0,0])
        translate([0,0,size - coupler_depth - epsilon]) {
            cylinder(r=connector_dia/2, h=size, center=true);
            translate([0,0, - size/2 + 0*coupler_depth/2])
                cylinder(r1=connector_dia/2 + clip_ring_depth, r2=connector_dia/2, h=coupler_depth, center=true);            
        }
        
        //
        // chamfers
        //
        
        translate([0, size*sqrt(2)/2 - chamfer/2, 0])
        rotate([45,0,0])
            cube([2*size, chamfer, chamfer], center=true);

        translate([0, -size*sqrt(2)/2 + chamfer/2, 0])
        rotate([45,0,0])
            cube([2*size, chamfer, chamfer], center=true);

        translate([-size/2,0,0])
        rotate([45,0,90])
            cube([2*size, chamfer, chamfer], center=true);

        translate([size/2,0,0])
        rotate([45,0,90])
            cube([2*size, chamfer, chamfer], center=true);

        translate([-size/2,0,size*sqrt(2)/2])
        rotate([45,0,90])
            cube([2*size, chamfer, chamfer], center=true);

        translate([size/2,0,size*sqrt(2)/2])
        rotate([45,0,90])
            cube([2*size, chamfer, chamfer], center=true);

        if (debug)
            translate([0,0,-epsilon])
            cube([size,size,size]);
    }
}


module coupler()
{    
    wall_thickness = size/10;
    
    translate([0,0,coupler_depth*1.25 - clearance/2])
    difference() {
        union() {
            translate([0,0,-coupler_depth*0.75])
            cylinder(r1=connector_dia/2 + clip_ring_depth, r2=connector_dia/2, h=coupler_depth - clearance, center=true);
            
            translate([0,0,coupler_depth*0.75])
                cylinder(r2=connector_dia/2 + clip_ring_depth, r1=connector_dia/2, h=coupler_depth - clearance, center=true);
                        
            cylinder(r=connector_dia/2, h=2*coupler_depth, center=true);
        }
        
        // empty inside
        cylinder(r=connector_dia/2 - size/8 + 1, h=3*coupler_depth, center=true);

        // cut-out for ring compression 
        hull() {
            translate([connector_dia/2 + coupler_depth,0,])
                cube([clip_ring_depth, size/5, 3*coupler_depth], center=true);
            cube([1, 1, 3*coupler_depth], center=true);
        }
    }
}


if (debug) {    
    // show coupler inside
    %rotate([-45,0,0])
    translate([0,0,size/2 - coupler_depth - clearance]) 
        color([0.9, 0.1, 0.1, 0.2]) coupler();
}

piece();
translate([size, 0, 0]) coupler();


