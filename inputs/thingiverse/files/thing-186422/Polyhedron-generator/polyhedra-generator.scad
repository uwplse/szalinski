// papergeek's entry for the 2013 MakerBot Academy Math Manipulative Challenge
// Tags: #MakerBotAcademyMath #Customizer
// Revision: 20-November-2013
//		Added tubular hub option (pipehub) for larger structures

// Show bed size guide. Turn this off for printing - it is meant for guidance on the maximum rod length
show_bed_size_guide = 0; //[0,6,8] Bed size in inches

// Type of polyhedron
polyhedron_type = "dodecahedron"; //[icosahedron,dodecahedron,cube]

// Radius of circumscribed sphere in millimeters (the sphere touching all vertices). Maximum for icosahedron on 6 inch bed: 120; on 8 inch: 190; for full plate dodecahedron: 97; for full plate cube: 100
circumscribed_sphere_radius = 97;

// Type of print - for smaller print beds you may want to separately print rods and hubs. pipehub is for use with PVC pipe
print_type = "fullplate"; //[minimal,fullplate,rodsonly,hubsonly]

// Speed up print time by reducing hub size (taking "cheese wedge" shaped chunks out of them)
hub_reduction = "cheese"; //[none,cheese]

//[Pipe]
// PVC pipe size in mm. US standard Schedule 40 PVC pipe sizes have a standard outside diameter. Thicker walled pipe is recommended for construction. 3/4" I.D. pipe is actually about 7/8" inside if thin-walled, closer to 3/4" for the thicker pipe rated for higher pressure (200psi). It's the outside that fits in plumbing connectors and that's all we care about.
pipe_outside_diameter = 27;

// Interconnection of pipes in the hub allows water to be run through them. Why? I dunno but it seems like a cool idea...
pipe_interconnect_style = "none"; //[none,cross,vee,ycross]

// Number of pipes to leave blind in hub. This is typically used for bottom edge hubs on (for example) a 2/3 icosahedron
pipe_blind_count = 0;

//[Advanced]
// Rod thickness in mm
rod_thickness = 2.8;
// Hub receiver thickness in mm. This indirectly determines the size of the hub hemisphere
receiver_thickness = 6.0;
// Hub receiver socket depth in mm
receiver_depth = 6;
// Hub receiver leg effective total length in mm
receiver_leg_length = 12;
// Hole factor - apply to size of receiver holes
receiver_hole_factor = 1.14;

if (polyhedron_type == "icosahedron") do_icosahedron();
else if (polyhedron_type == "cube") do_cube();
else if (polyhedron_type == "dodecahedron") do_dodecahedron();
do_bed_guide();

