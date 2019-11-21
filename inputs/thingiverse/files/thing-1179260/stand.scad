$fn = 180 * 1;

// The hole in the base will be a square with this length edges
hole_size = 2.5;

// Width of base
base_size_x = 45;

// Length of base
base_size_y = 20;

// Thickness of base
base_size_z = 2.5;

// Roundness of corners
base_roundness = 5;

// Offset the center of the hole this distance from the edge
hole_pos_x_rel = 13.5;

// Hole bevel depth - 0 to disable beveling
hole_bevel_depth = 0;

module roundedRect(size, radius)
{
    x = size[0];
    y = size[1];
    z = size[2];
    
    cylinder_z = 0.001;

    minkowski()
    {
        cube([x - radius * 2, y - radius * 2, z - cylinder_z], center = true);
        
        cylinder(r = radius, h = cylinder_z, center = true);
    }
}

difference()
{
    hole_pos_x_abs = base_size_x / -2 + hole_pos_x_rel;

    roundedRect([base_size_x, base_size_y, base_size_z], base_roundness);

    // Cut out a regular hole
    translate([hole_pos_x_abs, 0, 0])
    cube([hole_size, hole_size, base_size_z + 0.1], center = true);

    // Bevel the hole
    translate([hole_pos_x_abs, 0, base_size_z / 2 - hole_bevel_depth])
    minkowski()
    {
        translate([0, 0, 0.5])
        cube([hole_size, hole_size, 1], center = true);
        cylinder(r1 = 0, r2 = 1, h = 1, $fn = 4);
    }
}
