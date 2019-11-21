include <helix_extrude.scad>

spring_diameter = 8;
spring_wire_diameter = 1;
screw_diameter = 3.2;
bottom_thickness = 2 * 0.4;
bushing_height = 4;
bushing_inner_diameter = spring_diameter - 2 * spring_wire_diameter;
bushing_outer_diameter = spring_diameter;
spiral_pitch = spring_wire_diameter;
spiral_inner_radius = screw_diameter / 2;
spiral_outer_radius = bushing_outer_diameter / 2;
$fn = 500;

main();

module main() {
    difference() {
        base();

        screwHole();
    }
}

module base() {
    union() {
        cylinder(h = bushing_height, d = bushing_inner_diameter);
        cylinder(h = bottom_thickness, d = bushing_outer_diameter);
        ramp();
    }
}

module screwHole() {
    cylinder(h = 4 * bushing_height, d = screw_diameter, center = true);
}

module ramp() {
    translate([0,0,bottom_thickness])
    difference() {
        translate([0, 0, -spiral_pitch])
        helix_extrude(height=spiral_pitch)
            translate([spiral_inner_radius, 0, 0])
                square(size=[spiral_outer_radius - spiral_inner_radius,1]);
        translate([0,0,-spiral_outer_radius])
        cube(size = 2*spiral_outer_radius, center = true);
    }
}
