/* [Basics] */

// model resolution
resolution = 50; // [25:Draft, 50:Normal, 80:Smooth]

// box design
base_model = "Round"; // [Round,Rectengular]

// in mm, outer dimensions [width1, widht2, height], completely round if base_model=Round and width1=width2
outer_dimensions = [40,20,60];

// in mm, thickness of the boxe's walls
wall_thickness = 1;

// in mm, slot dimensions [width1, width2, guard_height]
slot_dimensions = [25, 1, 10];

// in mm, slot wedge opening diameter, if larger than slot diameter (and a valid angle is given) a wedged slot opening will be added, else: straight slot
slot_wedge_diameter = 5;


/* [Details] */

// in degrees, angle of the slot wedge opening, if between 0 and 90 (and a valid diameter is given) a wedged slot opening will be added, else: straight slot
slot_wedge_angle = 60;

// in mm, vertical slot position offset (limited), 0 is centered
slot_position_offset = 0;

// in mm, fillet diameter
fillet_diameter = 5;

// flat bottom (fillet only on top)?
flat_bottom = "Yes"; // [No,Yes]

// debug cross_section on X/Y/Z axis
debug_cross_section = "None"; // [None,X,Y,Z]


/* Initialize constants based on parameters ============================== */
$fn=resolution;
// box dimensions
mround = base_model == "Round";
dim_d = min(outer_dimensions[0], outer_dimensions[1]);
dim_w = max(outer_dimensions[0], outer_dimensions[1]);
dim_h = outer_dimensions[2];
// slot dimensions
sdim_d = min(slot_dimensions[0], slot_dimensions[1]);
sdim_w = max(slot_dimensions[0], slot_dimensions[1]);
sdim_h = slot_dimensions[2];
// slot offset (limited but doesn't consider e.g. round corners)
soff = [0,min(slot_position_offset,dim_d/2
          -max(sdim_d,slot_wedge_diameter)/2
          -2*wall_thickness),0];
// wedge
scut_a = max(min(slot_wedge_angle,90),0); // alpha
scut_d = min(slot_wedge_diameter, dim_d/2+2*wall_thickness);
// wedge cutout base triangle
//  _a_    ___
//  \  |  |  /
//  c\ |b | /
//    \|  |/
// TODO add limit for alpha (b <= sdim_h)
scut_ti_a = (scut_d-sdim_d)/2; // leg 1 (diameter)
scut_ti_b = scut_ti_a * tan(scut_a); // leg 2 (height)
scut_ti_c = sqrt(pow(scut_ti_a,2)+pow(scut_ti_b,2)); // hypotenuse
scut_ti_h = (scut_ti_a*scut_ti_b)/scut_ti_c;
// wedge outer triangle (walls)
scut_to_h = scut_ti_h + wall_thickness;
scut_to_a = scut_to_h / sin(scut_a);
scut_to_b = scut_to_a * tan(scut_a);
scut_to_c = sqrt(pow(scut_to_a,2)+pow(scut_to_b,2));
echo(scut_to_h=scut_to_h,scut_to_a=scut_to_a,scut_to_b=scut_to_b,scut_to_c=scut_to_c);
// booleans
flat_bottom_b = flat_bottom == "Yes";
wedge_slot_b = scut_a > 0 && scut_a < 90 // valid angle
               && scut_d > 0 && scut_d > sdim_d; // valid opening diameter
overcut = 0 + 0.001; // FIXME partially not applied correctly


/* == Draw Model ========================================================= */
    
difference() {
    // draw the blade box
    BladeBox();

    // optional debug cross section
    if (debug_cross_section == "X") {
        translate([0,-dim_d/2,-overcut]) cube([dim_w,dim_d,dim_h+4*overcut]);
    } else if (debug_cross_section == "Y") {
        translate([-dim_w/2-2*overcut,-dim_d,-overcut]) cube([dim_w+4*overcut,dim_d,dim_h+4*overcut]);
    } else if (debug_cross_section == "Z") {
        translate([0,0,dim_h/2+sdim_h+wall_thickness+overcut])
            cube([dim_w+4*overcut,dim_d+4*overcut,dim_h], center=true);
    }
}

