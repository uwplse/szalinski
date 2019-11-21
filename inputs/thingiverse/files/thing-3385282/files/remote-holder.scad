////////////////
// Parametric multi remote holder
// https://www.thingiverse.com/thing:3385282
//
// This is a remix of
// https://www.thingiverse.com/thing:485228
//
// made by Klaus Moser
////////////////

// Resolution
$fn=32;

// Remote widths
remote_width = [54, 51, 50];

// Text for remotes
remote_text = ["TV", "1&1", "Stereo"];

// Remote thickness
remote_thickness = 27;

// Holder height
height = 100;

// Difference front to back
slope_offset = 10;

// wall_width width (for best result put multiple of nozzle)
wall_width = 2.8; 

// Width of left and right edges
x_window = 4;

// Bottom edge height
z_window = 4;

// Bottom window width
bottom_window_width = 20;

// Screw hole diameter
screw_hole_diameter = 3.4;

// Screw head diameter
screw_head_diameter = 6;

// Screw head height
screw_head_height = 3;

// Engraving depth
engraving_depth = 1;

///////////////////////
// Calculated values //
///////////////////////
r = wall_width/2;
z_holder = height-wall_width;


function addl(list, c = 0) = 
    c > 0 ? 
    list[c] + addl(list, c - 1) 
    :
    list[c];
 
///////////
// Build //
///////////
holder(remote_width[0], remote_text[0], 0);
for (i=[1:len(remote_width)-1]) {
    translate([addl(remote_width, i-1)+i*wall_width,0,0]) {
        holder(remote_width[i], remote_text[i], i);
    }
}


/////////////
// Modules //
/////////////
module holder(width, text, position) {

    translate([0,0,r]) {
        
        difference() {
            back_wall(width);
            
            // Screw hole
            if (position == 0 || position == len(remote_width)-1) {
                translate([
                    r+width/2,
                    remote_thickness,
                    2/3*height
                ]) {
                    screw_hole();
                }
            }

            // Text
            translate([
                r+width/2,
                remote_thickness+engraving_depth,
                1/3*height
            ]) {
                rotate(90, [1,0,0])
                    linear_extrude(height=engraving_depth) {
                        text(
                            text,
                            font = "Liberation Sans",
                            valign = "center",
                            halign = "center"
                        );
                    }
            }
        }

        left_wall(width);
        front_left(width);
        front_bottom_left(width);

        right_wall(width);
        front_right(width);
        front_bottom_right(width);
       
        bottom_left(width);
        bottom_right(width);
    }
}
    
module back_wall(width) {

    translate([0, remote_thickness+r, 0]) {
        hull() {
            translate([r, 0, 0]) {
                sphere(r = r);
            }
        
            translate([width+3*r, 0, 0]) {
                sphere(r = r);
            }

            translate([r, 0, height]) {
                sphere(r = r);
            }
        
            translate([width+3*r, 0, height]) {
                sphere(r = r);
            }
        }
    }
}

module left_wall(width) {

    translate([r, 0, 0]) {
        hull() {
            sphere(r = r);
            
            translate([0, remote_thickness+r, 0]) {
                sphere(r = r);
            }

            translate([0, 0, height-slope_offset]) {
                sphere(r = r);
            }
            
            translate([0, remote_thickness+r, height]) {
                sphere(r = r);
            }
        }
    }
}

module right_wall(width) {

    translate([width+3*r, 0, 0]) {
        hull() {
            sphere(r = r);
            
            translate([0, remote_thickness+r, 0]) {
                sphere(r = r);
            }

            translate([0, 0, height-slope_offset]) {
                sphere(r = r);
            }
            
            translate([0, remote_thickness+r, height]) {
                sphere(r = r);
            }
        }
    }
}

module front_left(width) {

    translate([x_window/2+r, 0, 0]) {
        hull() {
            translate([-x_window/2, 0, 0]) {
                sphere(r = r);
            }
            
            translate([x_window/2, 0, 0]) {
                sphere(r = r);
            }

            translate([-x_window/2, 0, height-slope_offset]) {
                sphere(r = r);
            }
            
            translate([x_window/2, 0, height-slope_offset]) {
                sphere(r = r);
            }
        }
    }
}

module front_right(width) {

    translate([-x_window/2+width+3*r, 0, 0]) {
        hull() {
            translate([-x_window/2, 0, 0]) {
                sphere(r = r);
            }
            
            translate([x_window/2, 0, 0]) {
                sphere(r = r);
            }

            translate([-x_window/2, 0, height-slope_offset]) {
                sphere(r = r);
            }
            
            translate([x_window/2, 0, height-slope_offset]) {
                sphere(r = r);
            }
        }
    }
}

module front_bottom_left(width) {

    translate([r, 0, 0]) {
        hull() {
            translate([0, 0, 0]) {
                sphere(r = r);
            }

            translate([
                width/2-bottom_window_width/2,
                0,
                0
            ]) {
                sphere(r = r);
            }

            translate([0, 0, z_window]) {
                sphere(r = r);
            }

            translate([
                width/2-bottom_window_width/2,
                0,
                z_window
            ]) {
                sphere(r = r);
            }
        }
    }
}

module front_bottom_right(width) {

    translate([
        2*r+width/2+bottom_window_width/2,
        0,
        0
    ]) {
        hull() {
            sphere(r = r);
            
            translate([
                width/2-bottom_window_width/2,
                0,
                0
            ]) {
                sphere(r = r);
            }

            translate([
                0,
                0,
                z_window
            ]) {
                sphere(r = r);
            }
            
            translate([
                width/2-bottom_window_width/2,
                0,
                z_window
            ]) {
                sphere(r = r);
            }
        }
    }
}

module bottom_left(width) {

    hull() {
        translate([r, 0, 0]) {
            sphere(r = r);
        }
        
        translate([r, remote_thickness+r, 0]) {
            sphere(r = r);
        }

        translate([
            r+width/2-bottom_window_width/2,
            0,
            0
        ]) {
            sphere(r = r);
        }
        
        translate([
            r+width/2-bottom_window_width/2,
            remote_thickness+r,
            0
        ]) {
            sphere(r = r);
        }
    }
}

module bottom_right(width) {

    hull() {
        translate([
            width+3*r,
            0,
            0
        ]) {
            sphere(r = r);
        }
        
        translate([
            width+3*r,
            remote_thickness+r,
            0
        ]) {
            sphere(r = r);
        }

        translate([
            width+2*r-width/2+bottom_window_width/2,
            0,
            0
        ]) {
            sphere(r = r);
        }
        
        translate([
            width+2*r-width/2+bottom_window_width/2,
            remote_thickness+r,
            0
        ]) {
            sphere(r = r);
        }
    }
}

module screw_hole() {
    rotate(-90, [1,0,0]) {
        cylinder(
            d1=screw_head_diameter,
            d2=screw_hole_diameter,
            h=screw_head_height
        );
        translate([0,0,screw_head_height]) {
            cylinder(d=screw_hole_diameter, h=wall_width);
        }
    }
}
