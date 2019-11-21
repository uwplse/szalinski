// Radius gauge
$fa=2;
$fs=.1;

// Modification history:
// 08/01/2015 Replace WriteScad with text(); thank you roki@thingiverse!
// 08/01/2015 Strengthen hinge.
// 05/27/2016 Add "inches" version.

view = 0; // 0 = assembly view; 1 = arranged for printing
part = 3; // 1 = stationary part; 2 = moving part; 3 = both;
          // 4 = gauge w/ hole; 5 = gauge w/ pin; 6 = both gauges

// Constant
INCH = 25.4; // convert inches to MMs
CM = 10; // convert CMs to MMs

// Parameters
metric = true; // CMs if true; else inches
thickness = 3;
contact_radius = 5;
contact_spread = 25;
protractor_radius = contact_spread + contact_radius + 20;
pointer_radius = protractor_radius - 9;
pointer_width = contact_radius / 2;
hinge_cylinder_dia = 5;
hinge_pin_dia = hinge_cylinder_dia - .3;
hinge_pin_wall_thickness = 3.0;
hinge_pin_nub_dia = hinge_pin_dia + .7;
hinge_pin_spread_gap = thickness/4 * 1.8;
concave_tick_list =
    metric
        ? [4, 5, 6, 7, 8, 9, 10, 20, 40, 99999] // CMs
        : [5, 6, 7, 8, 9, 10, 20, 30]; // inches
concave_number_list =
    metric
        ? [3, 5, 10, 40] // CMs
        : [3, 4, 5, 10]; // inches
convex_tick_list =
    metric
        ? [2, 3, 4, 5, 6, 7, 8, 9, 10, 20, 40, 99999] // CMs
        : [6, 7, 8, 9, 10, 20, 30]; // inches
convex_number_list =
    metric
        ? [2, 5, 10, 40] // CMs
        : [2, 3, 4, 5, 10]; // inches


if ( view == 0 ) // 0 = assembly view
	{
    difference()
        {
        union()
            {
                if ( part == 1 || part == 3 )
                    stationary_part ();

                if ( part == 2 || part == 3 )
                    moving_part ();

                if ( part == 4 || part == 6 )
                    stationary_part_hinge ();

                if ( part == 5 || part == 6 )
                    moving_part_hinge ();
            }
        cube([99,99,99]);
        }
	}
else // view == 1 // 1 = arranged for printing
	{
    difference()
        {
        union()
            {
            if ( part == 1 || part == 3 )
                stationary_part ();

            if ( part == 2 || part == 3 )
                translate ([- contact_spread/2, contact_radius + 3, 2 * thickness])
                rotate ([180, 0, 0])
                moving_part ();

            if ( part == 4 || part == 6 )
                stationary_part_hinge ();

            if ( part == 5 || part == 6 )
                {
                translate ([2.1 * contact_radius, 0, 2 * thickness])
                rotate ([180, 0, 0])
                moving_part_hinge ();
                }
            }
        *cube([99,99,99]);
        }
    }



///////////////////////////////////////////////////////////////////////////////////

module stationary_part ()
{
	stationary_part_hinge ();

    difference ()
    {
    union () // protractor with contact cylinder
    {
        linear_extrude (height = thickness)
        difference () // protractor with cutouts
        {
            union () //Protractor with final ticks support
            {           
                difference () // Protractor arc.
                {
                    circle (r = protractor_radius, center = true, $fn = 100);
                    translate ([-999/2, 0]) square ([999, 999]);
                    rotate ([0, 0, -60]) translate ([-999/2, 0]) square ([999, 999]);
                }
                // support areas for final ticks
                translate ([-protractor_radius, 0, 0])
                square ([10, 3]);
                rotate([0, 0, 120])
                translate ([-protractor_radius, -3, 0])
                square ([10, 3]);

            }
            // cutout for contact cylinder on moving part.
            rotate ([0, 0, 120])
            translate ([- contact_spread, 0])
            circle (r = contact_radius + .5, $fn = 100, center = true); 

            // Don't let this part run into the hinge pin hole.
            circle (r = contact_radius * .9, center = true);
        }
        
        difference () // Tall contact cylinder on stationary part.
        {
	linear_extrude (height = 2 * thickness)
	translate ([- contact_spread, 0])
	circle (r = contact_radius, $fn = 100, center = true);
    // cutout for pointer
    rotate ([0, 0, -90])
    translate ([- pointer_width/2, - pointer_radius, thickness])
    cube ([pointer_width + contact_radius, pointer_radius, thickness + 1]);
    }

    }
    for ( measured_radius = convex_number_list )
		number_mark (
			str(abs(measured_radius)),
			angle_for_measured_convex_radius(measured_radius * (metric ? CM : INCH)));

	for ( measured_radius = concave_number_list )
		number_mark (
			str(abs(measured_radius)),
			- angle_for_measured_concave_radius(
                measured_radius * (metric ? CM : INCH)));

	for ( measured_radius = convex_tick_list )
		tick_mark (angle_for_measured_convex_radius(
                        measured_radius * (metric ? CM : INCH)));

	for ( measured_radius = concave_tick_list )
		tick_mark (- angle_for_measured_concave_radius(
                        measured_radius * (metric ? CM : INCH)));
    }
}



