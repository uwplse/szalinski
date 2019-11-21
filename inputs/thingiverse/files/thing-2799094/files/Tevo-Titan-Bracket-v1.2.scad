// in mm, [x,y,z] dimensions of the stepper motor base plate (note: add some x clearance)
stepper_dimensions = [42.5,42,40];

// boolean, auto fit height to match attachment bracket
stepper_autofit_height_p = "yes"; // [yes,no]
//stepper_autofit_height_p = "no"; // preset: rotated mount

// in mm, diameter
stepper_bore = 24; // [0:50]

// in mm, screw hole rectangle [x,y] (centered on base plate)
stepper_screw_rectangle = [31,31];

// in mm, screw hole diameter
stepper_screw_diameter = 3.4; // [0:15]

// in mm, affects heigt of grid and screw hole reinforcement (width via thickness)
stepper_slice_thickness = 1; // [0:5]

// in mm, adds additional rigidness, 0 for none
stepper_confinement_support_height = 17; // [0:50]

// in mm, slightly thinner in original version, set to 0 (auto thickness) for simpler print (default)
//stepper_confinement_top_thickness = 0; // could be added, but only makes it less stabale and harder to print

// in mm, move stepper up on the attachment plate
stepper_to_bracket_x_offset = 0; // [0:50]
//stepper_to_bracket_x_offset = 36; // preset: rotated mount (titan roughly 25mm thick + 11mm screw hole clearance)

// slice vector, add slice to screw hole at position [0,x,y,x/y] (0: disabled, 1: enabled)
extruder_screw_hole_slices = [0,1,1,0];

// in mm, diameter of the screw hole slice
extruder_screw_hole_slice_diameter = 6.5; // [0:15]

// in mm, thickness (height) of the screw hole slice
extruder_screw_hole_slice_thickness = 1; // [0:5]

// in mm, 0 for sharp edges, auto limited to screw hole slice thickness / 2
extruder_screw_hole_slice_radius = 0.5; // [0:2]

// in mm, [x,y] dimensions of the profile attachment bracket
attachment_dimensions = [40, 70];
//attachment_dimensions = [90, 40]; // preset: rotated mount

// in mm, screw hole rectangle [x,y] (centered on profile attachment)
attachment_screw_rectangle = [16.8, 59.8];
//attachment_screw_rectangle = [80, 16.8]; // preset: rotated mount

// in mm, screw hole diameter
attachment_screw_diameter = 3.9; // [0:15]

// in mm, screw hole width (optional stretch, only effective if > screw diameter)
attachment_screw_hole_width = 7; // [0:20]

// boolean, flip screw hole orientation (if hole width > diameter)
attachment_screw_hole_flip_p = "no"; // [yes,no]
//attachment_screw_hole_flip_p = "yes"; // preset: rotated mount

// in mm, 0 for sharp edges
attachment_edge_radius = 3; // [0:5]

// in mm, general material thickness
thickness = 2; // [1:5]

// Surface detail level
resolution = 50; // [30:Draft, 50:Normal, 80:Smooth]

/* == Draw Stuff ========================================================= */
// map yes/no strings to boolean
stepper_autofit_height = stepper_autofit_height_p == "yes";
attachment_screw_hole_flip = attachment_screw_hole_flip_p == "yes";

// render
StepperBracket($fn=resolution);

// dummy titan extruder
*color("Orange") {
    clearance=0.25;
    dim=[25,46.5,43.5];
    translate([-dim.x-clearance, -dim.y/2, thickness+clearance]) cube(dim);
    h=4; d=33.7;
    translate([-h-5, dim.z/2-6.5,36]) rotate([0,90,0]) cylinder(d=d, h=h, $fn=resolution);
}
// dummy stepper motor
*color("OrangeRed") {
    clearance=0.5;
    dim=[stepper_dimensions.z,stepper_dimensions.x,stepper_dimensions.y] - [0,clearance,0];
    translate([thickness+stepper_slice_thickness+clearance, -dim.y/2, thickness+clearance]) {
        cube(dim);
        h=22; d=5;
        translate([-h,dim.y/2,dim.z/2]) 
            rotate([0,90,0]) cylinder(d=d, h=h, $fn=resolution);
    }
}

