//cross-section size of coupler
cross_section = 18;
//length of each spoke of the coupler
coupler_length = 25;
//diameter of the tube hole
pipe_diameter = 11.1;
//diameter of the screw hole, 0 for none
screw_diameter = 2.8;
//type of coupler to make
coupler_type = 2;//[1: Straight, 2: L-coupler, 3: T-coupler, 4: Cross coupler]
//resolution (Segments per circle)
$fn=55;
module base_shape() {
    translate([0, 0, -0.1])//may be unnecessary - ensure no gaps in shape
    difference()
    {
        linear_extrude(height = coupler_length)
            square(cross_section);
        translate ([cross_section / 2, cross_section / 2, coupler_length * 0.11])
            cylinder(d = pipe_diameter, h= (coupler_length * 0.90));
        screw_hole();
    };
}

module screw_hole() {
    translate([cross_section / 2, cross_section / 2, cross_section * 0.75])
        rotate([-90, 0, 180])
            cylinder(d = screw_diameter, h = cross_section);
}

module straight_coupler() {
    union() {
        translate([cross_section, 0, cross_section])
        rotate([90, 180, 0])
                base_shape();
        translate([0, 0, cross_section])
            rotate([-90, 0, 0])
            base_shape();
    }
}

module l_coupler() {
       union() {
        translate([cross_section, 0, cross_section])
        rotate([90, 180, 90])
                base_shape();
        translate([0, 0, cross_section])
            rotate([-90, 0, 0])
            base_shape();
        translate([0, -cross_section, 0])
           cube(cross_section);
    } 
}

module t_coupler() {
    union () {
        straight_coupler();
        translate([0, -cross_section / 2, cross_section])
            rotate([-90, 0, 90])
            base_shape();
    }
}

module x_coupler() {
        union () {
        t_coupler();
        translate([cross_section, cross_section / 2, cross_section])
            rotate([-90, 0, -90])
            base_shape();
    }
}

if (coupler_type == 1) {
    straight_coupler();
} else if (coupler_type == 2) {
    l_coupler();
} else if (coupler_type == 3) {
    t_coupler();
} else if (coupler_type == 4) {
    x_coupler();
} else {
    echo("Invalid coupler type selected!");
}