/* == Customizer Settings ================================================ */
/*[Base]*/

// Handle: Stamp handle & base part, Rubber: Rubber part & Text, Full: Combined parts (demo model)
model = "Rubber"; // [Handle,Rubber,Full]

// Rectangular or Round base shape?
base_shape = "Rectangular"; // [Rectangular,Round]

// model resolution
resolution = 50; // [30:Draft, 50:Normal, 80:Smooth]

// in mm, stamp base dimensions [x,y,z] in case of base_shape = Rectangular and [d1,d2,h] in case of Round (perfectly round if d1=d2, else oval).
base_dimensions = [50,26,12];
//base_dimensions = [70,30,12];
//base_dimensions = [60,40,12];


/*[Base Tweaks]*/

// in mm, stamp base fillet
base_fillet = 2;

// in mm, depth of the rubber cutout on the buttom of the stamp base (usually <= rubber base_thickness), 0 for none (no cutout).
rubber_cutout_depth = 2;

// in mm, width of the border sourrounding the rubber cutout, sourrounding (holding) the rubber part, 0 for none (no cutout). this value will determine the rubber' parts x/y dimensions (base_dimensions x/y - 2x this value).
rubber_cutout_rim_width = 2;

// in mm, thickness of the rubber part base plate (without the text, usually >= rubber_cutout_depth).
rubber_base_thickness = 2;

// in mm, optionally add some space between base and rubber (shaved from each side of the base), only used if rubber_cutout_depth > 0
rubber_cutout_offset = [0,0];

// in mm, set fillet dimensions of the rubber, -1 for auto (fits base), also used to define the width of the optional text border
rubber_fillet = .8;

// in mm, handle diameter (max)
handle_diameter = 25;
//handle_diameter = 30;

// in mm, handle height
handle_height = 45;
//handle_height = 50;

// some factors (%) in ragne [0,1] affecting the handle style, depending on the handle_type (not all values may be used). any value outside the interval, e.g. -1, will activate the default setting.
handle_parameters = [-1, -1, -1];

// handle type
handle_type = 3; // [1:Straight, 2:Stretch, 3:Bezier]


/*[Text]*/

// optional text inscription for rubber plate
text_string = "TOP";
//text_string = "VERY";

// optional second line of text, not used if empty
text_string2 = "SECRET";
//text_string2 = "IMPORTANT";

// optional third line of text, not used if empty
text_string3 = "";
//text_string3 = "TOP";

// font size
text_font_size = 6;
//text_font_size = 5;

// font namae e.g. "DejaVu Serif" or "Catamaran"
//text_font_name = "DejaVu Serif";
text_font_name = "Vollkorn";
//text_font_name = "Catamaran";

// font style, e.g. "Bold", "Bold Italic", "Black", etc. (avaialable options depend on the selected font).
text_font_style = "Bold";
//text_font_style = "Black";

// add an additional border around the text, border thickness = rubber_fillet
text_border = "Yes"; // [Yes,No]


/* [Text Tweaks] */

// font size of text_string2, same as text_font_size if empty or value <= 0
text_font_size2 = -1;
//text_font_size2 = 9.5;

// font size of text_string3, same as text_font_size if empty or value <= 0
text_font_size3 = -1;

// in mm, optionally tweaks the text's [x,y] position if it's not positiend 100% as desired
text_pos_offset = [0,0];

// line spacing, default: 1 (usually no space), only used if text_string2 is non-empty, based on the largest font size.
text_line_spacing = 1.35;
//text_line_spacing = 1.25;

// font spacing (between characters), default: 1
text_spacing = 1;

// thickness of the text inscription, 0 for none
text_thickness = 2;

// in mm, adds an additional border around the text, negative offset from rubber base [x,y] in case of base_shape = Rectangular and [d1,d2] in case of Round. thickness same as text_thickness
text_border_offset = [0,0];


// initialize constants based on parameters
$fn = resolution;
//resolution_rubber = resolution / 2;
resolution_bezier = resolution < 50 ? 0.04 : (resolution > 50 ? 0.01 : 0.02);
text_border_b = text_border == "Yes";
rubber_dim = [base_dimensions[0] - rubber_cutout_rim_width*2,
              base_dimensions[1] - rubber_cutout_rim_width*2,
              rubber_base_thickness];
