// The total height of the ladder
height = 200;

// The total width of the ladder
width = 90;

// The distance between the centre of each rung
rung_spacing = 50;

// The diameter of each rung
rung_diameter = 15;

// How thick the connecting rails should be
rail_thickness = 8;

// Rounding applied to the rail's edges. This prevents sharp edges. Must be less than half the rail thickness and less than half the rung diameter
rail_corner_radius = 3;

// The angle the hooks make with the rails in degrees.
hook_angle = 70; // [90]

// The length of the hooks, set to zero for no hooks.
hook_length = 30;

/* [Hidden] */
$fa = 10;
$fn = 360 / $fa;

build();

module build()
{
    num_rungs = floor((height - rung_spacing / 2 - rung_diameter / 2) / rung_spacing) + 1;
    rail();
    translate([width - rail_thickness, 0, 0]) rail();
    
    module rail()
    {
        corner_diameter = rail_corner_radius * 2;
        minkowski()
        {
            translate([rail_corner_radius, rail_corner_radius, rail_corner_radius]) cube([rail_thickness - corner_diameter, rung_diameter - corner_diameter, height - corner_diameter]);
            sphere(r = rail_corner_radius);
        }
        translate([0, cos(hook_angle) * rail_thickness / 2 + rail_thickness / 2, height - sin(hook_angle) * rail_thickness]) rotate([180 - hook_angle, 0, 0]) minkowski()
        {
            translate([rail_corner_radius, rail_corner_radius, rail_corner_radius]) cube([rail_thickness - corner_diameter, rail_thickness - corner_diameter, hook_length + rail_thickness / 2]);
            sphere(r = rail_corner_radius);
        }
    }
    
    for(idx = [0 : num_rungs - 1])
        rotate([0, 90, 0]) translate([-(idx + 0.5) * rung_spacing, rung_diameter / 2, rail_thickness / 2]) cylinder(d = rung_diameter, h = width - rail_thickness);
}