// Copyright 2017 Arthur Davis (thingiverse.com/artdavis)
// This file is licensed under a Creative Commons Attribution 4.0
// International License.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.

// Optimize view for Makerbot Customizer:
// preview[view:south east, tilt:bottom]

// Choose geometry:
part = "A-Side"; // [A-Side, B-Side, Snap]
// Length of the Egg Casing Shell
case_length = 80; // [60:2:100]
// Coupler Shoulder Length
coupler_shoulder_len = 6.0; // [1.0:1.0:25.0]
// Coupler Shoulder Diameter
coupler_shoulder_diam = 22; // [10.0:0.2:50.0]
// Fitting Shoulder Length
coupler_fitting_len = 12.0; // [5.0:1.0:25.0]
// Fitting Shoulder Diameter
coupler_fitting_diam = 17.9; // [10.0:0.2:50.0]
// Wall thickness
wall_th = 2.0; // [1.0:0.2:4.0]
// Alignment boss diameters
boss_diam = 5; // [2.0:0.2:10.0]
// Alignment pin hole dimaters
pin_diam = 2.2; // [1.0:0.2:6.0]
// Depth of alignment pin holes
pin_depth= 4.0; // [1.0:0.2:10.0]
// Width of the snapping feature boss
snap_boss_wd = 10.0; // [2.0:1.0:20.0]
// Height of the snapping feature boss
snap_boss_ht = 3.0; // [1.0:1.0:10.0]
// Thickness of the snapping feature
snap_th = 2.0; // [1.0:1.0:6.0]
// Width of the snapping feature
snap_wd = 8.0; // [2.0:1.0:18.0]

/* [Hidden] */
// Special variables for facets/arcs
$fn = 48;

// Incremental offset to make good overlap for CSG operations
delta = 0.1;

// Amount to undersize features so they'll fit into cutouts
fit_tol = 0.2;

// Coupler extension to overlap with egg shell
coupler_extra = 50.0;

// Number of steps to sample the half profile of the shell
steps = 100;

// X-coordinates for the studs
stud_xpts = [0.2 * case_length, 0.8 * case_length];

// Egg profile computing function
function egg(x, l=case_length)= 0.9*l*pow(1-x/l, 2/3)*sqrt(1-pow(1-x/l, 2/3));

// Create egg profile
module egg_profile(length=case_length, offset=0, steps=steps) {
    ss = length / (steps-1); // step size
    v1 = [for (x=[0:ss:length]) [egg(x, length), x + offset]];
    // Make absolute sure the last point brings the profile
    // back to the axis
    v2 = concat(v1, [[0, length + offset]]);
    // Close the loop
    v3 = concat(v2, [[0, offset]]);
        polygon(points = v3);
}

// Create a solid egg part
module solid_egg(length=case_length, offset=0, steps=steps) {
    rotate_extrude(convexity = 10) {
        egg_profile(length=length, offset=offset, steps=steps);
    }
}

// Create exterior shell trimming volume
module egg_trim(length=case_length, offset=0, steps=steps){
    difference() {
        translate(v = [-delta, -length*1.05, -delta]) {
            cube(size=2.1*length);
        }
        rotate(a = [0, 90.0000000000, 0]) {
            solid_egg(length=length, offset=offset, steps=steps);
        }
    }
}

module main_body() {
    rotate(a = [0, 90.0000000000, 0])
    {
        difference() {
            difference() {
                union() {
                    solid_egg(length=case_length, offset=0, steps=steps);
                    difference() {
                        union() {
                            translate(v = [0, 0, -coupler_shoulder_len]) {
                                cylinder(d = coupler_shoulder_diam,
                                         h = coupler_shoulder_len + coupler_extra);
                            }
                            translate(v = [0, 0,
                                    -(coupler_shoulder_len+coupler_fitting_len)]) {
                                cylinder(d = coupler_fitting_diam,
                                         h = coupler_fitting_len + delta);
                            }
                        }
                        translate(v = [0, 0,
                        -(coupler_shoulder_len + coupler_fitting_len + delta/2.)]) {
                            cylinder(d = coupler_fitting_diam - 2 * wall_th,
                                     h = coupler_shoulder_len + coupler_extra + coupler_fitting_len + delta);
                        }
                    }
                }
                solid_egg(case_length - 2*wall_th, wall_th);
            }
            translate(v = [0, -100.0000000000, -100.0000000000]) {
                cube(size = 200);
            }
        }
    }
}

module stud(loc_diam, cyl_diam, ht, x) {
    translate(v = [x + loc_diam/2, egg(x, case_length - loc_diam), 0]) {
        cylinder(h=ht, d=cyl_diam);
    }
    translate(v = [x + loc_diam/2, -egg(x, case_length - loc_diam), 0]) {
        cylinder(h=ht, d=cyl_diam);
    }
}

// Create boss features for mating the shell haves
module egg_boss() {
    difference() {
      union() {
          for(x = stud_xpts)stud(boss_diam, boss_diam, case_length, x);
            }
        egg_trim();
    }
}
    
// Create boss feature for snap geometry (A-Side)
module snap_boss_a(){
    difference() {
        translate(v = [case_length - snap_boss_ht - wall_th, -snap_boss_wd/2, 0]) {
            cube(size = [snap_boss_ht, snap_boss_wd, wall_th]);
        }
        egg_trim();
    }
}


// Create boss feature for snap geometry (B-Side)
module snap_boss_b(){
    difference() {
        difference() {
            translate(v = [case_length - 2*snap_boss_ht - wall_th - fit_tol, -snap_boss_wd/2,0]) {
                cube(size = [2*snap_boss_ht + fit_tol, snap_boss_wd, case_length]);
            }
            translate(v=[case_length - 2*snap_th - snap_boss_ht - fit_tol, -snap_wd/2, 0]) {
            cube(size = [snap_th, snap_wd, case_length]);
            }
        }
        egg_trim();
    }
}

module make_nosecone() {
    difference() {
        union() {
            main_body();
            if (part == "A-Side") {
                snap_boss_a();
            } else if (part == "B-Side") {
                snap_boss_b();
            }
            egg_boss(diam=boss_diam);
        }
        for(x = stud_xpts)stud(boss_diam, pin_diam, pin_depth, x);
    }
}

module make_snap() {
    slen = 3 * wall_th; // Snap length
    sht = 2*wall_th; // Snap height
    sth = wall_th - fit_tol; // Snap thickness
    swd = snap_wd - fit_tol; // Snap width
    union() {
        cube(size = [sth, slen, swd]);
        difference() {
            translate(v=[0, slen, 0]){
                cube(size = [sht, sth, swd]);
            }
            translate(v=[sht, slen, -delta/2]){
                rotate(a=[0, 0, 45])
                cube(size = [2*sth, 2*sth, swd + delta]);
            }
        }
    }
}

// Allow MakerBot Customizer to generate STL based on part selection
module print_part() {
    if (part == "Snap") {
        make_snap();
    } else {
        make_nosecone();
    }
}

//part = "A-Side";
//part = "B-Side";
//part = "Snap";
print_part();