base_cutout_dim = [rubber_dim[0]+rubber_cutout_offset[0],
                   rubber_dim[1]+rubber_cutout_offset[1],
                   rubber_cutout_depth];
text_font_sizes = [text_font_size,
                   text_font_size2 == undef || text_font_size2 <= 0
                       ? text_font_size : text_font_size2,
                   text_font_size3 == undef || text_font_size3 <= 0
                       ? text_font_size : text_font_size3];

/* == Draw Model ========================================================= */
if (model == "Handle") {
    DrawStamp();
} else if (model == "Rubber") {
    DrawRubber();
} else {
    height = base_dimensions[2]+rubber_dim[2]-rubber_cutout_depth+handle_height;
    translate([0,height,base_dimensions[1]/2]) group() {
        rotate([90,0,0]) DrawStamp();
        translate([0,-rubber_cutout_depth,0]) rotate([270,180,0]) DrawRubber();
    }
}

module DrawStamp() {
    Stamp(base_shape == "Round", base_dimensions, base_fillet, base_cutout_dim,
          rubber_fillet, handle_type, handle_diameter, handle_height,
          handle_parameters);
}
module DrawRubber() {
    Rubber(base_shape == "Round", rubber_dim, text_border_b, rubber_fillet,
           text_border_offset, text_string, text_string2, text_string3,
           text_thickness, text_font_sizes, text_font_name, text_font_style,
           text_spacing, text_line_spacing, text_pos_offset);
}

/* - Heart Example ------------------------------------------------------- */
/* 1. Put Heart.svg in the same folder as this scad file
 * 2. Set all text parameters to "" (no text) and disable the text border "No"
 * 3. Raise the default base dimentions (for bigger rubber part)
 * 4. Uncomment ONE of the following "!RubberHeart..." lines to render one
 *    of the hert examples
 */

//!RubberHeart(); // "Heart Big" example
//!RubberHeart(true); // "Heats" example

module RubberHeart(many=false) {
    union() {
        Rubber(true, [56, 36, 2], false, .8, [0,0], "");
        if (many) {
            // "Hearst" example
            translate([0,0,rubber_base_thickness-1]) { // remove * to load 
                translate([-16,  4,  0]) rotate([  0,  0,  18]) Heart(0.8); // left-top
                translate([-14, -8,  0]) rotate([  0,  0,  24]) Heart(0.4); // left-bottom
                translate([ -3, 10,  0]) rotate([  0,  0, -15]) Heart(0.7); // center-top
                translate([  2, -5,  0]) rotate([  0,  0,  10]) Heart(1.2); // center-bottom
                translate([ 11,  9,  0]) rotate([  0,  0, -24]) Heart(0.4); // right-top
                translate([ 18, -5,  0]) rotate([  0,  0,  -8]) Heart(0.6); // right-bottom
            }
        } else {
            // "Heart Big" example
            translate([0,0,rubber_base_thickness-1]) {
                Heart(2.1);
                scale([1.3,1.1,1]) Heart(.6);
            }

        }
    }
}

module Heart(s=1, t=text_thickness+1) {
   linear_extrude(t) scale([s,s,1]) import("Heart.svg");
}


/* == Stamp Rubber Modules =============================================== */