/* == Stepper Bracket ==================================================== */
// complete stepper bracket
module StepperBracket() {
    stepper_confinement_height = stepper_autofit_height
                                 ? attachment_dimensions[0]-stepper_to_bracket_x_offset
                                 : stepper_dimensions[2];
    module StepperConfinement(h) {
        rotate([0,-90,0]) // up
            linear_extrude(thickness) // 3d
                polygon([[0,0],[0,stepper_dimensions[1]], [thickness,stepper_dimensions[1]],
                        [h, 0]]);
    }
    module StepperConfinementSlice() {
        w = (attachment_dimensions[1]-stepper_dimensions[0])/2 - thickness;
        h = stepper_confinement_support_height;
        if (w > 0) { // only draw if needed (attachment plate large enough)
            translate([thickness/2,0,thickness]) rotate([0,-90,0])
                linear_extrude(thickness) polygon([[0,0],[0,w], [h,w]]);
        }
    }
    module StepperMount() {
        rotate([90,0,90]) union() {
            translate ([0,stepper_dimensions[1]/2,0])
                StepperPlate(plate=[stepper_dimensions[0],stepper_dimensions[1],thickness],
                             screws=stepper_screw_rectangle, screw_d=stepper_screw_diameter,
                             bore=stepper_bore, step_slice_t=stepper_slice_thickness,
                             ex_slices_v=extruder_screw_hole_slices,
                             ex_slice_d=extruder_screw_hole_slice_diameter,
                             ex_slice_t=extruder_screw_hole_slice_thickness, t=thickness);
            translate([stepper_dimensions[0]/2+thickness,0])
                StepperConfinement(stepper_confinement_height);
            translate([-stepper_dimensions[0]/2,0])
                StepperConfinement(stepper_confinement_height);
        }
    }
    union() {
        // attachment bracket
        attachment_plate = [attachment_dimensions[0],attachment_dimensions[1],thickness];
        attachment_plate_trans = [attachment_dimensions[0]/2-stepper_to_bracket_x_offset,0,0];
        translate(attachment_plate_trans) // y to zero
            AttachmentPlate(plate=attachment_plate,
                            screws=attachment_screw_rectangle, screw_d=attachment_screw_diameter,
                            screw_w=attachment_screw_hole_width, screw_flip=attachment_screw_hole_flip,
                            edge_r=attachment_edge_radius);
        // stepper confinement
        translate([stepper_confinement_height/2,-attachment_dimensions[1]/2,0]) {
            StepperConfinementSlice();
            translate([0,attachment_dimensions[1],0]) mirror([0,1,0]) StepperConfinementSlice();
        }
        // stepper confinement back plate (optional extension if stepper is heighre than attachment bracket)
        difference() {
            translate([stepper_confinement_height,-stepper_dimensions[0]/2-thickness,0])
                rotate([0,0,90])
                    cube([stepper_dimensions[0]+2*thickness,stepper_confinement_height,thickness], center=false);
            // dummy attachment plate (prevent screw hole cover up)
            translate(attachment_plate_trans + [0,0,thickness/2]) cube(attachment_plate, center=true);
        }
        // stepper mount
        // FIXME magic number needed to avoid manifold warning (potential rounding issue?)
        translate([0,0,thickness-0.001]) StepperMount(); 
    }
}