module BladeBox() {
    difference() {
        union() {
            // box
            color("DarkBlue") rotate([180,0,0])
                translate([0,0,-dim_h]) BaseBox();
            // slot
            color("Orange") translate(soff) SlotWalls();
        }
        color("Orange") translate(soff) SlotCutouts();
    }
}

module SlotWalls() {
    // slot with wedge cutout?
    if (wedge_slot_b) {
        slot_outer_w = sdim_w + 2*wall_thickness;
        WedgeSlotWalls(slot_outer_w); // add triangular walls
        // add straight slot guard
        if (sdim_h > scut_ti_b) { // only if necessary
            slot_straight_h = sdim_h - wall_thickness;
            slot_straight_d = sdim_d + 2*wall_thickness;
            translate([-slot_outer_w/2,-slot_straight_d/2,wall_thickness])
                cube([slot_outer_w,slot_straight_d,slot_straight_h]);
        }
    } else if (sdim_h > wall_thickness) { // straight rounded slot (no wedge)
        translate([0,0,wall_thickness]) // add slot guard
            SoftCylinder(d=sdim_d+wall_thickness*2, h=sdim_h-wall_thickness,
                         f=0, w=sdim_w+wall_thickness*2);
    }
}

module SlotCutouts() {
    if (wedge_slot_b) {
        WedgeSlotCutouts(sdim_w);
    } else { // straight rounded slot only (no wedge)
        SoftCylinder(d=sdim_d, h=sdim_h+wall_thickness+overcut,
                     f=0, w=sdim_w);
    }
}

module WedgeSlotWalls(w) {
    difference() {
        TriangleCutout(scut_to_a, scut_to_b, w, s=sdim_d, h=sdim_h-overcut);
        // shave off top
        translate([overcut,overcut,wall_thickness/2-overcut])
            cube([w+4*overcut,scut_to_a*2+sdim_d+2*overcut,wall_thickness+overcut], center=true);
    }
}

module WedgeSlotCutouts() {
    translate([0,0,-overcut]) {
        // wedge cutout
        TriangleCutout(scut_ti_a,scut_ti_b,sdim_w,s=sdim_d,h=sdim_h+overcut);
        // straight cutout
        translate([-sdim_w/2,-sdim_d/2,0]) cube([sdim_w,sdim_d,sdim_h+2*overcut]);
    }
}

/*
 * lX - triangle leg 1 and 2
 * w - width
 * s - additional space between triangles, resulting in trapezoid (s = top width)
 * h - hight limiter, if > 0 cut of top reducing trapezoid height to h
 */
module TriangleCutout(l1, l2, w, s=0, h=0) {
    module _Wedge() {
        translate([-w/2,0,0]) rotate([90,0,90])
            linear_extrude(w)
                polygon([[0,0],[l1,0],[0,l2]]);
    }
    difference() {
        if (s > 0) {
            hull() { // acute isosceles trapezoid
                translate([0,s/2,0]) _Wedge();
                translate([0,-s/2,0]) mirror([0,1,0]) _Wedge();
            }
        }   else {
            union() { // prism
                _Wedge();
                mirror([0,1,0]) _Wedge();
            }
        }
        if (h > 0) { // height limitation (cut off)
            x = 2*l1+s;
            translate([-w/2-overcut,-x/2-overcut,h])
                cube([w+2*overcut,x+2*overcut,l2]);
        }
    }
}

module BaseBox() {
    if (mround) {
        difference() {
            SoftCylinder(d=dim_d, h=dim_h, f=fillet_diameter, w=dim_w,
                         flat_bottom=flat_bottom_b);
            translate([0,0,wall_thickness])
                SoftCylinder(d=dim_d-2*wall_thickness, h=dim_h-2*wall_thickness,
                             f=fillet_diameter-wall_thickness, w=dim_w-2*wall_thickness,
                             flat_bottom=flat_bottom_b);
        }
    } else {
        translate([0,0,dim_h/2]) {
            difference() {
                RoundCube([dim_w, dim_d, dim_h],
                          fillet_diameter, flat_bottom=flat_bottom_b,
                          center=true);
                RoundCube([dim_w-2*wall_thickness,
                           dim_d-2*wall_thickness,
                           dim_h-2*wall_thickness],
                          fillet_diameter-wall_thickness, flat_bottom=flat_bottom_b,
                          center=true);
           }
        }
    }
}

/* == Base Modules ======================================================= */