module Rubber(isround, dim, border, fillet, border_off, txt="Example",
              txt2="", txt3="", t=2,
              font_size, font_name="DejaVu Serif", font_style="", spacing=1,
              line_spacing=1, pos_off) {
    font = font_style != "" ? str(font_name, ":style=", font_style) : font_name;
    union() {
        // rubber base plate
        color("SpringGreen") translate([0,0,dim[2]/2]) {
            if (isround) { // round base shape
                // border collides with fillet?
                if (border && min(border_off[0], border_off[1]) < fillet) {
                    resize([0,dim[1],0])
                        cylinder(d=dim[0], h=dim[2], center=true);
                } else {
                    resize([0,dim[1],0])
                        SoftCylinder(dim[0], dim[2], fillet*2, flat_bottom=true,
                                     center=true);
                }
            } else { // rect base shape
                // border collides with fillet?
                if (border && min(border_off[0], border_off[1]) < fillet) {
                    SoftCube(dim, fillet, center=true);
                } else {
                    RoundCube(dim, fillet, flat_bottom=true, center=true);
                }
            }
        }
        // optional text inscription
        color("Coral") translate([pos_off[0],pos_off[1],dim[2]])
            linear_extrude(t) mirror([1,0,0]) {
                Text(txt, txt2, txt3, font, font_style, font_size, spacing,
                     text_border, border_off, line_spacing);
        }
        // text border
        if (border) {
            text_border = [dim[0]-border_off[0],dim[1]-border_off[1],t];
            translate([0,0,dim[2]+text_border[2]/2]) color("Aqua") {
                if (isround) { // round base shape
                    difference() {
                        resize([0,text_border[1],0])
                            cylinder(d=text_border[0], h=t, center=true);
                        resize([0,text_border[1]-fillet*4,0]) translate([0,0,-1/2])
                            cylinder(d=text_border[0]-fillet*4, h=t+2, center=true);
                    }
                } else { // rect base shape
                    SoftCube(text_border, fillet, center=true, hollow=true);
                }
            }
        }
    }
}


// TODO unnecessarily complicated, make this more generic (txt list etc.)
module Text(txt, txt2, txt3, font, font_style, font_size, spacing,
            text_border, border_off, line_spacing) {
    lsf = sign(line_spacing) * abs(1 - line_spacing);
    if (txt != "" && txt2 != "" && txt3 != "") { // three lines
        lspace = max(font_size) * lsf;
        height = font_size[0] + font_size[1] + font_size[2] + lspace * 2;
        translate([0,height/2,0]) {
            text(txt, size=font_size[0], font=font, halign="center",
                 valign="top", spacing=spacing);
            translate([0,-font_size[0]-lspace,0]) {
                text(txt2, size=font_size[1], font=font, halign="center",
                     valign="top", spacing=spacing);
                translate([0,-font_size[1]-lspace,0])
                    text(txt3, size=font_size[2], font=font, halign="center",
                         valign="top", spacing=spacing);
            }
        }
    } else if (txt != "" && txt2 != "") { // two lines
        lspace = max(font_size[0],font_size[1]) * lsf;
        height = font_size[0] + font_size[1] + lspace;
        translate([0,height/2,0]) {
            text(txt, size=font_size[0], font=font, halign="center",
                 valign="top", spacing=spacing);
            translate([0,-font_size[0]-lspace,0])
                text(txt2, size=font_size[1], font=font, halign="center",
                     valign="top", spacing=spacing);
        }
    } else { // single line
        height = font_size[0];
        translate([0,height/2,0])
            text(txt, size=font_size[0], font=font, halign="center",
                 valign="top", spacing=spacing);
    }
}

/* == Stamp Base Modules ================================================= */

module Stamp(isround, dim, fillet, cut_dim, cut_fillet, hand_type, hand_d,
             hand_h, hand_p) {
    hand_lmax = min(min(dim[0], dim[1]) - fillet, hand_d);
    union() {
        color("SpringGreen") translate([0,0,dim[2]]) {
            Handle(hand_d, hand_h, hand_lmax, hand_type, hand_p);
        }
        color("DodgerBlue") Base(isround, dim, fillet, cut_dim, cut_fillet);
    }
}

/* stamp base
 * dim - dimensions [x,y,z]
 * fillet - base fillet diamater
 * cut_dim - cutout dimensions [x,y,z]
 * cut_fillet - cutout fillet diamater
 */
module Base(isround, dim, fillet, cut_dim, cut_fillet) {
    if (isround) {
        difference() {
            translate([0,0,dim[2]/2]) // base
                resize([0,dim[1],0])
                    SoftCylinder(dim[0], dim[2], fillet*2, flat_bottom=true,
                                 center=true);
            translate([0,0,cut_dim[2]/2-1]) // cutout
                resize([0,cut_dim[1],0])
                    cylinder(d=cut_dim[0], h=cut_dim[2]+2, center=true);
        }
    } else {
        difference() {
            translate([0,0,dim[2]/2]) // base
                RoundCube(dim, fillet, flat_bottom=true, center=true);
            translate([0,0,cut_dim[2]/2]) // cutout
                SoftCube([cut_dim[0],cut_dim[1],cut_dim[2]], cut_fillet, center=true);
        }
    }
}


