// This code builds a box with three arbitrary sides that fits into the corner of a room. You can add arbitrary holes for a cable (wall panels) or some sensors (room side). The wall panels are identical if the side lengths are. Wall-to-wall edges can be mitered because wall corners often are. Miter depth is measured along the wall and can be > the box thickness. The miter angle is always 45°.

// All measurements are in mm.

/* version history
1.1: published at Thingiverse
1.2: add comments for Thingiverse Customizer
1.3: generation of holes was missing in some views
1.4: fix min distance of hole from lid edge
1.5: configure offset of hooks from lid
1.6: add dummy module to hopefully fix Customizer
1.7: fix low hole count, adjust hole positions
1.8: add cable hole, add (up to 4) top holes
*/

// length of first edge
side_x = 95   ; // [20:250]

// length of second edge
side_y = side_x; // [20:250]

// length of third edge
side_z = 110; // [20:250]

// thickness of walls.
wall_side = 1.5; // [10]

// thickness of lid.
wall_top = 2; // [10]

// how much to cut off at the edge, for better fit to walls. Must be less than min side wall thickness.
edge_miter = 2.5; // [0:0.1:2]

// output: top, sides 1-3, all four on plane, assembled, w/o top, w/o side 1-3
output = 3; // [0:1:9]

// which side shall have a hole for a cable? Zero=None
cable_side = 2; // [0-4]

// diameter of the cable
cable_width = 12; // [2-15]

// distance A
cable_y = 70-6; // [10-100]

// distance B
cable_x = 25-6; // [10-100]

// direction? 0=along X, 90=along Y, -1=towards Z-axis, -2=none
cable_angle=90; // [-2-90]

/*
Holes in the top, for things to poke through
*/

// center hole
th_center = 22.5; // [0-30]

// Offset for a hole near the X corner
th_off_x = 30; // [0-100]

// Offset for a hole near the Y corner
th_off_y = 20; // [0-100]

// Offset for a hole near the Z corner
th_off_z = 70; // [0-100]

// Size of a hole near the X corner
th_size_x = 0; // [0-20]

// Size of a hole near the Y corner
th_size_y = 0; // [0-20]

// Size of a hole near the Z corner
th_size_z = 4; // [0-20]


/* add mounting holes? at most n per side. They start in the corner and extend until there are either n/2 on a side or they get too close to the edge. NB: there's no collision check of holes vs. hooks! */
// number of mounting holes
n_holes = 1; // [0:11]
// bore diameter of hole, must be <ring
hole_inner = 4; // [2:0.5:8]
// diameter of strengthening ring
hole_outer = 6; // [3:0.5:12]
// height of strenghtening ring
hole_height = 1; // [0:2]
// sink inner edge of hole (for slanted-head screws)
hole_inner_sink = 0.5; // [0:0.2:5]
// distance of the holes from the edges
hole_edge = 20; // [0:0.5:30]
// distance between holes on the same edge
hole_offset = 18; // [0:0.5:50]

// separation between pieces when printing
delta = 5; // [1:2:11]

// number of hooks per edge, evenly spaced.
n_hooks = 2; // [0:5]
// hook width
hook_width = 2; // [1:0.5:5]
// width of the groove
groove_width = 3; // [1:0.5:7]
// additional offset of sides' hooks from lid (to prevent collisions with lid)
hook_off_edge = 1; // [0.5:0.5:4]
// hook depth (that's the part that bends)
hook_depth = 1; // [0.5:0.25:2.5]
// length of the part that bends
hook_len = 3; // [1:0.5:10]
// how far does the tip of the hook extend?
hook_edge_depth = 1; // [0.5:0.25:3]
// height of slanted part under the tip
hook_edge = 1; // [1:0.5:3]
// height of the head (from tip to top)
hook_head = 2; // [1:0.5:5]
// additional stremgthening of the base so the hook doesn't tear off
hook_base = 1; // [0:0.5:3]

// depth
hook_base_depth = hook_base;


