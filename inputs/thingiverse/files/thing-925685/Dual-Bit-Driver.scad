/* [Handle] */

// (total tool length in mm)
length = 100;

// (minimum wall thickness in mm)
side_thickness = 1;

// (number of sides)
handle_sides = 18; //  [6:6:60]

// (multiplier of bit radius)
handle_thickness = 1.25;

// (wiggle room for the bits in mm)
tolerance = 0.3;

/* [Bit 1] */

// (in mm)
bit1_socket_diameter = 6.35;

// (in mm)
bit1_socket_depth = 9;

// (in mm)
bit1_magnet_diameter = 4.7625;

// (in mm)
bit1_magnet_depth = 3.175;

/* [Bit 2] */

// (in mm)
bit2_socket_diameter = 3.96875;

// (in mm)
bit2_socket_depth = 18;

// (in mm)
bit2_magnet_diameter = 3.175;

// (in mm)
bit2_magnet_depth = 3.175;

bit1_socket_radius = ( bit1_socket_diameter + tolerance ) / 2;
bit1_socket_height = bit1_socket_depth + bit1_magnet_depth;
bit1_inner_radius = bit1_socket_radius / cos( 180 / 6 );
bit1_external_radius = bit1_inner_radius + side_thickness;

bit2_socket_radius = ( bit2_socket_diameter + tolerance ) / 2;
bit2_socket_height = bit2_socket_depth + bit2_magnet_depth;
bit2_inner_radius = bit2_socket_radius / cos( 180 / 6 );
bit2_external_radius = bit2_inner_radius + side_thickness;

difference(){
    hull(){
        cylinder( h = length, r1 = bit1_external_radius, r2 = bit2_external_radius, $fn = 6 );
        translate( v = [ 0, 0, bit1_socket_depth / 1.5 ] ){
            cylinder( h = ( length - ( ( bit1_socket_depth + bit2_socket_depth ) / 1.5 ) ), r1 = bit1_external_radius * handle_thickness, r2 = bit2_external_radius * handle_thickness, $fn = handle_sides );
        }
    }        
	translate( v = [ 0, 0, -1 ] ){
        cylinder( h = bit1_socket_depth + 1, r = bit1_inner_radius, $fn = 6 );
	}
	translate( v = [ 0, 0, -1 ] ){
        cylinder( h = bit1_socket_depth + bit1_magnet_depth + 1, r = ( bit1_magnet_diameter + tolerance ) / 2, $fn = 24 );
	}
	translate( v = [ 0, 0, length - bit2_socket_depth ] ){
        cylinder( h = bit2_socket_depth + 1, r = bit2_inner_radius, $fn = 6 );
	}
	translate( v = [ 0, 0, length - ( bit2_socket_depth + bit2_magnet_depth ) ] ){
        cylinder( h = bit2_socket_depth + bit2_magnet_depth + 1, r = ( bit2_magnet_diameter + tolerance ) / 2, $fn = 24 );
	}
}