module Handle(d, h, lmax, type=1, params=[-1,-1,-1,-1]) {
    if (type == 2) {
        HandleStreched(d, h, lmax, params[0], params[1], params[2], params[3]);
    } else if (type == 3) {
        HandleBezier(d, h, lmax, params[0], params[1], params[2], params[3]);
    } else {
        HandleStraight(d, h, lmax, params[0], params[1], params[2], params[3]);
    }
}


/* stamp handle 1 (Straight)
 * d - diameter (max)
 * h - height
 * lmax - low end part max diameter
 * ts - height scaling top part, [0,1] else 1
 * lfs - low end part fillet scaling factor, [0,1] else 0.5
 * ls - low end part scaling factor, [0,1] else 0.5
 */
module HandleStraight(d, h, lmax, ts=1, lfs=0.5, ls=0.5) {
    // fallback to defaults if given values are not between 0 and 1
    top_s = argdef(ts, 1, [0,1]);
    low_s = argdef(ls, 0.5, [0,1]);
    low_fil_s = argdef(lfs, 0.5, [0,1]);
    // low_d: [1, lmax]mm
    low_d = 1 + max(lmax-1, 0) * low_s;
    // low_fil_d: [low_d, lmax]mm
    low_fil_d = low_d + max(lmax-low_d,0) * low_fil_s;
    // top_d: [1, d]mm
    top_h = 1 + max(d-1, 0) * top_s;
    union() {
        // top
        translate([0,0,h-top_h/2]) resize(newsize=[0,0,top_h]) sphere(d=d);
        // low part (neck)
        cylinder(d=low_d, h=h-top_h/2);
        // low part fillet
        SphereHalf(d=low_fil_d, h=low_fil_d/4);
    }
}


/* stamp handle 2 (Stretched)
 * d - diameter (max)
 * h - height
 * lmax - low end part max diameter
 * ts - top part scaling factor, [0,1] else 2/3
 * lfs - low end part fillet scaling factor, [0,1] else 1
 */
module HandleStreched(d, h, lmax, ts=2/3, lfs=0.5) {
    // fallback to defaults if given values are not between 0 and 1
    top_s = argdef(ts, 2/3, [0,1]);
    low_fil_s = argdef(lfs, 0.5, [0,1]);
    // low_fil_d: [d/3, lmax]mm
    low_fil_d = d/3 + max(abs(lmax-d/3),0) * low_fil_s;
    // top_h: [1, lmax]mm
    top_h = 1 + max(d-1, 0) * top_s;
    low_h = h - top_h/2;
    difference() {
        union() {
            translate([0,0,h-top_h/2]) {
                // top
                SphereHalf(d, h=top_h/2);
                // low part (neck)
                mirror([0,0,1]) SphereHalf(d, low_h);
            }
            // low part fillet
            SphereHalf(d=low_fil_d, h=low_fil_d/4);
        }
        // handle lower end cut
        translate([0,0,-low_h/2]) cube([d,d,low_h], center=true);
    }
}


/* stamp handle 2 (Bezier)
 * d - diameter (max)
 * h - height
 * lmax - low end part max diameter
 * ts - top part height scaling factor, [0,1] else 0.55
 * ls - low part width scaling factor, [0,1] else 0.65
 * lfs - low end part fillet scaling factor, [0,1] else 0.45
 */
module HandleBezier(d, h, lmax, ts=0.55, ls=0.65, lfs=0.55) {
    // fallback to defaults if given values are not between 0 and 1
    top_s = argdef(ts, 0.25, [0,1]);
    low_s = argdef(ls, 0.65, [0,1]);
    low_fil_s = argdef(lfs, 0.55, [0,1]);
    // low_fil_d: [d/8, lmax]mm
    low_fil_d = d/8 + max(abs(lmax-d/8),0) * low_fil_s;
    low_fil_h = low_fil_d/2 * low_fil_s;
    // top_h: [1, lmax]mm
    low_h = h * 2/3; //h - top_h/2;
    top_h = low_h + (h - low_h) * top_s; //1 + max(d-1, 0) * top_s;

