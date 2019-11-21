// Title: Cable Holder
// Author: http://www.thingiverse.com/mtudury
// Date: 17/12/2016

/////////// PARAMETERS /////////////////

// milimeters

width = 40;
length = 20;
depth = 2;

count_holders = 2;
holder_external_diameter = 8;
holder_depth = 3.3;

big_spacer = 2.5;
small_spacer = 1.5;
internal_circle = 3.5;

$fn = 200;

/////////// END OF PARAMETERS /////////////////


// base
module base() {
    linear_extrude(depth) {
        hull() {
            circle(2);
            translate([length, 0, 0]) circle(2);
            translate([length, width, 0]) circle(2);
            translate([0, width, 0]) circle(2);
        }
    }
}
        
// cable holder
module holder() {
maxval = width*10;
poly= [ for (i = [0:maxval]) [i/count_holders/10, (sin(i/width*36-90)+1)*holder_depth+depth] ];
    
    translate([length/4,0,0]) rotate([90,0,90])
    difference() {
        linear_extrude(length/2) polygon(concat([[0,0]], poly, [[width/count_holders, 0]]));
        translate ([width/count_holders/2,depth+holder_depth/2,-0.1]) cylinder(length, internal_circle, internal_circle, false);
        translate ([width/count_holders/2,depth+holder_depth+holder_depth-(small_spacer/2),-0.1]) cylinder(length, small_spacer, small_spacer, false);
        translate ([width/count_holders/2,depth+holder_depth+holder_depth-(big_spacer/2),length/6-length/12]) cylinder(length/3, big_spacer, big_spacer, false);
    }    
                
}

base();

for (i = [1:count_holders]) 
    translate([0,(i-1)*width/count_holders,0]) holder();