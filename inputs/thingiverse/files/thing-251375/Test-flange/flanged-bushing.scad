//CUSTOMIZER VARIABLES

// Inner radius
inner_radius = 2;

// Flange radius
flange_radius = 10;

// Bushing radius
bushing_radius = 4;

// Bushing height
bushing_height = 20;

// Flange height
flange_height = 2;

//CUSTOMIZER VARIABLES END

total_height = flange_height + bushing_height;

$fs=1;

module bushing() {
	// Flange
	cylinder(h=flange_height, r=flange_radius);
	// Bushing
	cylinder(h=total_height, r=bushing_radius);
};

difference() {
	bushing();
	//Center hole
	cylinder(h=total_height, r=inner_radius);
};
