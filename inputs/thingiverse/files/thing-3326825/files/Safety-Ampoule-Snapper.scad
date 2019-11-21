// Ampoule Snapper

// Ampoule diameter
amp_d = 10.5;
// Ampoule base length
amp_b = 25;
// Ampoule top length
amp_t = 22;

// Wall thickness
wall_t = 2;

// Bendy coupler length for middle joint
coupler_l = 1.5;
// Bendy coupler length for outer joint
coupler_top_l = 6;
// Bendy coupler thickness
coupler_h = 1;

/* [Hidden] */
$fs=1;
zilch=0.001;
block_h = amp_d/2+wall_t;
block_w = amp_d*1.2+wall_t*2;
block_base_l = amp_b+wall_t*2;
block_top_l = amp_t+wall_t*2;

module block_base() {
    difference() {
        translate([0,0,block_h/2])
        cube([block_base_l, block_w, block_h], center=true);
        
        translate([0,0,block_h]) rotate([0,90,0]) {
            cylinder(d=amp_d, h=amp_b, center=true);
            translate([0,0,amp_b/2-zilch]) cylinder(d1=amp_d, d2=amp_d*0.65, h=wall_t+zilch*2);
        }
    }
}

module block_top() {
    difference() {
        translate([0,0,block_h/2])
        cube([block_top_l, block_w, block_h], center=true);
        
        translate([0,0,block_h]) rotate([0,90,0]) {
            cylinder(d1=amp_d*0.8, d2=amp_d*0.6, h=amp_t, center=true);
        }
        top_bulge = wall_t*2;
        translate([-block_top_l/2+wall_t/2-zilch,0,block_h]) rotate([0,90,0]) {
            cylinder(d1=amp_d*0.65, d2=amp_d*0.9, h=top_bulge+zilch*3, center=true);
            translate([0,0,top_bulge]) cylinder(d1=amp_d*0.9, d2=amp_d*0.65, h=top_bulge +zilch*3, center=true);
        }
    }
}

translate([-block_base_l/2,0,]) {
    rotate(180) {
        translate([0,-block_w/2,block_h-coupler_h*2]) cube([coupler_top_l, block_w, coupler_h]);
        translate([block_base_l/2+coupler_top_l,0,0])
        block_base();
    }
}
block_base();
translate([block_base_l/2,0,]) {
    translate([0,-block_w/2,0]) cube([coupler_l, block_w, coupler_h]);
    translate([coupler_l+block_top_l/2,0,0]) {
        block_top();
        translate([block_top_l/2,0,0]) {
            translate([0,-block_w/2,block_h-coupler_h*2]) cube([coupler_top_l, block_w, coupler_h]);
            translate([coupler_top_l+block_top_l/2,0,0]) {
                rotate(180) block_top();
            }
        }
    }
}

