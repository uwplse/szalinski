// Scoop size (#of Tablespoons)
num_tablespoons = 1; // 1, 2, 3, 4

// Handle Length (mm)
handle_length    = 80;

// Handle Width (mm)
handle_width     = 10;

// Handle Thickness (mm)
handle_thickness = 3;

// Grip Width (mm)
grip_width = 15;

volume = 14787*2*num_tablespoons;
radius = pow((volume * 3) / (4 * 3.1415), 1/3);
echo(radius);

coffee_scoop();

$fn=50;
module coffee_scoop() {

	difference() {

		union() { // objects to add to the design
			sphere(r=radius+2, center=true);
			translate([handle_length/2 + radius, 0, handle_thickness/2]) 
					cube([handle_length, handle_width, handle_thickness], center = true);
			translate([handle_length   + radius, 0, handle_thickness/2]) 
					cylinder(h=handle_thickness, r=grip_width/2, center=true);
		}

		union() { // object to subtract from the design
			translate([0,0,-(radius+2)]) cube([(radius+2)*2, (radius+2)*2, (radius+2)*2], center=true);
			sphere(r=radius, center=true);
		}
	}

}