//----- Customizable constants

// preview[view:south, tilt:top]

/* [Printer/Slicer] */

// of the target printer
nozzle_diameter= 0.4;

// to be used by the slicer
layer_height= 0.2;

/* [Rupee Shape] */

rupee_length= 190;
rupee_edge_pitch= 45;
rupee_tip_angle= 100;
rupee_aspect_ratio= 0.6;
rupee_center_facet_ratio= 0.5;

rupee_bowl_wall_count= 2;
rupee_bowl_floor_count= 4; // NOTE: An even number of layers promotes symmetry on the central facet.

/* [Light Socket Connector] */

rupee_shade_total_height= 140;

light_socket_connector_top_diameter= 50;
light_socket_connector_face_count= 64;

/* [Hidden] */

// The connector slits was both unnecessary and created problems while printing.
light_socket_connector_slit_xy_size= 0; // 0 will remove the slit entirely. 

// The magnets turned out to be unnecessary, so it's completely untested.
light_socket_connector_magnet_count= 0;
magnet_diameter= 5.0;
magnet_socket_xy_gap= 0.1;
magnet_socket_z_gap= 0.2;
magnet_socket_wall_count= 2;
magnet_socket_floor_count= 2;
magnet_socket_ceiling_count= 2; // Either 0 if glueing in magnets, or just thick enough to ensure the magnets are contained.
magnet_socket_support_pitch= 45;
magnet_socket_face_count= 64;

//----- Private constants

function hidden(x)= x; // Used to hide values from the customizer app.

csg_overlap= hidden(0.02);

rupee_bowl_wall_xy_size= (nozzle_diameter * rupee_bowl_wall_count);
rupee_bowl_floor_z_size= (layer_height * rupee_bowl_floor_count);

rupee_y_size= rupee_length;
rupee_x_size= (rupee_y_size * rupee_aspect_ratio);

rupee_center_facet_x_size= (rupee_center_facet_ratio * rupee_x_size);

rupee_edge_facet_x_size= ((rupee_x_size / 2) - (rupee_center_facet_x_size / 2));
rupee_edge_facet_z_size= (rupee_edge_facet_x_size * tan(rupee_edge_pitch));

rupee_z_size= (2 * rupee_edge_facet_z_size);

rupee_max_size= (max(rupee_x_size, rupee_y_size, rupee_z_size) + (2 * csg_overlap));

light_socket_connector_z_size= (rupee_shade_total_height - rupee_z_size);

light_socket_connector_top_radius= (light_socket_connector_top_diameter / 2);

magnet_socket_cavity_xy_radius= ((magnet_diameter / 2) + magnet_socket_xy_gap);
magnet_socket_cavity_z_size= (magnet_socket_z_gap + magnet_diameter + magnet_socket_z_gap);
magnet_socket_wall_xy_size= (nozzle_diameter * magnet_socket_wall_count);
magnet_socket_floor_z_size= (layer_height * magnet_socket_floor_count);
magnet_socket_ceiling_z_size= (layer_height * magnet_socket_ceiling_count);

magnet_socket_xy_radius= (magnet_socket_cavity_xy_radius + magnet_socket_wall_xy_size);
magnet_socket_z_size= (magnet_socket_floor_z_size + magnet_socket_cavity_z_size + magnet_socket_ceiling_z_size);

magnet_socket_support_z_size= ((2 * magnet_socket_xy_radius) * tan(magnet_socket_support_pitch));

//----- Information

echo("rupee_center_facet_x_size:", rupee_center_facet_x_size);
echo("rupee_z_size:", rupee_z_size);
echo("magnet_insertion pause_at_z:", (rupee_shade_total_height - magnet_socket_ceiling_z_size));

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

module rupee_bowl()
{
	difference()
	{
		rupee_solid(xy_inset_size= 0);
		
		difference()
		{
			translate([0, 0, csg_overlap])
			rupee_solid(
				xy_inset_size= rupee_bowl_wall_xy_size);
			
			translate([-(rupee_max_size / 2), -(rupee_max_size / 2), 0])
			cube(size= [
				rupee_max_size,
				rupee_max_size,
				rupee_bowl_floor_z_size]);
		}
	}
}

