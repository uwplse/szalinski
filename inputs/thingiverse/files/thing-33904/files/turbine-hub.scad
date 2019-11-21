/*

Whirlygig - A flying toy

Stick a hexagonal pencil in the middle, and stick 6 tongue depressors in each slot (glue advised!)

Spin the whirlygig counter clockwise in your hands and let go!

Jesse Parker 2012

November 2018 
Updating as a customizer

*/
// Number of blades
blades = 6;
// Angle of blades ( -90 - 90 )
blade_pitch = -65;

// Blade size defaults for a tounge depressor
blade_width = 1.8;
blade_height = 20;
blade_length = 100;

blade_support_t = .5;
blade_support_l = 22;
blade_support_h = 4;

// How close should the blades get to the axle
blade_axle_margin=1.5;

// Shaft hexagon diameter (outscribed) e.g. corner-to-corner
pencil_diameter = 7.4;
//axle_diameter = 6;



blade_angle = 360 / blades;


hub_height = max( (blade_height+(blade_support_h*2))*cos(abs(blade_pitch)), blade_width+(blade_support_t*2));

hub_radius = ( (blade_height+(blade_support_h*2))*sin(abs(blade_pitch)) )/2 + ((blade_width + (blade_support_t*2)) * sin(abs(blade_pitch)))/2;

//axle_diameter = pencil_diameter/cos(30);
axle_diameter = pencil_diameter;
//echo axle_diameter;



difference() {

difference () {
union() {
	cylinder(h = 20, r=val, center=true);

	cylinder(h = hub_height, r = hub_radius, center=true);

	for (i = [0:blades-1]) {

		rotate(blade_angle*i, [0,0,1]) {

			rotate(blade_pitch, [1,0,0]) {
//				translate([axle_diameter+(blade_support_l/2),0,0]) cube([blade_support_l,(blade_width + blade_support_t)*2,blade_height+(blade_support_h*2)], center=true);
				translate([(blade_support_l/2),0,0]) cube([blade_support_l,(blade_width + blade_support_t)*2,blade_height+(blade_support_h*2)], center=true);
			}
		}
	}

}

	for (i = [0:blades-1]) {

		rotate(blade_angle*i, [0,0,1]) {

			rotate(blade_pitch, [1,0,0]) {
				translate([(axle_diameter/2)+(blade_length/2)+blade_axle_margin,0,0])
                    cube([blade_length,blade_width,blade_height], center=true);
			}
		}

}

}


translate([0,0,hub_height/2+5]) { cube([150,150,10], center=true); }
translate([0,0,-hub_height/2-5]) { cube([150,150,10], center=true); }

union() {
cube([pencil_diameter, pencil_diameter/tan(60), 100], center = true);
rotate(60, [0,0,1]) { cube([pencil_diameter, pencil_diameter/tan(60), 100], center = true);}
rotate(120, [0,0,1]) { cube([pencil_diameter, pencil_diameter/tan(60), 100], center = true);}
}
}