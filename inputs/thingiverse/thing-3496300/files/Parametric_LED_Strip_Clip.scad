// Parametric LED Strip Holder for Board Edges
// https://www.thingiverse.com/thing:3496300
// by Bike Cyclist
// https://www.thingiverse.com/Bikecyclist


// Width of the clamped board
w_board = 22.5;

// Net height of the clamped length
h_board = 12;

// Radius of the clamping-end cylinder
r_board = 1;

// Width of the LED strip (including tolerance)
w_led = 8.5;

// Height of the LED strip (including tolerance)
h_led = 1.2;

// Radius of the LED strip retaining arc
r_led = 0.5;

// Thickness of the clamp features
th_clamp = 1;

// Length of the clamp
l_clamp = 15;

// Number of facets
$fn = 32;

// Small distance to ensure proper meshing
eps = 0.01;

rotate ([0, 90, 0])
{
    halfclamp (w_board, h_board, r_board, 0);

    translate ([0, 0, -th_clamp])
    mirror ([0, 0, 1])
    halfclamp (w_led, h_led, r_led);
    
    if (w_led < w_board)
    {
        chamfer ();
        
        mirror ([0, 1, 0])
        chamfer ();
    }
}

module chamfer ()
{
    hull ()
    {
        translate ([0, w_board/2 + th_clamp, -eps])
        rotate ([0, 90, 0])
        cylinder (r = eps, h = l_clamp, center = true);
        
        translate ([0, w_led/2 + th_clamp/2, -eps])
        rotate ([0, 90, 0])
        cylinder (r = eps, h = l_clamp, center = true);
        
        translate ([0, w_led/2 + th_clamp - r_led, h_led + r_led])
        rotate ([0, 90, 0])
        cylinder (r = r_led, h = l_clamp, center = true);
    }
    
    hull ()
    {
        translate ([0, w_led/2 + th_clamp/2, h_led + r_led])
        rotate ([0, 90, 0])
        cylinder (r = r_led, h = l_clamp, center = true);
    }
}

module halfclamp (width, free_height, r_corner)
{
    height = free_height + r_corner + th_clamp;
    d_corner = th_clamp - r_corner;
    
    translate ([0, 0, -height])
    {
        difference ()
        {
            ccube ([l_clamp, width + 2 * th_clamp, height]);
            
            epsdown ()
            ccube ([l_clamp + 2 * eps, width, height - th_clamp]);
        }

        for (i = [-1, 1])
            translate ([0, i * ((width + 2 * th_clamp)/2 - r_corner), 0])
            rotate ([0, 90, 0])
            hull ()
            {
                cylinder (d = 2 * r_corner, h = l_clamp, center = true);
                
                translate ([0, -i * d_corner, 0])
                cylinder (d = 2 * r_corner, h = l_clamp, center = true);
            }
    }
}

module ccube (dim)
{
    translate ([0, 0, dim[2]/2])
    cube ([dim [0], dim [1], dim [2]], center = true);
}

module epsdown (n = 1)
{
    translate ([0, 0, -n * eps])
    children ();
}