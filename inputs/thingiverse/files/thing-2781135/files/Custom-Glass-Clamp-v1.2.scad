/* == Customizer Settings ================================================ */
/*[Gimbal Settings]*/

// in mm [x,y,z]
bed_dimensions = [310,370,4.5];

// in mm [x,y,z], relative to front left corner bed (z = 0, screw head above bed, ignored when screw notch auto fit active)
bed_screw_position = [35, 20, 0];

// in mm [x,y,z]
bed_glass_dimensions = [310,310,4];

// in mm, optional clearance between bed and glass
bed_glass_clearance = 0.0;

// in mm, set 0 for no fillet
bed_glass_fillet_radius = 0;

// in mm [diameter, height], bolt height excluding screw head
screw_bolt_dimensions = [4.5,30];

// in mm [diameter, height]
screw_head_dimensions = [9, 1.8];

// in mm, stretch screw notch in y direction (0 for round notch only)
screw_notch_stretch = 8; // [0:25]

// in mm, 0 centered on screw
screw_notch_offset = -2; // [-25:25]

// boolean, flip screw notch from x to y axis (relevant only if stretch > 0)
screw_notch_flip_p = "yes"; // [yes,no]

// in mm, clearance between screw and screw notch (added to radius of screw and screw head)
screw_notch_clearance = 0.5;

// boolean, fit screw notch automatically, false if screw notch should onyl be inside (screw can't be used to fix clamp)
screw_notch_auto_fit_p = "yes"; // [yes,no]

// in mm, material thicknes below screw head (only used if screw notch auto fit is active)
screw_notch_auto_fit_thickness = 2;

// in mm, set 0 for no fillet
clamp_fillet_radius = 2; //[0:5]

// in mm [x,y,z], optionally tweak clearance between clamp and bed for looser(+)/tighter(-) fit
clamp_to_bed_clearance = [0.2,0.2,0.2];

// in mm [x,y,z], optionally tweak clearance between clamp and glass for looser(+)/tighter(-) fit, z only relevant if glass slice is added
clamp_to_glass_clearance = [-1.5,-1.5,0];

// in mm [x,y,z], clamp enclosing the glass where z = top thickness (ignored if slice is added)
clamp_glass_closure = [55,25,3];

// in mm [x,y,z], if x/y and z > 0 auto raise clamp and add slice on top of glass, thickness = z (offset from top of glass, overrides closure height)
clamp_glass_slice = [3,3,3];

// in mm [x,y], limit glass slice x/y width relative to glass corner, set to 0 for full size slice (full brackte x/y)
clamp_glass_slice_max_width = [15,15];

// in mm, width of the bracket below the bed (not affected by clearance, capped by clamp dimensions)
clamp_bed_bracket_width = 5;

// in mm, thickness of base material
thickness = 3; //[1:10]

// Surface detail level
resolution = 35; // [20:Draft, 35:Normal, 50:Smooth]

// toggle demo mode (show bed)
x_demo_mode_p = "no"; // [yes,no];

// toggle clamp orientation, print both 2 times
x_mirror_p = "no"; // [yes,no];

// rotate clamp for printing?
x_rotate_p = "no"; // [yes,no];

/* == Render ============================================================= */
// map yes/no strings to boolean
screw_notch_flip = screw_notch_flip_p == "yes";
screw_notch_auto_fit = screw_notch_auto_fit_p == "yes";
x_demo_mode = x_demo_mode_p == "yes";
x_mirror = x_mirror_p == "yes";
x_rotate = x_rotate_p == "yes";

// render
mirror(x_mirror ? [1,0,0] : [0,0,0])  {
    if (x_demo_mode) {
        PrintBedClampFit();
        PrintBedClamps();
    } else {
        rotate(x_rotate ? [-180,0,0] : [0,0,0]) {
            PrintBedClamp();
        }
    }
}

