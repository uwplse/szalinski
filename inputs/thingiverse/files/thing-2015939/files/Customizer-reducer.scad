// eccentric pipe reducer
// by MisterC

// input parameters

/* lower pipe */
// lower pipe inner diameter
lower_diameter = 32; // min/max:[1:100]
// lower pipe height
lower_height = 20; // min/max:[1:100]
// lower pipe wall
lower_wall = 4; // min/max:[0.5:0.5:10]

/* transition piece */
// gap between lower and upper pipes
trans_height = 20; // min/max:[5:50]

// offset of reducer:
trans_angle = 0; // min/max:[0:360]
// angle (0=+X,90=+Y etc)
// ratio to cl
trans_ratio = 100; // min/max:[0:100]
// 0 ratio is concentric
// 100 ratio is wall parallel

// should inside walls run through?
in_parallel = true; // [true,false]
// true if inner wall would be parallel, false if outer

// resolution of reducer
segments = 36; //[36:Low, 90:Medium, 180:High]


/* upper pipe */
// upper pipe inner diameter
upper_diameter = 12; // min/max:[1:100]
// upper pipe height
upper_height = 20; // min/max:[1:100]
// upper pipe wall
upper_wall = 2; // min/max:[0.5:0.5:10]


// calculated values
/* [Hidden]*/
ang = 360 / segments; // degrees per segment
$fn = segments; // make the pipes as accurate as the transition
fudge = 1; // fudge for cuts

// heights
lower_btm = 0;
lower_top = lower_btm + lower_height;
upper_btm = lower_top + trans_height;
upper_top = upper_btm + upper_height;

// pipe radii
lower_in = lower_diameter / 2;
lower_out = lower_in + lower_wall;
upper_in = upper_diameter / 2;
upper_out = upper_in + upper_wall;

// if parallel_check is inners (in_parallel is true) then centre_offset is inners else outers
// using SCAD's conditional syntax
ctr_off = in_parallel
    ? (lower_in - upper_in)
    : (lower_out - upper_out);

// now work out where the upper pipe centre is
x_offset = cos(trans_angle) * ctr_off * trans_ratio / 100;
y_offset = sin(trans_angle) * ctr_off * trans_ratio / 100;


// modules and functions
// cos_fill & sin_fill create a list of x&y co-ordinates using a loop structure copied from Mathgrrl's snowflakerator sequence generators
function cos_fill(distance, switch)
    = [for(step=[0:segments])
        distance*cos(ang*step) + x_offset*switch];

function sin_fill(distance, switch)
    = [for(step=[0:segments])
        distance*sin(ang*step) + y_offset*switch];

// lots of co-ordinate calcs
lower_Ox=cos_fill(lower_out,0);
lower_Oy=sin_fill(lower_out,0);

upper_Ox=cos_fill(upper_out,1);
upper_Oy=sin_fill(upper_out,1);

lower_Ix=cos_fill(lower_in,0);
lower_Iy=sin_fill(lower_in,0);

upper_Ix=cos_fill(upper_in,1);
upper_Iy=sin_fill(upper_in,1);

// and now to business
color ("green")
difference()    // lower pipe
{
    translate([0,0,lower_btm])
        cylinder(r=lower_out, h=lower_height);
    translate([0,0,lower_btm-fudge])
        cylinder(r=lower_in, h=lower_height+(2*fudge));
}
color ("red")
difference()    // upper pipe
{
    translate([x_offset,y_offset,upper_btm])
        cylinder(r=upper_out, h=upper_height);
    translate([x_offset,y_offset,upper_btm-fudge])
        cylinder(r=upper_in, h=upper_height+(2*fudge));
}
// 'cubes' (really trapezoidal blocks) for reducer using polyhedron command as per OpenSCAD wiki example 1 by Bruno Bronosky
color ("blue")
for (step=[1:segments])
{
    polyhedron(points = [
        [lower_Ox[step-1],lower_Oy[step-1],lower_top],
        [lower_Ox[step],lower_Oy[step],lower_top],
        [lower_Ix[step],lower_Iy[step],lower_top],
        [lower_Ix[step-1],lower_Iy[step-1],lower_top],
        [upper_Ox[step-1],upper_Oy[step-1],upper_btm],
        [upper_Ox[step],upper_Oy[step],upper_btm],
        [upper_Ix[step],upper_Iy[step],upper_btm],
        [upper_Ix[step-1],upper_Iy[step-1],upper_btm]
        ], faces = [
        [0,1,2,3],[4,5,1,0],[7,6,5,4],
        [5,6,2,1],[6,7,3,2],[7,4,0,3]]);
}