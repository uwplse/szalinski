/* [Object size ] */

object_size_x =  1.4; // [0.2:0.2:60]
object_size_y = 50  ; // [0.2:0.2:60]
object_size_z = 50  ; // [0.2:0.2:60]

/* [Object count] */

object_slots_x = 10; // [1:50]
object_slots_y =  2; // [1:50]
object_slots_z =  1; // [1:50]

/* [Margin between objects] */

object_air_x =  0.1; // [0.0:0.1:2]
object_air_y =  1  ; // [0.0:0.1:2]
object_air_z =  1  ; // [0.0:0.1:2]

/* [Wall] */

wall_x = 1.85; // [0.05:0.05:3]
wall_y = 1.85; // [0.05:0.05:3]
wall_z = 1.95; // [0.05:0.05:3]

/* [Gap between pieces] */

print_space_x = 0.3; //[0.05:0.05:0.5]
print_space_y = 0.3; //[0.05:0.05:0.5]
print_space_z = 0.3; //[0.05:0.05:0.5]

$fn=100;

/* [Export] */

part = "both"; // [top:Top cap,bottom:Bottom piece,both:Both pieces]

module truncate_to_z( minz, maxz )
{
	inf = 999;
	intersection()
	{
		children();
		translate([ -inf / 2, -inf / 2, minz ])
		{
			cube([ inf, inf, maxz - minz ]);
		}
	}
}

module box_case( inside_space, wall, space )
{
	truncate_to_z( - wall[ 2 ], inside_space[ 2 ] / 2 )
	{
		minkowski()
		{
			scale( wall )
				translate([ 0, 0, - wall[ 2 ] ])
					cylinder();
			cube( inside_space );
		}
	}
}

module box_clip( inside_space, wall )
{
	truncate_to_z( 3 * inside_space[ 2 ] / 8,
				   5 * inside_space[ 2 ] / 8 )
	{
		minkowski()
		{
			cube( inside_space );
			scale( wall )
			{
				sphere();
			}
		}
	}
}

module box_bottom( inside_space, wall, space )
{
	difference()
	{
		union()
		{
			box_case( inside_space, wall, space);
			box_clip( inside_space, ( wall - space ) / 2 );
		}
		cube( inside_space );
	}
}

module box_top( inside_space, wall, space )
{
	difference()
	{
		difference()
		{
			box_case( inside_space, wall, space );
			box_clip( inside_space, ( wall + space ) / 2 );
		}
		cube( inside_space );
	}
}

module box( inside_space, wall, space )
{
	translate( wall )
	{
		if( part != "top" )
		{
			box_bottom( inside_space, wall, space );
		}

		translate( [ 3 * wall[ 0 ] + inside_space[ 0 ], 0, 0 ] )
		{
			if( part != "bottom" )
			{
				box_top( inside_space, wall, space );
			}
		}
	}
}



object_size = [ object_size_x, object_size_y, object_size_z ];
object_slots = [ object_slots_x, object_slots_y, object_slots_z ];
object_air  = [ object_air_x, object_air_y, object_air_z ];
wall  = [ wall_x, wall_y, wall_z ];
print_space = [ print_space_x, print_space_y, print_space_z ];

object_inside_space = [for (i=[0:2]) object_slots[i] * ( object_size[i] + object_air[i] ) ];

color( "white" )
{
    box( object_inside_space, wall, object_space );
}