module stationary_part_hinge ()
{
	difference ()
	{
		linear_extrude (height = thickness)
		difference ()
		{
			// Contact circle with hinge cylinder.
			circle (r = contact_radius, $fn = 100, center = true);

			// Cut out hinge cylinder.
			circle (d = hinge_cylinder_dia, $fn = 100, center = true);
		}

	// Cut out lock-bevel in hinge cylinder.
	cylinder (h = thickness/2,
		d1 = hinge_cylinder_dia + thickness,
		d2 = hinge_cylinder_dia);
	}
}



module number_mark (text, angle)
color("Black")
{
	rotate (-30 + angle)
	translate ([0, - protractor_radius + 1, thickness - 1])
    linear_extrude (2)
    text (text, 3, "Consolas:style=Bold", halign = "center");

	tick_mark (angle, 4);
}



module tick_mark (angle, length = 2)
color("Black")
{
	rotate (-30 + angle)
	translate ([-.4, - (length + pointer_radius + .5), thickness - 1])
	cube ([.8, length, 2]);
}



module moving_part ()
color("Cyan")
{
	translate ([0, 0, thickness])
	linear_extrude (height = thickness)
	{
		// Pointer
		rotate ([0, 0, -30])
		difference ()
		{
			translate ([- pointer_width/2, - pointer_radius])
			square ([pointer_width, pointer_radius]);

			translate ([0, - pointer_radius])
			for ( a = [-45, 135] )
				rotate ([0, 0, a])
				translate ([.01, .01]) // avoid rendering error
				square ([9, 9]);
		}

		// Triangular fill between pointer and moving contact.
		polygon (
			points = [
				[0, 0],
				[contact_spread + contact_radius, 0],
				[.8 * - pointer_radius * sin(30), .8 * - pointer_radius * cos(30)] ],
			paths = [ [0, 1, 2] ]);
	}

	// Tall contact cylinder on moving part.
	linear_extrude (height = 2 * thickness)
	translate ([contact_spread, 0, 0])
	circle (r = contact_radius, $fn = 100, center = true);

	// Hinge pin.
	moving_part_hinge ();
}



module hinge_pin_solid ()
{
	// Bottom half of hinge cylinder.
	translate ([0, 0, thickness / 2])
	cylinder (h = thickness / 2, d = hinge_pin_dia, $fn = 100);

	// Bulge in the middle, that must be pressed through the hole in the matching
	// part, and will then expand to hold the pieces together.
	intersection ()
	{
		union ()
		{
			cylinder (h = thickness/4,
				d1 = hinge_pin_dia               - 1.0,
				d2 = hinge_pin_dia + thickness/2 - 1.0);
	
			translate ([0, 0, thickness/4])
			cylinder (h = thickness/4,
				d1 = hinge_pin_dia + thickness/2,
				d2 = hinge_pin_dia);
		}

		// Remove the too-wide portion of the bulge.
		cylinder (h = 99, d = hinge_pin_nub_dia);
	}
}



module moving_part_hinge ()
color("Cyan")
{
	// Contact circle with hinge pin.
	translate ([0, 0, thickness])
	linear_extrude (height = thickness)
	circle (r = contact_radius, $fn = 100, center = true);

	// Hinge pin.
	difference ()
	{
		hinge_pin_solid ();

		translate ([- hinge_pin_spread_gap/2, -99/2, -99/2])
		cube ([hinge_pin_spread_gap, 99, 99]);

		// Cut off the overhang on both ends.
		for ( m = [0, 1] )
			mirror ([0, m, 0])
			translate ([-9/2, hinge_pin_dia/2, -9/2])
			cube ([9, 9, 9]);
	}
}



function angle_for_measured_concave_radius (measured_radius)
= 2 * asin (contact_spread / 2 /(measured_radius - contact_radius));

function angle_for_measured_convex_radius (measured_radius)
= 2 * asin (contact_spread / 2 /(measured_radius + contact_radius));