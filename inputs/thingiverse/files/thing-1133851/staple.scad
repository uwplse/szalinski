/* [Hidden] */
$fn=30;

/* [Parameters] */
//nail diameter plus extra for hole dialation (add 0.6 for most printers)
nail_diameter = 1.8;
//width of the staple opening
staple_spacing = 11;
//depth of the staple opening
staple_cutout_depth = 3;

/* [Advanced Parameters] */
//radius of staple cutout
staple_radius = 2;
//thickness around nail hole
thickness = 2;
//thickness above cutout
top_thickness = 2;

ct = nail_diameter+2*thickness;
translate([-staple_spacing/2-ct/2,0,staple_cutout_depth+top_thickness])
rotate([180,0,0])
difference() {
	$fn=30;
	hull() {
		cylinder(d=ct,h=staple_cutout_depth+top_thickness);
		translate([staple_spacing+ct,0 ,0 ])
		cylinder(d=ct,h=staple_cutout_depth+top_thickness);
	}
	cylinder(d=nail_diameter,h=3*(staple_cutout_depth+thickness),center=true);
	translate([staple_spacing+ct,0 ,0 ])
	cylinder(d=nail_diameter,h=3*(staple_cutout_depth+thickness),center=true);
	hull() {
		translate([ct/2+staple_radius,0,staple_cutout_depth-staple_radius])
		rotate([90,0,0])
		cylinder(r=staple_radius,h=ct+5 , center=true);
		translate([ct/2-staple_radius+staple_spacing,0,staple_cutout_depth-staple_radius])
		rotate([90,0,0])
		cylinder(r=staple_radius,h=ct+5 , center=true);
		translate([ct/2+staple_radius,0, 0])
		rotate([90,0,0])
		cylinder(r=staple_radius,h=ct+5 , center=true);
		translate([ct/2-staple_radius+staple_spacing,0,0])
		rotate([90,0,0])
		cylinder(r=staple_radius,h=ct+5 , center=true);;
	}
}
