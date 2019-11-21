
// Width of triangle edges
triangle_width = 20;
// Height of triangle
triangle_height = 5;

// Height of inner triangle difference
tri_offset_height = 2.5;
// Edge of inner triangle difference
tri_offset_width = 17;

// Outer circle radius
circle_radius = 5;
// Screw hole width
screw_hole_width = 2;

// Screwhead diameter
screwhead_diameter = 6.2;
// Screwhead height
screwhead_height = 3;

tri_offset_x = (triangle_width - tri_offset_width);
tri_offset_y = (triangle_width - tri_offset_width);


render (convexity = 1) {
   create_part();
}

module create_part() {

difference() {
  union() {
	cylinder(h = triangle_height, r = circle_radius, center = false);

  	polyhedron(
		points = [
			[0, 0, 0], [0, 0, triangle_height],
			[0, - triangle_width, 0], [0, - triangle_width, triangle_height],
			[- triangle_width, 0, 0], [- triangle_width, 0, triangle_height],
			], 
		triangles = [
			[1,0,2], [1,2,3],
			[0,1,4], [1,5,4],
			[0,4,2], [1,3,5],
			[4,5,3], [3,2,4]
		]
	);
  }
  translate(v=[0, 0, triangle_height-screwhead_height]) {
	cylinder(h = screwhead_height, r = screwhead_diameter/2, center = false);
  }

  polyhedron(
	points = [
		[ - tri_offset_x, - tri_offset_y, -.01], [- tri_offset_x, -tri_offset_y , tri_offset_height],
		[- tri_offset_x, - triangle_width + tri_offset_y - .01, -.01], [- tri_offset_x, - triangle_width - tri_offset_y + .01, tri_offset_height],
		[- triangle_width + tri_offset_x - .01, -tri_offset_y, -.01], [- triangle_width + tri_offset_x - .01, - tri_offset_y, tri_offset_height],
		], 
	triangles = [
		[1,0,2], [1,2,3],
		[0,1,4], [1,5,4],
		[0,4,2], [1,3,5],
		[4,5,3], [3,2,4]
	]
  );
  translate(v = [0, 0, -0.01]) {
  	cylinder(h = triangle_height + 0.02, r = screw_hole_width, center = false);
  }
}

}