/* == Demo of Bed + Clamps =============================================== */
// demo print bed
module PrintBedClampFit() {
    bed_screw_position = screw_notch_auto_fit
            ? lvmult([1,1,0],bed_screw_position) + [0,0,screw_notch_auto_fit_thickness + clamp_to_bed_clearance[2]]
            : bed_screw_position;
    translate(clamp_to_bed_clearance) {
        PrintBedWithGlass(bed=bed_dimensions, glass=bed_glass_dimensions,
                          screw_pos=bed_screw_position,
                          screw=screw_bolt_dimensions, screw_head=screw_head_dimensions, 
                          glass_clear=bed_glass_clearance,
                          $fn=resolution);
    }
}
// demo clamps
module PrintBedClamps() {
    PrintBedClamp();
    mirror([1,0,0]) { translate([-bed_dimensions[0]-2*clamp_to_bed_clearance[0],0,0]) { PrintBedClamp(); } }
    mirror([0,1,0]) { translate([0,-bed_dimensions[1]-2*clamp_to_bed_clearance[1],0]) { PrintBedClamp(); } }
    mirror([1,0,0]) { mirror([0,1,0]) { {
        translate([-bed_dimensions[0]-2*clamp_to_bed_clearance[0],-bed_dimensions[1]-2*clamp_to_bed_clearance[1],0]) {
            PrintBedClamp();
        }
    } } }
}


/* == Clamp Modules ====================================================== */
// FIXME: pritty ugly and slow solution
module PrintBedClamp() {
    slice_auto_fit = max(clamp_glass_slice[0],clamp_glass_slice[1]) > 0 && clamp_glass_slice[2] > 0;
    slice_auto_z = (slice_auto_fit ? bed_glass_dimensions[2] + clamp_glass_slice[2] : clamp_glass_closure[2]);
    // base dimensions
    x = (bed_dimensions[0] - bed_glass_dimensions[0])/2 + clamp_glass_closure[0] + clamp_to_bed_clearance[0];
    y = (bed_dimensions[1] - bed_glass_dimensions[1])/2 + clamp_glass_closure[1] + clamp_to_bed_clearance[1] ;
    z = (clamp_bed_bracket_width > 0 ? thickness : 0) + 2*clamp_to_bed_clearance[2] + bed_dimensions[2] + slice_auto_z;
    
    bed = bed_dimensions + lvmult([1,1,2],clamp_to_bed_clearance);
    glass = bed_glass_dimensions + lvmult([1,1,2],clamp_to_bed_clearance)
            + [clamp_to_glass_clearance[0],
               clamp_to_glass_clearance[1],
               bed_glass_clearance-clamp_to_glass_clearance[2]];
    module PBCSoftCube(size) {
        SoftCubeLazy(size, clamp_fillet_radius, $fn=resolution);
    }
    module PBCBaseBox() {
        translate(-[thickness,thickness,(clamp_bed_bracket_width > 0 ? thickness : 0)]) {
            PBCSoftCube([x,y,z]);
        }
    }
    module PBCBedCutout() {
        bed_screw_position =
            [bed_screw_position[0] + clamp_to_bed_clearance[0],
             bed_screw_position[1] + clamp_to_bed_clearance[1],
             screw_notch_auto_fit ? (screw_notch_auto_fit_thickness + clamp_to_bed_clearance[2]) : bed_screw_position[2]];
        PrintBedWithGlass(bed=bed, glass=glass,
                          screw_pos=bed_screw_position + (screw_notch_flip?[0,screw_notch_offset,0,0]:[screw_notch_offset,0,0]),
                          screw=screw_bolt_dimensions+[screw_notch_clearance,0],
                          screw_head=screw_head_dimensions+[screw_notch_clearance,screw_notch_auto_fit?slice_auto_z:0], 
                          glass_clear=0,
                          screw_stretch=screw_notch_stretch, screw_stretch_flip=screw_notch_flip,
                          $fn=resolution);
    }
    module PBCGlassSlice() {
        union() {
            //clamp_glass_slice_max_width
            translate(lvmult(bed,[1,1,0])/2 - lvmult(glass,[1,1,0])/2 + [0,0,bed[2]+bed_glass_clearance]) { // glass position
                translate([clamp_glass_slice[0],clamp_glass_slice[1],clamp_glass_slice[2]]) {
                    PBCSoftCube(glass); // x/y base slice
                }
                if (clamp_glass_slice_max_width[0] > 0)
                    translate([max(clamp_glass_slice[0],clamp_glass_slice_max_width[0]),0,clamp_glass_slice[2]]) {
                        PBCSoftCube(glass); // x slice
                    }
                if (clamp_glass_slice_max_width[1] > 0)
                    translate([0,max(clamp_glass_slice[1],clamp_glass_slice_max_width[1]),clamp_glass_slice[2]]) {
                        PBCSoftCube(glass); // y slice
                    }
            }
        }
    }
    module PBCBelowBedCutout() {
        if (clamp_bed_bracket_width > 0) {
            translate([clamp_bed_bracket_width, clamp_bed_bracket_width, -thickness - clamp_to_bed_clearance[2]]) {
                cube([x,y,thickness + clamp_to_bed_clearance[2]]);
            }
        }
    }
    