/*
 * The pieces are joined with a couple of fancy hooks, the parameters for which require some explaining.

This is the groove which the hook joins:
 
     |   |
     |   |
     |   |
     |   | /- here is where the tip ends up at
    /    | -- hook_edge
    |    | -- hook_len
     \   | -- the part's edge is extended until it is hook_len high
      \  |
       \/  -- 1/2 miter

The top/side joins are <90° so this will be slanted to the left.

The hook, below, moves up and joins with the groove:
     /---- the top of the hook
 |\  ----- height: hook_head
 | \ /---- the tip of the hook
 | / ----- height: hook_edge
 | | ----- height: hook_len-hook_base
/ _|_----- height: hook_base (ASCII art is wrong, it's on the outside)
     \
      \
       \
_______/ - 1/2 miter
^ ^ ^ 
| |  \---- width: hook_edge_depth
|  \------ width: hook_depth
 \-------- width: hook_base_depth

For the top/side joins this will move to the left appropriately.

The hook shall be auto-placed so that it (a) meets with the groove and (b) isn't cut off by the miter.

hook_edge must be smaller than hook_edge_depth, otherwise the sides can just slide apart. This is not a problem with the top. TODO allow different parameters for it.

*/

module no_params_beyond_here() {
    // this is a lie but prevents Customizer to look beyond this
}

HOOKS_TOP = [n_hooks,hook_width,groove_width,hook_depth,hook_edge_depth,hook_head,hook_edge,hook_len,hook_base,hook_base_depth];
// Here you can modify the parameters for edges separately. Specifically we increase the edge depth so that the sides hold onto each other better, with an edge of 45° (or less) they'd slide apart.
HOOKS_EDGE = [3,hook_width,groove_width,hook_depth,hook_edge_depth,hook_head*1.5,hook_edge*0.6,hook_len,hook_base,hook_base_depth];

// Customizeable hooks. The basic lookup function just uses the same hook style everywhere.
function hc(n,c) = (n>=0) ? HOOKS_TOP[c] : HOOKS_EDGE[c];
N_HOOKS=0;
H_WIDTH=1;
H_G_WIDTH=2;
H_DEPTH=3;
H_EDGE_DEPTH=4;
H_HEAD=5;
H_EDGE=6;
H_LEN=7;
H_BASE=8;
H_BASE_DEPTH=9;

// don't change below this point

// first, some common trig formulae

function distance(a,b) = sqrt(a*a+b*b);

// Two circles of radius a and b, centered at (0,0) and (c,0), meet at (x,y):
function circle_intersect_x(a,c,b) = (a*a+c*c-b*b)/2/c;
function circle_intersect_y(a,x) = sqrt(a*a-x*x);

// all arrays are duplicated to avoid mod() when indexing with an offset

// arbitrary ordering so that side_x/side_y is at +x/+y when flattened.
// (z-axis ends up at -y, the y edge is mirrored to -x
//  the top of the box is in the -x/+y quadrant)
// This continues in the rest of the code: think of index zero as the Z axis
// or as referring to the XY-triangle that's perpendicular to it.
// Same for the other axes of course.

axes = [side_z,side_x,side_y,
        side_z,side_x,side_y,
        side_z,side_x,side_y]; 

// The edges are numbered so that edge N doesn't touch axis N
function _edge(n) = distance(axes[n+1], axes[n+2]);
edges = [_edge(0),_edge(1),_edge(2),
         _edge(0),_edge(1),_edge(2),
         _edge(0),_edge(1),_edge(2)];

// internal angles of side triangle n on the side in common with n+1
function side_angle(n) = atan2(axes[n+1], axes[n+2]);
angles1 = [side_angle(0),side_angle(1),side_angle(2),
           side_angle(0),side_angle(1),side_angle(2),
           side_angle(0),side_angle(1),side_angle(2)];

// The corners of the top plate, when it lies flat, are at X=(0,0) Z=(edge_y,0) Y=(x2,y2)
// yes this is the wrong way 'round, but that is intentional because you need to flip the lid when you put it on top of the box
x2=circle_intersect_x(edges[0],edges[2],edges[1]);
y2=circle_intersect_y(edges[0],x2);

// Heights of side triangles. Again, height vector N is perpendicular to axis N.
function _height(n) = sin(angles1[n]) * axes[n+2];
heights = [_height(0),_height(1),_height(2),
           _height(0),_height(1),_height(2),
           _height(0),_height(1),_height(2)];

