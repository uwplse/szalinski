base_size = 36;
hole_spacing = 30.5;
mounting_hole_radius = 1.5;
base_thickness = 1.5;
receiver_width = 23;
receiver_length = 23;
receiver_height = 7.5;
wall_thickness = 1;
zip_tie_center = 18; //from back
zip_tie_length = 4;
zip_tie_width = 2;
bevel_radius = 1;

$fs = 0.05;

module bevel(r, l) {
    translate([-r, -r, 0]) {
        difference() {
            translate([r/2, r/2, 0]) {
                cube([r+$fs, r+$fs, l+$fs], center=true);
            }
            cylinder(r=r, h=l+$fs*2, center=true);
        }
    }
}

module bevel_trans(r, l, tr, rot) {
    translate(tr) {
        rotate(rot) {
            bevel(r=r, l=l);
        }
    }    
}

module mounting_hole(x, y, s, r, t) {
    translate([s/2*x, s/2*y, 0]) {
        cylinder(r=r, h=t+$fs, center=true);
    }
}
module base(b, s, r, t) {
    difference() {
        cube([b, b, t], center=true);
        union() {
            mounting_hole(1, 1, s, r, t);
            mounting_hole(-1, 1, s, r, t);
            mounting_hole(1, -1, s, r, t);
            mounting_hole(-1, -1, s, r, t);
            br = (b-s)/2;
            bevel_trans(tr=[b/2, b/2, 0], rot=[0, 0, 0], r=br, l=t+$fs);
            bevel_trans(tr=[-b/2, b/2, 0], rot=[0, 0, 90], r=br, l=t+$fs);
            bevel_trans(tr=[b/2, -b/2, 0], rot=[0, 0, -90], r=br, l=t+$fs);
            bevel_trans(tr=[-b/2, -b/2, 0], rot=[0, 0, 180], r=br, l=t+$fs);
        }
    }
}

