// parameterized trefoil 


// CUSTOMIZER VARIABLES
//Height of knot
Height = 0.5;
// Radius of tube
R = 0.3;
// Number of Sides 
Sides = 10;

// Scale 
Scale = 15;
// END CUSTOMIZER VARIABLES

function f(t) = //trefoil  
    [  sin(t) + 2 * sin(2 * t),
       cos(t) - 2 * cos(2 * t),
       - Height * sin (3 * t)
    ];

module disc_p2p(p1, p2, r) {
      assign(p = p2 - p1)
      translate(p1 + p/2)
      rotate([0, 0, atan2(p[1], p[0])])
      rotate([0, atan2(sqrt(pow(p[0], 2)+pow(p[1], 2)),p[2]), 0])
      render() cylinder(h = 0.1, r1 = r, r2 = 0);
};

module tube(r, step) {
    for (t=[0: step: 359])
       assign (p0 = f(t), 
               p1 = f(t + step ),
               p2 = f(t + 2 * step))
       render() hull() {
          disc_p2p (p0,p1,r);
          disc_p2p (p1,p2,r);   
       }
};

$fn=Sides;
scale(Scale) translate([0,0,Height + R]) tube (R,2);