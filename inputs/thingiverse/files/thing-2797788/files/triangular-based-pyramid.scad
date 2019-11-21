polyhedron(
  points=[ [0,0,0],[40,0,0],[20,sqrt(1200),0], // the three points at base
           [20,sqrt(1200)/2,70]  ],                                 // the apex point 
  faces=[ [0,1,3],[1,2,3],[0,2,3],              // each triangle side
              [0,1,2] ]                         // two bottom triangle base
 );