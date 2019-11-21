// Copyright (c) 2014-2016, William Waters
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification, 
// are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this list 
//    of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice, this list 
//    of conditions and the following disclaimer in the documentation and/or other materials 
//    provided with the distribution.
//
// 3. Neither the name of the copyright holder nor the names of its contributors may be used
//    to endorse or promote products derived from this software without specific prior 
//    written permission.
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS
// OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
// MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
// COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
// EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) 
// HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR 
// TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS 
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

//
// This script builds a converging-diverging nozzle of initial radius Rinlet with 
// four sections:
//
// A converging cone with half-angle Ain
// A converging radial inlet smoothly tangent to Ain
// A diverging radial outlet smoothly tangent to a Aout
// A diverging parabolic bell expanding to radius Rexit
//
// Documentation: http://www.waters.to/blog/rocket-nozzles-part-1-the-math/
// 
// Author: Bill Waters www.waters.to
//
// Credits:
// Nozzle equations: http://www.scribd.com/doc/58809639/13/Bell%C2%A0nozzle
// Bezier equations: Thingiverse user donb - http://www.thingiverse.com/thing:8931
//
// Thanks to reprap user buback who pointed out the utility of donb's algorithm in this thread:
// http://forums.reprap.org/read.php?88,319401 . Although his project at 
// http://www.thingiverse.com/thing:8931 bears a superficial resemblance to this one, there
// are many important differences.
//
// In particular, this program models the solid interior of the nozzle and only
// in post-processing does it compute an outer shell.  In modeling that interior space, I 
// attempt to be as rigorous as possible in my math in order to avoid lumps, bumps, and 
// discontinuities.  Finally, I attempt to document my work to improve understanding of
// both the math and the model.
//   

//CUSTOMIZER VARIABLES

// Wall Thickness of the Nozzle (approximate) 
wallThickness = 1.5;

// Radius of the nozzle inlet
Rinlet = 8;

// Converging Angle 
Ain = 35;

// Radius of the nozzle throat
Rthroat = 1.5;

// Radius of the nozzle exit.   
// This plus Rthroat define the nozzle's expansion ratio
Rexit = 16;

// Angle at which the throat transitions 
// from an arc to a parabola
Aout = 30; // [20, 25, 30, 35, 45]

// How long should the nozzle be relative to a 15% cone
pct = .7; // [.60, .65, .70, .75, .80, .85, .90, .95, 1]

// Experimental: minimum external radius
minRadius = 3;

//CUSTOMIZER VARIABLES END

// Important for rendering circles and arcs smoothly
$fn = 200 /* don't customize */ + 0;

if (wallThickness > Rthroat) { 
   echo("WARNING: wallThickness should be less than Rthroat");
}

// Lead-in to the converging cone
leadInCylinderLen = Rinlet;

finalize(3d="true") 
  makeShell(thickness = wallThickness, minRadius = minRadius)
    full2dNozzle(leadInCylinderLen = leadInCylinderLen,
                 Rinlet = Rinlet, Ain = Ain, Rthroat = Rthroat,
                 Rexit = Rexit, Aout = Aout, pct = pct);


module full2dNozzle(Rinlet, Ain, Rthroat, Rexit, Aout, pct, 
                    leadInCylinderLen = 0)
{

  // convergent section is just a conic nozzle mirrored about the y axis
  mirror()
    conicNozzle2d(Rthroat = Rthroat,
                  Rexit = Rinlet,  
                  Rarc = 1.5 * Rthroat,
                  a = Ain,
                  extraLen = leadInCylinderLen);


  bellNozzle2d(Rthroat = Rthroat,
               Rexit = Rexit,  
               Rarc = .382 * Rthroat,
               a = Aout,
               pct = pct);
}

// Returns the point P where the exit arc is tangent to the given angle 
//
//        _     /
//      -   -  / a=angle   
//     /     \P_____________ y = Rthroat + Rarc - Rarc * cos(a)
//     \     /             
//      - _ - ______________ y = Rthroat
//        |             
//        |          
//        __________________ y = 0
//
// 
function findTransition(Rthroat, Rarc, angle) = 
  [ Rarc * sin(angle), 
    Rthroat + Rarc - (Rarc * cos(angle)) 
  ];

// Builds the 2D profile of a nozzle with radius Rthroat 
// expanding along an arc of radius Rarc into a cone with 
// half-angle a, terminating at exit radius Rexit
//
// Recommended values converging nozzles:
// Rarc: 1.5 * Rthroat
// a: 20 < a < 35
module conicNozzle2d(Rthroat, Rarc, Rexit, a, extraLen = 0) 
{

  // The transition point from arc to cone
  Ptrans = findTransition(Rthroat, Rarc, a); //[x, Rthroat + Rarc - y];
  
  // Compute h, the rise from Ptrans to Rout
  z = Rexit - Ptrans[1];

  // Compute q, the run from Ptrans to the exit plane
  q = z / tan(a);
  len = Ptrans[0] + q;

  throatSegment(Rthroat = Rthroat,
				   Rarc = Rarc,
                Ptrans = Ptrans);

  coneSegment2d(Ptrans, 
                [len, Rexit]);

  totalLen = len + extraLen;
  if (extraLen) {
    polygon([[len, 0], [totalLen, 0],
             [totalLen, Rexit], [len, Rexit]]);
  }
}

