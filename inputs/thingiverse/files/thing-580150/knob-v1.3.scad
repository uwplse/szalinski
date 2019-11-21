// preview[view:south, tilt:top diagonal]



/* [Knob] */
// Knob width (total length)
knob_width						= 38;

// Knob height (total height)
knob_height						= 13;

// Knob wall size (default = 2.6)
knob_wall						= 2.6;

// Knob wall stripes (number of stripes, 0=off)
knob_wall_stripes				= 0; // eg 60

// Knob wall stripes size
knob_wall_stripes_size		= 0.6; // eg 0.6

// Inner support
knob_support					= "yes"; // [yes,no]

// Inner support height (0=auto)
knob_support_height			= 0;

// Center width (total hole width)
knob_adapter_width			= 3.6;

// Center height (total hole height, 0=auto)
knob_adapter_height			= 0;

// Center structured (gear style)
knob_adapter_structure		= "yes"; // [yes,no]

// Center fine structure (no is better for smaller diameters)
knob_adapter_structure_fine= "yes"; // [yes,no]




/* [Hidden] */
knob_adapter_radius			= knob_adapter_width/2;
knob_radius						= knob_width/2;

e									= .05;
res								= 128;



// basic knob
difference() {
	union() {
		for(i = [1:(knob_wall/2)*10]) {
			echo ( i, " <> ",  (knob_radius-knob_wall/2)+i/10, " <> ", i*0.1 );
			translate([0, 0, 0.1*i]) cylinder(r=(knob_radius-knob_wall/2)+i/10, h=0.1, $fn=res);
		}
		translate([0, 0, knob_wall/2]) cylinder(r=knob_radius, h=knob_height-knob_wall/2, $fn=res);
	}


	translate([0, 0, knob_wall]) cylinder(r=knob_radius-knob_wall, h=knob_height-knob_wall+e, $fn=res);


	// wall stripes
	if(knob_wall_stripes > 0) {
		for(i=[1:knob_wall_stripes]) {
			rotate([0,0,i*360/knob_wall_stripes]) translate([knob_width/2*-1, -knob_wall/4, 0]) cube([knob_wall_stripes_size, knob_wall_stripes_size, knob_height+e]);
		}
	}
}



// knob adapter
difference() {
	union() {
		// inner support
		if(knob_support == "yes") {
			if(knob_support_height == 0) {
				translate([(knob_radius-knob_wall)*-1, knob_wall/2*-1, knob_wall]) cube([(knob_radius-knob_wall)*2, knob_wall, knob_height-knob_wall*2]);
				rotate([0, 0, 90]) translate([(knob_radius-knob_wall)*-1, knob_wall/2*-1, knob_wall]) cube([(knob_radius-knob_wall)*2, knob_wall, knob_height-knob_wall*2]);
			} else {
				translate([(knob_radius-knob_wall)*-1, knob_wall/2*-1, knob_wall]) cube([(knob_radius-knob_wall)*2, knob_wall, knob_support_height]);
				rotate([0, 0, 90]) translate([(knob_radius-knob_wall)*-1, knob_wall/2*-1, knob_wall]) cube([(knob_radius-knob_wall)*2, knob_wall, knob_support_height]);


			}
		}

		// inner circle
		if(knob_adapter_height == 0) {
			translate([0, 0, knob_wall]) cylinder(r=knob_adapter_radius+knob_wall, h=knob_height-knob_wall*2, $fn=res);
		} else {
			translate([0, 0, knob_wall]) cylinder(r=knob_adapter_radius+knob_wall, h=knob_adapter_height, $fn=res);
		}
	}

	if(knob_adapter_height == 0) {
			translate([0, 0, knob_wall]) cylinder(r=knob_adapter_radius, h=knob_height-knob_wall*2+e, $fn=res);
	} else {
			translate([0, 0, knob_wall]) cylinder(r=knob_adapter_radius, h=knob_adapter_height+e, $fn=res);
	}

	if(knob_adapter_structure == "yes") {
		if(knob_adapter_structure_fine == "yes") {
			for(i = [1:20]) {
				if(knob_adapter_height == 0) {
					rotate([0, 2, 18*i]) translate([0, 0, knob_wall]) cube([knob_adapter_radius/3.1415926, knob_adapter_radius, knob_height-knob_wall*2+e]);
				} else {
					rotate([0, 2, 18*i]) translate([0, 0, knob_wall]) cube([knob_adapter_radius/3.1415926, knob_adapter_radius, knob_adapter_height+e]);
				}

			}
		} else {
			for(i = [1:15]) {
				if(knob_adapter_height == 0) {
					rotate([0, 2, 24*i]) translate([0, 0, knob_wall]) cube([knob_adapter_radius/3.1415926, knob_adapter_radius, knob_height-knob_wall*2+e]);
				} else {
					rotate([0, 2, 24*i]) translate([0, 0, knob_wall]) cube([knob_adapter_radius/3.1415926, knob_adapter_radius, knob_adapter_height+e]);
				}
			}
		}
	}
}