module do_dodecahedron()
{
  chord_ratio = 1 / 1.401258538; // Radius is edge length * (1 + sqrt(5)) * sqrt(3) / 4
  chord_length = circumscribed_sphere_radius * chord_ratio;
  edge_count = 30;
  vertex_count = 20;
  face_count = 12;
  dihedral_angle = 116.56505; // acos(-1/sqrt(5))
  echo("Dodecahedron; radius=", circumscribed_sphere_radius, " edge length=", chord_length, " edge count=", edge_count, " vertex_count=", vertex_count, " face count=", face_count );
  rod_spacing = 1.4;
  hub_ybase = (edge_count / 2 + 1) * rod_thickness * rod_spacing + (rod_spacing - 1) * rod_thickness;
  hub_width = (print_type == "rodsonly") ? 0 : 64;
  hub_spacing = 25.15;
  // Make these X offsets different for staggered rows
  hub_offset1 = 13.5;
  hub_offset2 = 26.075;
  hub_offset3 = 13.5;
  hub_offset4 = 26.075;
  // Y offset from rod field for each row
  hub_row1_offset = 7;
  hub_row2_offset = 29;
  hub_row3_offset = 50;
  hub_row4_offset = 71;
  hub_length = 6 * hub_spacing + hub_offset1;
  breakoff_length = rod_thickness * rod_spacing * (edge_count / 2 - 1) + rod_thickness;
  // Rods are normally grouped on either side of hubs
  // to allow maximum length. The greater number of dodeca
  // hubs does not allow this to fit on a single plate,
  // so we can handle a special case where length <= 70
  rod_xoffset1 = (chord_length <= 70) ? 1 : (hub_length - chord_length) / 2;
  rod_xoffset2 = (chord_length <= 70) ? (1 + chord_length + 3) : (hub_length - chord_length) / 2;
  rod_yoffset1 = 0;
  rod_yoffset2 = (chord_length <= 70) ? 0 : (hub_ybase + hub_width);
  if (print_type != "hubsonly" && print_type != "pipehub") for ( i = [0 : (edge_count / 2 - 1)] )
  {
    if (i == 0 || (print_type != "minimal"))
    {
	 make_chord( chord_length, rod_yoffset1 + i * rod_thickness * rod_spacing, rod_xoffset1, 0 );
	 make_chord( chord_length, rod_yoffset2 + i * rod_thickness * rod_spacing, rod_xoffset2, 0 );
	 }
  }
  // Generate hubs in staggered rows
  if (print_type != "rodsonly") for (i = [0 : 4]) 
  {
	if (i == 0 || (print_type != "minimal" && print_type != "pipehub"))
	{
	 translate([hub_offset1+i*hub_spacing,hub_ybase+hub_row1_offset,0]) draw_dodeca_hub(chord_length);
	 if (print_type!="minimal" && print_type != "pipehub")
	 {
		translate([hub_offset2+i*hub_spacing,hub_ybase+hub_row2_offset,0]) draw_dodeca_hub(chord_length);
		translate([hub_offset3+i*hub_spacing,hub_ybase+hub_row3_offset,0]) draw_dodeca_hub(chord_length);
		translate([hub_offset4+i*hub_spacing,hub_ybase+hub_row4_offset,0]) draw_dodeca_hub(chord_length);
	 }
	}
  }
  //for (i = [0 : 5]) translate([39,-55 + i*24,0]) draw_icosa_hub();
  if (print_type == "fullplate" || print_type == "rodsonly")
  {
  translate([rod_xoffset1 + receiver_depth,rod_yoffset1,0]) cube(size=[0.3,breakoff_length,0.2], center=false);
  translate([rod_xoffset1 + chord_length - 0.3 - receiver_depth,rod_yoffset1,0]) cube(size=[0.3,breakoff_length,0.2], center=false);
  translate([rod_xoffset2 + receiver_depth,rod_yoffset2,0]) cube([0.3,breakoff_length,0.2]);
  translate([rod_xoffset2 + chord_length - 0.3 - receiver_depth,rod_yoffset2,0]) cube(size=[0.3,breakoff_length,0.2], center=false);
  }

}

