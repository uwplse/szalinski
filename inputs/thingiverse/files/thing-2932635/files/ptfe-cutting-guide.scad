// Diameter of hole for PTFE tube (mm)
tube_diameter = 4.5;
// Size of slot for blade (mm)
blade_thickness = 1;
// Corner Smoothness (higher is smoother)
$fn = 36;

/* [Hidden */

wall_thickness = 2;
base_thickness = 5;
corner_radius = 4;

tube_guide_thickness = tube_diameter + (wall_thickness * 2);
blade_guide_thickness = blade_thickness + (wall_thickness * 2);
base_size = max(20, tube_guide_thickness * 2);

echo("tube guide diameter", tube_guide_thickness);
echo("blade guide diameter", blade_guide_thickness);
echo("base size", base_size);

//cube([base_size, base_size, base_thickness]);

difference()
{
    union()
    {
        cube([base_size - blade_guide_thickness, base_size, base_thickness]);
        #translate([0, (base_size - tube_guide_thickness) / 2 , base_thickness]) tube_guide();
        #translate([base_size - blade_guide_thickness, 0, 0]) blade_guide();
    }
    translate([-1, base_size /2, base_thickness + wall_thickness + (tube_diameter / 2)]) tube_hole();
}

module tube_guide()
{
    cube([base_size - blade_guide_thickness, tube_guide_thickness, tube_guide_thickness / 2]);
    translate([0, tube_guide_thickness / 2, tube_guide_thickness / 2  ]) rotate([0, 90, 0]) cylinder(d = tube_guide_thickness, h = base_size - blade_guide_thickness);
}

module tube_hole()
{
    union()
    {
    rotate([0, 90, 0]) cylinder(d = tube_diameter, h = base_size + 2);
    rotate([0, 90, 0]) cylinder(d = tube_diameter + 1, d2 = tube_diameter, h = 2);
    translate([base_size - wall_thickness + (blade_thickness / 2), 0, 0]) rotate([0, 90, 0]) cylinder(d = tube_diameter + 1, d2 = tube_diameter, h = blade_thickness);
    }
}

module blade_guide()
{
    difference()
    {
        hull()
        {
        cube([blade_guide_thickness, base_size, base_thickness]);
        translate([0, corner_radius, base_thickness + tube_guide_thickness - corner_radius]) rotate([0, 90, 0]) cylinder(r = corner_radius, h = blade_guide_thickness);
        translate([0, base_size - corner_radius, base_thickness + tube_guide_thickness - corner_radius]) rotate([0, 90, 0]) cylinder(r = corner_radius, h = blade_guide_thickness);
        }
        translate([(blade_guide_thickness - blade_thickness) / 2, -1, base_thickness]) cube([blade_thickness, base_size + 2, base_thickness + tube_guide_thickness]);
    }
}