//Make this slightly larger than actual pen size for a good tolerance
pencil_hole_diameter = 6; 

//make this one slightly smaller than the hole for press fit
adapter_size_diameter = 7.85; 

//Defines how long into the mount the plug goes, about 5-10mm is good for stability
Insert_length = 7.5;

// Use same diameter as in the mount
collar_diameter = 10; 

// Any height will do, about 2mm is good
collar_height = 2;



difference() {
	union() {
		cylinder(h = collar_height, r1 = collar_diameter/2, r2 = collar_diameter/2, center = false);
		translate([0, 0, collar_height]) cylinder(h = Insert_length, r1 = adapter_size_diameter/2, r2 = adapter_size_diameter/2, center = false);
	}
	translate([0, 0, -1]) cylinder(h = (Insert_length+collar_height)+2, r1 = pencil_hole_diameter/2, r2 = pencil_hole_diameter/2, center = false);
}