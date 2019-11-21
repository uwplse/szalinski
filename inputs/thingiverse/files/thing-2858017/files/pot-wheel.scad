// An assembly to adjust a pair of potentiometers using a thumbwheel. This is
// designed to be embedded in a housing of some sort, so the housing is
// minimal and just holds everything together. A thin piece of sheet metal
// (1mm or so) is used ans an axle, post are used as bearings.

// Designed for standart small 10KOhm pots, such as uxcell a14052600ux1117
// with the body of 7x6.5x4mm and three terminals.

// Keep in mind that pots rotate in opposite directions when the thumbwheel
// is turned, so hthey need to be wired differently.

// pot_wheel builds the wheel, pot_housing builds the housing. Set do_build
// to 0 to see the wheel positioned in the base, set to 1 for getenrating
// build file.

// By Nenad Rijavec
// Feel free to use and modify as you see fit.

do_build = 1 ;
wheel_w = 5 ;
wheel_d = 30 ;
pot_l = 6.5 ;
pot_h = 8 ;
pot_thickness = 11 ;
housing_wall = 2 ;
housing_h = pot_h + housing_wall ;
housing_w = wheel_w + 2 + 2*housing_wall ;
housing_l = wheel_d + 2 + 2*housing_wall ;

module pot_wheel()
{
	difference() {
		cylinder( wheel_w, d=wheel_d, $fn=100 ) ;
		translate( [ 0, 0, -1 ] )
		union() {
			// slot for the axle
			translate( [ -0.75, -3, 0 ] ) 
				cube( [ 1.5, 6, wheel_w+2 ] ) ;
			// wheel perimeter structure for betetr grip
			for ( i=[ 0:35 ] ) {
				rotate( [ 0, 0, 10*i ] )
				translate( [ -1.00+wheel_d/2, 0, 0 ] )
				linear_extrude( height = wheel_w + 2 ) 
				polygon( points=[ [ 0, 0 ], 
						[ 1.4, -1.0 ],
						[ 1.4, 1.0 ] ] );
			}
		}
	}
}

module pot_housing()
{
	difference() {
		union() {
			cube( [ housing_w, housing_l, housing_h ] ) ;
			translate( [ -4, (housing_l-pot_l)/2-3, 0 ] )
					cube( [ 4, 6+pot_l, housing_h ] ) ;
			translate( [ housing_w, (housing_l-pot_l)/2-3, 0 ] )
					cube( [ 4, 6+pot_l, housing_h ] ) ;
		}
		union() {
			translate( [ housing_wall, housing_wall,
			-1 ] ) 
			cube( [ housing_w-2*housing_wall,
				housing_l - 2 * housing_wall,
				housing_h+2 ] ) ;
			translate( [ -housing_w-1,
				(housing_l-pot_l)/2,
			 	housing_wall ] )
					cube( [ housing_w +
					2*pot_thickness+2,
						pot_l,
						housing_h ] ) ;
		}
	}
}

if( do_build ) {
	pot_wheel() ;
	translate( [ 13+wheel_d/2, 0, 0 ] )
	pot_housing() ;
} else {
	translate( [ -1, housing_l/2, housing_wall+pot_h/2 ] )
		rotate( [ 0, 90, 0 ] )
		pot_wheel() ;
	translate( [ 1.5-housing_w/2, 0, 0 ] ) pot_housing() ;
}


// nenad me fecit