/**
 * A ring
 *
 * d - ring diameter
 * t - thickness (diameter)
 */
module Ring(d, t) {
    rotate_extrude(angle=360) translate([d/2, 0, 0]) circle(d=t);
}
//!Ring(40, 10);

/**
 * A straight cylinder with a fillet on top and optionally bottom (default)
 *
 * d - diameter
 * h - height
 * f - fillet radius, default: min(d,h)/4
 *     0 will result in a regular/stretched cylinder
 *     f must be < min(d,h)/2, if it's not min(d,h)/4 is used instead
 * w - width (stretched if >d), default: 0 (round)
 * flat_bottom - flat bottom, default: false (bottom with fillet)
 * center - center object z, default: false
 */
module SoftCylinder(d=1, h=1, f, w, flat_bottom=false, center=false) {
    fillet = f == undef || min(d,h)/2 <= f ? min(d,h)/4 : f;
    echo(d=d,h=h,f=f,fillet=fillet,w=w,flat_bottom=flat_bottom,center=center);
    module _Top() {
        if (w > d) { // stretch (no scale, we want even fillets)
            translate([(w-d)/2,0,0]) Ring(d-fillet, fillet);
            translate([-(w-d)/2,0,0]) Ring(d-fillet, fillet);
        } else {
            Ring(d-fillet, fillet);
        }
    }
    module _Cylinder() {
        hull() {
            translate([0,0,h-fillet/2]) _Top(); // top
            if (flat_bottom) {
                if (w > d) { // stretch (no scale, we want even fillets)
                    translate([(w-d)/2,0,0]) cylinder(d=(d), h=fillet);
                    translate([-(w-d)/2,0,0]) cylinder(d=(d), h=fillet);
                } else {
                    cylinder(d=(d), h=fillet);
                }
            } else {
                translate([0,0,+fillet/2]) _Top(); // bottom
            }
        }
    }
    translate([0,0,center ? -h/2 : 0]) {
        if (f > 0) { // fillet?
            _Cylinder();
        } else {
            if (w > d) { // stretch?
                hull() {
                    translate([(w-d)/2,0,0]) linear_extrude(h) circle(d=d);
                    translate([-(w-d)/2,0,0]) linear_extrude(h) circle(d=d);
                }
            } else {
                linear_extrude(h) circle(d=d);
            }
        }
    }
}
//!SoftCylinder(40, 20, 5, flat_bottom=false, center=true); // cylinder(d=40, h=20, center=true);
//!SoftCylinder(30, 20, 5, flat_bottom=true); // !cylinder(d=30, h=20);
//!SoftCylinder(40, 2, 0.8, flat_bottom=true, center=true); //!cylinder(d=40, h=2, center=true);
//!SoftCylinder(30, 20, 5, w=50, flat_bottom=true); // stretched
//!SoftCylinder(10, 50, 0, w=25, flat_bottom=true);
//!SoftCylinder(10, 50, 5, w=25, flat_bottom=true);


/* cube with with rounded edges
 * dim - dimensions [x,y,z]
 * fr - fillet radius, default: ff * min(dim), 0.0001 if <= 0
 * ff - fillet factor, default 1/4, ignored if fr is provided
 * flat_bottom - bottom half is flat, top half is rounded, default: false
 * center - center the model, default: false
 * hollow - hollow (frame only), default: false
 */
module RoundCube(dim, fr, ff=1/4, flat_bottom=false, center=false, hollow=false) {
    rv = fr == undef ? min(dim[0],dim[1],dim[2]) * ff : fr;
    r = rv <= 0 ? 0.0001 : rv;
    module _Corner() {
        union() {
            translate(lvmult(dim, [-1/2,-1/2,1]) + [r,r,-r]) {
                sphere(r=r);
                if (flat_bottom) {
                    translate([0,0,-dim[2]+r]) cylinder(r=r, h=dim[2]-r);
                } else {
                    translate([0,0,-dim[2]+r*2]) sphere(r=r);
                }
            }
        }
    } // base
    translate(lvmult(dim, center ? [0,0,-1/2] : [1/2,1/2,0])) {
        if (hollow) {
            union() {
                hull() { _Corner(); mirror([1,0,0]) _Corner(); }
                hull() { mirror([1,0,0]) _Corner(); rotate([180,180,0]) _Corner(); }
                hull() { rotate([180,180,0]) _Corner(); mirror([0,1,0]) _Corner(); }
                hull() { mirror([0,1,0]) _Corner(); _Corner(); }
            }
        } else {
            hull() {
                _Corner();
                for (p = [[1,0,0], [0,1,0]]) mirror(p) _Corner();
                rotate([180,180,0]) _Corner();
            }
        }
    }
}
//!RoundCube([10,20,15]);
//!RoundCube([20,40,15], 3, flat_bottom=true, hollow=true);


