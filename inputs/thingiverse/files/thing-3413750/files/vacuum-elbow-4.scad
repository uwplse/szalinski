//Customizable tapered coupler
//Ari M Diacou
//Feb 7, 2019

//////////////////////// Parameters ////////////////////////////////
//is the diameter (in mm) of the corner and the untapered diameter. If fitting OVER your pipe, set this to (pipe diameter + 2*thickness+0.5)*1.03.
outer_diameter=25;
//(in mm) of a single wall of the coupler
thickness=1.0;
//is the number of segments that make up a circle.
resolution=60;
//is the diameter (in mm) of the corner of the tapered diameter. If fitting OVER your pipe, set this to (pipe diameter + 2*thickness+0.5)*1.03.
output_diameter=15;
// times the outer diameter is the length that the pipes will couple by
coulpling_length=0.2;
//times the outer diameter is the length that the outer diameter tapers to the output diameter over
tapering_length=0.4;
//times the outer diameter is the distance between the corner and the taper. Range=[0,∞)
taper_displacement=.1;
///////////////// Derived Parameters //////////////////////////
//4 works, anything else lower than 8 becomes 8, everything else is rounded to the next lower even number. Evens are needed because spheres cannot have an odd number of facets, which leads to cylinder/sphere mismatches which drastically increases number of rendered facets.
$fn=(resolution==4)? 4: max(2*floor(resolution/2),8);
inner_diameter=outer_diameter-2*thickness;
//a small value used for elimitating edge artifacts
ep=0.05+0;
//so the edges line up
corner_lineup=360/$fn/2;
//////////////////// Main() ////////////////////////////////////
cone3();
elbow();
////////////////// Functions ///////////////////////////////////
module cone3(){
    translate([0,-(.5+taper_displacement)*outer_diameter+ep,0]) 
    rotate([90,corner_lineup,0]){
        taper();
        output();
        }
    }

module taper(){
    difference(){
        cylinder(d1=outer_diameter,h=tapering_length*outer_diameter,d2=output_diameter);
        translate([0,0,-ep]) cylinder(d1=inner_diameter,h=tapering_length*outer_diameter+2*ep,d2=output_diameter-2*thickness);
        }
    }
    
module output(){
    translate([0,0,(tapering_length)*outer_diameter-ep])
    difference(){
        cylinder(d=output_diameter, h=(coulpling_length)*outer_diameter);
        translate([0,0,-ep])
        cylinder(d=output_diameter-2*thickness, h=(1.1*coulpling_length)*outer_diameter+ep);
        }
    }
    

module elbow(){
    difference(){
        outer_elbow();
        inner_elbow();
        }
    }
module outer_elbow(){
    rotate([90,-corner_lineup,0]) cylinder(h=(.5+taper_displacement)*outer_diameter, d=outer_diameter);
    sphere(d=outer_diameter);
    rotate([0,90,0]) rotate([0,0,corner_lineup]) cylinder(h=(.6+coulpling_length)*outer_diameter, d=outer_diameter);
    }
module inner_elbow(){
    rotate([90,corner_lineup,0]) cylinder(h=outer_diameter+ep, d=inner_diameter);
    sphere(d=inner_diameter);
    rotate([0,90,0]) rotate([0,0,corner_lineup]) cylinder(h=outer_diameter+ep, d=inner_diameter);
    }