    // test: visualize notches
    //PBCBaseBox();
    //PBCZSlice();
    //PBCBedCutout();
    //PBCBelowBedCutout();
    
    // final clamp (base box with cutouts)
    difference() {
        PBCBaseBox();
        PBCBedCutout();
        if (slice_auto_fit) PBCGlassSlice();
        PBCBelowBedCutout();
    }
}

/* == Simple Print Bed Representation ==================================== */
/* A simplified representation of a print bed with screws and glass plate
 bed                 the print bed dimensions [x,y,z]
 screw_pos           the [x,y,z] screw (holes) position, offset relative to front left corner of print bed, (z optional,
                     default: 0, screw head on top of bed)
 screw               screw dimensions [d,h] (bolt only, screw head not considered)
 screw_head          screw head dimensions [d,h]
 glass               the glass dimensions [x,y,z]
 screw_hole_clear    optional screw hole clearance (radius, default: 0)
 glass_clear         optional clearance between glass and bed (default: 0)
 screw_stretch        stretch screw (default: 0, only sencible if model is used for cutout)
 screw_stretch_flip  stretch screw x/y directly flip (default: false, only sencible if model is used for cutout)
*/
module PrintBedWithGlass(bed, glass, screw_pos, screw, screw_head,
                         screw_hole_clear=0, glass_clear=0, screw_stretch=0, screw_stretch_flip=false) {
    screw_pos = [screw_pos[0],screw_pos[1],(screw_pos[2]==undef?0:screw_pos[2])]; // 2d to 3d
    screw_pos_off = screw_pos + [0,0,-screw[1]+bed[2]]; // screw offset, z relative to bed 
    // print bed
    PrintBed(bed=bed, screw_pos=screw_pos, screw=screw, screw_head=screw_head,
             screw_hole_clear=screw_hole_clear, screw_stretch=screw_stretch, screw_stretch_flip=screw_stretch_flip);
    // glass plate with screw holes (if coliding)
    difference() {
        translate(lvmult(bed,[1,1,0])/2 - lvmult(glass,[1,1,0])/2 + [0,0,bed[2]+glass_clear]) {
            SoftCubeLazy(glass, bed_glass_fillet_radius); // glas plate
        }
        translate(screw_pos_off) { // screw holes (if colliding)
            SimpleScrewRect(rect=bed-lvmult(screw_pos,[2,2]),
                            screw=screw+[screw_hole_clear*2,0],
                            head=screw_head+[screw_hole_clear*2,0]);
        }
    }
}
//PrintBedWithGlass(bed=[200, 200, 4], glass=[160,200,3], screw_pos=[15, 15], screw=[3,30], screw_head=[7,1.5]);
//PrintBedWithGlass(bed=[200, 200, 4], glass=[200,190,3], screw_pos=[20, 20,3+0.4], screw=[3,30], screw_head=[7,1.5],
//                  screw_hole_clear=0.2, glass_clear=0.2);

