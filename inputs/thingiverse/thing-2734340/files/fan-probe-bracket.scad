$fn=100;

hole_spacing = 32;
hole_size = 3.4;	// screw hole size
fanSize = 40; // Length of the fan edge
outer_circle_diameter = 36;	// diameter of actual fan
inner_circle_diameter = 16;	// diameter of center support circle
vane_count = 3;			// whatever you like here.
vane_width = 2;
ring_count = 0;
ring_width = 2;


sheetThickness = 1; // Thiknes of the lateral holder sheets
fanThickness = 11.1; // Thicknes of the fan
frontBackThickness = 1; // Thiknes of the front and back parts of the holder
probeDiameter = 18; // Diameter of the probe
probeHolderWidth = 4;
probeHolderThickness = 12; // Distance between hoder and probe
holderVerticalOffset = 0;
holderHorizontalOffset = -1;

union() {
    translate([0, 0, -sheetThickness])
        cpu_fan_grille(hole_spacing=hole_spacing, hole_size=hole_size, outer_size=fanSize, corner_cut_radius=fanSize, outer_circle_diameter=outer_circle_diameter, inner_circle_diameter=inner_circle_diameter, outer_thickness=sheetThickness, inner_thickness=sheetThickness, vane_count=vane_count, vane_width=vane_width, ring_count=ring_count, ring_width=ring_width);
    translate([0, 0, fanThickness])
        cpu_fan_grille(hole_spacing=hole_spacing, hole_size=hole_size, outer_size=fanSize, corner_cut_radius=fanSize, outer_circle_diameter=outer_circle_diameter, inner_circle_diameter=inner_circle_diameter, outer_thickness=sheetThickness, inner_thickness=sheetThickness, vane_count=vane_count, vane_width=vane_width, ring_count=ring_count, ring_width=ring_width);
    translate([-(frontBackThickness+(fanSize/2)), -fanSize/2, -sheetThickness])
        cube([frontBackThickness, 40, fanThickness+(2*sheetThickness)]);
    translate([fanSize/2, -fanSize/2, -sheetThickness])
        cube([frontBackThickness, 40, fanThickness+(2*sheetThickness)]);
    translate([-(frontBackThickness+(fanSize/2)), (fanSize/2)-holderVerticalOffset, holderHorizontalOffset])
        probeHolder();
}


module probeHolder() {
    externalDiameter = probeDiameter+(2*probeHolderWidth);
    rotate([90, 0, 0])
        translate([-externalDiameter/2, 0, 0])
            difference() {
                union() {
                    cylinder(d=externalDiameter, h=probeHolderThickness);
                    translate([0, -externalDiameter/2, 0])
                        cube(size=[externalDiameter/2, externalDiameter, probeHolderThickness]);
                }
                cylinder(d=probeDiameter, h=probeHolderThickness);
            }
}

module cpu_fan_grille(hole_spacing = 32, hole_size = 3.4, outer_size = 40, corner_cut_radius = 40, outer_circle_diameter = 36, inner_circle_diameter = 16, outer_thickness = 1, inner_thickness = 1, vane_count = 3, vane_width = 2, ring_count = 0, ring_width = 2) {
    // some calculated values
    vane_angle = 360 / vane_count;
    // ring_spacing defines the CENTER of each ring (radius)
    ring_spacing = (outer_circle_diameter - inner_circle_diameter+ring_width)/(ring_count+1)/2;
    //ring_spacing = outer_circle_diameter;

	union() {
        // outer mounting ring is a cube minus the cutouts
        difference() {
            intersection() {
                translate(v=[-outer_size/2, -outer_size/2,0])
                    cube(size=[outer_size, outer_size, outer_thickness]);
                cylinder(r=corner_cut_radius, h=outer_thickness);
            }
            // cut the screw holes
            translate(v=[hole_spacing/2, hole_spacing/2, 0])
                cylinder(h=outer_thickness, r=hole_size/2);
            translate(v=[-hole_spacing/2,- hole_spacing/2, 0])
                cylinder(h=outer_thickness, r=hole_size/2);
            translate(v=[hole_spacing/2,- hole_spacing/2, 0])
                cylinder(h=outer_thickness, r=hole_size/2);
            translate(v=[-hole_spacing/2, hole_spacing/2, 0])
                cylinder(h=outer_thickness, r=hole_size/2);

            // cut the main center hole
            cylinder(h=outer_thickness, r=outer_circle_diameter/2);
        }
        // the inner circle
        cylinder(h=inner_thickness, r=inner_circle_diameter/2);
        // rotate for aesthetics
        rotate([0,0,vane_angle/2])
        for (angle = [0 : vane_angle : 360] ) {
            rotate([0,0,angle])
            translate(v=[0,-vane_width/2,0])
            cube(size=[outer_circle_diameter/2, vane_width, inner_thickness]);
        }
        // circles
        for (x = [1 : ring_count ]) {
            difference() {
                cylinder(h=inner_thickness, r=inner_circle_diameter/2 + (ring_spacing * x) + (ring_width/2));
                cylinder(h=inner_thickness, r=inner_circle_diameter/2 + (ring_spacing * x) - (ring_width/2));
            }
        }
	}
}