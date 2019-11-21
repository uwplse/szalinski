// openscad model by markwal
// modeled on thing:613685 by jherridge
// dimensions in mm

// Do you want tabs to hold the glass or a full corner?
full_corner=0;  // [0:tabs,1:full corner]

// (mm) a thicker base requires a longer screw
base_thickness=4;

// (mm) thickness of your build platform before the glass is added (both the heater and the aluminum)
heated_bed_thickness=10;

// (mm) thickness of the glass plate rounded down
glass_thickness=2;

// (mm) width of the bolt slot
bolt_diameter=3;

// overhang is the space on each side where the aluminum plate
// is bigger than the glass plate.  Round up because that 
// will just leave some air between the edge of the plate 
// and the clip.  Rounding down will leave play for the glass.

// (mm) the overhang pushes on the glass to hold it in place, the smaller the glass (in x and y) the more overhang you need
overhang=2;

union() {

difference() {
	// base
	cube([24,24,base_thickness]);

	// slot
	rotate([0,0,-45]) 
	translate([0,8,0]) hull() {
		translate([0,18,0])
			cylinder(h=base_thickness,d=bolt_diameter, $fn=30);
		cylinder(h=base_thickness,d=bolt_diameter,$fn=30);
	}
}

// we make the towers completely overlap the base and
// the overhang in order to avoid problems generating
// the mesh when rounding may have the faces not overlap
translate([12*(1-full_corner),0,0])
	cube([12*(1+full_corner),5,base_thickness+heated_bed_thickness+glass_thickness]);
translate([12*(1-full_corner),0,base_thickness+heated_bed_thickness])
	cube([12*(1+full_corner),5+overhang,glass_thickness]);

translate([0,12*(1-full_corner),0])
	cube([5,12*(1+full_corner),base_thickness+heated_bed_thickness+glass_thickness]);
translate([0,12*(1-full_corner),base_thickness+heated_bed_thickness])
	cube([5+overhang,12*(1+full_corner),glass_thickness]);
}