// stepper base plate with screw holes
module StepperPlate(plate, screws, screw_d, bore, step_slice_t,
                    ex_slices_v, ex_slice_d, ex_slice_t, ex_slice_r, t) {
    // convert screw hole rectangle to x/y offset (from base plate exterior)
    module StepperScrewHoles(d, h, re=0, v=[1,1,1,1]) {
        translate([0,0,h/2])
            clone_rect(screws, v=v, center=true) SoftCylinder(d=d, h=h, re1=re, center=true);
    }
    translate([0,0,plate[2]/2]) difference() { // plate flat on ground (extruder slices below)
        union() {
            // base plate
            cube(plate, center=true);
            translate([0,0,plate[2]/2]) { // above plate
                // stepper slice (spacer grid)
                translate([0,0,step_slice_t/2]) {
                    translate ([0,screws[1]/2])  cube([plate[0],t,step_slice_t], center=true);
                    translate ([screws[0]/2,0])  cube([t,plate[1],step_slice_t], center=true);
                    translate ([0,-screws[1]/2]) cube([plate[0],t,step_slice_t], center=true);
                    translate ([-screws[0]/2,0]) cube([t,plate[1],step_slice_t], center=true);
                }
                // stepper screw hole slices
                StepperScrewHoles(d=screw_d+t*1.75, h=step_slice_t);
            }
            // extruder screw hole slices
            edge_rad = extruder_screw_hole_slice_radius >= 0 ? extruder_screw_hole_slice_radius : 0;
            translate([0,0,-plate[2]/2 -ex_slice_t]) // below plate
                StepperScrewHoles(d=ex_slice_d, h=ex_slice_t, re=edge_rad, v=ex_slices_v);
        }
        // screw holes
        translate([0,0,- plate[2]/2 - ex_slice_t])
            StepperScrewHoles(d=screw_d, h=step_slice_t + plate[2] + ex_slice_t);
        // stepper axis bore
        cylinder(d=bore, h=plate[2], center=true);
    }
}
//StepperPlate([42,42,2], [31,31], 3.4, 24, 1, [0,1,1,0], 6.5, 1, 2, $fn=30);
//StepperPlate([38,42,2], [28,32], 3.4, 18, 3, [1,1,1,1], 8, 4, 3, $fn=30);

// aluminium profile attachment
module AttachmentPlate(plate, screws, screw_d, screw_w, screw_flip, edge_r) {
    screw_off = (plate - screws)/2;
    screw_delta = screw_w > screw_d
                  ? (screw_w - screw_d) / 2
                  : 0;
    screw_delta_v = screw_flip ? [0,screw_delta,0] : [screw_delta,0,0];
    difference() {
        // base plate
        translate([0,0,plate[2]/2]) SoftCubeLazy(plate, edge_r, center=true);
        translate(-plate/2 + screw_off)
            clone_rect(plate - 2*screw_off) {
                hull() {
                    translate(screw_delta_v) cylinder(d=screw_d, h=plate[2]);
                    translate(-screw_delta_v) cylinder(d=screw_d, h=plate[2]);
                }
            }
    }
}
//AttachmentPlate([40,70,2], [17,60], 4, 7, false, 2, $fn=30);

/* == Transformation Modules ============================================= */
/* Clone children 3 times in a rectangular pattern
 rect    [x,y] dimensions of the rectangle
 v       cloning vector [0,x,y,xy] (default: [1,1,1,1])
 center  center all children relative to the provided rect (default: false)
*/
module clone_rect(rect, v=[1,1,1,1], r=[0,0,0], center=false)
    translate(center ? -rect/2 : [0,0,0])
        for (i=[0:1], j=[0:1])
            translate(lvmult([i,j],rect))
                if (v[i+j*2] == 1) children();
//clone_rect([10,20]) cylinder(d=2, h=10);
//clone_rect([10,20]) union() { cube([2,4,10]); cube([4,1,10]); };
//clone_rect([10,20], [1,0,0,1]) union() { cube([2,4,10]); cube([4,1,10]); };


/* == Fillet ============================================================= */
/* cube with softened (z-axis) edges, lazy version
 size    [x,y,z]
 radius  fillet radius, standard cube if <= 0, limited to x/y dimensions (fully rounded x/y edges)
 expand  fillet, size defines outer dimensions (false, default) or add radius to x/y size (true)
 center  center cube (default: false)
 - based on https://www.thingiverse.com/thing:9347
*/
module SoftCubeLazy(size, radius, expand=false, center=false) {
    if (radius <= 0) { // standard cube, no fillet
        cube(size, center);
    } else {
        x = size[0]; y = size[1]; z = size[2];
        r = min(x/(expand ? 1 : 2), y/(expand ? 1 : 2), radius); // maximum radius (must not exceed x/y dimensions)
        off = r / (expand ? 2 : 1);
        translate (center ? [0,0,-z/2] : [x/2,y/2,0]) {
            linear_extrude(height=z) hull() {
                // place 4 circles in the corners, with the given radius
                translate([-x/2 + off, -y/2 + off, 0]) circle(r);
                translate([ x/2 - off, -y/2 + off, 0]) circle(r);
                translate([-x/2 + off,  y/2 - off, 0]) circle(r);
                translate([ x/2 - off,  y/2 - off, 0]) circle(r);
            }
        }
    }
}
//SoftCubeLazy([20,20,20], 2, $fn=50);
//SoftCubeLazy([40,10,20], 220, center=true, $fn=50);
//SoftCubeLazy([20,10,20], 200, expand=true, center=true, $fn=50);

