// hex toy bricks based on designs described at 
// http://tamivox.org/redbear/hex_toy_bricks/index2.html
// I follow the prose descriptions and formulas given there, but this
// implementation in openscad is original.

// configurable values
stud_height = 2;
base_height = 3;
base_width = 3.5;
outer_width = .8;
inner_width = .64;
ceiling_thickness = .4;
stud_inset = .05;
outer_wall_inset = .25;
corner_round = .05;

// Round or hex studs are both viable choices
use_round_stud = false;

// "the base height equals the sum of the socket depth and the ceiling
// thickness"
socket_depth = base_height - ceiling_thickness;

// "the stud height cannot be more than the socket depth"
if(socket_depth < stud_height) error();

// "If the stud width is denoted by S, the base width by B, and the inner width
// by I, then S = (B - I) / sqrt(3)" says tamivox.org, but this doesn't
// make a correct model in openscad even after accounting for the fact that
// a "hexagon" constructed with cylinder() is measured with the diameter across
// points instead of across flats.
hex_stud_width = base_width - inner_width / sqrt(3);

// "Some manufacturers might prefer a round stud.  For a crisp fit in the
// hexagonal sockets, the diameter should be sqrt(3) times the stud width as
// given in figure F-1a"
round_stud_width = hex_stud_width * sqrt(3)/2;

// advance from point to point of hex
short_advance = base_width * sqrt(3);
// advance from to flat of hex
long_advance = 1.5 * base_width;

X = [1,0,0];
Y = [0,1,0]; XY = X+Y;
Z = [0,0,1]; XZ = X+Z; YZ = Y+Z; XYZ=X+Y+Z;

module cube_cc(sz, cc) {
    translate([sz[0] * cc[0] * -.5, sz[1] * cc[1] * -.5, sz[2] * cc[2] *-.5])
        cube(sz);
}

module cube_cx(sz) { cube_cc(sz, X); }
module cube_cy(sz) { cube_cc(sz, Y); }
module cube_cxy(sz) { cube_cc(sz, X+Y); }

module lambda_wall(width=inner_width) {
    for(th=[0,120,240])
        rotate([0,0,th])
            cube_cy([base_width, width, base_height - ceiling_thickness/2]);
}

module hexgrid(x, y) {
    yprime = y + .5 * x;
    translate([x*long_advance, yprime*short_advance,0]) children();
}

// Output a hex grid of walls nx × ny
module inner_walls(nx, ny) {
    translate([-base_width/2, -short_advance/2, -base_height])
    for(x=[-1:1:nx]) {
        for(y=[-1:1:ny]) {
            hexgrid(x,y) lambda_wall();
        }
    }
}


module outline_single() {
    rotate(Z*30)
    circle(short_advance, $fn=6);
}

module round_stud() {
    cylinder(r=round_stud_width-stud_inset, h=stud_height);
}

module hex_stud() {
    difference() {
        translate(-ceiling_thickness*Z/2)
        cylinder(r=hex_stud_width-stud_inset, h=stud_height+ceiling_thickness/2, $fn=6);
        translate(-ceiling_thickness*Z)
        cylinder(r=(hex_stud_width-stud_inset)/2, h=stud_height+2*ceiling_thickness, $fn=24);
    }
}

module stud() {
    if(use_round_stud) round_stud(); else hex_stud();
}

function maxcoord_x(seq, best=0) = len(seq) == 0 ? best
    : maxcoord_x(rest(seq), max(best, seq[0][0]));
function maxcoord_x(seq, best=0) = len(seq) == 0 ? best
    : maxcoord_x(rest(seq), max(best, seq[0][0]));

module outline_coordlist(cc) {
    offset(r=-corner_round)
    offset(r=corner_round)
    for(ii=[0:1:len(cc)-1]) {
        ci = cc[ii];
        hull() {
            for(jj=[0:1:len(ci)-1]) {
                cij = ci[jj];
                x = cij[0];
                y = cij[1];
                hexgrid(x,y) outline_single();
            }
        }
    }
}

module inner_volume_coordlist(cc) {
    translate([0,0,-base_height-1])
    linear_extrude(height=base_height+2)
        offset(delta=-outer_wall_inset-outer_width/2)
        outline_coordlist(cc);
}

module outer_walls_coordlist(cc) {
    translate(-Z*base_height)
    linear_extrude(height=base_height-ceiling_thickness/2)
        difference() {
            offset(delta=-outer_wall_inset)
                outline_coordlist(cc);
            offset(delta=-outer_width-outer_wall_inset)
                outline_coordlist(cc);
        }
}

module ceiling_coordlist(cc) {
    translate((-ceiling_thickness+1e-3)*Z)
        linear_extrude(height=ceiling_thickness)
            offset(delta=-outer_wall_inset-1e-3)
            outline_coordlist(cc);
}

// The structure of the "cc" parameter is complicated:
// It is a list of lists of nonnegative integer coords
// Each coord gets a stud
// The outer walls for each list of points get hulled together, which is useful
// for lateral bricks.  The outermost lists are not hulled but common edges
// are eliminated, which is useful for punctal bricks.  It seems possible that
// there are uses for bricks that combine punctal and lateral features.
module piece_coordlist(cc) {
    maxx = max([for (i=cc) max([for(j=i) j[0]])]);
    maxy = max([for (i=cc) max([for(j=i) j[1]])]);

    color("red") outer_walls_coordlist(cc);
    intersection() {
        color("blue") inner_walls(maxx+1, maxy+1);
        inner_volume_coordlist(cc);
    }
    color("orange") ceiling_coordlist(cc);
    for(ii=[0:1:len(cc)-1]) {
        ci = cc[ii];
        for(jj=[0:1:len(ci)-1]) {
            cij = ci[jj];
            x = cij[0];
            y = cij[1];
            hexgrid(x,y) stud();
        }
    }
}

// A-1
hexgrid(-1,3)
piece_coordlist([[[0,0]]]);
piece_coordlist([
    [[0,1]], [[2,0]]
]);

// A-3.1
hexgrid(1,3)
piece_coordlist([
    [[0,2]], [[2,1]], [[4,0]]
]);
// A-3.2
hexgrid(4,0)
piece_coordlist([
    [[0,2]], [[2,1]], [[3,2]]
]);

// A-3.3
hexgrid(1,1)
piece_coordlist([
    [[0,1]], [[2,0]], [[1,2]]
]);

// D-1 (lateral brick)
hexgrid(4,-1)
piece_coordlist([[[0,0],[2,0]]]);
