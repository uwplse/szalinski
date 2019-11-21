// Parametric Zip Toggle V4: 25.11.2018
// As suggested by https://www.thingiverse.com/blackboots:
// Decreased default tolerance 
// 
// Parametric Zip Toggle V3: 23.11.2018
// As suggested by https://www.thingiverse.com/warr3ntor:
// Rendered parts lie flat on a common plane now 
// No artifacts at small thicknesses any more
// Customizer uses tabs now
//
// Parametric Zip Toggle V2: 22.11.2018
// Minor syntax correction, slight-arrangement of rendered parts
//
// Parametric Zip Toggle V1: 22.11.2018
// First release
//
// https://www.thingiverse.com/thing:3232726
// by https://www.thingiverse.com/Bikecyclist

/* [Loop] */

//Width of Loop
w_loop = 10;

// Length of Loop
l_loop = 10;

// Height of Loop
h_loop = 2;

// Thickness of Loop (and other Parts interfacing with the Loop)
th_loop = 1.5;

// End Radius of Loop
r_loop = (w_loop)/2;

// Gap in Loop
w_gap = 2 * th_loop;

// Width of Hook
w_hook = 4 * th_loop;

// Length of Hook
l_hook = 8;

/* [Grip] */

// Width of Grip
w_grip = 13;

// Lenght of Grip
l_grip = 30;

// Edge Radius of Grip
r_grip = 2;

/* [Tolerances] */

// Height Tolerance of Grip
h_tol = 0.5;

// Width Tolerance of Grip ... required value depends a lot on your printer
w_tol = 0.5;

/* [Technical] */

// Small distance to ensure proper meshing ... normally no need to change it
epsilon = 0.01;

// Number of facets
$fn = 32;

/* [Hidden] */

//Version number
version = "V4";

//cutdup (10, h_loop + epsilon)
{
    translate ([-1.1 * w_grip, 0, 0])
        key_part ();
    
    translate ([0, 0, th_loop + h_tol])
        grip_part ();

    translate ([1.1 * w_grip, l_grip/2, 0])
        loop_part ();
}

module loop_part ()
{
    color ("green")
        linear_extrude (h_loop, convexity = 8)
            hook_section ();
}

module grip_part ()
{
    translate ([0, 0, -h_tol])
        difference ()
        {
            translate ([0, l_loop/2 + l_hook - 5 * th_loop + l_grip/2, -th_loop])
                rcube ([w_grip, l_grip, h_loop + 2 * h_tol + 2 * th_loop], r_grip);
            
            translate ([0, l_loop/2 + l_hook - 4 * th_loop + l_grip/2 - epsilon, (h_loop + 2 * h_tol)/2 - th_loop])
                linear_extrude (h_loop + 2 * h_tol)
                    csquare ([w_hook - 2 * th_loop - 2 * w_tol, l_grip + 2 * epsilon]);
            
            linear_extrude (h_loop + 2 * h_tol, convexity = 8)
                offset (w_tol)
                    hook_section ();
            
            translate ([0, l_loop/2 + l_hook - 4 * th_loop - epsilon, 0])
                linear_extrude (h_loop + 2 * h_tol)
                    csquare ([w_hook - 2 * th_loop, 2 * th_loop]);
            
            linear_extrude (h_loop + 2 * h_tol, convexity = 8)
                offset (w_tol)
                    key_section ();
        }
}
        
module key_part ()
{    
    color ("red")
        linear_extrude (h_loop, convexity = 8)
            key_section (solid = false);
}


module key_section (solid = true)
{
    translate ([0, l_loop/2 + l_grip/2 + l_hook - 5 * th_loop, 0])
    {
        // "Needle" shape
        hull ()
        {
            translate ([0, 2 * w_tol])
                csquare ([2 * th_loop - 2 * w_tol, l_grip - 4 * w_tol]);
            
            translate ([0, -l_grip/2])
                csquare ([epsilon, epsilon]);
        }
        
        // Cutout near the end
        if (solid)
            translate ([0, l_grip/2 - th_loop])
                csquare ([4.5 * th_loop, 2 * th_loop]);
        
        // Cutout for the end cap
        translate ([0, l_grip/2 - th_loop/2])
            csquare ([6 * th_loop, th_loop]);
        
        // Barbs
        if (solid)
            union ()
            {
                hull ()
                    little_barbs ();
                
                translate ([0, 2 * th_loop])
                    scale ([0.8, 0.8, 0.8])
                        hull ()
                            little_barbs ();
            }
        else
            little_barbs ();
    }
        
}

module hook_section ()
{
    difference ()
    {
        rsquare ([w_loop, l_loop], r_loop);
        
        rsquare ([w_loop - 2 * th_loop, l_loop - 2 * th_loop, h_loop], r_loop - th_loop);

        translate ([0, l_hook/2, 0])
            csquare ([w_gap, l_hook]);
    }

    translate ([0, l_loop/2 - th_loop + l_hook/2, 0])
        barb_pair (l_hook);
}


module barb_pair (l_barb)
{
    difference ()
    {
        union ()
        {
            csquare ([w_hook, l_barb]);

            translate ([0, l_barb/2, 0])
                union ()
                {
                    hull ()
                    {
                        translate ([0, -th_loop])
                            csquare ([w_hook + 2 * th_loop, epsilon, h_loop]);
                        
                        csquare ([w_hook, epsilon, h_loop]);
                    }
                    translate ([0, -3/2 * th_loop])
                        csquare ([w_hook + 2 * th_loop, th_loop, h_loop]);
                }
        }
        
        csquare ([w_hook - 2 * th_loop, l_barb + 2 * epsilon, h_loop + 2 * epsilon]);
    }
}

module little_barbs ()
{
    for (i = [-1, 1])
        translate ([0, l_grip/2 - 7 * th_loop])
            rotate ([0, 0, i * 60])
                translate ([i * 5/2 * th_loop, 0])
                    csquare ([5 * th_loop, th_loop/2]);
}

module rsquare (dim, r = 0.001)
{
    if (r <= dim [0]/2 && r <= dim [1]/2)
        hull ()
            for (i = [-1, 1], j = [-1, 1])
                translate ([i * (dim[0]/2 - r), j * (dim[1]/2 - r), 0])
                    circle (r);
else
    echo ("rsquare: corner radius too large [r, dim]:", r, dim [0], dim [1]);
}

module csquare (dim)
{
    square ([dim [0], dim [1]], center = true);
}

module rcube (dim, r = 0.001)
{
    if (r <= dim [0]/2 && r <= dim [1]/2 && r <= dim [2]/2)
        hull ()
            for (i = [-1, 1], j = [-1, 1], k = [-1, 1])
                translate ([i * (dim[0]/2 - r), j * (dim[1]/2 - r), (k + 1) * (dim [2]/2 - r) + r])
                    sphere (r, $fn = 32);
else
    echo ("rcube: corner radius too large [r, dim]:", r, dim [0], dim [1], dim [2]);
}


module cutdup (d = 0, h = 0, a = 1000)
{
    translate ([0, 0, d])
        difference ()
        {
            children ();
            
            translate ([0, 0, h - a/2])
                cube ([a, a, a], center = true);
        }
    
    translate ([0, 0, -d])
        difference ()
        {
            children ();
            
            translate ([0, 0, h + a/2])
                cube ([a, a, a], center = true);
        }
}