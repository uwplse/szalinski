
/* [Size] */

// width of stomp pad, should be less than the width of your board
_width = 200;

// length of the stomp pad, usually about the width of your boot
_length = 108;

// radius of the rounded corners
_radius = 30;

// thickness of the stomp pad, not including the ridges
_base_thickness = 1.2;


/* [Ridges] */

// spacing of the ribs
_ridge_spacing = 22;

// width of the ridges
_ridge_size = 8;

// height of the ridges
_ridge_height = 3;

// angle of the ridges
_ridge_angle = 70;


/* [Cuts] */

// spacing of the cuts along the length of the pad
_cut_spacing = 22;

// width of the cuts
_cut_width = 1;

// depth of the cuts
_cut_depth = 0.25;

/* [Hidden] */
EPS = 0.1;
MAX_BASE_CUT = 0.25;

module rrect(h, w, l, r) {
    r = min(r, min(w/2, l/2));
    w = max(w, EPS);
    l = max(l, EPS);
    h = max(h, EPS);
    if (r <= 0) {
        translate([-w/2, -l/2,0]) {
            cube([w,l,h]);
        }
    } else {
        hull() {
            for (y = [-l/2+r, l/2-r]) {
                for (x = [-w/2+r, w/2-r]) {
                    translate([x,y,0]) {
                        cylinder(h=h, r=r, center=false);
                    }
                }
            }
        }
    }
}

module cutout(w, l, spacing, h, cutw, cutd) {
    for (i = [0:spacing:l]) {
        translate([0,i - spacing * floor(0.5 * l/spacing), h]) {
            cube(size=[w, cutw, cutd*2], center=true);
        }
    }
}


module createPart(width, length, radius, base_thickness, ridge_size, ridge_height, ridge_spacing, ridge_angle, cut_spacing, cut_width, cut_depth) {

    intersection () {
        difference() {
            union() {
                difference() {
                    cube(size=[width, length, base_thickness*2], center=true);
                    cutout(width, length, cut_spacing/2, base_thickness, cut_width, MAX_BASE_CUT);
                }
                for (i = [0:ridge_spacing:width]) {
                    hull() {
                        translate([i - ridge_spacing * floor(0.5 * width/ridge_spacing),0,0]) {
                            cube(size=[ridge_size, length, base_thickness*2], center = true);
                            cube(size=[max(EPS,ridge_size - 2*ridge_height/tan(ridge_angle)), length, (base_thickness + ridge_height)*2], center = true);                            
                        }
                    }
                }
            }
            cutout(width, length, cut_spacing, ridge_height + base_thickness, cut_width, min(cut_depth, ridge_height + MAX_BASE_CUT));
        }
        rrect((base_thickness + ridge_height)*2, width, length, radius, $fn=90);
    }

}

createPart(_width, _length, _radius, _base_thickness, _ridge_size, _ridge_height, _ridge_spacing, _ridge_angle, _cut_spacing, _cut_width, _cut_depth);
