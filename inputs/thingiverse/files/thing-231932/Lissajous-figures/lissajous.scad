/*
  lissajous code 
  Copyright kitwallace.co.uk 
*/

// Parameter a 
A = 2;  
// Parameter b 
B = 3; 
// Phase  in degrees
Phase = 30;
// radius of tube 
R = 0.1;
// no of sides to tube
Sides = 10; 
// Resolution  numbers below 2 are very slow
Step = 2;
// Scale
Scale =12;
// Eccentricity  1 is square, 1.618 is golden mean
E = 1.618;

function f(t) = //lissajous curve 
    [ E * cos(A * t + Phase),
      sin(B * t),
     0
    ];

module disc_p2p(p1, p2, r) {
      assign(p = p2 - p1)
      translate(p1 + p/2)
      rotate([0, 0, atan2(p[1], p[0])])
      rotate([0, atan2(sqrt(pow(p[0], 2)+pow(p[1], 2)),p[2]), 0])
      render() cylinder(h = 0.1, r1 = r, r2 = 0);
};

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
   translate([0,0,R])
       tube(R, Step); 