    // control points
    cpoints=[[0,           low_fil_d/2],
             [low_fil_h,             low_fil_d],
             [low_h*low_s/2,         -low_fil_d*low_s],
             [low_h,                 d/2], //-line_width],
             [top_h,                 d*(0.9+0.2*low_s)],
             [h,                     d/3],
             [h,                     0]
    ];
    // polyline points
    points=concat([[0,0]], // base
                  bezier(cpoints, resolution_bezier),
                  [[h, 0]]); // back wall (necessary to fill object)
    translate([0,0,-0.1]) // move slightly down to ensure intersaction with base
    union() {
        *translate([0,0,h+1/2]) { // debug: ruler
            Line([-d/2,0], [d/2,0]);
            translate([-d/2-1.5,0,-20]) cube([1,1,20]);
            translate([d/2+1/2,0,-20])  cube([1,1,20]);
        }
        // low part (neck)
        rotate([0,180,0]) rotate_extrude() // stand up & extrude
        {
            // debug: 2d handle shape
            //color("silver") Line([h+1/2, 50], [h+1/2, -50], .1); // top ruler
            //!BezierCurve(points, w=.1, steps=1, draw_cp=true); // debug
            //!Polyline(points, w=1);
            // change angle for correct extrusion
            rotate([0,0,-90]) polygon(points);
        }
    }
}


/* == Basic Modules ====================================================== */
/* top half of a sphere, optionally stretched
 * d - sphere's diameter
 * h - height (vertical stretch), optional, default: radius
 */
module SphereHalf(d, h) {
    h2 = h == undef ? d : h*2;
    difference() {
        resize(newsize=[0,0,h2]) sphere(d=d);
        translate(-[0,0,h2/2]) cube([d,d,h2], center=true);
    }
}


/* == Fillet ============================================================= */
/* cube with with rounded edges
 * dim - dimensions [x,y,z]
 * ff - fillet factor, default 1/4, ignored if fr is provided
 * fr - fillet radius, default: ff * min(dim), 0.0001 if <= 0
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


/**
 * A straight cylinder with a fillet on top and optionally bottom (default)
 * d - diameter
 * h - height
 * fillet - fillet radius
 * flat_bottom - flat bottom, default: false (bottom with fillet)
 * center - center object z, default: false
 */
module SoftCylinder(d, h, fillet, flat_bottom=false, center=false) {
    module _Ring() {
        rotate_extrude(angle=360)
            translate([d/2-fillet/2, 0, 0]) circle(d=fillet);
    }
    translate([0,0,center ? -h/2 : 0])
    hull() {
        translate([0,0,h-fillet/2]) _Ring(); //top
        if (!flat_bottom) {
            translate([0,0,+fillet/2]) _Ring(); //top
        } else {
            cylinder(d=d, h=fillet);
        }
    }
}
//!SoftCylinder(40, 20, 5, false, true); // cylinder(d=40, h=20, center=true);
//!SoftCylinder(30, 20, 5, true); // !cylinder(d=30, h=20);
//!SoftCylinder(40, 2, 0.8, true, center=true); //!cylinder(d=40, h=2, center=true);

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


/* == Basic 2D Modules =================================================== */

/* Draw a straight vector
 * pN - points [x,y] p0 and p1 of the vector [p0, p1]
 * w - line width (diameter)
 * sq - square shaped [p0, pN], producing an edged start/end point? else: round
 *      square might be desirable if x/y need to be > 0 (e.g. rotate_extrude)
 *      note that both are centered (use translation [w,w]) and thickness may vary
 */
module Line(p0, p1, w=1, sq=[false,false]) {
    module _Point(_p, _sq) {
        if (_sq) {
            sw = w*sqrt(2); // square's diagonal
            translate(-[w,w]) square(sw);
        } else {
            //translate(center ? [0,0] : [w/2,w/2])
            circle(w,$fn=20);
        }
    }
    hull() {
        translate(p0) _Point(p0, sq[0]);
        translate(p1) _Point(p1, sq[1]);
    }
}
//!Line([0,0], [10,10], sq=[true,false]);