// Builds the 2d profile of a nozzle with radius Rthroat
// expanding along an arc of radius Rarc transitioning at 
// angle a into a parabolic bell of final radius Rexit.
//
// The length of the nozzle is specified as a percentage
// relative to the length of a 15 degree cone nozzle.
// 
//
// Recommended value for Rarc: 0.382 * Rthroat (diverging nozzles)
// Recommended values for a: 20 < a < 35
// Recommended values for pct: 0.6 < pct < 0.8
//
module bellNozzle2d(Rthroat, Rarc, Rexit, a, pct) 
{
  Ptrans = findTransition(Rthroat, Rarc, a); 

  // Calculate length of a full 15 degree cone
  cone15Len = Rexit / tan(15);

  bellLen = pct * cone15Len;

  bellSegment2d(Ptrans = Ptrans,
	             Pexit = [bellLen, Rexit],
                a = a);

  throatSegment(Rthroat = Rthroat,
					Rarc = Rarc,
					Ptrans = Ptrans);

}

// Builds a bell nozzle from Ptrans to Pexit that is:
// - tangent to angle a at Ptrans
// - horizontal at Pexit
module bellSegment2d(Ptrans, Pexit, a) 
{
   // Compute P1, the intersection of lines 
   // [P1, Px] (horizontal line)
   // [Ptrans, P1] (rising to the right with a slope of a)

   // h is the rise from Ptrans to P1.  This is easy since
   // we assume a horizontal exit 
   h = Pexit[1] - Ptrans[1];

	// x is the run from Ptrans to P1
   x = h / tan(a);

   p1 = Ptrans + [x, h];

   bezierApprox(Ptrans, p1, Pexit, steps=20 );               
}

// Make a trapezoidal segment of a cone like this:
//
//            Pexit
//          /|
//         / |
// Ptrans /  |
//        |  |
//        |  |
//        |  |
//        |  |
//        ----
module coneSegment2d(Ptrans, Pexit) { 
   p2 = [Pexit[0], 0];
   p3 = [Ptrans[0], 0];     
   polygon([Ptrans, Pexit, p2, p3]);
}

// Make a segment that is a rectangle
// with a circular arc nicked out of 
// corner.  
//        _
//      -   -      
//     /     \                Ptrans
//     \     /|             /|  
//      - _ - |  Rthroat _ - |
//        |   |          |   |
//        |   |          |   |
//        -----          -----
//                         
module throatSegment(Rthroat, Rarc, PTrans) {
  difference() {
    polygon([[0, 0],
	          [0, Rthroat],
             Ptrans,
             [Ptrans[0], 0]]);

    translate([0, Rthroat + Rarc, 0])
      circle(r=Rarc); 
  }
}

// Builds a quadratic bezier curve from P0 to P2 using P1 as the 3rd 
// control point.
//
// Based on algorithm by donb - http://www.thingiverse.com/thing:8931
// Adapted from a variant by buback - http://www.thingiverse.com/thing:8931 
//
// I modified the algorithm to create a trapezoidal approximation (buback used triangles to 
// create the inverse of what we build here)
//
// The idea of bezier curve is to build an arc from p0 to p2 that is 
// tangent to the line from p0 -> p1 as well as the line from p1 -> p2.
//
// We approximate that curve via a series of trapezoids
//  
// In the drawing, X is P0, Y is P1 and Z is P2
//      
//      Y   . . Z
//        . | | | 
//      . | | | |
//      | | | | | 
//    X | | | | |
//    | | | | | |
//    | | | | | |
//    | | | | | |
//    -----------
module bezierApprox(p0,p1,p2,steps=25) 
{
	stepsize1 = (p1-p0)/steps;
	stepsize2 = (p2-p1)/steps;
	for (i=[0:steps-1]) {
		point1 = p0+stepsize1*i;
		point2 = p1+stepsize2*i;
        point3 = p0+stepsize1*(i+1);
        point4 = p1+stepsize2*(i+1);
		bpoint1 = point1+(point2-point1)*(i/steps);
        bpoint2 = point3+(point4-point3)*((i+1)/steps);
        x0 = bpoint1[0];
        x1 = bpoint2[0];
		polygon(points=[bpoint1,bpoint2,
                        [x1, 0],
                        [x0, 0]]);	
	}
}

// Turns a 2-d profile in X-Y space into a 3D solid
module finalize(3d) {
    // work around floating point rounding bug in rotate_extrude 
    epsilon = [1e-5, 0, 0];
  if (3d == "true") { 
    rotate_extrude()
      translate(epsilon) rotate([0, 0, -90]) children(0);
  } else {
    children();
  }
}

// Takes a 2D profile, shifts it vertically
// and subtracts the original.
//
// A more precise approach would use a minkowski sum, but
// that seems to be inordinately expensive computationally
// as of OpenScad 2014.3
//
// If thickness is zero, leaves the profile alone
module makeShell(thickness, minRadius) {
  if (thickness) {
    difference() { 
      union() {
        polygon([[-minRadius, Rthroat], [-minRadius, minRadius],
                   [minRadius, minRadius], [minRadius, Rthroat]]);
        translate([0, thickness, 0])
          children(0);
      }
     children(0);
   }  
  } else {
    children(0);
  }
}
