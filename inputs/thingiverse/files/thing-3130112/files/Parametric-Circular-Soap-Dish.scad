// Parametric Circular Soap Dish
// V2 by Bikecyclist: October 01, 2018 - With parametric chamfer as suggested by https://www.thingiverse.com/driley82
// V1 by Bikecyclist: October 01, 2018
// https://www.thingiverse.com/thing:3130112

// Diameter of dish
d = 60;

// Thickness of dish
th = 2;

// Diameter of holes in dish
d_holes = 5;

// Chamfer Diameter (i. e. 1.2 = 120 % of hole diameter)
chamfer = 1.15;

// Number of legs
n_legs = 6;

// Height of legs
h_legs = 5;

// Diameter of legs
d_legs = 3;

// Number of faces for large features
$fn = 256;

// Number of faces for small features
fn_small = 32;

// Small constant to ensure proper meshing
epsilon = 0.01;

for (i = [1:n_legs])
    rotate (360/n_legs * i)
        translate ([d/2 - d_legs/2, 0, th])
                cylinder (d = d_legs, h = h_legs, $fn = fn_small);

sieve (d, th, d_holes, d_legs);

module sieve (d, thickness = 1, d_hole = 2.5, rim = 0)
{
    I = ((d - rim)/(d_hole * 1.2) - 1)/2;
    
    delta = (d - rim)/(2 * I + 1);
    
    translate ([0, 0, thickness/2])
        difference ()
        {
            cylinder (d = d, h = thickness, center = true);
            for (i = [1:I])
            {
                c = 2 * PI * 3 * i;
                n_holes = floor (c/3);
                for (j = [0:n_holes])
                    rotate ([0, 0, j * 360/n_holes])
                        translate ([delta * i, 0, 0])
                        {
                            cylinder (d = d_hole, h = 0.01 + thickness, center = true,$fn = fn_small);
                
                            translate ([0, 0, -thickness/2  + (chamfer - 1 + epsilon)])
                                cylinder (d1 = d_hole * chamfer + epsilon, d2 = d_hole, h = (chamfer - 1 + epsilon)/2 * d_hole, center = true, $fn = fn_small);
                        }
            }
            cylinder (d = d_hole, h = 2 * thickness, center = true, $fn = fn_small);
            
            translate ([0, 0, -thickness/2 + (chamfer - 1 + epsilon)])
                cylinder (d1 = d_hole * chamfer + epsilon, d2 = d_hole, h = (chamfer - 1 + epsilon)/2 * d_hole, center = true, $fn = fn_small);
        }
}