/* Draw a poligonal chain
 * points - a sequence [p0:pN] of vecices [x,y]
 * w - line width (diameter)
 * index - starting index (points)
 * sq - square shaped (edged) start/end points? else: round
 *      square might be desirable if x/y need to be > 0 (e.g. rotate_extrude)
 *      note that both are centered (use translation [w,w]) and thickness may vary
 */
module Polyline(points, w=1, sq=false) {
    n = len(points);
    for (i=[1:n-1]) {
        if (i == 1) { // first
            Line(points[i-1], points[i], w, [sq, false]);
        } else if (i == n-1) { // last
            Line(points[i-1], points[i], w, [false, sq]);
        } else {
            Line(points[i-1], points[i], w, [false, false]);
        }
    }
}
//Polyline(bezierc([0,0],[90,60],[10,90],[20,120]));
//!translate([1,1]) Polyline(bezierc([0,0],[90,60],[10,90],[20,120]), sq=[true, true]);
//Polyline([for(v=[0:50]) [v,pow(v,1.2)]], sq=true);


/* A red polyline with highlighted points
 * points - a sequence of points [x,y] (vertices)
 * w - line width
 * r - point radius
 * h - line extrusion height
 * alpha - base color alpha channel (point alpha +30%)
 */
module PolylineWithPoints(points, w=1, r, h=1, alpha=0.5) {
    rad = r == undef ? w*2/3 : r; // default point radius: 2/3 * line width
    for (p = points) translate([p[0],p[1],-0.1]) { // +/-0.1 point offset
        color("Gold", min(alpha*1.3, 1)) linear_extrude(h + h*0.2) circle(rad);
    }
    color("DarkRed", alpha) linear_extrude(h) Polyline(points, w);
}
//PolylineWithPoints([[0, 10], [7, 20], [6, 0], [30, 17]]);


/* == Bezier Curves ====================================================== */
/* Sources:
 * https://en.wikipedia.org/wiki/B%C3%A9zier_curve
 * https://en.wikipedia.org/wiki/Composite_B%C3%A9zier_curve
 */

/* -- Bezier: Modules ---------------------------------------------------- */

/* Draw a quadratic or cubic Bezier curve
 * points - control points, quadratic [p0,p1,p2] or cubic [p0,p1,p2,p3]
 * w - line width
 * steps - curve resolution
 * draw_cp - draw control points (for reference)
 */
module BezierCurve(points, w=0.5, steps=0.05, draw_cp=false) {
  if (draw_cp) { // draw control points?
      PolylineWithPoints(points, w=max(w/2, 0.0002), r=max(w/3, 0.0001));
  }
  Polyline(bezier(points, steps=steps), w);
}
//!BezierCurve([[0, 10], [7, 20], [6, 0], [30, 17]], draw_cp=true);


/* -- Bezier: Functions -------------------------------------------------- */

/* Quadratic Bezier curve
 * pN - control points vectors [x,y] p0 to p2
 * steps - resolution
 */
function bezierq(p0, p1, p2, steps=0.05) =
    [for (t = [0:steps:1+steps])
         pow(1-t, 2)*p0 + 2*(1-t)*t*p1 + pow(t, 2)*p2];
//echo(bezierq([0, 10], [7, 20], [6, 0]));
//Polyline(bezierq([0, 10], [7, 20], [6, 0]));


/* Quadratic Bezier curve
 * points - a matrix [p0,p1,p2,3] of control point vectors [x,y]
 * steps - resolution
 */
function bezierqm(points, steps=0.05) =
    bezierq(points[0], points[1], points[2], steps);
//echo(bezierqm([[0, 10], [7, 20], [6, 0]]));
//Polyline(bezierqm([[0, 10], [7, 20], [6, 0]]));


/* Cubic Bezier curve
 * pN - control points vectors [x,y] p0 to p3
 * steps - resolution
 */
