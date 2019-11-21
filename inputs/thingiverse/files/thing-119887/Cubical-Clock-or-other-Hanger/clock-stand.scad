// preview[view:south west, tilt:top diagonal]

/* [General Settings] */
// How thick is the cubical wall?
wall_thickness = 50;//[15:75]

// How long should the back side be?
back_height = 50;//[15:100]

// How long should the front side be?
front_height = 100;//[30:150]

// Adjust the resolution
resolution = 32;//[16:36]
$cf=resolution;

// How wide should the hanger be?
hanger_width = 35;//[5:75]

// How thick should the plastic be?
hanger_thickness = 5;//[2:10]

/* [Hook Settings] */
// Diameter of the hook (this should be smaller than the hole for clearance).
hook_diameter = 7;//[1:25]

// Thickness of the hook (shallower than hole depth for clearance).
hook_depth = 2;//[1:10]

// Diameter of the bar (this should be smaller than the smallest part of the hole for clearance).
bar_diameter = 5;//[1:20]

// Length of the hook bar (slightly larger than keyhole material thickness).
bar_depth = 2;//[1:10]

/* [Hidden] */

edge_radius = 1;

main(); //runs program

module main(){

	translate( [-wall_thickness / 2, front_height / 2, hanger_width / 2 + edge_radius / 2] ) rotate( a=[ 90, 0, 0] ) {
		//Top
		translate( [( wall_thickness + hanger_thickness ) / 2, 0, 0] ) {
			roundedRect( size = [( wall_thickness + 2 * hanger_thickness ), hanger_width, hanger_thickness], radius = edge_radius );
		}

		//Back
		translate( [0, 0, hanger_thickness] ) {
			roundedRect( size = [hanger_thickness, hanger_width, back_height], radius = edge_radius );
		}

		//Front
		difference() {
			translate( [( wall_thickness + hanger_thickness ), 0, hanger_thickness] ) roundedRect( size = [hanger_thickness, hanger_width, front_height], radius = edge_radius );
			translate( [( wall_thickness + 1.5 * hanger_thickness + hook_depth + bar_depth ), 0, ( front_height - ( hook_diameter / 2 ) + hook_depth - 0.5 * hanger_thickness )] ) rotate(a=[0, 270, 0]) cylinder( h = bar_depth + 2 * hanger_thickness, r = ( bar_diameter / 2 ), $fn = $cf );
		}
	}

	//Hooks
	drawHook();
}

module drawHook() {

	large_radius = ( hook_diameter / 2 );
	small_radius = ( bar_diameter / 2 );

	cylinder( h = hook_depth, r1 = large_radius, r2 = large_radius, $fn = $cf );

	translate( [ 0, 0, hook_depth ] ) {

		cylinder( h = bar_depth + hanger_thickness, r1 = small_radius, r2 = small_radius, $fn = $cf );

		intersection() {

			translate( [0, -small_radius, 0] ) {
				cube( [hook_diameter, bar_diameter, bar_depth] );
			}

			cylinder( h = bar_depth, r1 = large_radius, r2 = large_radius, $fn = $cf );
		}
	}
}

module roundedRect( size, radius ) {

	x = size[0];
	y = size[1];
	z = size[2];

	linear_extrude( height = z )

	hull() {

		// place 4 circles in the corners, with the given radius
		translate( [( -x / 2 ) + ( radius / 2 ), ( -y / 2 ) + ( radius / 2 ), 0] ) circle( r = radius );

		translate( [( x / 2 ) - ( radius / 2 ), ( -y / 2 ) + ( radius / 2 ), 0] ) circle( r = radius );

		translate( [( -x / 2 ) + ( radius / 2 ), ( y / 2 ) - ( radius / 2 ), 0] ) circle( r = radius );

		translate( [( x / 2 ) - ( radius / 2 ), ( y / 2 ) - ( radius / 2 ), 0] ) circle( r = radius );
	}
}