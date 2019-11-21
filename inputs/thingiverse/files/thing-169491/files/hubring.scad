$fn=256;

// Main diameters:
inner = 56.6;
outer = 67.1;

// Tuning parameters:
clearance = 0.3;     // Inner clearance
height = 6.5;
cone = 2;           // Thickness and height of the conical flange
inner_cone = 1;     // Inner bevel
ridge_displacement = 3;
ridge_thickness = 0.25;
ridge_height = 2;

hole = inner / 2 + clearance;

difference() {
    union () {
	cylinder(r=outer/2, h=height);
	cylinder(r1=(outer + 2*cone)/2, r2=outer/2, h=cone);
	translate([0,0, ridge_displacement])
            cylinder(r=outer/2 + ridge_thickness, h=ridge_height);
    }
    union() {
	translate([0,0, -0.5]) cylinder(r=hole, h=height + 1);
	translate([0,0, -0.01])
            cylinder(r1=hole + inner_cone, r2=hole, h=inner_cone);
    }
}