module walls(b, l, w, h, t, bt, br) {
    difference() {
        union() {
            translate([0, (b-l)/2, (h+bt)/2]) {
                difference() {
                    cube([w+(t*2), l, h], center=true);
                    cube([w+$fs, l+$fs, h+$fs], center=true);
                }
            }
            //bottom short bevel
            bevel_trans(tr=[-(w+t)/2, b/2-l, bt/2], rot=[0, 90, 0], r=br, l=t-$fs);
            bevel_trans(tr=[(w+t)/2, b/2-l, bt/2], rot=[0, 90, 0], r=br, l=t-$fs);
            
            //bottom long bevel
            bevel_trans(tr=[-w/2, (b-l)/2, bt/2], rot=[0, 90, 90], r=br, l=l-$fs);
            bevel_trans(tr=[-(w/2+t), (b-l)/2, bt/2], rot=[0, 90, -90], r=br, l=l-$fs);
            bevel_trans(tr=[w/2+t, (b-l)/2, bt/2], rot=[0, 90, 90], r=br, l=l-$fs);
            bevel_trans(tr=[w/2, (b-l)/2, bt/2], rot=[0, 90, -90], r=br, l=l-$fs);
            
            //wrap around bevels
            intersection() {
                bevel_trans(tr=[-(w+t)/2, b/2-l, bt/2], rot=[0, 90, 0], r=br, l=t*4);
                bevel_trans(tr=[-w/2, (b-l)/2, bt/2], rot=[0, 90, 90], r=br, l=l*2);
            }
            intersection() {
                bevel_trans(tr=[-(w+t)/2, b/2-l, bt/2], rot=[0, 90, 0], r=br, l=t*4);
                bevel_trans(tr=[-(w/2+t), (b-l)/2, bt/2], rot=[0, 90, -90], r=br, l=l*2);
            }
            intersection() {
                bevel_trans(tr=[(w+t)/2, b/2-l, bt/2], rot=[0, 90, 0], r=br, l=t*4);
                bevel_trans(tr=[w/2+t, (b-l)/2, bt/2], rot=[0, 90, 90], r=br, l=l*2);
            }
            intersection() {
                bevel_trans(tr=[(w+t)/2, b/2-l, bt/2], rot=[0, 90, 0], r=br, l=t*4);
                bevel_trans(tr=[w/2, (b-l)/2, bt/2], rot=[0, 90, -90], r=br, l=l*2);
            }

        }
        //top bevel
        bevel_trans(tr=[(w+t)/2, b/2-l, bt/2+h], rot=[0, -90, 180], r=br, l=t+$fs);
        bevel_trans(tr=[-(w+t)/2, b/2-l, bt/2+h], rot=[0, -90, 180], r=br, l=t+$fs);
        bevel_trans(tr=[(w+t)/2, b/2, bt/2+h], rot=[0, -90, 0], r=br, l=t+$fs);
        bevel_trans(tr=[-(w+t)/2, b/2, bt/2+h], rot=[0, -90, 0], r=br, l=t+$fs);
    }
}
module zip_tie_holes(b, c, l, w, rw, rh, t, bt, br) {
    difference() {
        union() {
            translate([rw/2+w/2+t+br, b/2-c, 0]) {
                rotate([0, 0, 90]) {
                    cube([l, w, bt+$fs], center=true);
                }
            }
            translate([-(rw/2+w/2+t+br), b/2-c, 0]) {
                rotate([0, 0, 90]) {
                    cube([l, w, bt+$fs], center=true);
                }
            }
            translate([rw/2+t/2, b/2-c, bt/2+rh-t/2]) {
                rotate([0, 0, 90]) {
                    cube([l, t+$fs, t+$fs], center=true);
                }
            }
            translate([-(rw/2+t/2), b/2-c, bt/2+rh-t/2]) {
                rotate([0, 0, 90]) {
                    cube([l, t+$fs, t+$fs], center=true);
                }
            }
        }
        //top bevels
        bevel_trans(tr=[rw/2+t/2, b/2-c+l/2, bt/2+rh-t], rot=[0, 90, 0], r=br, l=t+$fs);
        bevel_trans(tr=[rw/2+t/2, b/2-c-l/2, bt/2+rh-t], rot=[0, 90, 180], r=br, l=t+$fs);
        bevel_trans(tr=[-(rw/2+t/2), b/2-c+l/2, bt/2+rh-t], rot=[0, 90, 0], r=br, l=t+$fs);
        bevel_trans(tr=[-(rw/2+t/2), b/2-c-l/2, bt/2+rh-t], rot=[0, 90, 180], r=br, l=t+$fs);
        
        //bottom bevels
        bevel_trans(tr=[rw/2+w/2+br, b/2-c+l/2, 0], rot=[0, 180, 0], r=br, l=bt+$fs);
        bevel_trans(tr=[rw/2+w/2+br, b/2-c-l/2, 0], rot=[0, 180, 90], r=br, l=bt+$fs);
        bevel_trans(tr=[rw/2+w/2+br+w, b/2-c+l/2, 0], rot=[0, 180, -90], r=br, l=bt+$fs);
        bevel_trans(tr=[rw/2+w/2+br+w, b/2-c-l/2, 0], rot=[0, 180, 180], r=br, l=bt+$fs);
        
        bevel_trans(tr=[-(rw/2+w/2+br+w), b/2-c+l/2, 0], rot=[0, 180, 0], r=br, l=bt+$fs);
        bevel_trans(tr=[-(rw/2+w/2+br+w), b/2-c-l/2, 0], rot=[0, 180, 90], r=br, l=bt+$fs);
        bevel_trans(tr=[-(rw/2+w/2+br), b/2-c+l/2, 0], rot=[0, 180, -90], r=br, l=bt+$fs);
        bevel_trans(tr=[-(rw/2+w/2+br), b/2-c-l/2, 0], rot=[0, 180, 180], r=br, l=bt+$fs);
    }
}
module component(base_size, hole_spacing, mounting_hole_radius, base_thickness, receiver_width, receiver_length, receiver_height, wall_thickness, zip_tie_center, zip_tie_length, zip_tie_width, bevel_radius) {
    difference() {
        union() {
            base(base_size, hole_spacing, mounting_hole_radius, base_thickness);
            walls(base_size, receiver_length, receiver_width, receiver_height, wall_thickness, base_thickness, bevel_radius);
        }
        zip_tie_holes(base_size, zip_tie_center, zip_tie_length, zip_tie_width, receiver_width, receiver_height, wall_thickness, base_thickness, bevel_radius);
    }
}


component(base_size, hole_spacing, mounting_hole_radius, base_thickness, receiver_width, receiver_length, receiver_height, wall_thickness, zip_tie_center, zip_tie_length, zip_tie_width, bevel_radius);