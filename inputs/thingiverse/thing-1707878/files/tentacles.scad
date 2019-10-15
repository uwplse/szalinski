/*

Tentacle generator (or something)

Simple recursion method

Fernando Jerez (2016)


Notes: Rendering on OpenSCAD it's very slow, be patient.
*/

// preview[view:south, tilt:top]

// Number of main branchs
branchs = 3; // [1:10]

// Size of first ball in mms (affects length of tentacles and total size of figure)
radius = 10; // [5:20]

// More angle, more spiralized. Zero angle -> Straight tentacles
angle = 15; // [0:30]

// Number of balls between ramifications (bigger-->less branching)
new_branch = 5; //[1:30]

/* [Hidden] */
min_radius = 1.5;

// Main program: Main branchs
for(i=[0:(360/branchs):359]){
    union(){ 
        rotate([0,0,i]) tentacle(radius,angle,1); 
    }
}


// Recursion module
module tentacle(r,ang,n){
    if(r>min_radius){
        semisphere(r);
        rotate([0,0,ang]) translate([r,0,0]) tentacle(r*0.95,ang*1.02,n+1);
        
        if(n%new_branch==0){
            rotate([0,0,-90]) translate([r,0,0]) tentacle(r*0.6,ang,1);
        }
    }
}

// Semisphere
module semisphere(r){
    difference(){
        sphere(r,$fn = min(30,10+r*2)); // less facets for smaller balls (improves render time)
        translate([0,0,-r]) cube([2*r,2*r,2*r],center = true);
    }
}