/* == Customizer Settings ================================================ */
/*[Gimbal Settings]*/

// in mm [x,y]
bridge_dimensions = [64,16];

// in mm [x,y], [0,0] if not needed
crosssection_dimensions = [10,32];

// in mm
crosssection_xoffset = -2;

// in mm, outer width (for inner width: add 2x handle_thickness if hooks are used)
handle_a_width = 62;

// in mm, 0 if not needed
handle_a_hooks = 6;

// in mm, outer width (for inner width: add 2x handle_thickness if hooks are used)
handle_b_width = 62;

// in mm, 0 if not needed
handle_b_hooks = 0;

// soft (rounded) hooks?
hooks_soft = true;

// in mm, x/y thickness of the handles
handle_thickness = 6;

// in mm, z thickness of base material
thickness = 10;

// Surface detail level
resolution = 35; //[20:Draft, 35:Normal, 50:Smooth]


/* == Render ============================================================= */
HClamp($fn=resolution);


/* == H-Clamp ============================================================ */
module HClamp() {
    union() {
        // handle a
        translate([handle_thickness+handle_a_hooks,-handle_a_width/2,0])
            rotate([0,0,90])
                UClampOSoft(handle_a_width,handle_a_hooks,handle_thickness,thickness,soft_pins=hooks_soft);
        translate([handle_thickness,0]) {
            // bridge
            translate([0,-bridge_dimensions[1]/2,0])
                cube(lvmult([1,1,thickness],bridge_dimensions));
            // bridge cross-section
            translate(-crosssection_dimensions/2 + [bridge_dimensions[0]/2 + crosssection_xoffset,0])
                SoftCubeLazy(lvmult([1,1,thickness], crosssection_dimensions), 2.5); // check radius
            // handle b
            translate([bridge_dimensions[0]-handle_b_hooks,handle_b_width/2,0])
                rotate([0,0,270])
                    UClampOSoft(handle_b_width,handle_b_hooks,handle_thickness,thickness,soft_pins=hooks_soft);
        }
    }
}

/* U-shaped "clamp" (bracket) based on inner dimensions and thickness
 [w] inner width (space between two pins)
 [h] inner height (pin length)
 [d] clamp diameter
 [dz] clamp z diameter (thtickness)
*/

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

/* == Clamp ============================================================== */
/* U-shaped "clamp" (bracket) based on inner dimensions and thickness
 [w] inner width (space between two pins)
 [h] inner height (pin length)
 [d] clamp diameter
 [dz] clamp z diameter
*/
module UClamp(w, h, d, dz) {
    difference() {
        cube([w+2*d,h+d,dz]);
        translate([d,-1,-1]) {
            cube([w,h+1,dz+2]);
        }
    }
}
//UClamp(10,10,10,10);
//UClamp(20,10,15,8);

/* U-shaped "clamp" (bracket) based on inner dimensions and thickness
 [w] inner width (space between two pins)
 [h] inner height (pin length)
 [d] clamp diameter
 [dz] clamp z diameter (thtickness)
 [soft_pins] rounded pins (default: false)
*/
module UClampSoft(w, h, d, dz, soft_pins=false) {
    module UCLeft() {
        union() {
            hull() {
                if (soft_pins) {
                    translate([d/2,d/2,0]) cylinder(d=d, h=dz);
                } else {
                    cube([d,h,dz]);
                }
                translate([d/2,d/2+h,0]) cylinder(d=d, h=dz);
            }
            hull() {
                translate([d,h,0]) cube([w/2,d,dz]);
                translate([d/2,d/2+h,0]) cylinder(d=d, h=dz);
            }
        }
    }
   union() {
       UCLeft();
       translate([w+2*d,0,0]) mirror([1,0,0]) UCLeft();
   }
}
//UClampSoft(20,10,15,8);
//UClampSoft(20,10,15,8, true);

/* U-shaped "clamp" (bracket) based on outer dimensions and thickness
 [w] outer width (space between two pins)
 [h] inner height (pin length)
 [d] clamp diameter
 [dz] clamp z diameter (thtickness)
 [soft_pins] rounded pins (default: false)
*/
module UClampOSoft(w, h, d, dz, soft_pins=false) {
    UClampSoft(w-2*d, h, d, dz, soft_pins);
}
//UClampSoft(20,10,15,8);
//UClampOSoft(50,10,15,8);

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