module do_icosahedron()
{
  chord_ratio = 1 / 0.9510565163; // Radius is edge length * sin(2*pi/5)
  chord_length = circumscribed_sphere_radius * chord_ratio;
  edge_count = 30;
  vertex_count = 12;
  face_count = 20;
  dihedral_angle = 138.189685;
  echo("Icosahedron; radius=", circumscribed_sphere_radius, " edge length=", chord_length, " edge count=", edge_count, " vertex_count=", vertex_count, " face count=", face_count );
  rod_spacing = 1.22;
  hub_ybase = (edge_count / 2 + 1) * rod_thickness * rod_spacing + (rod_spacing - 1) * rod_thickness;
  hub_width = (print_type == "rodsonly") ? 0 : 46;
  hub_spacing = 25.15;
  // Make these X offsets different for staggered rows
  hub_offset1 = 13.5;
  hub_offset2 = 13.5;
  // Y offset from rod field for each row
  hub_row1_offset = 8;
  hub_row2_offset = 32;
  hub_length = 6 * hub_spacing + hub_offset1;
  breakoff_length = rod_thickness * rod_spacing * (edge_count / 2 - 1) + rod_thickness;
  rod_offset = max(1, (hub_length - chord_length) / 2);
  if (print_type != "hubsonly" && print_type != "pipehub") for ( i = [0 : (edge_count / 2 - 1)] )
  {
    if (i == 0 || print_type != "minimal")
    {
	 make_chord( chord_length, i * rod_thickness * rod_spacing, rod_offset, 0 );
	 make_chord( chord_length, hub_ybase + hub_width + i * rod_thickness * rod_spacing, rod_offset, 0 );
	 }
  }
  // Generate hubs in staggered rows
  if (print_type != "rodsonly") for (i = [0 : 5]) 
  {
	if (i == 0 || print_type != "minimal")
	{
	 translate([hub_offset1+i*hub_spacing,hub_ybase+hub_row1_offset,0]) draw_icosa_hub(chord_length);
	 if (print_type!="minimal") translate([hub_offset2+i*hub_spacing,hub_ybase+hub_row2_offset,0]) draw_icosa_hub(chord_length);
	}
  }
  //for (i = [0 : 5]) translate([39,-55 + i*24,0]) draw_icosa_hub();
  if (print_type == "fullplate" || print_type == "rodsonly")
  {
  translate([rod_offset + receiver_depth,0,0]) cube(size=[0.3,breakoff_length,0.2], center=false);
  translate([rod_offset + chord_length - 0.3 - receiver_depth,0,0]) cube(size=[0.3,breakoff_length,0.2], center=false);
  translate([rod_offset + receiver_depth,hub_ybase+hub_width,0]) cube([0.3,breakoff_length,0.2]);
  translate([rod_offset + chord_length - 0.3 - receiver_depth,hub_ybase+hub_width,0]) cube(size=[0.3,breakoff_length,0.2], center=false);
  }
}

module do_cube()
{
  chord_ratio = 1 / 0.86602540378443864676372317075294; // Radius of circumscribed sphere is (sqrt(3)/2 * edge length)
  chord_length = circumscribed_sphere_radius * chord_ratio;
  edge_count = 12;
  vertex_count = 8;
  face_count = 6;
  dihedral_angle = 90.0;
  hub_spacing = 25;
  hub_row1_offset = 6;
  hub_row2_offset = 30;
  echo("Cube; radius=", circumscribed_sphere_radius, " edge length=", chord_length, " edge count=", edge_count, " vertex_count=", vertex_count, " face count=", face_count );
  hub_ybase = (edge_count / 2 + 1) * rod_thickness * 3 / 2 + rod_thickness / 2;
  hub_width = (print_type == "rodsonly") ? 0 : 44;
  breakoff_length = rod_thickness * 3/2 * 5 + rod_thickness;
  if (print_type != "hubsonly" && print_type != "pipehub") for ( i = [0 : (edge_count / 2 - 1)] )
  {
    if (i == 0 || print_type != "minimal")
    {
		make_chord( chord_length, i * rod_thickness * 3 / 2, 1, 0 );
		make_chord( chord_length, hub_ybase + hub_width + i * rod_thickness * 3 / 2, 1, 0 );
	 }
  }
  if (print_type != "rodsonly") for ( i = [0 : 3] )
  {
	if (i == 0 || print_type != "minimal")
	{
		translate([14+i*hub_spacing,hub_ybase+hub_row1_offset,0]) draw_cube_hub(chord_length);
		if (print_type != "minimal") translate([17+i*hub_spacing,hub_ybase+hub_row2_offset,0]) draw_cube_hub(chord_length);
	}
  }
  // Add breakoff stringers at hub penetration depth
  if (print_type == "fullplate" || print_type == "rodsonly")
  {
  translate([1 + receiver_depth,0,0]) cube(size=[0.3,breakoff_length,0.2], center=false);
  translate([1 + chord_length - 0.3 - receiver_depth,0,0]) cube(size=[0.3,breakoff_length,0.2], center=false);
  translate([1 + receiver_depth,hub_ybase+hub_width,0]) cube([0.3,breakoff_length,0.2]);
  translate([1 + chord_length - 0.3 - receiver_depth,hub_ybase+hub_width,0]) cube(size=[0.3,breakoff_length,0.2], center=false);
  }
  // Debugging
  //translate([-40,0,0]) draw_hub_receiver_leg( 0 );
}

