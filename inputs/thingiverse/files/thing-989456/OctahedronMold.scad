inside_radius = 20; //[1:100]
thickness=3; //[1:10]


translate([inside_radius+2*thickness,0,0])
polyhedron(
  points=concat(inside_radius*[ [1,0,0],[0,-1,0],[-1,0,0],[0,1,0], // the four points at base
           [0,0,1]  ],     // the apex point 
              (inside_radius+thickness)*[ [1,0,0],[0,-1,0],[-1,0,0],[0,1,0], // the four points at base
           [0,0,1]  ]),     // the apex point
  faces=[ [0,1,4],[1,2,4],[2,3,4],[3,0,4],              // each triangle side
          [0,4,1]+[5,5,5],[1,4,2]+[5,5,5],[2,4,3]+[5,5,5],[3,4,0]+[5,5,5],
          [1,0,5,6], [2,1,6,7],[3,2,7,8],[0,3,8,5]  ]
 );
 
 translate(-1*[inside_radius+2*thickness,0,0])
polyhedron(
  points=concat(inside_radius*[ [1,0,0],[0,-1,0],[-1,0,0],[0,1,0], // the four points at base
           [0,0,1]  ],     // the apex point 
              (inside_radius+thickness)*[ [1,0,0],[0,-1,0],[-1,0,0],[0,1,0], // the four points at base
           [0,0,1]  ]),     // the apex point
  faces=[ [0,1,4],[1,2,4],[2,3,4],[3,0,4],              // each triangle side
          [0,4,1]+[5,5,5],[1,4,2]+[5,5,5],[2,4,3]+[5,5,5],[3,4,0]+[5,5,5],
          [1,0,5,6], [2,1,6,7],[3,2,7,8],[0,3,8,5]  ]
 );