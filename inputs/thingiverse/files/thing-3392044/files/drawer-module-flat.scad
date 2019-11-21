/* [Basic] */
// which model(s) to output
output = 0; // [0:Small drawer <1x1>, 1:Wide drawer <2x1>, 2:Big drawer <2x2>, 3:keys <for connecting drawers together>, 4:EVERYTHING!!]
// the width of the smallest (1x1) drawer
base_width = 60; // [40:100]
// the width of the smallest (1x1) drawer
base_height = 60; // [40:100]
// drawer depth
depth = 130; // [30:200]
// how rounded should the corners be? (set to zero to have compleltely squared off edges)
corner_radius = 5; // [0:10]

drawer_wall_thickness = 2.5; // [0.5:5]
body_wall_thickness = 3; // [0.5:5]

handle_width = 30; // [5:60]
// how far does the handle stick out from the drawer?
handle_protrusion = 7; // [3:20]

/* [Wall Pattern] */
pattern_inset   = 3;
// diameter of the largest hole
pattern_max_d   = 13;
// diameter of the smallest hole
pattern_min_d   = 2;
// space between holes
pattern_spacing = 15.5;

/* [Advanced] */
// how big a gap between drawer and body? Small values result in a tighter fit.
drawer_tessalation_tolerance = 0.5; // [0.2:2]
// how closely should multiple drawers fit together? Small values result in a tighter fit.
module_tessalation_tolerance = 0.3; // [0.1:1]

/* [Hidden] */
spacing = 15;

$fa = 10;
$fn = 360 / $fa;

module print_body(width = 1, height = 1)
{
    rotate([90, 0, 0])
        body(width, height);
}

if(output == 0)
{
    drawer();
    translate([0, -spacing, 0])
        print_body();
}
if(output == 1)
{
    drawer(2, 1);
    translate([0, -spacing, 0])
        print_body(2, 1);
}
if(output == 2)
{
    drawer(2, 2);
    translate([0, -spacing, 0])
        print_body(2, 2);
}
if(output == 3)
{
    key(1);
    translate([spacing * 2, 0, 0])
        mirror([1, 0, 0])
        key(2);
    translate([0, spacing * 2, 0])
        key(4);
}
if(output == 4)
{
    translate([spacing + base_width, -spacing * 2 - base_width, 0])
    rotate([0, 0, -90])
    {
        drawer();
        translate([0, -spacing, 0])
            print_body();
    }
    translate([])
    {
        drawer(2, 1);
        translate([0, -spacing, 0])
            print_body(2, 1);
    }
    translate([-base_width * 2 - spacing, 0, 0])
    {
        drawer(2, 2);
        translate([0, -spacing, 0])
            print_body(2, 2);
    }
    translate([spacing * 2 + base_width * 2, 0, 0])
    {
        key();
        translate([spacing * 2, 0, 0])
            mirror([1, 0, 0])
            key(2);
        translate([0, spacing * 2, 0])
            key(4);
    }
}
module rounded_square(size = [10, 10], center = false, cr = 2, cd = undef)
{
    cr = cr == undef ? cd / 2 : cr;

    if(cr > 0)
    {
        new_size = [ for(s = size) s - cr * 2 ];

        if(new_size[0] > 0 && new_size[1] > 0)
        {
            minkowski()
            {
                translate(center ? [0, 0] : [cr, cr])
                    square(size = new_size, center = center);
                circle(r = cr);
            }
        }
    }
    else
    {
        square(size = size, center = center);
    }
}
module rounded_cube(size = [10, 10, 10], center = false, cr = 2, cd = undef)
{
    cr = cr == undef ? cd / 2 : cr;

    if(cr > 0)
    {
        new_size = [ for(s = size) s - cr * 2 ];

        if(new_size[0] > 0 && new_size[1] > 0 && new_size[2] > 0)
        {
            minkowski()
            {
                translate(center ? [0, 0, 0] : [cr, cr, cr])
                    cube(size = new_size, center = center);
                sphere(r = cr);
            }
        }
    }
    else
    {
        cube(size = size, center = center);
    }
}
module skew(x_along_y = 0, x_along_z = 0, y_along_x = 0, y_along_z = 0, z_along_x = 0, z_along_y = 0)
{
    mtx = [
        [ 1, tan(x_along_y), tan(x_along_z), 0 ],
        [ tan(y_along_x), 1, tan(y_along_z), 0 ],
        [ tan(z_along_x), tan(z_along_y), 1, 0 ],
        [ 0, 0, 0, 1 ]
    ];
    multmatrix(mtx)
        children();
}