// Construct a chord of specified length and end-coding
module make_chord( length, yoffset, xoffset, endcoding )
{
  if (endcoding == 0) draw_0_chord( length, yoffset, xoffset );
  else if (endcoding == 1) draw_1_chord( length, yoffset, xoffset );
}

// Construct chord with 0 coding
module draw_0_chord( length, yoffset, xoffset )
{
  translate([xoffset,yoffset,0]) cube(size = [length, rod_thickness, rod_thickness], center = false );
}

// Construct chord with 1 encoding
module draw_1_chord( length, yoffset, xoffset )
{
}

// Draw cube hub
module draw_cube_hub(chord_length)
{
	// We are basically taking a corner and rotating each leg
	// outward by the angle between each leg and the ray which is equidistant
	// from all legs.
	// 1. The hub is the apex of a pyramid whose top edges
	//    (the ones that join at the vertex) are equal
	//		to our chord length (an edge of the polyhedron)
	//	2. If we look at a top view (2d projection) of
	//		the pyramid, the angle between top edges is
	//		360 / (number of legs joining at this vertex).
	projected_angle = 360 / 3;
	//	3. We'll call the inner angle of a face alpha.
	//		This gets harder when they're not all the same.
	gamma = 90.0;
	// 4.	Using the SAS rule, we have enough to calculate
	//		a base edge of our pyramid (we'll calculate half
	//		by dividing into two right triangles)
	base_edge = 2 * chord_length * sin(gamma/2);
	// 5. Projecting the apex and top edges onto the base plane, we'll
	//		calculate the length of one of the top edge projections using ASA
	//		for the base equilateral triangle
	base_incenter = 180 - /* 2 * 60 / 2 */ 60;
	top_edge_projection_length = (base_edge / 2) / sin(base_incenter/2);
	// 6.	Finally, get the angle from the perpendicular to the base incenter to one of the top edges
	top_edge_angle = asin(top_edge_projection_length / chord_length);
	sphere_radius = (print_type == "pipehub") ? pipe_outside_diameter * 2 : receiver_thickness * 2.0;
	//echo("Base edge=", base_edge, " top edge angle=", top_edge_angle);
  translate([0,0,receiver_thickness * 0.4]) rotate([180,0,0]) union()
  {
	// The hemisphere base needs to provide a flat solid
	// base for printing the hub, and also provides support for the angled legs. In solids with higher vertex counts,
	// the legs will begin to approach 90 degrees from perpendicular to the bed.
   translate([0,0,receiver_thickness * 0.4]) difference()
   {
	  union()
	  {
			difference()
			{
				// Coefficient should be enough to eliminate overhang
				sphere( r = sphere_radius, center = true );
				// Make sure sphere does not fill inside of receiver legs
			   rotate( a = [top_edge_angle,0,0 * projected_angle] ) draw_hub_receiver_leg( -1 );
   			rotate( a = [top_edge_angle,0,1 * projected_angle] ) draw_hub_receiver_leg( -1 );
   			rotate( a = [top_edge_angle,0,2 * projected_angle] ) draw_hub_receiver_leg( -1 );
			}
		   rotate( a = [top_edge_angle,0,0 * projected_angle] ) draw_hub_receiver_leg( 0 );
   		rotate( a = [top_edge_angle,0,1 * projected_angle] ) draw_hub_receiver_leg( 0 );
   		rotate( a = [top_edge_angle,0,2 * projected_angle] ) draw_hub_receiver_leg( 0 );
	  }
	  // Cutoff needs to eliminate maximum coefficient
	  translate( [0,0,receiver_thickness*3] ) cube( size = receiver_thickness * 6, center = true );
		// Carve some cheese wedges out of the wheel
		// to reduce print time.
	  if (hub_reduction == "cheese") translate( [0,0,-2 * sphere_radius] ) union() {
		rotate( a = [0,0,0.5 * projected_angle] ) translate([0,sphere_radius*0.4,0]) cheese_wedge( 2 * sphere_radius, projected_angle * 0.65, sphere_radius * 0.4 );
		rotate( a = [0,0,1.5 * projected_angle] ) translate([0,sphere_radius*0.4,0]) cheese_wedge( 2 * sphere_radius, projected_angle * 0.65, sphere_radius * 0.4 );
		rotate( a = [0,0,2.5 * projected_angle] ) translate([0,sphere_radius*0.4,0]) cheese_wedge( 2 * sphere_radius, projected_angle * 0.65, sphere_radius * 0.4 );
	  }
   }
  }
}