///* cube with softened (z-axis) edges, strict version
// size    [x,y,z]
// radius  fillet radius, standard cube if <= 0, must be <= 1/2* min(x,y) or <= min(x,y) if expand = true
// expand  fillet, size defines outer dimensions (false, default) or add radius to x/y size (true)
// center  center cube (default: false)
// - based on https://www.thingiverse.com/thing:9347
//*/
//module SoftCube(size, radius, expand=false, center=false) {
//    x = size[0]; y = size[1]; z = size[2];
//    assert(radius >= 0, "radius must be >= 0");
//    if (expand) {
//        assert(radius <= x, "radius must be <= x when expand = true");
//        assert(radius <= y, "radius must be <= y when expand = true");
//    }  else {
//        assert(radius <= x/2, "radius must be <= x/2 when expand = false");
//        assert(radius <= y/2, "radius must be <= y/2 when expand = false");
//    }    
//    if (radius <= 0) { // standard cube, no fillet
//        cube(size, center);
//    } else {
//        off = radius / (expand ? 2 : 1);
//        translate (center ? [0,0,-z/2] : [x/2,y/2,0]) {
//            linear_extrude(height=z) hull() {
//                // place 4 circles in the corners, with the given radius
//                translate([-x/2 + off, -y/2 + off, 0]) circle(radius);
//                translate([ x/2 - off, -y/2 + off, 0]) circle(radius);
//                translate([-x/2 + off,  y/2 - off, 0]) circle(radius);
//                translate([ x/2 - off,  y/2 - off, 0]) circle(radius);
//            }
//        }
//    }
//}
//SoftCube([20,20,20], 2, $fn=50);
//SoftCube([40,10,20], 5, center=true, $fn=50);
//SoftCube([20,10,20], 10, expand=true, center=true, $fn=50);

/* cylinder with softened edges
 h     cylinder height (default: 1)
 r1    cylinder radius bottom (default: 1)
 r2    cylinder radius top (default: 1)
 r     cylinder radius (default: r = r1 = r2)
 d1    cylinder diameter bottom (default: d1 = r1*2)
 d2    cylinder diameter top (default: d2 = r2*2)
 d     cylinder diameter (default: d = d1 = d2)
 re1   edge radius bottom (default: 0)
 re2   edge radius top (default: 0)
 re    edge radius (default: re = r1 = r2)
 note: cone dimensions (width and angle) are slightly off when r1 != r2 (may need changes)
*/
module SoftCylinder(h, r1, r2, r, d1, d2, d, re1, re2, re, center=false) {
    module Edge(d, e) {
        if (e > 0) {
            rotate_extrude(convexity = 10) translate([d/2-e, 0, 0]) circle(r = e);
        } else {
            linear_extrude(0.000001) circle(d=d); // FIXME hack
        }
    }
    dia1 = nvl([d1,d,nvl([r1,r,1])*2]);
    dia2 = nvl([d2,d,nvl([r2,r,1])*2]);
    erad1 = nvl([re1,re,0]);
    if (erad1 > h/2) echo("WARNING: re1 (or re/2) must be < height/2, reducing to height/2");
    e1 = erad1 > h/2 ? h/2 : erad1;
    erad2 = nvl([re2,re,0]);
    if (erad2 > h/2) echo("WARNING: re2 (or re/2) must be < height/2, reducing to height/2");
    e2 = erad2 > h/2 ? h/2 : erad2;
    translate([0,0,center ? -h/2 : 0]) { // center?
        hull() {
            translate([0,0,e1]) Edge(dia1, e1);
            translate([0,0,h-e2]) rotate([0,180,0]) Edge(dia2, e2); // FIXME rotate hack
        }
    }
}
//cylinder(r=5,h=10,center=true,$fn=50);
//SoftCylinder(r=5,h=10,re=2.5,center=true,$fn=50);
//cylinder(r1=8,r2=5,h=10,center=true,$fn=50);
//SoftCylinder(r1=8,r2=5,h=10,re1=1,re2=2.5,center=true,$fn=50);
//cylinder(d1=10,r2=3,h=10,re1=2.5,re2=0,$fn=50);
//SoftCylinder(d1=10,r2=3,h=10,re1=1.5,re2=0,$fn=50);
//SoftCylinder(d=6.5, re=0.5, h=2, $fn=50);
//SoftCylinder(d=6.5, re=1, h=2, $fn=50);

