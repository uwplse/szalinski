// Round customizable lends hood.  Orignally designed for standard lense on Sony A6000
// Base desined to slip over and grip focus ring.
// Designed to print without supports

// Designed by Gorgar thingiverse user

/* [General] */

// Base section defaults fits the Sony A6000 standard lense.  Only Change if different lense.
 // Lense outer diameter in mm
lense_d = 64.58;  
// Width of hood that grips onto the lense
lense_grip_w = 15;
// thickness of hood around lense grip area in mm
lense_wall = 5;

// This is a small indent that mounts the hood flush against
// the small bevel at the end of the lense.
bumper_h = 3;
bumper_d = lense_d - 2.5;

// There is small indent after the focus ring
// Intended to help the grip, but this is probably not needed but it does not hurt
base_ring_h = 2.2; 
base_ring_d = lense_d - .28;

// The degrees between each gap on the base grip.
// These gaps allow the base to be flexible and fit over the lense focur ring
// I would not go smaller than 9 degrees (should be a factor of 360 if u want symmetry)
gap_step = 9;  
// size of each gap in mm.  Cannot think of a good reason to change this
gap_w =1; 

// Length of the first flared section out from the end of the lense
mid_l = 50; 
// Diameter (inner) at end of mid flar section.
// Depending on your lense you will need wider or narrower.
mid_d = 130; 
// Thickness of hood in mid flare section in mm
mid_wall = 2.5;


// Length of outer flare section.
end_l = 25;
// End flare diameter.  Make sure it is not in the frame of the lense
end_d = 140;
end_wall = 2.5;

// Which one would you like to see?   You can just print the base part to make sure it fits your lense before printing the whole thing.   The defaults work for the A6000 standard lens
part = "all"; // [all:All assembled together,baseonly:Just the base that attached to camera lense,hoodonly:Just the flare hood portion]


$fn = 40;

echo(version=version());

render() {
translate([0,0,end_l+mid_l+lense_grip_w]) rotate([180,0,0]) coneHood();
}

*cylinder(h=110,d1=50,d2=100);

module coneHood() {

if  ( part=="all" || part=="baseonly")  {
  
difference() {
    union() {
        difference () {
            minkowski() {
                linear_extrude(height = lense_grip_w) {
                           circle(d=lense_d);    
                }
                cylinder(d=lense_wall,h=1);
            }
            translate([0,0,lense_grip_w]) cylinder(d=lense_wall+lense_d+1,h=2);
            linear_extrude(height = lense_grip_w) {
                    circle(d=lense_d);
            }
            
        }

        translate([0,0,lense_grip_w-bumper_h]) {
            difference() {
                cylinder(h=bumper_h, d=lense_d+lense_wall/2);
                cylinder(h=bumper_h, d1=lense_d, d2=bumper_d);
            }
        }
        difference() {
            cylinder(h=base_ring_h, d=lense_d+lense_wall/2);
            cylinder(h=base_ring_h, d=base_ring_d);
        }
    }
    for (a=[gap_step:gap_step:180]) {
        rotate([0,0,a]) cube([gap_w,2*(lense_d+lense_wall+1), 2*lense_grip_w -1],center=true);
    }
}
}

if  ( part=="all" || part=="hoodonly")  {
translate([0,0,lense_grip_w]) {
    difference() {
        minkowski() {
            linear_extrude(height = mid_l, scale = mid_d/lense_d) {
                circle(d=lense_d);
            }
            cylinder(d=mid_wall,h=1);
        }
        translate([0,0,mid_l])  cylinder(d=mid_d+mid_wall+1,h=2);
        linear_extrude(height = mid_l, scale = mid_d/lense_d) {
                circle(d=lense_d);
        }
    }
    
}
        

translate([0,0,lense_grip_w+mid_l]) {
    difference() {
        minkowski() {
            linear_extrude(height = end_l, scale = end_d/mid_d) {
                circle(d=mid_d);
            }
            cylinder(d=end_wall,h=1);
        }
        translate([0,0,end_l]) cylinder(d=end_d+end_wall+1,h=2);
        linear_extrude(height = end_l, scale = end_d/mid_d) {
                circle(d=mid_d);
        }
    }
}
}
}
   


