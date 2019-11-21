
hole_size = 1.5; //Radius of the hole.
//To make a hole on the top cylinder.
difference() {
   translate([0,0,12])
	cylinder(12,2.5,4, center = true, $fn=100);

	translate([0,0,15]) 
	rotate([90,0,90])
      cylinder (10, hole_size,hole_size, center = true, $fn=100);
}

// 2 Pyramids to complete the model.
// We can do this in a loop with variables, but have kept it simple to be clear.

//1st pyramid for the top part.

apex_point_top_pyramid = 10; //Apex point for top pyramid, which is inside the cylinder.
rotate(a=[0,0,45])
polyhedron(
  points=[ [5,5,0],[5,-5,0],[-5,-5,0],[-5,5,0], // the four points at base
           [0,0,apex_point_top_pyramid]  ],                                 // the apex point 
  triangles=[ [0,1,4],[1,2,4],[2,3,4],[3,0,4],          // each triangle side
              [1,0,3],[2,1,3] ]                         // two triangles for square base
 );


//2nd pyramid for the bottom part.
apex_point_bottom_pyramid = 20;
rotate(a=[180,0,45])
polyhedron(
  points=[ [5,5,0],[5,-5,0],[-5,-5,0],[-5,5,0], // the four points at base
           [0,0,apex_point_bottom_pyramid]  ],                                 // the apex point 
  triangles=[ [0,1,4],[1,2,4],[2,3,4],[3,0,4],          // each triangle side
              [1,0,3],[2,1,3] ]                         // two triangles for square base
 );