///* cylinder with softened edges using minovski
// r       radius (default: 1)
// h       height (default: 1)
// re      radius edges (default: 0, flat)
// center  center on z-axis (default: false)
//*/
//module SoftCylinderM(r=1, h=1, re=0, center=false) {
//    translate([0,0,center ? 0 : h/2]) { // center?
//        resize([r*2,r*2,h]) minkowski($fn=50) {
//            cylinder(r=r, h=h, center=true);
//            sphere(r=re/2);
//        }
//    }
//}
////cylinder(r=2,h=20,center=true,$fn=50);
////SoftCylinderM(r=2,h=20,center=true,$fn=50);
////cylinder(r=5,h=20,center=true,$fn=50);
////SoftCylinderM(r=5,h=20,re=2.5, h=20,center=true,$fn=50);

/* == Matrix Math ======================================================== */
/* lazy vector multiplication, multiply up to 4 vectors with 2 or 3 dimensions
   v1 is used to identify max dimensions
   if v2 to v4 have more dimensions they are ignored
   if v2 to v4 have less dimensions 1 is assumumed */
function lvmult(v1, v2=[1,1,1], v3=[1,1,1], v4=[1,1,1]) =
    v1[2] == undef
      ? [v1[0]*v2[0]*v3[0]*v4[0],
         v1[1]*v2[1]*v3[1]*v4[1]]
      : [v1[0]*v2[0]*v3[0]*v4[0],
         v1[1]*v2[1]*v3[1]*v4[1],
         v1[2]*nvl([v2[2],1])*nvl([v3[2],1])*(nvl([v4[2],1]))];
//echo(lvmult([2,3],[3,4]));
//echo(lvmult([10,20,30],[2,3]));
//echo(lvmult([10,20,30],[2,3,4],[10,10,10],[2,2,2]));
//echo(lvmult([2,3],[3,4,1]));

/* lazy vector division, divide up to 4 vectors with 2 or 3 dimensions
   v1 is used to identify the dimensions
   if v2 to v4 have more dimensions they are ignored
   if v2 to v4 have less dimensions 1 is assumumed */
function lvdiv(v1, v2=[1,1,1], v3=[1,1,1], v4=[1,1,1]) =
    v1[2] == undef
      ? [v1[0]/v2[0]/v3[0]/v4[0],
         v1[1]/v2[1]/v3[1]/v4[1]]
      : [v1[0]/v2[0]/v3[0]/v4[0],
         v1[1]/v2[1]/v3[1]/v4[1],
         v1[2]/nvl([v2[2],1])/nvl([v3[2],1])/nvl([v4[2],1])];
//echo(lvdiv([10,20,30],[2,3,4]));
//echo(lvdiv([10,20,30],[2,3,4],[10,10,10],[2,2,2]));
//echo(lvdiv([2,3],[3,4,1]));

/* == Vector Operations ================================================== */
/* get first non-null value from vector, single argument, or undef */
function nvl(v) = _nvlRec(v);
// not sure how to get a sub-vector, separate function and _i would not be necessary
function _nvlRec(v, _i=0) = 
    let (vec = concat(v))
        vec == undef || _i < 0 || _i >= len(vec)
        ? undef
        : (vec[_i] != undef ? vec[_i] : _nvlRec(vec, _i+1));
//echo(nvl([undef,undef,3])); // 3
//echo(nvl([_a,_b,3])); // 3
//echo(nvl([3])); // 3
//echo(nvl([])); // undef
//echo(nvl(1)); // 1
//echo(nvl()); // undef