key_interface_angle   = 30;
key_inset_past_corner = 2;
key_depth             = depth / 3;

rear_frame_inset = 12;

handle_angle  = 45;
handle_height = handle_protrusion / tan(90 - handle_angle) * 2;

countersink_diameter = 7;
screw_hole_diameter  = 3.5;
countersink_height   = 3;

module stacked()
{
    assemble();
    translate([base_width, 0, 0])
        assemble();
    translate([base_width * 2, 0, 0])
        assemble(2, 2);
    translate([0, 0, base_height])
        assemble(2, 1);
    translate([0, 0, base_height * 2])
        assemble(4, 1);
}

module test_tessalation(width = 1, height = 1)
{
    intersection()
    {
        assemble(width, height);
        cube([width * base_width / 2, 999, height * base_height /  2]);
    }
}

module assemble(width = 1, height = 1)
{
    body(width, height);
    translate([body_wall_thickness + drawer_tessalation_tolerance, body_wall_thickness + drawer_tessalation_tolerance, body_wall_thickness + drawer_tessalation_tolerance])
        drawer(width, height);
    translate([base_width * width + module_tessalation_tolerance / 2, key_depth, -module_tessalation_tolerance / 2])
        rotate([-90, 0, 0])
        mirror([0, 0, 1])
        key(1);
    translate([-module_tessalation_tolerance / 2, key_depth, -module_tessalation_tolerance / 2])
        rotate([-90, 90, 0])
        mirror([0, 0, 1])
        key(1);
    translate([-module_tessalation_tolerance / 2, key_depth, base_height * height + module_tessalation_tolerance / 2])
        rotate([-90, 180, 0])
        mirror([0, 0, 1])
        key(1);
    translate([base_width * width + module_tessalation_tolerance / 2, key_depth, base_height * height + module_tessalation_tolerance / 2])
        rotate([-90, 270, 0])
        mirror([0, 0, 1])
        key(1);
}

module drawer(width = 1, height = 1)
{
    width         = width * base_width + (width - 1) * module_tessalation_tolerance - body_wall_thickness * 2 - drawer_tessalation_tolerance * 2;
    height        = height * base_height + (height - 1) * module_tessalation_tolerance - body_wall_thickness * 2 - drawer_tessalation_tolerance * 2;
    depth         = depth - body_wall_thickness - drawer_tessalation_tolerance;
    corner_radius = max(0, corner_radius - body_wall_thickness - drawer_tessalation_tolerance);

    echo("drawer inner dims: ", width - drawer_wall_thickness * 2, depth - drawer_wall_thickness * 2, height - drawer_wall_thickness, " (w,d,h)");
    echo(sqrt(pow(width - drawer_wall_thickness * 2, 2) + pow(depth - drawer_wall_thickness * 2, 2)), " (hyp)");

    difference()
    {
        intersection()
        {
            translate([corner_radius, 0, corner_radius])
                minkowski()
                {
                    translate([0, corner_radius, 0])
                            cube([width - corner_radius * 2, depth - corner_radius, height - corner_radius * 2]);
                    difference()
                    {
                        sphere(r = corner_radius);
                        translate([-500, 0, -500])
                            cube(999);
                    }
                }
            translate([-body_wall_thickness - drawer_tessalation_tolerance, -body_wall_thickness - drawer_tessalation_tolerance, -body_wall_thickness - drawer_tessalation_tolerance])
                rounded_cube([
                    width + body_wall_thickness * 2 + drawer_tessalation_tolerance * 2,
                    depth + body_wall_thickness + drawer_tessalation_tolerance,
                    height + body_wall_thickness * 2 + drawer_tessalation_tolerance * 2
                ], cr = corner_radius + body_wall_thickness + drawer_tessalation_tolerance);
        }
        translate([drawer_wall_thickness, drawer_wall_thickness, drawer_wall_thickness])
            rounded_cube([
                width - drawer_wall_thickness * 2,
                depth - drawer_wall_thickness * 2 - body_wall_thickness - drawer_tessalation_tolerance,
                999
            ], cr = corner_radius - drawer_wall_thickness);
    }