module magnet_socket()
{
	difference()
	{
		translate([
			-magnet_socket_xy_radius,
			0,
			-(magnet_socket_z_size + magnet_socket_support_z_size)])
		union()
		{
			cylinder(
				r= magnet_socket_xy_radius,
				h= (magnet_socket_z_size + magnet_socket_support_z_size),
				$fn= magnet_socket_face_count);
			
			translate([0, -magnet_socket_xy_radius, 0])
			cube(size= [
				magnet_socket_xy_radius,
				(2 * magnet_socket_xy_radius), 
				(magnet_socket_z_size + magnet_socket_support_z_size)]);
		}
		
		// Magnet cavity.
		translate([
			-magnet_socket_xy_radius,
			0,
			-(magnet_socket_cavity_z_size + magnet_socket_ceiling_z_size)])
		cylinder(
			r= magnet_socket_cavity_xy_radius,
			h= magnet_socket_cavity_z_size,
			$fn= magnet_socket_face_count);
			
		// Support bevel
		translate([
			-(2 * magnet_socket_xy_radius),
			0,
			-magnet_socket_z_size])
		rotate([0, -(90 - magnet_socket_support_pitch), 0])
		translate([
			-magnet_socket_support_z_size,
			-magnet_socket_xy_radius,
			-(2 * magnet_socket_support_z_size)])
		translate([0, -csg_overlap, 0])
		cube(size= [
			magnet_socket_support_z_size,
			((2 * magnet_socket_xy_radius) + (2 * csg_overlap)),
			(2 * magnet_socket_support_z_size)]);
	}
}

module light_socket_connector_exterior()
{
	cylinder(
		r= light_socket_connector_top_radius,
		h= light_socket_connector_z_size,
		$fn= light_socket_connector_face_count);
		
	difference()
	{
		translate([
			-(rupee_center_facet_x_size / 2),
			-(rupee_y_size / 2),
			0])
		cube(size= [
			rupee_center_facet_x_size,
			rupee_y_size,
			min((rupee_z_size / 2), light_socket_connector_z_size)]);
		
		translate([0, 0, -(rupee_z_size / 2)])
		rupee_negative_edges(xy_inset_size= 0);
	}
}

module light_socket_connector_negative_interior()
{
	translate([0, 0, -csg_overlap])
	cylinder(
		r= (light_socket_connector_top_radius - rupee_bowl_wall_xy_size),
		h= (csg_overlap + light_socket_connector_z_size + csg_overlap),
		$fn= light_socket_connector_face_count);
			
	intersection()
	{
		// Base X-Positive
		translate([((rupee_center_facet_x_size / 2) - rupee_bowl_wall_xy_size), 0, 0])
		rotate([0, -(90 - rupee_edge_pitch), 0])
		mirror([1, 0, 0])
		translate([0, -(rupee_max_size / 2), 0])
		cube(size= rupee_max_size);
		
		// Base X-Negative
		mirror([1, 0, 0])
		translate([((rupee_center_facet_x_size / 2) - rupee_bowl_wall_xy_size), 0, 0])
		rotate([0, -(90 - rupee_edge_pitch), 0])
		mirror([1, 0, 0])
		translate([0, -(rupee_max_size / 2), 0])
		cube(size= rupee_max_size);
	}
	
	// If the user needs the connector to be split to
	// allow the bulb to pass through.
	if (light_socket_connector_slit_xy_size > 0)
	{
		translate([
			-(light_socket_connector_slit_xy_size / 2),
			-(rupee_max_size / 2),
			0])
		cube(size= [
			light_socket_connector_slit_xy_size,
			rupee_max_size,
			(light_socket_connector_z_size + csg_overlap)]);
	}
}

module light_socket_connector_magnet_sockets()
{
	magnet_placement_angle= (360 / light_socket_connector_magnet_count);
	
	// NOTE: We must perform this check, otherwise the
	// culling-cylinder will become the only child passed
	// to intersection().
	if (light_socket_connector_magnet_count > 0)
	{
		intersection()
		{
			translate([0, 0, light_socket_connector_z_size])
			union()
			{
				for (index= [0 : (light_socket_connector_magnet_count - 1)])
				{
					rotate([0, 0, (90 + (index * magnet_placement_angle) + (magnet_placement_angle / 2))])
					translate([csg_overlap, 0, 0])
					translate([(light_socket_connector_top_radius - rupee_bowl_wall_xy_size), 0, 0])
					magnet_socket();
				}
			}
			
			// Ensure the magnet sockets don't poke out.
			cylinder(
				r= light_socket_connector_top_radius,
				h= light_socket_connector_z_size,
				$fn= light_socket_connector_face_count);
		}
	}
}

module light_socket_connector_whole()
{
	union()
	{
		difference()
		{
			light_socket_connector_exterior();
			
			light_socket_connector_negative_interior();
		}
		
		light_socket_connector_magnet_sockets();
	}
}

module rupee_shade()
{
	union()
	{
		rupee_bowl();

		translate([0, 0, -csg_overlap])
		translate([0, 0, rupee_z_size])
		light_socket_connector_whole();
	}
}

//----- Output

rotate([0, 0, 45]) // Rotate to better fit in the printer, while keeping the bottom-fill symmetrical to look nice. (could fit better with a different angle, but the bottom surface would be asymmetrical)
//rupee_bowl();
//light_socket_connector_whole();
rupee_shade();