// Draw icosahedron hub
module draw_icosa_hub(chord_length)
{
  // Central angle is 2 * asin(chord * 0.5 / R)
  //					 	 2 * asin(R * chord_factor * 0.5 / R)
  //						 2 * asin(chord_factor * 0.5)
  //						 56.787500870592539769243472357818 degrees
  c_angle = 56.787500870592539769243472357818;
  ca_complement = 90.0 - c_angle;
	// We are basically taking a corner and rotating each leg
	// outward by the angle between each leg and the ray which is equidistant
	// from all legs.
	// 1. The hub is the apex of a pentakis pyramid whose top edges
	//    (the ones that join at the vertex) and bottom edges
	//		are equal to our chord length (an edge of the polyhedron)
	//	2. If we look at a top view (2d projection) of
	//		the pyramid, the angle between top edges is
	//		360 / (number of legs joining at this vertex).
	projected_angle = 360 / 5;
	//	3. We'll call the inner angle of a face gamma.
	//		This gets harder when they're not all the same.
	gamma = 60.0;
	// 4.	Since the icosahedron has triangular faces, we
	//		already know the length of a base edge of our
	//		five-sided pyramid
	base_edge = chord_length;
	// 5. Projecting the apex and top edges onto the base plane, we'll
	//		calculate the length of one of the top edge projections 
	//		(forming the side of a single triangle) using ASA
	base_incenter = 360 / 5;
	top_edge_projection_length = (base_edge / 2) / sin(base_incenter/2);
	// 6.	Finally, get the angle from the perpendicular to the base incenter to one of the top edges
	top_edge_angle = asin(top_edge_projection_length / chord_length);
	sphere_radius = (print_type == "pipehub") ? pipe_outside_diameter * 2 : receiver_thickness * 2.0;
	//echo("Top edge projection=", top_edge_projection_length, " top edge angle=", top_edge_angle);
  rotate([180,0,0]) difference()
  {
	  union()
	  {
		difference()
		{
			// Sphere should be large enough to eliminate overhang
			// below bottom edge of receiver legs
			sphere( r = sphere_radius, center = true );
			// Make sure sphere does not intrude into receiver slots
			for (i = [0 : 4])
			{
			   rotate( a = [top_edge_angle,0,i * projected_angle] ) draw_hub_receiver_leg( -1 );
			}
		} // difference - sphere minus receivers
		for (i = [0 : 4])
		{
		   rotate( a = [top_edge_angle,0,i * projected_angle] ) draw_hub_receiver_leg( 0 );
		}
	  } // union - sphere plus receiver legs
	  translate( [0,0,receiver_thickness*3] ) cube( size = receiver_thickness * 6, center = true );
		// Carve some cheese wedges out of the wheel
		// to reduce print time.
	  if (hub_reduction == "cheese") translate( [0,0,-2 * sphere_radius] ) union() {
		rotate( a = [0,0,0.5 * projected_angle] ) translate([0,sphere_radius*0.4,0]) cheese_wedge( 2 * sphere_radius, projected_angle * 0.65, sphere_radius * 0.4 );
		rotate( a = [0,0,1.5 * projected_angle] ) translate([0,sphere_radius*0.4,0]) cheese_wedge( 2 * sphere_radius, projected_angle * 0.65, sphere_radius * 0.4 );
		rotate( a = [0,0,2.5 * projected_angle] ) translate([0,sphere_radius*0.4,0]) cheese_wedge( 2 * sphere_radius, projected_angle * 0.65, sphere_radius * 0.4 );
		rotate( a = [0,0,3.5 * projected_angle] ) translate([0,sphere_radius*0.4,0]) cheese_wedge( 2 * sphere_radius, projected_angle * 0.65, sphere_radius * 0.4 );
		rotate( a = [0,0,4.5 * projected_angle] ) translate([0,sphere_radius*0.4,0]) cheese_wedge( 2 * sphere_radius, projected_angle * 0.65, sphere_radius * 0.4 );
	  }
   } // difference - hub unit with bottom chopped off
}