    translate([width / 2 - handle_width / 2, depth - drawer_wall_thickness, height / 2 - handle_height / 2])
        handle();

    module handle()
    {
        difference()
        {
            skew(y_along_z = 90 - handle_angle)
                cube([handle_width, drawer_wall_thickness, handle_height / 2]);
            translate([handle_width / 2, 0, 0])
                rotate([-90, 0, 0])
                resize([handle_width - drawer_wall_thickness * 2, 0, 0])
                cylinder(d = handle_height, h = 999);
        }
        translate([0, handle_protrusion, handle_height / 2])
            skew(y_along_z = handle_angle + 90)
            cube([handle_width, drawer_wall_thickness, handle_height / 2]);
        translate([drawer_wall_thickness, 0, 0])
            end();
        translate([handle_width, 0, 0])
            end();

        module end()
        {
            rotate([0, -90, 0])
                linear_extrude(height = drawer_wall_thickness)
                polygon(points = [[0, 0], [handle_height, 0], [handle_height / 2, handle_protrusion]]);
        }
    }
}

module body(width = 1, height = 1)
{
    width  = width * base_width + (width - 1) * module_tessalation_tolerance;
    height = height * base_height + (height - 1) * module_tessalation_tolerance;

    difference()
    {
        rounded_cube([width, depth, height], cr = corner_radius);
        translate([body_wall_thickness, body_wall_thickness, body_wall_thickness])
            rounded_cube([
                width - body_wall_thickness * 2,
                999,
                height - body_wall_thickness * 2
            ], cr = corner_radius - body_wall_thickness);
        translate([rear_frame_inset, -500, rear_frame_inset])
            rounded_cube([width - rear_frame_inset * 2, 999, height - rear_frame_inset * 2], cr = corner_radius);
        translate([0, depth / 2, height / 2])
            rotate([0, 90, 0])
            linear_extrude(height = 999)
            intersection()
            {
                dot_pattern(depth - pattern_inset * 2, pattern_min_d, pattern_max_d, pattern_spacing)
                    circle();
                square([height - pattern_inset * 2, depth - pattern_inset * 2], center = true);
            }
        translate([width / 2, depth / 2, -0.1])
            linear_extrude(height = body_wall_thickness + corner_radius + 0.2)
            intersection()
            {
                dot_pattern(depth - pattern_inset * 2, pattern_min_d, pattern_max_d, pattern_spacing)
                    circle();
                square([width - pattern_inset * 2, depth - pattern_inset * 2], center = true);
            }
        translate([width, 0, height])
            key_cutout();
        translate([width, 0, 0])
            rotate([0, 90, 0])
            key_cutout();
        translate([0, 0, 0])
            rotate([0, 180, 0])
            key_cutout();
        translate([0, 0, height])
            rotate([0, 270, 0])
            key_cutout();

        translate([width / 2, 0, height - corner_radius - body_wall_thickness - countersink_diameter / 2])
            rotate([-90, 0, 0])
            {
                cylinder(d1 = screw_hole_diameter, d2 = countersink_diameter, h = countersink_height);
                translate([0, 0, countersink_height])
                    cylinder(d = countersink_diameter, h = 999);
            }
    }

    translate([width / 2, 0, height - corner_radius - body_wall_thickness - countersink_diameter / 2])
        rotate([-90, 0, 0])
        difference()
        {
            cylinder(d = countersink_diameter + body_wall_thickness * 2, h = body_wall_thickness);
            cylinder(d1 = screw_hole_diameter, d2 = countersink_diameter, h = countersink_height);
            translate([0, 0, countersink_height])
                cylinder(d = countersink_diameter, h = 999);
        }

    module key_cutout()
    {
        rotate([90, 0, 0])
            translate([0, 0, -key_depth - module_tessalation_tolerance])
            linear_extrude(height = key_depth + module_tessalation_tolerance)
            key_section(true);
    }
}

module dot_pattern(d, min_dot_d, max_dot_d, spacing)
{
    r = d / 2;

    function get_dot_d(x, y) =
        sqrt(pow(x * spacing - r, 2) + pow(y * spacing - r, 2)) >= r ? 0 : (max_dot_d - min_dot_d) * (1 - sqrt(pow(x * spacing - r, 2) + pow(y * spacing - r, 2)) / r) + min_dot_d;

