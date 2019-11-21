// The inner diameter of the large end of the adapter. This is the outer diameter of the larger of the two hoses you're connecting.
param_from = 102.75;

// The inner diameter of the small end of the adapter. This is the outer diameter of the smaller of the two hoses you're connecting.
param_to = 30.75;

// The total height of the adapter.
param_height = 60;

// The thickness of the adapter walls.
param_wall_thickness = 2;

// The height of each of the top and bottom vertical bands of the adapter.
param_band_height = 10;

module funnel(from, to, height, wall_thickness, band_height) {
	// Bottom band.
	difference() {
		cylinder(r=(from/2)+wall_thickness, h=band_height);
		cylinder(r=(from/2), h=band_height);
	}

	// Funnel.
	translate([0, 0, band_height]) difference() {
		cylinder(r1=(from/2)+wall_thickness, r2=(to/2)+wall_thickness, h=height-(2*band_height));
		cylinder(r1=(from/2), r2=(to/2), h=height-(2*band_height));
	}

	// Top band.
	translate([0, 0, height-band_height]) difference() {
		cylinder(r=(to/2)+wall_thickness, h=band_height);
		cylinder(r=(to/2), h=band_height);
	}
}

$fa = 1;
$fs = 1;

funnel(from=param_from, to=param_to, height=param_height, wall_thickness=param_wall_thickness, band_height=param_band_height);