/* A simplified representation of a print bed with screws
 bed                 the print bed dimensions [x,y,z]
 screw_pos           the [x,y,z] screw (holes) position, offset relative to front left corner of print bed, (z optional,
                     default: 0, screw head on top of bed)
 screw               screw dimensions [d,h] (bolt only, screw head not considered)
 screw_head          screw head dimensions [d,h]
 screw_hole_clear    optional screw hole clearance (radius, default: 0)
 screw_stretch        stretch screw (default: 0, only sencible if model is used for cutout)
 screw_stretch_flip  stretch screw x/y directly flip (default: false, only sencible if model is used for cutout)
*/
module PrintBed(bed, screw_pos, screw, screw_head, screw_hole_clear=0, screw_stretch=0, screw_stretch_flip=false) {
    screw_pos = [screw_pos[0],screw_pos[1],(screw_pos[2]==undef?0:screw_pos[2])]; // 2d to 3d
    screw_pos_off = screw_pos + [0,0,-screw[1]+bed[2]]; // screw offset, z relative to bed 
    // print bed with screw holes
    difference() {
        cube(bed); // print bed
        translate(screw_pos_off) { // screw holes
            SimpleScrewRect(rect=bed-lvmult(screw_pos,[2,2]),
                            screw=screw+[screw_hole_clear*2,0],
                            head=screw_head+[screw_hole_clear*2,0],
                            screw_stretch=screw_stretch, screw_stretch_flip=screw_stretch_flip);
        }
    }
    // screws
    translate(screw_pos_off) {
        SimpleScrewRect(rect=bed-lvmult(screw_pos,[2,2]),
                        screw=screw, head=screw_head,
                        screw_stretch=screw_stretch, screw_stretch_flip=screw_stretch_flip);
    }
}
//PrintBed(bed=[200, 200, 4], screw_pos=[20, 20], screw=[3,30], screw_head=[7,1.5]);
//PrintBed(bed=[200, 200, 4], screw_pos=[10, 20,-1.2], screw=[3,30], screw_head=[7,1.5], screw_hole_clear=0.2);
//PrintBed(bed=[200, 200, 4], screw_pos=[20, 20], screw=[3,30], screw_head=[7,1.5], screw_stretch=4, screw_stretch_flip=true);

/* == Simple Screw / Screw Notch ========================================= */
/* 4 SimpleScrews positioned in a rectangle
 rect  rectangle dimensions, a SimpleScrew is positiond in each corner [x,y]
 screw               screw dimensions [d,h] (bolt only, screw head not considered)
 head                screw head dimensions [d,h]
 screw_stretch        stretch screw (default: 0, sencible if model is used for cutout)
 screw_stretch_flip  stretch screw x/y directly flip (default: false, sencible if model is used for cutout)
*/
module SimpleScrewRect(rect, screw, head, screw_stretch=true, screw_stretch_flip=false) {
    rotate([0,0,screw_stretch_flip?0:90]) {
        SimpleScrewStretched(screw, head, screw_stretch);
    }
    translate(lvmult([1,0],rect)) {
        rotate([0,0,screw_stretch_flip?0:90]) {
            SimpleScrewStretched(screw, head, screw_stretch);
        }
    }
    translate(lvmult([0,1],rect)) {
        rotate([0,0,screw_stretch_flip?0:90]) {
            SimpleScrewStretched(screw, head, screw_stretch);
        }
    }
    translate(lvmult([1,1],rect)) { // ignore 3rd dimension
        rotate([0,0,screw_stretch_flip?0:90]) {
            SimpleScrewStretched(screw, head, screw_stretch);
        }
    }
}
//SimpleScrewRect(rect=[50,100], screw=[3,30], head=[7,1.5], stretch=15);


