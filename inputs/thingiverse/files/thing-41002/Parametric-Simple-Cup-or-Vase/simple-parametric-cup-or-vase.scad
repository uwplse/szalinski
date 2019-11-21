// Simple Customizable Cup.

// By Donald E. King, 1/8/2013

// Written primarily to check out the Thingiverse.com Customizer feature.

// resolution of circles, cylinders and spheres
1_res = 5;  // [120, 60, 50, 40, 30, 20, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3]

// outside radius of cup
radius_1 = 30;

// height of cup
height_1 = 30;

// wall thickness (negative values produce a disc wthout walls)
t_wall = 1; //  [0.5, 1, 1.5, 2, 2.5, 3, 4, 5, -1]

// bottom thickness (negative values produce a hollow cylinder)
t_bottom = 2;  //  [0.5, 1, 1.5, 2, 2.5, 3, 4, 5, -1]


difference()
{

translate([0, 0, height_1/2])
cylinder(r = radius_1, h = height_1, center = true, $fn = 1_res);

translate([0, 0, t_bottom + 2*height_1/2])
cylinder(r = radius_1-t_wall, h = 2*height_1, center = true, $fn = 1_res);

}

