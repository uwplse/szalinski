polyhedron(
  points=[ [20,20,0],[20,-20,0],[-20,-20,0],[-20,20,0], // the four points at base
           [0,0,70]  ],                                 // the apex point 
  faces=[ [0,1,4],[1,2,4],[2,3,4],[3,0,4],              // each triangle side
              [1,0,3],[2,1,3] ]                         // two triangles for square base
 );