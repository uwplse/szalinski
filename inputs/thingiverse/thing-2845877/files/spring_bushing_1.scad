spring_diameter = 8;
spring_wire_diameter = 1;
screw_diameter = 3.2;
bottom_thickness = 2 * 0.4;
bushing_height = 4;
bushing_inner_diameter = spring_diameter - 2 * spring_wire_diameter;
bushing_outer_diameter = spring_diameter;
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
    }
}

module screwHole() {
    cylinder(h = 4 * bushing_height, d = screw_diameter, center = true);
}
