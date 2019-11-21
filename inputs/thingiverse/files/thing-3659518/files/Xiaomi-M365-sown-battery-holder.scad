//////////////////
/// PARAMETERS ///
//////////////////

// make sure to check these 3 parameters first!

// widht of hose clamp
clamp_width = 13.5;

// thickness of hose clamp - double it if it'metal one, so it fits through
clamp_thck = 2.4;

// thickness of rubber padding (bike tube works well)
tube_padding = 0.7;



// other paramaters:

// cylinder wall count override
$fn = 256;

// holes-to-holes width of base
width_holes = 52.2;

// holes-to-holes lenght of base
lenght_holes = 160;

// approximate hole spacing (gets computed)
hole_spacing = 5;

// holes diameter
hole_d = 1.5;

// base height
base_height = 5;

// rounding of base
base_rnd = 15;

// rounding of holes on base
holes_rnd = 10;

// number of holes on rounded corner
holes_rnd_count = 2;

// vertical scooter tube diameter
tube_d_h = 42.4;

// horizontal scooter tube diameter
tube_d_v = 52.5;

// distance from holes to edge of base
holes_padding = 5;

// added width to support
add_thck = 2;

// support walls thickness
support_wall_th = 5;

// positions for clamp mounts
clamps_offsets = [60, -20, -60];

///////////////////////////
/// COMPUTED PARAMETERS ///
///////////////////////////

base_width = width_holes + holes_padding * 2;
base_lenght = lenght_holes + holes_padding * 2;

hole_r = hole_d / 2;

lenght_holes_act = lenght_holes - holes_rnd * 2;
width_holes_act = width_holes - holes_rnd * 2;

count_width = round(width_holes_act / hole_spacing);
count_lenght = round(lenght_holes_act / hole_spacing);

tube_d_h_act = tube_d_h + tube_padding * 2;
tube_d_v_act = tube_d_v + tube_padding * 2;

tube_r_h_act = tube_d_h_act / 2;
tube_r_v_act = tube_d_v_act / 2;

module roundedcube(x, y, z, r)
{
    hull()
    {
        translate([x / 2 - r, -y / 2 + r, 0])
        cylinder(r = r, h = z, center = true);

        translate([-x / 2 + r, -y / 2 + r, 0])
        cylinder(r = r, h = z, center = true);

        translate([x / 2 - r, y / 2 - r, 0])
        cylinder(r = r, h = z, center = true);

        translate([-x / 2 + r, y / 2 - r, 0])
        cylinder(r = r, h = z, center = true);
    }
}

module holes_on_rounded_corners(r, d, h, count, quadrant)
{
    for (i = [1 : count])
    {
        angle = quadrant * 90 - 180; // NE=1, NW=2, SW=3, SE=4

        rotate([0, 0, angle + 90 / (count + 1) * i])
        translate([0, r])
        hole(d = d, h = h, center = true);
    }
}

module hole(d, h, $fn=16)
{
    union()
    {
        translate([0, 0, h / 2])
        cylinder(d1 = d, d2 = d * 3, h = d * 2, center = true, $fn = $fn);

        cylinder(d = d, h = h + 2 * d, center = true, $fn = $fn);

        translate([0, 0, -h / 2])
        cylinder(d1 = d * 3, d2 = d, h = d * 2, center = true, $fn = $fn);
    }
}

module base()
{
    difference()
    {
        // base
        color("darkred")
        roundedcube(base_width, base_lenght, base_height, base_rnd);

        // holes on left and right side
        for (i = [0:count_lenght])
        {
            y = -lenght_holes_act / 2 + i * lenght_holes_act / count_lenght;

            translate([-width_holes / 2, y, 0])
            rotate([0, 0, 90])
            hole(d = hole_d, h = base_height, center = true);

            translate([width_holes / 2, y, 0])
            rotate([0, 0, 90])
            hole(d = hole_d, h = base_height, center = true);
        }
        
        // holes on top and bottom side
        for (i = [0 : count_width])
        {
            x = -width_holes_act / 2 + i * width_holes_act / count_width;

            translate([x, -lenght_holes / 2, 0])
            hole(d = hole_d, h = base_height, center = true);

            translate([x, lenght_holes / 2, 0])
            hole(d = hole_d, h = base_height, center = true);
        }

        // holes around rounded corners
        translate([width_holes_act / 2, lenght_holes_act / 2])
        holes_on_rounded_corners(holes_rnd, hole_d, base_height, holes_rnd_count, 1);

        translate([-width_holes_act / 2, lenght_holes_act / 2])
        holes_on_rounded_corners(holes_rnd, hole_d, base_height, holes_rnd_count, 2);

        translate([-width_holes_act / 2, -lenght_holes_act / 2])
        holes_on_rounded_corners(holes_rnd, hole_d, base_height, holes_rnd_count, 3);

        translate([width_holes_act / 2, -lenght_holes_act / 2])
        holes_on_rounded_corners(holes_rnd, hole_d, base_height, holes_rnd_count, 4);
    }
}

module ellipsoid(dx, dy, h, center = true, $fn = 256)
{
    scale([1, dy / dx, 1])
    cylinder(d = dx, h = h, center = center, $fn = $fn);
}

// cutout for hose clamp
module clamp_cutout()
{
    color("orange")
    rotate([-90, 0, 0])
    translate([0, -tube_r_v_act])
    difference()
    {
        ellipsoid(tube_d_h_act + add_thck + clamp_thck * 2,
            tube_d_v_act + base_height * 2 + clamp_thck * 2, clamp_width);

        ellipsoid(tube_d_h_act + add_thck, tube_d_v_act + base_height * 2, 100);
    }
}

// support
module support()
{
    rotate([-90, 0, 0])
    translate([0, -tube_r_v_act])
    difference()
    {
        union()
        {
            color("orange")
            ellipsoid(tube_d_h_act + add_thck, tube_d_v_act + base_height * 2, clamp_width);

            color("darkblue")
            translate([-tube_r_h_act - add_thck / 2, 0, clamp_width / 2])
            cube([tube_d_h_act + add_thck, tube_r_v_act + base_height, support_wall_th]);

            color("darkblue")
            translate([-tube_r_h_act - add_thck / 2, 0, -clamp_width / 2 - support_wall_th])
            cube([tube_d_h_act + add_thck, tube_r_v_act + base_height, support_wall_th]);
        }
        
        color("grey")
        ellipsoid(tube_d_h_act, tube_d_v_act, 100);
        
        color("darkblue")
        translate([-50, -100, -50])
        cube([100, 100, 100]);
    }
}

// final assembly
difference()
{
    union()
    {
        translate([0, 0, -base_height / 2])
        base();

        for (i = clamps_offsets)
        {
            translate([0, i])
            support();
        }
    }

    for (i = clamps_offsets)
    {
        translate([0, i])
        clamp_cutout();
    }
}

// representation of scooter tube and cable plugs
// color("gray")
// translate([0, 0, tube_d_v_act / 2])
// rotate([90, 0, 0])
// ellipsoid(tube_d_h, tube_d_v, 300);

// color("red")
// translate([0, base_lenght / 2 - 60, tube_d_v / 2])
// rotate([0, 90, 0])
// ellipsoid(15, 30, tube_d_h + 10);