// internal angle of the top plate against side N
function top_angle(n) = atan2(axes[n], heights[n]);
angles2 = [top_angle(0),top_angle(1),top_angle(2),
           top_angle(0),top_angle(1),top_angle(2),
           top_angle(0),top_angle(1),top_angle(2)];

// The edge to remove from wall N+1 so that it meets wall N-1 halfway,
// which can be rotated so that it's also the edge to remove from N-1
// to meet N+1 halfway, which is why there's only one chamfer1 module.
module chamfer1(n) {
    translate([0,0,wall_side])
        rotate(a=[0,90,0])
            linear_extrude(height=axes[n], center=false) 
                polygon([[0,0],[wall_side,0],[0,wall_side]]);
}

// A wall with thickness B merges with a wall with thickness A at angle Alpha
// so that their outer edges coincide. Calculate the angle Gamma (with 0<Gamma<Alpha)
// required to chamfer the edge of B so that the walls' inner edges also meet.
// (Verifying this formula is left as an exercise for the reader.)
function angle_c(alpha,a,b) = atan2(b, a/sin(alpha)+b/tan(alpha));

// The edge to remove from side N so that it meets the top halfway
module chamfer2(n) {
    ac = angle_c(angles2[n+2], wall_top, wall_side);

    translate([0,axes[n+1],wall_side])
        rotate([0,0,angles1[n+2]+180])
            rotate([-90,0,0])
                linear_extrude(height=edges[n+2], center=false) 
                    polygon([[0,0],[wall_side/tan(ac),0],[0,wall_side]]);
}

// The three chamfer edges of a side
module chamfer_side(n) {
    union() {
        chamfer1(n);
        translate([wall_side,0,wall_side]) rotate([-90,0,90]) chamfer1(n+1);
        chamfer2(n);
    }
}

// The edge to remove from the top so that it meets wall N halfway
module chamfer3(n) {
    ac = angle_c(angles2[n], wall_side, wall_top);
    rotate([0,90,0])
        linear_extrude(height=edges[n], center=false)
            polygon([[0,0],[-wall_top,0],[-wall_top,wall_top/tan(ac)]]);
}

// calculate the internal angle of the top triangle at corner N
// (also left as an exercise …)
function angle3(n) = acos((edges[n+1]*edges[n+1]+edges[n+2]*edges[n+2]-edges[n]*edges[n])/2/edges[n+1]/edges[n+2]);

// The three chamfer edges of the top
module chamfer_top() {
    union() {
        chamfer3(2); // the Y edge of the top plate lies along the x axis. See "corners of the top plate", above
        translate([x2,y2,0]) rotate([0,0,180+angle3(1)]) chamfer3(0);
        translate([edges[2],0,0]) rotate([0,0,180-angle3(0)]) chamfer3(1);
    }
}



// ***** Here's where we build our joints. ******

// polygon for the hook. n-1: edge-to-edge, else edge-to-top
module poly_hook(n) {
    a_hook = atan2(hc(n,H_HEAD), hc(n,H_DEPTH)+hc(n,H_EDGE_DEPTH));
    a_wall = (n<0) ? 90 : angles2[n];
    a_chamfer = (n<0) ? 45 : angle_c(angles2[n], wall_top, wall_side);

    y_tip = hc(n,H_LEN)+hc(n,H_EDGE);
    y_top = hc(n,H_LEN)+hc(n,H_EDGE)+hc(n,H_HEAD);

    // if a_hook > a_wall, the wall is too flat and we need to start with the hook's top
    x_top = (a_hook > a_wall) ? y_top/tan(a_wall) : y_tip/tan(a_wall)+hc(n,H_EDGE_DEPTH)+hc(n,H_DEPTH);
    x_tip = (a_hook > a_wall) ? y_top/tan(a_wall)-hc(n,H_EDGE_DEPTH)-hc(n,H_DEPTH) : y_tip/tan(a_wall);

    x_edge = x_tip+hc(n,H_EDGE_DEPTH);
    y_edge = y_tip-hc(n,H_EDGE);

