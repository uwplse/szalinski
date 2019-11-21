// Pi derived from a whole number.
// for 999999 inspired by Shek Singhal
// implemented as a Pyramid
// see: http://vortexspace.org/display/theory/Phe+-+Universal+Curvature+Constant

Phe = 1 / sqrt((sqrt(5)+1)/2); // =~ 0.78615137775742(...)

//r = 220; // * actual unit for this object is a royal_cubit =~ 523 to 529 mm

// Radius
r = 22; // 0.22-222222  
h = r / Phe;

color ("PaleGoldenrod")
polyhedron(
  points=[ [r,r,0],[r,-r,0],[-r,-r,0],[-r,r,0], // the four points at base
//           [0,0,r]  ],                        // the apex point for Cheops
           [0,0,h]  ],                          // the apex point for half an octahedron
  triangles=[ [0,1,4],[1,2,4],[2,3,4],[3,0,4],  // each triangle side
              [1,0,3],[2,1,3] ]                 // two triangles for square base
);

// other stuff
// slant_height = r / Phe / Phe;
// CircleArea = (4*r) * (sqrt( 2) * Phe);
// CircleCircum = (8*r) * Phe;