    for(x = [0 : ceil(d / spacing)])
        for(y = [0 : ceil(d / spacing)])
        {
            d = get_dot_d(x, y);
            if(d > 0)
                translate([x * spacing - r, y * spacing - r])
                    resize([d, 0], auto = true)
                    children(0);
        }
}

module key(num_interfaces)
{
    difference()
    {
        union()
        {
            section();
            if(num_interfaces > 1)
            {
                mirror([1, 0, 0])
                    section();

                if(num_interfaces > 2)
                {
                    mirror([1, 1, 0])
                        section();
                    mirror([0, 1, 0])
                        section();
                }
            }
        }
        dots();
        rotate([0, 0, 90])
            dots();
        rotate([0, 0, 180])
            dots();
        rotate([0, 0, 270])
            dots();
    }

    module dots()
    {
        translate([base_height / 2, 500, 0])
            rotate([90, 0, 0])
            linear_extrude(height = 999)
            intersection()
            {
                dot_pattern(depth - pattern_inset * 2, pattern_min_d, pattern_max_d, pattern_spacing)
                    circle();
                square([base_height - pattern_inset * 2, depth - pattern_inset * 2], center = true);
            }
    }

    module section()
    {
        intersection()
        {
            linear_extrude(height = key_depth)
                translate([-module_tessalation_tolerance / 2, -module_tessalation_tolerance / 2, 0])
                key_section();
            translate([-base_width - module_tessalation_tolerance / 2, -base_height - module_tessalation_tolerance / 2, key_depth - depth])
                rounded_cube([base_width, base_height, depth], cr = corner_radius);
        }
        linear_extrude(height = key_depth - corner_radius)
        {
            if(num_interfaces != 2)
            {
                translate([-corner_radius - key_inset_past_corner - module_tessalation_tolerance / 2, -module_tessalation_tolerance / 2 - 0.1])
                    square([key_inset_past_corner, module_tessalation_tolerance + 0.1]);
            }
            translate([-module_tessalation_tolerance / 2 - 0.1, -corner_radius - key_inset_past_corner - module_tessalation_tolerance / 2])
                square([module_tessalation_tolerance + 0.1, key_inset_past_corner]);

            if(num_interfaces == 1)
            {
                translate([
                    -corner_radius - key_inset_past_corner - module_tessalation_tolerance / 2 - body_wall_thickness / tan(key_interface_angle),
                    module_tessalation_tolerance / 2
                ])
                    flap_shape();
                translate([
                    module_tessalation_tolerance / 2,
                    -corner_radius - key_inset_past_corner - module_tessalation_tolerance / 2 - body_wall_thickness / tan(key_interface_angle)
                ])
                    mirror([1, 0, 0])
                    rotate([0, 0, 90])
                    flap_shape();
            }

        }

        module flap_shape()
        {
            width  = body_wall_thickness / tan(key_interface_angle) + key_inset_past_corner;
            height = min(drawer_wall_thickness, body_wall_thickness);
            polygon(points = [
                [0, 0],
                [width, 0],
                [width - key_inset_past_corner, height],
                [0, height]
            ]);
        }
    }
}

module key_section(as_cutout = false)
{
    inset   = as_cutout ? corner_radius + key_inset_past_corner + module_tessalation_tolerance : corner_radius + key_inset_past_corner;
    padding = as_cutout ? module_tessalation_tolerance : 0;

    translate([-base_width / 2, -base_height / 2])
        intersection()
        {
            difference()
            {
                rounded_square(
                    [base_width + padding, base_height + padding],
                    cr = corner_radius,
                    center = true
                );
                rounded_square([
                    base_width - body_wall_thickness * 2 - padding,
                    base_height - body_wall_thickness * 2 - padding
                ], cr = corner_radius - body_wall_thickness - (as_cutout ? module_tessalation_tolerance : 0), center = true);
            }
            union()
            {
                translate([base_width / 2 - inset, base_height / 2 - inset, 0])
                    polygon(points = [
                        [0, 0],
                        [-body_wall_thickness / tan(key_interface_angle), inset - body_wall_thickness],
                        [0, inset],
                        [inset, inset],
                        [inset, 0],
                        [inset - body_wall_thickness, -body_wall_thickness / tan(key_interface_angle)],
                        [0, 0]
                    ]);
                translate([base_width / 2 - inset, base_height / 2])
                    square([inset, padding]);
                translate([base_width / 2, base_height / 2 - inset])
                    square([padding, inset]);
            }
        }
}