    // base towards the center
    // polygon([[x_top,y_top], [x_tip,y_tip], [x_edge,y_edge], [x_edge,0], [x_edge+hook_depth+hc(n,H_BASE_DEPTH),0], [x_tip,hc(n,H_BASE)]]);
    // base towards the edge
    polygon([[x_top,y_top], [x_tip,y_tip], [x_edge,y_edge], [x_edge,hc(n,H_BASE)], [x_edge-hc(n,H_BASE_DEPTH),0], [x_edge+hc(n,H_DEPTH),0]]);

}

// polygon for the hook's groove. n-1: edge-to-edge, else edge-to-top
module poly_hook_groove(n) {
    a_hook = atan2(hc(n,H_HEAD), hc(n,H_DEPTH)+hc(n,H_EDGE_DEPTH));
    a_wall = (n<0) ? 90 : angles2[n];
    a_chamfer = (n<0) ? 45 : angle_c(angles2[n], wall_top, wall_side);

    y_tip = hc(n,H_LEN)+hc(n,H_EDGE);
    y_top = hc(n,H_LEN)+hc(n,H_EDGE)+hc(n,H_HEAD);

    if (a_hook > a_wall) { // wall too flat, need additional offset
        x_top = y_top/tan(a_wall);
        x_tip = x_top-hc(n,H_EDGE_DEPTH)-hc(n,H_DEPTH);
        x_edge = x_tip+hc(n,H_EDGE_DEPTH);
        y_edge = y_tip-hc(n,H_EDGE);
        x_base = x_edge - y_edge / tan(a_hook);
        rotate(atan2(x_top,y_top))
        polygon([[x_top,y_top],[x_tip,y_tip],  [x_edge,y_edge], [x_base,0], [0,0]]);
    } else { // simple case
        x_tip = y_tip*tan(90-a_wall); // avoid dividing by infinity
        x_edge = x_tip+hc(n,H_EDGE_DEPTH);
        y_edge = y_tip-hc(n,H_EDGE);
    
        // start at tip, counterclockwisewall_top*cos(angles2[n])
        rotate(atan2(x_tip,y_tip))
        if (x_edge/tan(a_chamfer) > y_edge)
            polygon([[x_tip,y_tip], [x_edge,y_edge], [0,0]]);
        else
            polygon([[x_tip,y_tip], [x_edge,y_edge], [x_edge,x_edge/tan(a_chamfer)], [0,0]]);

    }
}

// distribute hooks/grooves along the wall
module hook_pos_wall(n,off=0) {
    n_h = hc(-1-n,N_HOOKS);
    n_h_lim = n_h + hook_off_edge+0.5;
    for(x=[1:n_h])
        let(xx=(off?-0.5:0)+x) 
        translate([0,0,axes[n]*(off?n_h_lim-xx:xx)/n_h_lim])
        linear_extrude(hc(-1-n,H_G_WIDTH), center=true)
            children();
}

// grooves along the wall
module grooves_wall(n,off=0) {
    hook_pos_wall(n,off) poly_hook_groove(-1-n);
}

// hooks along the wall
module hooks_wall(n, off=0) {
    hook_pos_wall(n, off) poly_hook(-1-n);
}

// position hooks/grooves along the edge
module hook_pos_edge(n) {
    for(x=[1:hc(n,N_HOOKS)]) translate([0,0,edges[n]*(x+1)/(hc(n,N_HOOKS)+3)])
        linear_extrude(hc(n,H_G_WIDTH), center=true)
            children();
}

// grooves for the edge
module grooves_edge(n) {
    hook_pos_edge(n) poly_hook_groove(n);
}

// hooks along the edge
module hooks_edge(n) {
    a_chamfer = angle_c(angles2[n], wall_side,wall_top);
    rotate([0,90,0]) rotate(90)
    translate([wall_top/tan(a_chamfer),wall_top,0])
    hook_pos_edge(n) poly_hook(n);
}

// the actual hole, slightly larger so that preview sees it
module hole_bore() {
    union() {
        translate([0,0,-0.5]) cylinder(h=hole_height+wall_side+1,d=hole_inner);
        translate([0,0,wall_side+hole_height-hole_inner_sink]) cylinder(h=hole_inner_sink,d1=0,d2=hole_outer);
    }
}

