//----- Customizable constants

// preview[view:south, tilt:top]

/* [Printer/Slicer] */

// of the target printer
nozzle_diameter= 0.4;

// to be used by the slicer
layer_height= 0.2;

/* [Rupee Shape] */

rupee_length= 30;
rupee_edge_pitch= 45;
rupee_tip_angle= 100;
rupee_aspect_ratio= 0.6;
rupee_center_facet_ratio= 0.5;

rupee_hollow_wall_count= 2;
rupee_hollow_floor_count= 4; // NOTE: An even number of layers promotes symmetry on the central facet.

/* [Plating] */

plating_row_count= 5;
plating_column_count= 10;
plating_x_gap= 1;
plating_y_gap= 1;

//----- Private constants

function hidden(x)= x; // Used to hide values from the customizer app.

csg_overlap= hidden(0.02);

rupee_hollow_wall_xy_size= (nozzle_diameter * rupee_hollow_wall_count);
rupee_hollow_floor_z_size= (layer_height * rupee_hollow_floor_count);

rupee_y_size= rupee_length;
rupee_x_size= (rupee_y_size * rupee_aspect_ratio);

rupee_center_facet_x_size= (rupee_center_facet_ratio * rupee_x_size);

rupee_edge_facet_x_size= ((rupee_x_size / 2) - (rupee_center_facet_x_size / 2));
rupee_edge_facet_z_size= (rupee_edge_facet_x_size * tan(rupee_edge_pitch));

rupee_z_size= (2 * rupee_edge_facet_z_size);

rupee_max_size= (max(rupee_x_size, rupee_y_size, rupee_z_size) + (2 * csg_overlap));

//----- Information

echo("rupee_center_facet_x_size:", rupee_center_facet_x_size);
echo("rupee_z_size:", rupee_z_size);

//----- Implementation

module rupee_negative_top_edge()
{
	clipping_cube_x_size= (rupee_x_size / cos(rupee_edge_pitch));
	
	rotate([0, rupee_edge_pitch, 0])
	translate([-(clipping_cube_x_size / 2), -(rupee_max_size / 2), 0])
	cube(size= [
		clipping_cube_x_size,
		rupee_max_size,
		rupee_max_size]);
}

module rupee_negative_full_edge(
	xy_inset_size)
{
	translate([-xy_inset_size, 0, 0])
	{
		rupee_negative_top_edge();
		
		mirror([0, 0, 1])
		rupee_negative_top_edge();
	}
}

module rupee_negative_edges(
	xy_inset_size)
{
	// Right
	translate([(rupee_x_size / 2), 0, 0])
	rupee_negative_full_edge(xy_inset_size);
	
	// Top-Right
	translate([0, (rupee_y_size / 2), 0])
	rotate([0, 0, (rupee_tip_angle / 2)])
	rupee_negative_full_edge(xy_inset_size);
	
	// Top-Left
	translate([0, (rupee_y_size / 2), 0])
	mirror([1, 0, 0])
	rotate([0, 0, (rupee_tip_angle / 2)])
	rupee_negative_full_edge(xy_inset_size);
	
	// Left
	translate([-(rupee_x_size / 2), 0, 0])
	mirror([1, 0, 0])
	rupee_negative_full_edge(xy_inset_size);
	
	// Bottom-Left
	translate([0, -(rupee_y_size / 2), 0])
	mirror([1, 0, 0])
	rotate([0, 0, -(rupee_tip_angle / 2)])
	rupee_negative_full_edge(xy_inset_size);
	
	// Bottom-Right
	translate([0, -(rupee_y_size / 2), 0])
	rotate([0, 0, -(rupee_tip_angle / 2)])
	rupee_negative_full_edge(xy_inset_size);
}

module rupee_solid(
	xy_inset_size)
{
	translate([0, 0, (rupee_z_size / 2)])
	difference()
	{
		cube(
			size= [rupee_x_size, rupee_y_size, rupee_z_size],
			center= true);
		
		rupee_negative_edges(xy_inset_size= xy_inset_size);
	}
}

module rupee_hollow()
{
	difference()
	{
		rupee_solid(xy_inset_size= 0);
		
		intersection()
		{
			translate([0, 0, csg_overlap])
			rupee_solid(
				xy_inset_size= rupee_hollow_wall_xy_size);
			
			translate([-(rupee_max_size / 2), -(rupee_max_size / 2), rupee_hollow_floor_z_size])
			cube(size= [
				rupee_max_size,
				rupee_max_size,
				(rupee_z_size - (2 * rupee_hollow_floor_z_size))]);
		}
	}
}

module rupee_on_end_facet()
{
	rotate([0, -rupee_edge_pitch, 0])
	rotate([0, 0, -(rupee_tip_angle / 2)])
	translate([0, (rupee_y_size / 2), -(rupee_z_size / 2)])
	rupee_solid(xy_inset_size= 0);
}

module rupee_on_side_facet()
{
	rotate([0, -rupee_edge_pitch, 0])
	translate([(rupee_x_size / 2), 0, -(rupee_z_size / 2)])
	difference()
	{
		rupee_solid(xy_inset_size= 0);
		
		translate([
			-(rupee_center_facet_x_size / 2),
			-(rupee_center_facet_x_size / 2),
			0])
		*cube(size= [
			rupee_center_facet_x_size,
			rupee_center_facet_x_size,
			rupee_z_size]);
	}
}

module rupee_on_edge_plate()
{
	for (row_index= [0 : (plating_row_count - 1)])
	{
		for (column_index= [0 : (plating_column_count - 1)])
		{
			translate([
				(column_index * ((rupee_z_size / sin(rupee_edge_pitch)) + plating_x_gap)),
				(row_index * rupee_length), // TODO: Make this more accurate.
				0])
			rupee_on_side_facet();
		}
	}
}

module convert_to_flat_plate()
{
	cell_x_size= (rupee_x_size + plating_x_gap);
	cell_y_size= ((rupee_y_size - 7.5) + plating_y_gap); // TODO: Clean this up!
	
	plate_x_size= (cell_x_size * plating_column_count);
	plate_y_size= (cell_y_size * plating_row_count);
	
	translate([
		-(plate_x_size / 2),
		-(plate_y_size / 2),
		0])
	for (row_index= [0 : (plating_row_count - 1)])
	{
		for (column_index= [0 : (plating_column_count - 1)])
		{			
			
			translate([
				((column_index * cell_x_size) + ((row_index % 2) * (cell_x_size / 2))),
				(row_index * cell_y_size),
				0])
			translate([(rupee_x_size / 2), (rupee_y_size / 2), 0])
			child(0);
		}
	}
}

//----- Output

//rupee_on_side_facet();
convert_to_flat_plate()
render()
rupee_hollow();