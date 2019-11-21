polyhedron(
  points=[ [0,0,0],[40,0,0],[20,sqrt(1200),0], // the three points at base
           [0,0,70],[40,0,70],[20,sqrt(1200),70]  ],                                 // the three points at top 
  faces=[ [0,1,4,3],[1,2,5,4],[0,2,5,3],              // each triangle side
              [0,1,2], [3,4,5] ]                         // two top and bottom triangle base
 );