// an inward-slanted ring on the hole, for stability when screwing it to an actual wall
module hole_ring() {
    cylinder(h=hole_height+wall_side,d=hole_outer);
}

// Position the holes.
module hole_pos(n) {
    // Start position
    inner = hole_edge+wall_side;
    
    // how close to the lid edge may we get?
    c_offset = wall_side/tan(angle_c(angles2[n], wall_top, wall_side)) + hole_outer/2 + hole_height/tan(angles2[n]);
    
    // Here we figure the corresponding max offsets. The first subtracted term gets us to the place we'd be if the holes were at the outer edge, but of course they aren't.
    lim_1 = axes[n+1] - c_offset / sin(90-angles1[n]) - inner*tan(angles1[n]);
    lim_2 = axes[n+2] - c_offset / sin(angles1[n]) - inner/tan(angles1[n]);

    // if there's an even number of holes, shift them to be halfway between the places they'd be if there was an odd number.
    union() {
        if (n_holes>0 && n_holes%2) translate([inner,inner,0]) children();
        if (n_holes>=2) for (x=[1:n_holes/2]) {
            offset=(x-(1-n_holes%2)/2)*hole_offset+inner;
            if (offset <= lim_1) translate([offset,inner,0]) children();
            if (offset <= lim_2) translate([inner,offset,0]) children();
        }
    }
}

// Modifier that adds holes
module make_holes(n) {
    difference() {
        union() {
            hole_pos(n) hole_ring();
        
            children();
        }
        hole_pos(n) hole_bore();
    }
}

// Main code: make a side
module side(n) {
    a_chamfer = angle_c(angles2[n], wall_top, wall_side);

    union() {
        difference() {
            linear_extrude(height=wall_side, center=false) 
                polygon([[0,0],[axes[n+1],0],[0,axes[n+2]]]);
            chamfer_side(n+1);
            #cable(n+1);
            to_next_side() mitered_edge(n+1);
            to_next_side() to_next_side() mitered_edge(n+2);
        }
        
        translate([wall_side,0,wall_side]) rotate([0,-90,-90]) grooves_wall(n+2,0);
        translate([axes[n+1],wall_side,wall_side]) rotate([-90,-90,90]) grooves_wall(n+1,1);
        
        // Yes this can be simplified, but then it'll be unreadable.
        translate([0,axes[n+2],wall_side]) rotate(angles1[n]-90) translate([0,-wall_side/tan(a_chamfer),0]) rotate([0,90,0]) rotate([0,0,180]) grooves_edge(n);
        translate([0,wall_side,wall_side]) rotate([0,90,0]) rotate([0,0,90])        hooks_wall(n+1,0);
        translate([wall_side,axes[n+2],wall_side]) rotate([90,0,0]) hooks_wall(n+2,1);
    }
}

// rotate side N (or something on it) to move to N+1
module to_next_side() {
    rotate([90,0,0]) rotate([0,90,0]) children();
}

// One outer edge chamfer.
module mitered_edge(n) {
    //translate([0,0,wall_side])
        linear_extrude(height=axes[n], center=false) 
                polygon([[0,0],[edge_miter,0],[0,edge_miter]]);
}

// All outer edge chamfers
module mitered_edges() {
    mitered_edge(0);
    to_next_side() mitered_edge(1);
    to_next_side() to_next_side() mitered_edge(2);
}

// show all sides where they belong
module uncut_sides(n=-1) {
    if (n != 1) make_holes(0) side(0);
    if (n != 2) to_next_side() color("red") make_holes(1) side(1);
    if (n != 3) to_next_side() to_next_side() color("green") make_holes(2) side(2);
}

module sides(n=-1) {
    difference() {
        uncut_sides(n);
        mitered_edges();
    }
}

// The hole for a cable on one of the sides.
module cable(n=1) {
    if(cable_side==n) {
        a=(cable_angle==-1) ? atan2(cable_y,cable_x) : cable_angle;
        hd=(distance(cable_x,cable_y)-cable_width)/3;
        translate([cable_x,cable_y,0]) {
            cylinder(h=wall_side, d=cable_width);
            if(cable_angle>-2) {
                translate([-cable_width*cos(a),-cable_width*sin(a),wall_side])
                    rotate(a)
                    rotate([90,0,0])
                    rotate_extrude(angle=90)
                        translate([cable_width, 0, 0])
                        circle(d = cable_width);
                translate([-cable_width*cos(a),-cable_width*sin(a), cable_width+wall_side]) rotate(a)
                    rotate(a=90,v=[0,-1,0])
                    cylinder(h=hd,d=cable_width);
            }
        }
    }
}

