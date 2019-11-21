// mathgrrl scutoid made by polyhedral loft

/////////////////////////////////////////////////////////////////////////////
// PARAMETERS

// preview[view:south, tilt:top diagonal]

steps = 1*100; 

// Radius of Scutoid base (in mm)
radius = 20; 
r = radius;
s = sin(36)/sin(30);    // scale factor for equal hex and pent side lengths
p = r*cos(36);          // distance from center to midside of pentagon
x = s*r*cos(30);        // distance from center to midside of hexagon

// Height of Scutoid (in mm)
height = 60;
h = height;

// Angle (twists the entire form)
angle = -15;

// Push (translates the base away from the top)
push = -5;
translation = 1*[push,0,0];

// Steps (higher for finer resolution, lower for fewer polygons)
steps = 1*100; 

// Flare (the two pieces will be different unless this is 1)
flare = 1;              

// Height of the extra vertex (as a fraction of total height, between 0 and 1; the two pieces will be different unless this is .5)
vertical = .5;  
v = vertical;

/////////////////////////////////////////////////////////////////////////////
// PERIMETER DEFINITIONS

// top left hexagon
H = [for(i=[0:5]) 
        [[flare,0,0],[0,flare,0],[0,0,1]]
        * [s*r*cos(i*360/6+30)-x,s*r*sin(i*360/6+30),h] ];

// bottom left pentagon
P = [ for(i=[0:4]) 
        [[cos(angle/2),-sin(angle/2),0],[sin(angle/2),cos(angle/2),0],[0,0,1]]*translation  
            + [[cos(angle),-sin(angle),0],[sin(angle),cos(angle),0],[0,0,1]]
              * [r*cos(i*360/5+36)-p,r*sin(i*360/5+36),0] ];
 
// top right pentagon
Q = [ for(i=[0:4]) 
         [[flare,0,0],[0,flare,0],[0,0,1]]
         * [r*cos(i*360/5+144)+p,r*sin(i*360/5+144),h] ];
    
// bottom right hexagon
K = [for(i=[0:5]) 
        [[cos(angle/2),-sin(angle/2),0],[sin(angle/2),cos(angle/2),0],[0,0,1]]*translation 
            + [[cos(angle),-sin(angle),0],[sin(angle),cos(angle),0],[0,0,1]]
                * [s*r*cos(i*360/6+150)+x,s*r*sin(i*360/6+150),0] ];

// extra vertex determined by double scutoid
V = go( go(K[2],H[4],v), go(P[4],Q[1],v), .5);

// left middle layer (5 sides) 
ML = 1*[ go(P[0],H[0],v), go(P[1],H[1],v), go(P[2],H[2],v), go(P[3],H[3],v), V ];
// left middle layer with repeated vertex (6 sides)
MLstar = 1*[ go(P[0],H[0],v), go(P[1],H[1],v), go(P[2],H[2],v), go(P[3],H[3],v), V, V+[0,0,.001] ];

// right middle layer (5 sides) 
MR = 1*[ go(K[0],Q[0],v), V, go(K[3],Q[2],v), go(K[4],Q[3],v), go(K[5],Q[4],v) ];
// right middle layer with repeated vertex (6 sides)
MRstar = 1*[ go(K[0],Q[0],v), V, V+[0,0,.001], go(K[3],Q[2],v), go(K[4],Q[3],v), go(K[5],Q[4],v) ];

/////////////////////////////////////////////////////////////////////////////
// DOUBLE PERIMETER DEFINITIONS

// upper perimeter
DA = 1*[ Q[0], H[1], H[2], H[3], H[4], H[5], Q[2], Q[3], Q[4] ];

// lower perimeter (same number of points!)
DB = 1*[ P[0], P[1], P[2], P[3], P[4], K[2], K[3], K[4], K[5] ];

// middle layer
DM = [ go(P[0],Q[0],v), go(P[1],H[1],v), go(P[2],H[2],v), go(P[3],H[3],v), V, V+[0,0,.001],
      go(K[3],Q[2],v), go(K[4],Q[3],v), go(K[5],Q[4],v) ];

/////////////////////////////////////////////////////////////////////////////
// RENDERS

scutoid();
translate([10,0,0]) scutoidmatch();

/////////////////////////////////////////////////////////////////////////////
// SCUTOIDS

// single scutoid
module scutoid(){
    color("green") polyloft(P,ML);
    color("green") polyloft(MLstar,H);
}

// single matching scutoid
module scutoidmatch(){
    color("orange") polyloft(K,MRstar);
    color("orange") polyloft(MR,Q);
}

// double scutoid
module doublescutoid(){
    polyloft(DB,DM);
    polyloft(DM,DA);
}

//test to see if left and right are the same
module scutoidtest(){
    color("yellow"){
        polyloft(P,ML);
        polyloft(MLstar,H);
    }
    color("blue")
    translate([0,0,h]+[[cos(angle/2),-sin(angle/2),0],[sin(angle/2),cos(angle/2),0],[0,0,1]]*translation)
    rotate(180,[1,0,0])
    rotate(180-angle,[0,0,1]){
        polyloft(K,MRstar);
        polyloft(MR,Q);
    }
}
      
/////////////////////////////////////////////////////////////////////////////
// POLYLOFT 
      
module polyloft(A,B){

    /// DEFINE POINTS //////////////////////////////////////////////

    // points at kth level
    function points(k) = [ for(i=[0:len(A)-1]) go(A[i],B[i],k/steps) ];
        
    // recursively list all points up to level n
    function allpoints(n) = (n==0 ? points(0) : concat(allpoints(n-1),points(n)));
    
    // all points
    // listed ccz starting with bottom slice and going up
    allpoints = allpoints(steps+1);
    
    /// DEFINE FACES ///////////////////////////////////////////////

    // quads at kth level
    function quads(k) = [ 
        for(i=[0:len(A)-1]) 
            [ i+(k-1)*len(A),(i+1)%len(A)+(k-1)*len(A),
              (i+1)%len(A)+len(A)+(k-1)*len(A),
              i+len(A)+(k-1)*len(A) ] 
    ];
    
    // recursively list all quads up to level n
    function allquads(n) = (n==0 ? [] : concat(allquads(n-1),quads(n)));
    
    // all quads
    // listed ccz starting with bottom slice and going up
    allquads = allquads(steps);
        
    // top and bottom faces  
    top = [ for(i=[0:len(B)-1]) i+len(A)+(len(A))*(steps-1) ]; 
    bottom = [ for(i=[0:len(A)-1]) (len(A)-1)-i ];
        
    // all faces
    allfaces = concat([bottom],allquads,[top]);
    
    /// DEFINE POLYHEDRON //////////////////////////////////////////
    
    polyhedron(
        points = allpoints,
        faces = allfaces
    );
    
}

/////////////////////////////////////////////////////////////////////////////
// INTERPOLATION 

// point that is t in [0,1] of the way between points A and B
function go(A,B,t) =
    (1-t)*A+t*B;