// Draw dodecahedron hub
module draw_dodeca_hub(chord_length)
{
	// We are basically taking a corner and rotating each leg
	// outward by the angle between each leg and the ray which is equidistant
	// from all legs.
	// 1. The hub is the apex of a pyramid whose top edges
	//    (the ones that join at the vertex) are equal
	//		to our chord length (an edge of the polyhedron)
	//	2. If we look at a top view (2d projection) of
	//		the pyramid, the angle between top edges is
	//		360 / (number of legs joining at this vertex).
	projected_angle = 360 / 3;
	//	3. We'll call the inner angle of a face gamma.
	//		This gets harder when they're not all the same.
	gamma = 72.0;
	// 4.	Using the SAS rule, we have enough to calculate
	//		a base edge of our pyramid (we'll calculate half
	//		by dividing into two right triangles)
	base_edge = 2 * chord_length * sin(gamma/2);
	// 5. Projecting the apex and top edges onto the base plane, we'll
	//		calculate the length of one of the top edge projections using ASA
	//		for the base triangle
	base_incenter = 120;
	top_edge_projection_length = (base_edge / 2) / sin(base_incenter/2);
	// 6.	Finally, get the angle from the perpendicular to the base incenter to one of the top edges
	top_edge_angle = asin(top_edge_projection_length / chord_length);
	sphere_radius = (print_type == "pipehub") ? pipe_outside_diameter * 2 : receiver_thickness * 2.0;
	leg_factor = (print_type == "pipehub") ? pipe_outside_diameter * 0.4 : receiver_thickness * 0.4;
	cutoff_translation = (print_type == "pipehub") ? pipe_outside_diameter * 3 : receiver_thickness * 3;
	cutoff_size = cutoff_translation * 2;
	//echo("Base edge=", base_edge, " top edge angle=", top_edge_angle);
  translate([0,0,leg_factor]) rotate([180,0,0]) union()
  {
	// The hemisphere base needs to provide a flat solid
	// base for printing the hub, and also provides support for the angled legs. In solids with higher vertex counts,
	// the legs will begin to approach 90 degrees from perpendicular to the bed.
   translate([0,0,leg_factor]) difference()
   {
	  union()
	  {
			difference()
			{
				// Coefficient should be enough to eliminate overhang
				sphere( r = sphere_radius, center = true );
				// Make sure sphere does not fill inside of receiver legs
			   rotate( a = [top_edge_angle,0,0 * projected_angle] ) draw_hub_receiver_leg( -1 );
   			rotate( a = [top_edge_angle,0,1 * projected_angle] ) draw_hub_receiver_leg( -1 );
   			rotate( a = [top_edge_angle,0,2 * projected_angle] ) draw_hub_receiver_leg( -1 );
			}
		   rotate( a = [top_edge_angle,0,0 * projected_angle] ) draw_hub_receiver_leg( 0 );
   		rotate( a = [top_edge_angle,0,1 * projected_angle] ) draw_hub_receiver_leg( 0 );
   		rotate( a = [top_edge_angle,0,2 * projected_angle] ) draw_hub_receiver_leg( 0 );
	  }
	  // Cutoff needs to eliminate maximum coefficient
	  translate( [0,0,cutoff_translation] ) cube( size = cutoff_size, center = true );
		// Carve some cheese wedges out of the wheel
		// to reduce print time.
	  if (hub_reduction == "cheese") translate( [0,0,-2 * sphere_radius] ) union() {
		rotate( a = [0,0,0.5 * projected_angle] ) translate([0,sphere_radius*0.4,0]) cheese_wedge( 2 * sphere_radius, projected_angle * 0.75, sphere_radius * 0.4 );
		rotate( a = [0,0,1.5 * projected_angle] ) translate([0,sphere_radius*0.4,0]) cheese_wedge( 2 * sphere_radius, projected_angle * 0.75, sphere_radius * 0.4 );
		rotate( a = [0,0,2.5 * projected_angle] ) translate([0,sphere_radius*0.4,0]) cheese_wedge( 2 * sphere_radius, projected_angle * 0.75, sphere_radius * 0.4 );
	  }
   } // difference which gets rotated and translated
		// Debug
		//	cheese_wedge( 4 * sphere_radius, projected_angle, sphere_radius * 1.1 );
  }
}

