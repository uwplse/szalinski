/* [Generic case generator settings]*/
// Markham Thomas   Jan 10th, 2018
// Version 1.2
// Updated: Jan 17th, 2018 to support chamfering
// Updated: Jan 13th, 2018 to support cutouts (holes) in all 4 side-walls
// Openscad code to generate a project case with mounting screw holes
// add a small amount to account for shrinkage
// The post numbering is:   (where zero is the origin)
//   Y   ------------
//   Y   | 2        3 |
//   Y   | 1        4 |
//   Y   -------------|
//   OXXXXXXXXXXXX
// NOTE: each post if they exist are measured from their closest wall for both x and y distances
shrink_fix = 0.5;       //[0.1:0.1:0.6]
// width of the case along X axis
xwidth = 85; //[10:5:200] 
// width of the case along Y axis
ywidth = 57; //[10:5:200]
// case wall thickness
thickness = 2;          //[1:1:4]
// case height (if need outside height exact add thickness to this value)
caseheight = 12;         //[5:5:100]
// select if support posts needed (offsets are measured from inside wall to center of post)
posts = 1; //[0:false,1:true]
// select if air vents wanted in baseplate
base_plate_vents = 1; //[0:false,1:true]
// select if air vents wanted in top plate
top_plate_vents = 1; //[0:false,1:true]
// resolution of the cylinder used for the the posts inside the case
resolution = 28;               //[12:4:88]
//The X offset of post #1 from its closest Y wall (post nearest the origin)
xpost1_offset = 4;   //[1:0.5:100]
//The Y offset of post #1 from its closets X wall (post closest to origin)
ypost1_offset = 4;   //[1:0.5:100]
//The X offset of post #2 from its closest Y wall (clockwise from 1st)
xpost2_offset = 4;   //[1:0.5:100]
//The Y offset of post #2 from its closest X wall (clockwise from 1st)
ypost2_offset = 4;  //[1:0.5:100]
//The X offset of post #3 from its closest Y wall (clockwise from 2nd)
xpost3_offset = 25;   //[1:0.5:100]
//The Y offset of post #3 from its closets X wall (clockwise from 2nd)
ypost3_offset = 4;    //[1:0.5:100]
//The X offset of post #4 from its closest Y wall (clockwise from 3rd)
xpost4_offset = 25;   //[1:0.5:100]
//The Y offset of post #4 from its closest X wall (clockwise from 3rd)
ypost4_offset = 4;  //[1:0.5:100]
//Diameter of post
post_dia = 5;     //[1:0.5:5]
//diameter of screw hole in the post
post_hole_dia = 3;  //[1:0.5:4]
//height of the post
post_height = 5;    //[2:0.5:10]
//select if a lid is wanted
lid = 1; //[0:false,1:true]
//select true if you wanted chamfered edges
chamfer = 1;//[0:false,1:true]
//amount of chamfer (keep it small)
cham_val = 0.2;//[0.1:0.1:0.5]
/* [Cutouts] */
//Cutouts are all measured from the nearest origin wall - thickness of that wall
//Select true if cutouts are wanted on the X wall that's along the X axis
Xorig_cutout = 0; //[0:false,1:true]
//Select true if cutouts are wanted on the X wall away from the X axis
Xfar_cutout = 0; //[0:false,1:true]
//Select true if cutouts are wanted on the Y wall that's along the Y axis
Yorig_cutout = 0; //[0:false,1:true]
//Select true if cutouts are wanted on the Y wall away from the Y axis
Yfar_cutout = 1; //[0:false,1:true]
//Xorig_cutout bottom left X value
Xorig_cutout_bleft_x = 3; //[5:1:100]
//Xorig_cutout bottom left Z height above base - thickness
Xorig_cutout_bleft_z = 1; //[5:1:100]
//Xorig_cutout width on X axis
Xorig_cutout_width_x = 80; //[5:1:100]
//Xorig cutout height on Z axis
Xorig_cutout_height_z = 6; //[5:1:100]
//Xfar_cutout bottom right X value (facing the far X wall from outside the box)
Xfar_cutout_bright_x = 3; //[5:1:100]
//Xfar_cutout bottom right Z height above base - thickness
Xfar_cutout_bright_z = 2; //[5:1:100]
//Xfar_cutout width on X axis
Xfar_cutout_width_x = 80; //[5:1:100]
//Xfar_cutout height on Z axis
Xfar_cutout_height_z = 6; //[5:1:100]
//Yorig_cutout bottom right Y value
Yorig_cutout_bright_y = 3; //[5:1:100]
//Yorig_cutout bottom left Z height above base - thickness
Yorig_cutout_bright_z = 0; //[5:1:100]
//Yorig_cutout width on Y axis
Yorig_cutout_width_y = 52; //[5:1:100]
//Yorig cutout height on Z axis
Yorig_cutout_height_z = 10; //[5:1:100]
//Yfar_cutout bottom right Y value
Yfar_cutout_bleft_y = 3; //[5:1:100]
//Yfar_cutout bottom left Z height above base - thickness
Yfar_cutout_bleft_z = 0; //[5:1:100]
//Yfar_cutout width on Y axis
Yfar_cutout_width_y = 52; //[5:1:100]
//Yfar cutout height on Z axis
Yfar_cutout_height_z = 10; //[5:1:100]

