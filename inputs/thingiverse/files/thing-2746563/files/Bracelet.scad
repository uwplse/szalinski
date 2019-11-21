// Inner diameter of the bracelet
dia = 57;

// diameter of the spiral wire - the diameter can be different
// on width vs height
wire_dia_w = 4;
wire_dia_h = 2;

// diameter of the hole that the wire is spiralling around
wire_hole = 3;

// gap between consecutive rounds of the spiral
wire_gap = 1.4;

fillet = .2;

// Nnumber of sides of the polygon that is the crossection of the wire
// Use 4 for a square/rectangular crossection wire
wnum = 4;


// inner circumference = PI * dia
// divide that by wire_dia + wire_gap to get number of turns
turns = floor(PI * dia / (wire_dia_w + wire_gap));


points_per_turn = 48;

vnum = points_per_turn * turns;
// v = turning in the main torus
vlist = [ for(i = [0:vnum]) (i *360/vnum) % 360];
// w = turning around the wire, only 4 points
wlist = [ for(i = [0:wnum]) (i*360/wnum + (90-360/wnum/2)) % 360];

// Note in both v and w, we have the first value repeated as 
// the last value, this makes it easier to wrap around

// a = radius of main torus, b = radius of torus tube
a = (wire_hole/2 + wire_dia_h +  dia + wire_dia_h + wire_hole/2)/2;
b = (wire_hole/2 + wire_dia_h + wire_hole/2)/2;
cw = wire_dia_w/2 * sqrt(2);
ch = wire_dia_h/2 * sqrt(2);

// xFunc and yFunc are similar to cos and sin, but they create a 
// rounded rectangle instead, i.e. they are complex forms of
//   function xFunc(b,t) = b * cos(t);
//   function yFunc(b,t) = b * sin(t);
//
// Internally they Cceates an approximation of a rounded rectangle
// with fillet radius 'b*fillet'
// b = radius of rectangle
// conceptually draww a circle of radius  b*sqrt(2)-b*fillet so that 
// at the corners the circle misses the corner by b*fillet,
// and then clips this circle to a rectangle of radius b 
// (i.e. size 2b x 2b )

function xFunc(b,t) = let(b1 = (b*sqrt(2)-fillet*b) * cos(t))
  b1 < -b ? -b : (b1 > b ? b : b1);

function yFunc(b,t) = let(b1 = (b*sqrt(2)-fillet*b) * sin(t))
  b1 < -b ? -b : (b1 > b ? b : b1);


// See  https://math.stackexchange.com/questions/324527/do-these-equations-create-a-helix-wrapped-into-a-torus
//
//  Equation of a regular torus
//    x = (a + b * cos(u)) * cos(v)
//    y = (a + b * cos(u)) * sin(v)
//    z = b * sin(u)
//
//  To get a helical curve on a torus
//    set u = v * turns
//
//  Since we want a rounded rectangle rather than a circle, use xFunc and yFunc
//  for the tube, i.e. xFunc(u) instead of b*cos(u)
//  and yFunc(u) instead of b*sin(u)
//
//    x = (a + xFunc(b,u)) * cos(v)
//    y = (a + xFunc(b,u)) * sin(v)
//    z = b * yFunc(b,u)
//
// The above equation describes the center of the helical curve
// on a torus
// The wire's core is this curve, but the wire has a thickness of c
//  
points = [ for(v = vlist, w = wlist) 
  [
   (a + xFunc(b+ch*sin(w), v*turns)) * cos(v) 
        + (cw*cos(w) * sin(v)), 
   (a + xFunc(b+ch*sin(w), v*turns)) * sin(v) 
        - (cw*cos(w) * cos(v)),
   yFunc(b+ch*sin(w), v*turns) 
  ]
];

faces = [ for(i = [0:vnum-1], j = [0:wnum-1])
  [
    (i  ) * (wnum+1) + (j  ), (i+1) * (wnum+1) + (j  ),
    (i+1) * (wnum+1) + (j+1), (i  ) * (wnum+1) + (j+1)
  ]
];


polyhedron(points = points, faces = faces, convexity=10);