// Draw a single hub receiver leg
module draw_hub_receiver_leg( encoding )
{
  // Make top centered at 0,0,0 pointing down
  translate([0,0,-receiver_leg_length/2]) difference()
  {
    cube( size = [receiver_thickness, receiver_thickness, receiver_leg_length], center = true );
	 if (encoding == 0)
	 {
		translate([0,0,receiver_depth - receiver_leg_length]) cube( size = [rod_thickness * receiver_hole_factor, rod_thickness * receiver_hole_factor, receiver_leg_length], center = true );
	 } // Square hole
	 // else may be no hole (-1)
  }
}

module do_bed_guide()
{
  if (show_bed_size_guide != 0) draw_bed_guide( show_bed_size_guide * 25.4 );
}

module draw_bed_guide( width )
{
  translate([-0.025*width,-0.025*width,0]) difference()
  {
	cube( size = [width*1.05, width*1.05, 1], center = false );
   translate([width*0.025,width*0.025,0]) cube( size = [width, width, 1], center = false );
  }
  // Leave a 0.05mm gap so we can verify clearance
  translate([0,0,-1.05]) cube( size = [width, width, 1], center  = false );
}

// Make a "cheese wedge" with point and base at 0,0,0 
// to carve out nonessential chunks from a hub
module cheese_wedge( wedge_height, angle, inner_radius )
{
  leg = wedge_height * 1.3;
  p1x = 2 * leg * sin(angle/2);
  p1y = leg * cos(angle/2);
  p2x = -p1x;
  p2y = p1y;
  //echo("Wedge x1=", p1x, " y1=", p1y, " x2=", p2x, " y2=", p2y, " height=", wedge_height);
  // polygon assumes right-handed winding order
  // i.e. make a fist using your right hand with thumb pointing up. Your thumb
  // is the Z axis and the winding needs to go in the
  // direction your fingers curl around (counterclockwise).
  // paths vector is not required
	difference()
	{
		linear_extrude( height = wedge_height, center = false ) polygon( points = [ [0,0], [p1x,p1y], [p2x,p2y] ], convexity = 2 );
		cylinder( r = inner_radius, h = wedge_height, center = false );
	}
}