xwide = xwidth + shrink_fix;
ywide = ywidth + shrink_fix;

// chamfered edges
module mcube(v=[1,1,1],b=1) {
    if (chamfer) {
        translate([v[0]/2,v[1]/2,v[2]/2]) {
            hull() {        // use hull and sweep a sphere past the object
                for(x=[-(v[0]/2-b),(v[0]/2-b)]){
                    for(y=[-(v[1]/2-b),(v[1]/2-b)]){
                        for(z=[-(v[2]/2-b),(v[2]/2-b)]) {
                            translate([x,y,z]) sphere(b);
                        }
                    }
                }
            }
        }
    } else {
        cube([v[0],v[1],v[2]]);
    }
}

$fn = resolution;
// origin X wall
if (Xorig_cutout) {
    difference() {
        mcube([xwide+thickness,thickness, caseheight],cham_val);
        translate([Xorig_cutout_bleft_x + thickness,0,Xorig_cutout_bleft_z+thickness]) cube([Xorig_cutout_width_x,thickness,Xorig_cutout_height_z]);
    }
} else {
    mcube([xwide+thickness*2,thickness, caseheight],cham_val);
}
// X wall opposite the origin X wall, bottom right of cutout facing the wall, measure from origin Y
if (Xfar_cutout) {
    translate([0,ywide+thickness,0]) {
        difference() {
            mcube([xwide+thickness,thickness, caseheight],cham_val);
            translate([Xfar_cutout_bright_x + thickness,0,Xfar_cutout_bright_z+thickness]) cube([Xfar_cutout_width_x,thickness,Xfar_cutout_height_z]);
        }
    }
} else {
    // farside from origin X wall
    translate([0,ywide+thickness,0]) mcube([xwide+thickness*2,thickness, caseheight],cham_val);
}
// Origin Y wall, measure from origin so bottom right of cutout box
if (Yorig_cutout) {
    difference() {
        mcube([thickness,ywide+thickness*2, caseheight],cham_val);
        translate([0,Yorig_cutout_bright_y+thickness,Yorig_cutout_bright_z+thickness]) cube([thickness,Yorig_cutout_width_y,Yorig_cutout_height_z]);
    }
} else {
    mcube([thickness,ywide+thickness*2, caseheight],cham_val);
}
// Y wall opposite the Origin Y wall, measure from X-axis so bottom left coords of cutout box
if (Yfar_cutout) {
    translate([xwide+thickness,0,0]) {
        difference() {
            mcube([thickness,ywide+thickness*2, caseheight],cham_val);
            translate([0,Yfar_cutout_bleft_y+thickness,Yfar_cutout_bleft_z+thickness]) cube([thickness,Yfar_cutout_width_y,Yfar_cutout_height_z]);
        }
    }
} else {
    // farside from origin Y wall
    translate([xwide+thickness,0,0]) mcube([thickness,ywide+thickness*2, caseheight],cham_val);
}

// offset can be zero if near origin, or further if we are doing the lid (xwide*10)
module vent(length, width, offset) {
    for (a=[0:4:20]) {
        translate([offset+length/2+thickness,a+ywide/3,0]) cube([length, width, thickness]);
    }
}

// base plate of project box
if (base_plate_vents) {
    difference() {
        mcube([xwide+thickness*2, ywide + thickness*2,thickness],cham_val);
        vent(xwide/2,2,0);
    }
} else {
    mcube([xwide+thickness*2, ywide + thickness*2,thickness],cham_val);
}

module post(post_d,hole_d,post_h) {
    difference() {
        cylinder(r=post_d/2,h=post_h,center=false);
        cylinder(r=hole_d/2,h=post_h,center=false);
    }
}

// post offsets are all measured from their closest 2 walls in X and Y
if (posts) {
    translate([xpost1_offset+thickness,ypost1_offset+thickness,thickness]) post(post_dia,post_hole_dia,post_height);
    translate([xpost2_offset+thickness,(ywide+thickness)-ypost2_offset,thickness]) post(post_dia,post_hole_dia,post_height);
    translate([(xwide+thickness)-xpost3_offset,(ywide+thickness)-ypost3_offset,thickness]) post(post_dia,post_hole_dia,post_height);
    translate([(xwide+thickness)-xpost4_offset,ypost4_offset+thickness,thickness]) post(post_dia,post_hole_dia,post_height);
}

// lid is a module so we can diff vents if needed
module lid() {
    translate([xwide+thickness*10,0,0]) {
        mcube([xwide+thickness*2,ywide+thickness*2,thickness],cham_val);          // lid
        difference() {                                                  // lid inner ribs
            translate([thickness+shrink_fix/2,thickness+shrink_fix/2,thickness]) cube([xwide-shrink_fix,ywide-shrink_fix,thickness]);
            translate([thickness*2,thickness*2,thickness]) cube([xwide-thickness*2,ywide-thickness*2,thickness]);
        }
    }
}

// lid has ribs that should help it stick onto the top of the project box
if (lid && top_plate_vents) {
        difference() {
            lid();
            vent(xwide/2,2,xwide+thickness*10);
        }
} else {
    lid();
}
