//Curve smoothness, from 1 to 3.
quality = 3; //[1:draft, 2:meh, 3:best]

//Thickness of the rail. Used as the interior distance between the inner and outer sides of the fence posts.
rail_thickness = 8;
//Height of the rail from top face to bottom face.
rail_height = 25.4;
//Radius of each of the corners of the rail's cross-section.
rail_edge_radius = 1;

//Height of each of the fence posts.
fence_post_inner_height = 55;
//Height of the clip portion, on the other side of the rail.
fence_post_outer_height = 10;

//Length on the rail covered by the fence post.
fence_post_length = 25;

//Thickness of the fence post—the distance of the exterior edges of the post from the interior edges/the rail.
fence_post_thickness = 2;

module rounded_square(dims, r=2, thickness=1) {
	hull() {
		translate([0, 0, thickness * 0.5]) {
			translate([dims[0] * -0.5 + r, dims[1] * -0.5 + r, 0]) cylinder(r=r, h=thickness, center=true);
			translate([dims[0] * +0.5 - r, dims[1] * -0.5 + r, 0]) cylinder(r=r, h=thickness, center=true);
			translate([dims[0] * -0.5 + r, dims[1] * +0.5 - r, 0]) cylinder(r=r, h=thickness, center=true);
			translate([dims[0] * +0.5 - r, dims[1] * +0.5 - r, 0]) cylinder(r=r, h=thickness, center=true);
		}
	}
}

module rail() {
color("white")
rounded_square([rail_thickness, rail_height], r=rail_edge_radius, thickness=fence_post_length * 2);
}

difference() {
union() {
rounded_square([rail_thickness + fence_post_thickness / 2, fence_post_inner_height], r=rail_edge_radius * 2, thickness=fence_post_length);
//color("red")
translate([fence_post_thickness, fence_post_inner_height * 0.5 - fence_post_outer_height * 0.5 + 0.05, -0.05])
rounded_square([rail_thickness + fence_post_thickness * 2, fence_post_outer_height], r=rail_edge_radius * 2, thickness=fence_post_length + 0.1);
}

*translate([fence_post_thickness - rail_edge_radius, (fence_post_inner_height * 0.5 - rail_height * 0.5) - rail_edge_radius, 0])
rail();

translate([fence_post_thickness, -fence_post_thickness, fence_post_length * -0.5])
//color("blue")
rounded_square([rail_thickness, fence_post_inner_height], r=rail_edge_radius, thickness=fence_post_length * 2);
}