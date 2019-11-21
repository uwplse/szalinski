// Galactic Organizer provided by Stellar Innovation
// http://www.thingiverse.com/stellarinnovation/about
// under Creative Commons License, Attribution (BY)
//
// The organizer is built from a given number of spiral arms.
// Each arm consists of a given number of sockets.
// The sockets are evenly spaced on the involute of a circle.
// The innvolute has the property of a constant distance between the arms
// (the same spacing as between sockets of a single arm).

// Number of arms
numArms = 4; // [2:12]

// Number of sockets per arm (the centerpiece is shared)
numSocketsPerArm = 5; // [3:30]

// Diameter of hole (+tolerance)
socketInnerDiameter = 15.5; // [8:0.1:35]

// Wall thickness
wallThickness = 2.4; // [1.2:0.4:4.0]

// Slope (degrees)
slope = 15; // [0:45]

// Minimum socket depth
minSocketDepth = 20; // [1.0:0.5:35.0]

// hole plus wall
socketOuterDiameter = socketInnerDiameter + 2*wallThickness;

// distance center-to-center
distance = socketInnerDiameter + wallThickness;

// angle between arms (in radians), also: normalized distance (radius 1)
deltaTheta = 2*PI/numArms;

// radius of the circle, whose involute makes the spiral arms
radius = distance/deltaTheta;

// first socket is at distance r0 from the origin. A regular polygon, whose
// side is distance (normalized: deltaTheta) is formed by the first socket
// of each arm.
r0 = 0.5*deltaTheta/sin(180/numArms);
firstSocketT = sqrt(r0*r0-1);

degreesPerRadian = 180/PI;

// height difference between adjacent sockets
deltaH = distance*tan(slope);

// total height
slopeLength = numSocketsPerArm - 1; // less "first socket"
height = wallThickness + minSocketDepth + slopeLength*deltaH;

// Equaltion of the involute: x = cos t + t sin t, y = sint t - t cost t 
// Given a first t and a normalized distance, find "next t" (normalized: radius=1)

function solveNext(t0, normDist) = let (deg0 = t0*degreesPerRadian,
                                         x0 = cos(deg0) + t0*sin(deg0),
                                         y0 = sin(deg0) - t0*cos(deg0),
                                         t1 = sqrt(2*normDist + t0*t0),
                                         deg1 = t1*degreesPerRadian,
                                         f = t1*t1 - 2*x0*(cos(deg1)+t1*sin(deg1)) - 2*y0*(sin(deg1) - t1*cos(deg1)) + 
                                             1 + x0*x0 + y0*y0 - normDist*normDist,
                                         df = 2*t1 - 2*x0*t1*cos(deg1) - 2*y0*t1*sin(deg1)) 
                                     t1 - f/df;

// First approximation is based on equation of arc length: L = 0.5*radius*t²
// Second approximation by a single Newton-iteration
// 0 = f(t) = (x-x0)² + (y-y0)² - deltaTheta²
    
// Compute the t parameter of socket (n=0, 1, 2,...)
function socketT(n) = (n==0)? firstSocketT : solveNext(socketT(n-1), deltaTheta);
    
function pointXY(t) = let (deg = t*degreesPerRadian,
                           x = radius*(cos(deg) + t*sin(deg)),
                           y = radius*(sin(deg) - t*cos(deg)))
                       [x, y];
                       
for (arm=[1:numArms])
  rotate((arm-1)*deltaTheta*degreesPerRadian)
    intersection() {
      Arm();
      RampedSpiral();
    }

module Arm() {
  dh = deltaH*wallThickness/distance;
    
  for (s = [0:numSocketsPerArm-1]) {
    t = socketT(s);
    translate(pointXY(t)) {
      h = (s == 0)? height : (height + min(0, dh - (s-1)*deltaH));
      p = (s == 0)? minSocketDepth : (minSocketDepth + dh + deltaH);
      Socket(h, p);
    }
  }
}

module Socket(h, pocket) {
  difference() {
    cylinder(d=socketOuterDiameter, h=h, $fn=60);
    translate([0,0,h-pocket])
      cylinder(d=socketInnerDiameter, h=height, $fn=60);
  }
}

// Arm is intersected with a ramped spiral to get the slope
module RampedSpiral() {
  // SpiralSlope
  ds = 0.5 + wallThickness/distance;
  for (socket=[0:numSocketsPerArm])
    SpiralSegment(socket, height-deltaH*(socket-ds));

  // First socket  
  t = socketT(0);
  p = pointXY(t);
  translate(p)
    cylinder(d=socketOuterDiameter, h=height, $fn=60);
}



// The s:th segment of that spiral
module SpiralSegment(s, h) {
  eps = 0.001;
  t0 = socketT(s);
  t1 = socketT(s+1);
  steps=(s==1)? 40 : max(30-5*s, 10);
  dt = (t1-t0)/steps;  
  dh = deltaH/steps;
  dl = distance/steps;
  
  for (i=[0:steps-1]) {
    t = t0 + i*dt;
    SpiralSlice(t-eps, t+dt+eps, h-i*dh);
  }
}

// Adds k*N(t) to the point (x(t), y(t)). N is unit-length normal to the curve.
function addNormal(t, k) = let (deg = t*degreesPerRadian,
                                 c = cos(deg), s=sin(deg),
                                 x = radius*(c + t*s),
                                 y = radius*(s - t*c))
                             [x + k*s, y - k*c];

// Points p1 -> p2 -> p3 are enumerated in counterclockwise order  
function counterClockwise(p1, p2, p3) = let (dx1 = p2[0] - p1[0], 
                                              dy1 = p2[1] - p1[1],
                                              dx2 = p3[0] - p2[0], 
                                              dy2 = p3[1] - p2[1])
                                          (dx1*dy2 - dx2*dy1) > 0;

// Each SpiralSegment is interpolated by several "slices"
module SpiralSlice(t0, t1, h) {
  p0_prim = addNormal(t0, -0.5*socketOuterDiameter);
  p0_bis = addNormal(t0, +0.5*socketOuterDiameter);
  p1_prim = addNormal(t1, -0.5*socketOuterDiameter);
  p1_bis = addNormal(t1, +0.5*socketOuterDiameter);
    
  dx1 = p0_bis[0] - p0_prim[0];
  dy1 = p0_bis[1] - p0_prim[1];
  a = atan2(dy1, dx1);
  r = sqrt(p0_prim[1]*p0_prim[1] + p0_prim[0]*p0_prim[0]);
  andSome = 1;

  if (counterClockwise(p1_bis, p1_prim, p0_prim)) {
    difference() {
      linear_extrude(height=h)
        polygon([p0_prim, p0_bis, p1_bis, p1_prim]);
      
      translate(p0_prim)
        rotate(a)
          translate([-0.5*andSome, 0, h])
            rotate([-slope, 0])
              cube([r + socketOuterDiameter + andSome, socketOuterDiameter, deltaH]);
    }
  }
}
