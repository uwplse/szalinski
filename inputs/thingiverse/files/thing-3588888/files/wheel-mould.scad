// Which part to produce
part = "both"; // [outside:Outside only,inside:Inside only,both:Outside and inside]

// The diameter of the hole in the bottom
hole_diameter = 6;
// The diameter of the part on the inside mould which fits in the hole
inside_post_diameter = 5.4;
// The difference in radius between the outside and inside of the tread
tread_depth = 1;
// The wheel diameter at the outside of the tread
wheel_diameter = 37;
// The inside diameter of the tyre (the hub diameter)
wheel_id = 30;
// The width of the wheel (the depth of the mould)
wheel_width = 12;
// The approximate distance between ridges in the tread
tread_width = 2.5;
// The amount of twist in the tread - higher values makes the tread take a greater angle
tread_twist = 90;
// How wide to make the groove
groove_width = 2;

/* [Hidden] */
base_thickness = 2;
mould_thickness = 2;

wing_width = 10;

tread_count = floor(wheel_diameter * PI / tread_width / 2);
tread_angle = 360 / tread_count;
$fs = 0.1;
$fn = 96;

module hole() {
    cylinder(d=hole_diameter, h=base_thickness);
}

module wheel_profile() {
    intersection() {
        circle(d=wheel_diameter);
        for (a = [0 : tread_angle : 360]) {
            rotate(a)
            translate([-tread_width / 2, 0])
            square(size=[wheel_diameter * 2, tread_width]);
        }
    }
    circle(d=wheel_diameter - tread_depth*2);
}

module wing() {
    scale([1, wing_width, wing_width])
        translate([-wing_width/2, 0, 1])
        rotate([0, 90, 0])
        linear_extrude(height=wing_width)
            polygon(points=[[1,0],[0, 0],[0,1]]);
}

module outside_mould() {
    difference() {
        union() {
            cylinder(h=base_thickness + wheel_width, d=wheel_diameter + (mould_thickness * 2));
            wing_y = sqrt(pow((wheel_diameter + mould_thickness)/2, 2) - pow(wing_width / 2, 2));
            wing_z = (base_thickness + wheel_width - wing_width) / 2;
            for (a = [0, 180])
                rotate([0, 0, a]) translate([0, wing_y, wing_z]) wing();
        }
        hole();
        translate([0, 0, base_thickness])
            linear_extrude(h=wheel_width, twist=tread_twist)
            wheel_profile();
    }
}

module radial_indent(r, d) {
  rotate_extrude($fn=96)
    translate([r-1, 0, 0])
    polygon(points=[[0,0],[d,d],[d,-d]]);
}

module inside_mould() {
    cylinder(h=base_thickness, d=wheel_diameter + (mould_thickness * 2));
    translate([0, 0, base_thickness])
        difference() {
            cylinder(h=wheel_width, d=wheel_id);
            translate([0, 0, wheel_width/2])
                radial_indent(wheel_id / 2, groove_width / 2);
        }
    translate([0, 0, base_thickness + wheel_width])
        cylinder(h=base_thickness * 2, d=inside_post_diameter);
}

if (part == "inside")
    inside_mould();
else if (part == "outside")
    outside_mould();
else {
    outside_mould();
    translate([1.2 * (wheel_diameter + (mould_thickness * 2)), 0, 0])
        inside_mould();
}