/* A simplified screw tretched in y axis
   Can be used (difference) to add a screw notch. Screw and head needs to be tweeked
   accordingly (clearance, material thickness, etc.)
 screw  screw dimensions [d,h] (bolt only, screw head not considered)
 head   screw head dimensions [d,h]
 stretch  distance between the center (screw axis) of two combined screws
*/
module SimpleScrewStretched(screw, head, stretch) {
    union() {
        translate(-[0,stretch/2,0]) {
            SimpleScrew(screw, head);
        }
        // screw head guide
        translate([0,0,head[1]/2 + screw[1]]) {
            cube([head[0],
                  stretch,
                  head[1]],
                  center=true);
        }    
        // screw guide
        translate([0,0,screw[1]/2]) {
            cube([screw[0],
                  stretch,
                  screw[1]],
                  center=true);
        }
        translate([0,stretch/2,0]) {
            SimpleScrew(screw, head);
        }
    }
}
//SimpleScrewStretched(screw=[3,30], head=[7,1.5], stretch=15);

/* A simplified screw
 screw  screw dimensions [d,h] (bolt only, screw head not considered)
 head   screw head dimensions [d,h]
*/
module SimpleScrew(screw, head) {
    union() {
        // screw head guide
        translate([0,0,screw[1]]) {
            cylinder(d=head[0], h=head[1]);
        }
        // screw guide
        cylinder(d=screw[0], h=screw[1]);
    }
}
//SimpleScrew(screw=[3,30], head=[7,1.5]);


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

/* cube with softened (z-axis) edges, strict version
 size    [x,y,z]
 radius  fillet radius, standard cube if <= 0, must be <= 1/2* min(x,y) or <= min(x,y) if expand = true
 expand  fillet, size defines outer dimensions (false, default) or add radius to x/y size (true)
 center  center cube (default: false)
 - based on https://www.thingiverse.com/thing:9347
*/
module SoftCube(size, radius, expand=false, center=false) {
    x = size[0]; y = size[1]; z = size[2];
    assert(radius >= 0, "radius must be >= 0");
    if (expand) {
        assert(radius <= x, "radius must be <= x when expand = true");
        assert(radius <= y, "radius must be <= y when expand = true");
    }  else {
        assert(radius <= x/2, "radius must be <= x/2 when expand = false");
        assert(radius <= y/2, "radius must be <= y/2 when expand = false");
    }    
    if (radius <= 0) { // standard cube, no fillet
        cube(size, center);
    } else {
        off = radius / (expand ? 2 : 1);
        translate (center ? [0,0,-z/2] : [x/2,y/2,0]) {
            linear_extrude(height=z) hull() {
                // place 4 circles in the corners, with the given radius
                translate([-x/2 + off, -y/2 + off, 0]) circle(radius);
                translate([ x/2 - off, -y/2 + off, 0]) circle(radius);
                translate([-x/2 + off,  y/2 - off, 0]) circle(radius);
                translate([ x/2 - off,  y/2 - off, 0]) circle(radius);
            }
        }
    }
}
//SoftCube([20,20,20], 2, $fn=50);
//SoftCube([40,10,20], 5, center=true, $fn=50);
//SoftCube([20,10,20], 10, expand=true, center=true, $fn=50);

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
         v1[2]*(v2[2]==undef?1:v2[2])*(v3[2]==undef?1:v3[2])*(v4[2]==undef?1:v4[2])];
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
         v1[2]/(v2[2]==undef?1:v2[2])/(v3[2]==undef?1:v3[2])/(v4[2]==undef?1:v4[2])];
//echo(lvdiv([10,20,30],[2,3,4]));
//echo(lvdiv([10,20,30],[2,3,4],[10,10,10],[2,2,2]));
//echo(lvdiv([2,3],[3,4,1]));
