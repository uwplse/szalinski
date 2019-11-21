/* [Main] */
$fn = 128;

// How many sides in your polygon?
num_sides = 7; // [2:16]

// Make base a solid polygon instead of a web.
solid_base = 0; // [0:Web, 1:Solid]

// Diameter of the can, in mm.  68 works for a standard soda can in the US.
can_diam = 68; // [10:200]

// Height of the top ring, in mm.
ring_height = 50; // [10:200]

// Distance away from the can for the base of the stabilizer, in mm.
extra_rad = 25.4; // [10.0:0.2:100.0]

/* [Tweaks] */
// An aesthetic choice for the middle base ring (only if solid_base==false)
base_mid_ring_mult = 2; // [1:4]

// Diameter of the various rods, in mm.  Recommend 4 or higher for strength.
rod_diam = 4; // [2:20]

// Scaling factor for rods in the base layer.  Increase if you need more material in the base for adhesion (or just like the look better)
base_widening = 1.0; // [1.0:0.1:10.0]

// An additional scaling for the spheres inthe corners.
outer_sphere_widening = 5.0; // [1.0:0.1:10.0]

// Derived:
step = 360/num_sides;
can_rad = can_diam/2;
base_rad = can_rad + extra_rad;
base_diam = base_rad*2;
rod_rad = rod_diam/2;
base2can = (base_rad - can_rad) - rod_rad;
rod_height = sqrt(ring_height*ring_height + base2can*base2can);
vtheta = -atan2(base2can,ring_height);
htheta = 90 - (180-step)/2;
base_seg = 2*base_rad*sin(step/2);

module Torus(major,minor) {
    rotate_extrude(convexity=4) {
        translate([major,0,0]) {
            circle(minor);
        }
    }
}

module Bushing(outer,inner,height,center) {
    rotate_extrude(convexity=4) {
        translate([inner,center?-height/2:0,0]) {
            square([outer-inner,height]);
        }
    }
}

module piece() {
    kludge = rod_diam*base_widening*outer_sphere_widening + 1;

    difference() {
        union() {
            rotate([0,vtheta,0]) cylinder(d=rod_diam, h=rod_height);
                
            translate([-base2can,0,0])
            cylinder(d=rod_diam,h=ring_height);
            
            if(!solid_base) {
                rotate([-90,0,htheta])
                cylinder(r=rod_rad*base_widening, h=base_seg);
                
                rotate([-90,0,90])
                cylinder(r=rod_rad*base_widening, h=base_rad);
                
                sphere(r=rod_rad*base_widening*outer_sphere_widening);
            }
        }
        
                    
        rotate([0,vtheta*cos(htheta),htheta])
        translate([rod_rad*base_widening,-kludge/2,-ring_height/2])
        cube([kludge, kludge, ring_height]);
        
        rotate([0,vtheta*cos(htheta),-htheta])
        translate([rod_rad*base_widening,-kludge/2,-ring_height/2])
        cube([kludge, kludge, ring_height]);
    }
}

module inner_wings_top() {
    difference() {
        Bushing(outer=can_rad+rod_rad+rod_rad/2,
                inner=can_rad+rod_rad-rod_rad/2,
                height=ring_height);
        
        // minus angled wings so we're only printing what we have to:
        for (i=[0:num_sides]) {
            angle = step * i + step/2; // offset halfway between supports
            rotate([0,0,angle])
            translate([can_rad,0,-base_diam*sqrt(2)+ring_height])
            rotate([45,0,0])
            cube([can_rad,2*base_diam,2*base_diam],center=true);
        }
    }
}

module stabilizer() {
    // The main pieces:
    for (i = [0:num_sides]) {
        angle = step * i;
        
        translate([base_rad*cos(angle),base_rad*sin(angle),0])
        rotate([0,0,angle])
        piece();
    }
        
    
    // the ring at the top:
    translate([0,0,ring_height])
    Torus(major=can_rad+rod_rad,minor=rod_rad,$fn=64);
    
    // That's going to need some support to print...
    inner_wings_top();
    translate([0,0,ring_height]) rotate([180,0,0]) inner_wings_top();
    
    // the base:
    if(solid_base) {
        cylinder(d=base_diam+rod_diam,
                 h=rod_diam,
                 $fn=num_sides);
    } else {
        // Option 1:
        //translate([0,0,rod_rad])
        //Torus(major=can_rad+rod_rad,minor=rod_rad);
        
        // Option 2:
        Torus(major=can_rad+rod_rad,
              minor=rod_rad*base_widening,
              $fn = num_sides*base_mid_ring_mult);
    }
}

// A can, for reference:
//translate([0,0,rod_rad*base_widening]) 
//%cylinder(d=can_diam-1, h=110);
//%Bushing(outer=(can_diam-1)/2, inner=20, height=110);

//scale([0.25,0.25,0.25])
difference() {
    stabilizer();
    
    // Trim off bits of the tilted vertical rods that
    // poke through the base:
    translate([-base_diam,-base_diam,-2*ring_height])
    cube([2*base_diam,2*base_diam,2*ring_height]);
}
