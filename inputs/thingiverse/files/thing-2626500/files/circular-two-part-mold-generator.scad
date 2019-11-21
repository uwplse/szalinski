/*************************************************
 Parametric circular two-part mold generator
 Author: Jason Webb
 Website: http://jason-webb.info
*************************************************/
// Model parameters
model_filename = "Tire- Slick.stl";
model_rotate = [0,0,90];
model_translate = [0,0,-6];
model_scale = 1;

// Mold parameters
mold_diameter = 38;
mold_height = 12;
mold_spacing = 5;

// Pour hole parameters
pour_hole_translate = [0,0,0];
pour_hole_rotate = [90,0,-90];
pour_hole_r1 = 3.5;
pour_hole_r2 = 3.5;
pour_hole_height = 0;//DEFALT IS 50, I set to 0 for this particular mold

// Registration marks parameters
key_size = 4;
key_margin = 10;
key_fettle = 0.4;
master_key_size = [6,6,4];

side_by_side();

/****************************************
 Rotate and place both halves side by side 
 along the X axis for easy single-plate printing
*****************************************/
module side_by_side() {
	// Rotate about the Z axis to align parts with X axis - helps when printing
	rotate([0,0,90]) {
		// Scoot the left half over a bit
		translate([0, -mold_diameter - mold_spacing/2, mold_height])
			bottom_half();
		
		// Rotate the top half, then scoot it over a bit
		rotate([0,180,0])
			translate(v = [0, mold_diameter + mold_spacing/2, -mold_height])
				top_half();	
	}
}

/*******************************************
 Bottom half of the mold
********************************************/
module bottom_half() {
	// Create the mold form with negative keys
	difference() {

		// Create the basic mold form by subtracting the STL from a cube half it's size
		difference() {
			translate([0,0,-mold_height])
				cylinder(r1 = mold_diameter, r2 = mold_diameter, mold_height);

			scale(model_scale)	
				translate(model_translate)
					rotate(model_rotate)
						import(model_filename);
		}

		// Key 1 (negative)
		translate([-mold_diameter/2 + key_margin, -mold_diameter + key_margin, 0])
			sphere(key_size + key_fettle, $fn = 30);

		// Key 2 (negative)
		translate([mold_diameter/2 - key_margin, mold_diameter - key_margin, 0])
			sphere(key_size + key_fettle, $fn = 30);

		// Pour hole
		translate(pour_hole_translate)
			rotate(pour_hole_rotate)
				cylinder(pour_hole_height, pour_hole_r1, pour_hole_r2);
	}

	// Key 3 (positive)
	translate([-mold_diameter/2 + key_margin, mold_diameter/2 + key_margin, 0])
		sphere(key_size, $fn = 30);

	// Key 4 (positive)
	translate([mold_diameter/2 - key_margin, -mold_diameter/2 - key_margin, 0])
		sphere(key_size, $fn = 30);
}

/*******************************************
 Top half of the mold
********************************************/
module top_half() {
	// Create the mold form with negative keys
	difference() {

		// Create the mold form by subtracting the STL from a cube half it's size
		difference() {
			translate([0,0,0])
				cylinder(r1 = mold_diameter, r2 = mold_diameter, mold_height);

			scale(model_scale)
				translate(model_translate)
					rotate(model_rotate)
						import(model_filename);
		}

		// Key 3 (negative)
		translate([-mold_diameter/2 + key_margin, mold_diameter/2 + key_margin, 0])
			sphere(key_size + key_fettle, $fn = 30);

		// Key 4 (negative)
		translate([mold_diameter/2 - key_margin, -mold_diameter/2 - key_margin, 0])
			sphere(key_size + key_fettle, $fn = 30);

		// Pour hole
		translate(pour_hole_translate)
			rotate(pour_hole_rotate)
				cylinder(pour_hole_height, pour_hole_r1, pour_hole_r2);
	}

	// Key 1 (positive)
	translate([-mold_diameter/2 + key_margin, -mold_diameter + key_margin, 0])
		sphere(key_size, $fn = 30);

	// Key 2 (positive)
	translate([mold_diameter/2 - key_margin, mold_diameter - key_margin, 0])
		sphere(key_size, $fn = 30);

}
