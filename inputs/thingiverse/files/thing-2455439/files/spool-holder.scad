// bearing dimensions
bearing_d = 22.2;
bearing_h = 7;

// max and min size of the spool holder diameter
max_d = 70;
min_d = 25;

// height of the holder
cone_h = 30;

// rod diameter
rod_d = 8.1;

// cutouts
cutN = 7;           // Number of cutouts
cutRatio = 0.9;     // This parameter supposed to be near 1.0, but change as you want.
bearing_wall = 5;   // This ensures minimal thickness of the wall that holds the bearing

// circle control
$fa = 1;
$fs = 1;

// Hyperbole functions
function flatten(vec) = [ for (e1 = vec) for (e2 = e1) e2 ] ;
    
function calcHyperAlphaRec(a, b, c, r, q1, q2) =
    let(q = (q1+q2)/2)
    let(p = b*b*(c*cos(q)-a)/(b*b*cos(q)*cos(q)-a*a*sin(q)*sin(q)))
    let(x = c-p*cos(q))
    let(y = p*sin(q))
    let(rx = sqrt(x*x+y*y))
    let(q1 = rx < r ? q : q1)
    let(q2 = rx > r ? q : q2)
    abs(rx/r-1) < 0.001 ? q : calcHyperAlphaRec(a, b, c, r, q1, q2);

function calcHyperAlpha(a, b, c, r) = calcHyperAlphaRec(a, b, c, r, 0, 180-atan(b/a));

function calcHyperABCA(a, b, c, q, z) =
    let(p = b*b*(c*cos(q)-a)/(b*b*cos(q)*cos(q)-a*a*sin(q)*sin(q)))
    [c-p*cos(q),p*sin(q),z];

function calcHyper(a, q, r, z, n) =
    let(n2 = floor(n/2))
    let(b = a*tan(q/2))
    let(c = sqrt(a*a+b*b))
    let(q0 = calcHyperAlpha(a,b,c,r))
    [for(i=[-n2:n2]) calcHyperABCA(a, b, c, q0*i/n2, z)];

function next(v,m) = v+1-m*floor((v+1)/m);

module hyper(a1, a2, q1, q2, r1, r2, h, nh, nz) {
    z = [for(i=[0:nz]) i/nz*h];
    a = [for(i=[0:nz]) i/nz*(a2-a1)+a1];
    q = [for(i=[0:nz]) i/nz*(q2-q1)+q1];
    r = [for(i=[0:nz]) i/nz*(r2-r1)+r1];
    dimZ = nz+1;
    dimH = 2*floor(nh/2)+1;
    hyper = flatten([for(i=[0:nz]) calcHyper(a[i], q[i], r[i], z[i], nh)]);
    fc = concat(
        [
            for (iz=[0:dimZ-2]) for (ih=[0:dimH-1]) [
                     ih +       dimH*     iz,
                next(ih,dimH) + dimH*     iz,
                next(ih,dimH) + dimH*next(iz,dimZ)
            ]
        ],
        [
            for (iz=[0:dimZ-2]) for (ih=[0:dimH-1]) [
                     ih +       dimH*     iz,
                next(ih,dimH) + dimH*next(iz,dimZ),
                     ih       + dimH*next(iz,dimZ)
            ]
        ],
        [
            [for (ih=[dimH-1:-1:0]) ih],
            [for (ih=[0:dimH-1]) ih + dimH*(dimZ-1)]
        ]
    );
    polyhedron(points=hyper, faces=fc);
}

cutAngle = cutRatio * 360 / cutN;
difference(){
// cone
	translate([0,0,cone_h/2])cylinder(r1 = max_d/2, r2 = min_d/2, h = cone_h, center=true);

// cutout for the bearing
	translate([0,0,bearing_h/2-.1]) cylinder(r=bearing_d/2, h=bearing_h, center=true);
	
// the center rod 
	translate([0,0,max_d/2+bearing_h-.11]) cylinder(r=rod_d/2, h=max_d, center=true);
	
// material saving cutout (hyperbolic)
    for (i=[0:cutN-1])rotate(a=[0,0,i*360/cutN])
        translate([0, 0, -0.1]) hyper(
            bearing_d/2+bearing_wall, min_d/2, 
            cutAngle, cutAngle, 
            2*max_d, 2*max_d, 
            cone_h+0.2, 
            30, 10
        );
  
}