// helper to subtract the cable from the top
module cables() {
    cable(1);
    to_next_side() cable(2);
    to_next_side() to_next_side() cable(3);
}

// move the top to where it belongs
module to_top() {
    translate([axes[1],0,0])
        rotate(-180+angles2[0], v=[-axes[1],axes[2],0])
            rotate(90-angle3(1)+angles1[0])
                children();
}

// invert to_top. Required for the outer edge chamfer and cable.
module from_top() {
    rotate(angle3(1)-angles1[0]-90)
    rotate(180-angles2[0], v=[-axes[1],axes[2],0])
    translate([-axes[1],0,0])
    children();
}

module top_holes()
{
    ax=atan2(y2,x2);
    az=atan2(y2,(edges[2]-x2));
    ay=180-ax-az;
    ay2=180+ax+ay/2;
//xyz => yzx

    if(th_center) {
        x=edges[2]/(1+tan(ax/2)/tan(az/2));
        translate([x,x*tan(ax/2),-0.5]) cylinder(h=wall_top+1,d=th_center);
    }
    if(th_size_x) {
        translate([th_off_x*cos(ax/2),th_off_x*sin(ax/2),-0.5]) cylinder(h=wall_top+1,d=th_size_x);
    }
    if(th_size_y) {
        translate([x2+th_off_z*cos(ay2),y2+th_off_z*sin(ay2),-0.5]) cylinder(h=wall_top+1,d=th_size_y);
    }
    if(th_size_z) {
        translate([edges[2]-th_off_z*cos(ay/2),th_off_z*sin(az/2),-0.5]) cylinder(h=wall_top+1,d=th_size_z);
    }
}

// the top piece
module uncut_top() {
    union() {
        difference() {
            linear_extrude(height=wall_top, center=false) 
                polygon([[0,0],[edges[2],0],[x2,y2]]);
            chamfer_top();
            #top_holes();
        }
        hooks_edge(2);
        translate([x2,y2,0]) rotate([0,0,180+angle3(1)]) hooks_edge(0);
        translate([edges[2],0,0]) rotate([0,0,180-angle3(0)]) hooks_edge(1);
   }
}

// cut the mitered corners off the top edge. The math to do that explicitly is annoyingly complicated, so we simply reverse the transform that puts the top onto the box.
module top() {
    difference() {
        uncut_top();
        from_top() mitered_edges();
        from_top() cables();
    }
}

module box(n=-1) {
    union() {
        sides(n);
        if (n) to_top() top();
    }
}

module flat() {
    translate([delta/2,-delta/2,0]) rotate(270) make_holes(1) side(1);
    translate([delta/2,delta/2,0]) make_holes(2) side(2);
    translate([-delta/2,-delta/2,0]) rotate(180) make_holes(0) side(0);
    translate([-edges[2]-delta/2,delta/2,0]) top();
}

// output: top, sides 1-3, all four on plane, assembled, w/o top, w/o side 1-3
if (output == 0)
    top();
else if (output <= 3)
    make_holes(output) side(output);
else if (output == 4)
    flat();
else
    box(output-6);

module batt() {
    r=4;
    union() {
        cube([17,r,60]);
        translate([r,r,r]) minkowski() { cube([17-2*r,18-2*r,60-2*r]); sphere(r); } }
}
module pi() {
    r=5;
    union() {
        
        translate([r,r,0]) minkowski() {
            cube([32-2*r,67-2*r,18-2]);
            cylinder(1,r=r);
        }
        translate([32-2-5,8,18-1]) cube([5,52,7]);
    }
}
if(0 && (output>4)) {
translate([67+wall_side+2,19+wall_side+2,8+wall_side+2]) rotate(45) rotate([0,-125,0]) pi();
translate([wall_side+2,wall_side+2,wall_side+2]) batt();
}