function bezierc(p0, p1, p2, p3, steps=0.05) =
    [for (t = [0:steps:1+steps])
         pow(1-t, 3)*p0 + 3*pow(1-t, 2)*t*p1
         + 3*(1-t)*pow(t, 2)*p2 + pow(t, 3)*p3];
//echo(bezierc([0, 10], [7, 20], [6, 0], [30, 17]));
//Polyline(bezierc([0, 10], [7, 20], [6, 0], [30, 17]));


/* Cubic Bezier curve
 * points - a matrix [p0,p1,p2] of control point vectors [x,y]
 * steps - resolution
 */
function beziercm(points, steps=0.05) =
    bezierc(points[0], points[1], points[2], points[3], steps);
//echo(beziercm([[0, 10], [7, 20], [6, 0], [30, 17]]));
//PolylineWithPoints(beziercm([[0, 10], [7, 20], [6, 0], [30, 17]]));


/* Bezier curve of dregree n (recursive)
 * points - a matrix [p0,..,pN] of control point vectors [x,y]
 * steps - resolution
 */
function bezier(points, steps=0.05) =
    [for (t = [0:steps:1+steps]) _bezier_rec(points, t)];

function _bezier_rec(points, t) =
    len(points) == 1 ? points[0] :
        let(p1=_bezier_rec(subv(points,0,-1), t),
            p2=_bezier_rec(subv(points,1), t),
            nt=1-t)
        [nt*p1[0] + t*p2[0], nt*p1[1] + t*p2[1]];
//!echo(bezier([[0, 10], [7, 20], [6, 0], [30, 17]]));
//Polyline(bezier([[0, 10], [7, 20], [6, 0], [30, 17]]));
//!Polyline(bezier([[0, 0], [17, -15], [20, 0], [30, 17], [27, 40], [55, 15]]));
//!Polyline(bezier([for (i=[0:10]) [i,pow(i*2,i/8)]]));


/* == Basic Math Functions =============================================== */

/* Factorial n!
 */
function fact(n) = n == 0 ? 1 : fact(n-1) * n;
//echo(fact_5=fact(5));


/* Binomial coefficient nCk (n k)
 * https://en.wikipedia.org/wiki/Binomial_coefficient
 */
function nck(n, k) = fact(n) / (fact(k) * fact(n-k));
//!let(n=4) echo([for (i=[0:n]) nck(n, i) ]);
//!for(n=[0:8]) echo([for (k=[0:n]) nck(n, k) ]); // Pascal's triangle


/* == Misc Functions ===================================================== */

/* Get a subset of the given vector
 * Error tolerant, ignores idx. oud of bounds except f < l (deprecated)
 * v - a vector
 * f - firts index, default: 0, min: 0, max: n-1
 * l - last index, negative: n-1-l, default: n-1, min: 0, max: n-1
 */
function subv(v, f=0, l) =
    let (n = len(v),
         i1 = min(max(f,0),n-1),
         i2 = l==undef ? n-1
              : (l < 0 ? max(n-1+l,0) : min(l,n-1)))
        [for (i=[i1:i2]) v[i]];
//!echo(subv([1,2,3,4,5,6],1,3)); // [2,3,4]
//!echo(subv([1,2,3,4,5,6],0,-2)); // [1,2,3,4]


/* Percentage p of the given range [a,b]
 */
function pctrange(a, b, p) = min(a,b) + abs(a-b) * p;
//echo(pctrange(21, 78, 0));
//echo(pctrange(21, 78, 0.5));
//echo(pctrange(21, 78, 1));


/* Lazy argument evaluation
 * Returns def if x is undef or if x is not in given range, else returns x
 * x - a scalar value
 * def - the default value
 * range - valid value range, e.g. [0,1] (valid x must be >= 0 and <=1)
 */
function argdef(x, def=0, range) =
   x == undef ? def
     : range == undef ? x
       : (x < range[0] || x > range[1]) ? def : x;
//echo(argdef(undef, 0)); // undef arg, defaults to 0
//echo(argdef(1.3, .5, [0,1])); // percent value 0-100% expected but 130%
//echo(argdef(7, 0, [-10,10])); // arg ok (in range)
//echo(argdef(17, 0, [-10,10])); // arg not in range, defaults to 0