/* cube with softened (z-axis) edges, error tolerant version
 size    [x,y,z]
 radius  fillet radius, standard cube if <= 0, limited to x/y dimensions (fully rounded x/y edges)
 expand  fillet, size defines outer dimensions (false, default) or add radius to x/y size (true)
 center  center cube (default: false)
 hollow  frame only, width = radius
 - based on https://www.thingiverse.com/thing:9347
*/
module SoftCube(size, radius, expand=false, center=false, hollow=false) {
    x = size[0]; y = size[1]; z = size[2];
    r = min(x/(expand ? 1 : 2), y/(expand ? 1 : 2), radius); // maximum radius (must not exceed x/y dimensions)
    off = r / (expand ? 2 : 1);
    // corner points
    points=[[ x/2 - off,  y/2 - off, 0],
            [ x/2 - off, -y/2 + off, 0],
            [-x/2 + off, -y/2 + off, 0],
            [-x/2 + off,  y/2 - off, 0]];
    if (radius <= 0) { // standard cube, no fillet
        cube(size, center);
    } else {
        translate (center ? [0,0,-z/2] : [x/2,y/2,0]) {
            if (hollow) {
                for (i=[0:len(points)-1]) {
                    hull() {
                        translate(points[i]) cylinder(r=r, h=z);
                        translate(points[i > len(points)-2 ? 0 : i+1])
                            cylinder(r=r, h=z);
                    }
                }
            } else {
                // create circles in place of the 4 corner points
                hull() for (p=points) translate(p) cylinder(r=r, h=z);
            }
        }
    }
}
//SoftCube([20,20,20], 2, $fn=50);
//SoftCube([40,10,20], 220, center=true, $fn=50);
//SoftCube([20,10,20], 200, expand=true, center=true, $fn=50);
//!SoftCube([20,10,20], 5, expand=true, center=true, $fn=50);


/* == Vector/Matrix Math ================================================= */

/* Lazy vector multiplication
 * Multiplies all vectors in matrix m using dimensions of v0, ignoring
 * additional dimensions of vector v1 to vN
 * m - a matrix [v0,..,vn] where v0 dimensions are dimensions of res. vector
 */
function lvmult(v1, v2=[1,1,1], v3=[1,1,1], v4=[1,1,1]) =
    v1[2] == undef
      ? [v1[0]*v2[0]*v3[0]*v4[0],
         v1[1]*v2[1]*v3[1]*v4[1]]
      : [v1[0]*v2[0]*v3[0]*v4[0],
         v1[1]*v2[1]*v3[1]*v4[1],
         v1[2]*(v2[2]==undef?1:v2[2])*(v3[2]==undef?1:v3[2])*(v4[2]==undef?1:v4[2])];


/* Lazy vector division
 * Divide up to 4 vectors with size 2 or 3
   v1 is used to identify the dimensions
   if v2 to v4 have more dimensions they are ignored
   if v2 to v4 have less dimensions 1 is assumumed */
function lvdiv(v1, v2=[1,1,1], v3=[1,1,1], v4=[1,1,1]) =
    v1[2] == undef
      ? [v1[0]/v2[0]/v3[0]/v4[0],
         v1[1]/v2[1]/v3[1]/v4[1]]
      : [v1[0]/v2[0]/v3[0]/v4[0],
         v1[1]/v2[1]/v3[1]/v4[1],
         v1[2]/(v2[2]==undef?1:v2[2])/(v3[2]==undef?1:v3[2])/(v4[2]==undef?1:v4[2])];
//echo(lvdiv([10,20,30],[2,3,4]));
//echo(lvdiv([10,20,30],[2,3,4],[10,10,10],[2,2,2]));
//echo(lvdiv([2,3],[3,4,1]));
