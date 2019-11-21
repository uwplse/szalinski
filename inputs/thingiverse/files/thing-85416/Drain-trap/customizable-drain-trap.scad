// sink drain diameter
1_drain_diameter = 84; // [50:100]

// outer ring height
2_rim_height = 5; // [4:6]
// outer ring width
3_rim_width = 5; // [4:8]

// trap grid height
4_mesh_height = 4; // [2:4]
// grid line thickness
5_mesh_thickness = 2; // [1:4]
// grid hole width
6_mesh_hole_width = 8; // [6:10]

// handle height
7_handle_height = 20; // [10:30]
// handle top diameter
8_handle_diameter = 16; // [14:20]

function polar_dist(x, y) = sqrt(pow(x, 2) + pow(y, 2));

mesh_spacing = 6_mesh_hole_width + 5_mesh_thickness;
num_holes = floor((1_drain_diameter/2)/mesh_spacing);

$fn=50;

union()
{
    // Mesh
    difference()
    {
        cylinder(r=1_drain_diameter/2, h=4_mesh_height);

        for (x = [-num_holes:num_holes])
        {
            for (y = [-num_holes:num_holes])
            {
                if (polar_dist(x * mesh_spacing, y * mesh_spacing) < (1_drain_diameter / 2) - 3_rim_width)
                {
                    translate([
                        x * mesh_spacing,
                        y * mesh_spacing,
                        4_mesh_height/2])
                    cube([6_mesh_hole_width, 6_mesh_hole_width, 4_mesh_height+0.1], center=true);
                }
            }
        }
    }

    // Rim
    difference()
    {
        cylinder(r=1_drain_diameter/2, h=2_rim_height);

        translate([0, 0, -0.05])
        cylinder(r=1_drain_diameter/2-3_rim_width, h=2_rim_height+0.1);
    }

    // Handle
    cylinder(r1=6_mesh_hole_width/2+5_mesh_thickness, r2=8_handle_diameter/2, h=7_handle_height);
}
