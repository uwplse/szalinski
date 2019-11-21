// CSG file generated from FreeCAD Export 0.1d

// variable description
spacer_height = 12; // possible values
spacer_diameter = 8; // 
inner_diameter = 5; //
rim_diameter = 12; //
rim_height = 1.5;

// Cylinder
difference() {
	// Outer Cylinder
	cylinder(h = spacer_height, d= spacer_diameter, $fn=50);
	// Inner Cylinder
	cylinder(h = spacer_height, d= inner_diameter, $fn=50);
}

// RIM
difference() {
	cylinder(h = rim_height, d= rim_diameter, $fn=50);
	// Inner Cylinder
	cylinder(h = spacer_height, d= inner_diameter, $fn=50);
}

