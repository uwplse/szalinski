// Length
length = 160;

// Width
width = 40;

// Height
height = 2;

// Thickness of bottom
bottom_thickness = 0.5;

// Border width
border = 2;

// Open front
cut_front = true;



pad = 0.1;	// Padding to maintain manifold
round_r = 2;	// Radius of round
smooth = 45;	// Number of facets of rounding cylinder

// To fix the corners cut the main cube with smaller cubes with spheres removed

difference() {
    rounded_box(length + border*2, width + border*2, height, pad);
    
    translate([0, 0, bottom_thickness]) {
        cube([length, width, height], center = true);
    }
    
    if(cut_front)
        translate([0, width/2+border/2-pad/2, 0])
            cube([length+border*2, border+pad, height+border], center = true);
}





module rounded_box(box_l, box_w, box_h, pad) {
   
    difference() {
        cube([box_l, box_w, box_h], center = true);
    
        translate([0, -box_w/2+round_r, box_h/2-round_r]) {
            difference() {
                translate([0,-round_r-pad,round_r+pad])
                    cube([box_l+2*pad, round_r*2+pad, round_r*2+pad], center = true);
                rotate(a=[0,90,0])
                    cylinder(box_l+4*pad,round_r,round_r,center=true,$fn=smooth);
            }
        }
        translate([0, box_w/2-round_r, box_h/2-round_r]) {
            difference() {
                translate([0,round_r+pad,round_r+pad])
                    cube([box_l+2*pad, round_r*2+pad, round_r*2+pad], center = true);
                rotate(a=[0,90,0])
                    cylinder(box_l+4*pad,round_r,round_r,center=true,$fn=smooth);
            }
        }
    
        translate([-box_l/2+round_r, 0, box_h/2-round_r]) {
            difference() {
                translate([-round_r-pad, 0, round_r+pad])
                    cube([round_r*2+pad, box_w+2*pad, round_r*2+pad], center = true);
                rotate(a=[0,90,90])
                    cylinder(box_w+4*pad,round_r,round_r,center=true,$fn=smooth);
            }
        }
        translate([box_l/2-round_r, 0, box_h/2-round_r]) {
            difference() {
                translate([round_r+pad, 0, round_r+pad])
                    cube([round_r*2+pad, box_w+2*pad, round_r*2+pad], center = true);
                rotate(a=[0,90,90])
                    cylinder(box_w+4*pad,round_r,round_r,center=true,$fn=smooth);
            }
        }
    }
}


