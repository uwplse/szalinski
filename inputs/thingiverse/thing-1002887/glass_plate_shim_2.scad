//Thickness of the shim, in millimeters. Theoretically should be the thickness of your glass plate, though I have to subtract about 0.4mm for my printer for some reason. My glass plate is 2.2mm thick.
shim_thickness = 1.8;

$fn = 24 * 1;

module rounded_square(dims, r=2, thickness=1) {
hull() {
translate([0, 0, thickness * 0.5]) {
	translate([dims[0] * -0.5, dims[1] * -0.5, 0]) cylinder(r=r, h=thickness, center=true);
	translate([dims[0] * +0.5, dims[1] * -0.5, 0]) cylinder(r=r, h=thickness, center=true);
	translate([dims[0] * -0.5, dims[1] * +0.5, 0]) cylinder(r=r, h=thickness, center=true);
	translate([dims[0] * +0.5, dims[1] * +0.5, 0]) cylinder(r=r, h=thickness, center=true);
}
}
}


rounded_square([10, 10], thickness=plate_thickness);
