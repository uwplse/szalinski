/*
  torus knot code 
  Copyright kitwallace.co.uk 
*/

// Torus Parameter p
P = 3;  
// Torus Parameter q
Q = 7; 
// torus width : 0 for braided cylinder
Twidth = 0;
// torus height : 0 for 2-D torus
Theight = 1;
// radius of tube 
R = 0.15;
// no of sides to tube
Sides = 12; 
// Resolution  numbers below 2 are very slow
Step = 1;
// Scale
Scale =15;

module disc_p2p(p1, p2, r) {
      assign(p = p2 - p1)
      translate(p1 + p/2)
      rotate([0, 0, atan2(p[1], p[0])])
      rotate([0, atan2(sqrt(pow(p[0], 2)+pow(p[1], 2)),p[2]), 0])
      render() cylinder(h = 0.1, r1 = r, r2 = 0);
};

function f(t) = //torus curve 
    [ (2 + Twidth * cos (Q*t))* cos(P*t),
      (2 + Twidth * cos (Q*t))* sin(P*t),
       - Theight * sin (Q * t)
    ];

module tube(r, step) {
    for (t=[0: step: 360])
       assign (p0 = f(t), 
               p1 = f(t + step ),
               p2 = f(t + 2 * step))
       render() hull() {
          disc_p2p (p0,p1,r);
          disc_p2p (p1,p2,r);   
       }
};

$fn=Sides;
scale(Scale) 
   translate([0,0,Theight +R])
    union() {
       tube (R, Step); 
    }