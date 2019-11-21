// Standard Wall
// V3 by Bikecyclist, 07 October 2018: Customizer doesn't speak boolean?!
// V2 by Bikecyclist, 07 October 2018: Customizer Syntax Fix
// V1 by Bikecyclist, 07 October 2018
// https://www.thingiverse.com/thing:3142698
//
// For use with Modular Castle Playset:
// https://www.thingiverse.com/thing:1930665
//
// More things for the Modular Castle Playset: https://www.thingiverse.com/Bikecyclist/collections/modular-castle-playset

// Wall thickness
d = 3;

// Wall thickness for walls with connectors
dx = 7;

// Bottom Chamfer
c = 1;

// Top Chamfer
tc = 0.5;

// Solid core - uses more material, depending on slicer settings (0 = no solid core)
is_solid = 0;

// Add brims for printing? These are easier to remove than the slicer's. (0 = no brims)
has_brims = 0;

// Number of facets for rounded elements
$fn = 128;

// Small distance to ensure proper meshing
epsilon = 0.01;

standard_wall (is_solid);

if (has_brims != 0)
    brims ();

module brims ()
{
    for (i = [-1, 1])
        translate ([80/2 * i, 0, 0])
            hull ()
                for (j = [-1, 1])
                    translate ([0, 40/2 * j, 0])
                        cylinder (d = 9, h = 0.3);
}

module standard_wall (solid = 0)
{
    difference ()
    {
        ccube ([80 + epsilon, 40 + epsilon, 34 + epsilon], c, 0);
        
        if (solid == 0)
          epstep (-1)
            intersection ()
            {
                rotate ([0, 90, 0])
                    translate ([0, 0, -(80 - 2 * dx)/2])
                        linear_extrude (80 - 2 * dx)
                            arc (34 - d, 8);
                
                ccube ([80 - 2 * d, 40 - 2 * d, 34 - d]);
            }
        
        epstep (-1)
            for (i = [-1, 1])
                translate ([80/2 * i, 0, 0])
                    connectivity (i);
    }


    for (j = [-1, 1])
    {
        translate ([0, j * (40/2 - 10/2), 34])
        {
            ccube ([80, 10, 6], 0, tc, true);

            for (i = [-1:1])
                translate ([26.75 * i, 0, 0])
                        ccube ([15, 10, 12], 0, tc);
        }
    }
}
    
module ccube (c, bc = 0, tc = 0, xonly = false)
{  
    bcx = xonly ? 0 : bc;
    tcx = xonly ? 0 : tc;
    
    hull ()
    {
        translate ([0, 0, (c[2] + bc - tc)/2])
            cube ([c[0], c[1], c[2] - bc - tc], center = true);
        
        translate ([0, 0, c[2] - tc/2])
            cube ([c[0] - 2 * tcx, c[1] - 2 * tc, tc], center = true);
    }

    hull ()
    {
        translate ([0, 0, (c[2] + bc - tc)/2])
            cube ([c[0], c[1], c[2] - bc - tc], center = true);
        
        translate ([0, 0, bc/2])
            cube ([c[0] - 2 * bcx, c[1] - 2 * bc, bc], center = true);
    }
}


module epstep (s)
{
    translate ([0, 0, s * epsilon])
        children ();
}

module arc (ra, h)
{
    translate ([-h, -ra/2, 0])
        union ()
        {
            intersection ()
            {
                circle (ra);
                
                translate ([0, ra, 0])
                    circle (ra);
                
                translate ([-ra, 0, 0])
                    square ([ra, ra]);
            }
            square ([h, ra]);
        }
}

module connectivity (i)
{
    connector_hole ();

    rotate ([0, 0, -i * 90])
    {
        translate ([0, 0, 27.5])
            rotate ([90, 0, 0])
                cylinder (d1 = 2.2, d2 = 1.75, h = 7.5);

        translate ([0, 0 + 1e-2, 27.5])
            rotate ([90, 0, 0])
                cylinder (d1 = 3.2, d2 = 0, h = 1.6);
    }
}

module connector_hole ()
{
    h = 17;
    wl = 15.7;
    
    wcl = 5.82;
    ll = 23.75;
    rl = 3.25;
    r2l = 1;
    offl = 7.75;
    
    wcu = 3.44;
    lu = 20.68;
    ru = 3;
    r2u = 1;
    yu = -1.5;
    du = 0.81 + ru + r2u;
    
    hull()
    {
        cube ([ll, wcl, epsilon], center = true);
        
        translate ([0, 0, h])
            cube ([lu, wcu, epsilon], center = true);
    }
 
    connector_hole_dovetail ();
    
    mirror ([1, 0, 0])
        connector_hole_dovetail ();
    
    module connector_hole_dovetail ()    
    {
        hull()
        {
            for (i = [-1, 1])
            {
                translate ([offl, i * (wl/2 - rl), 0])
                    cylinder (r = rl, epsilon);
                
                translate ([ll/2 - r2l, i * (wl/2 - r2l), 0])
                    cylinder (r = r2l, epsilon);
                    
                difference ()
                {
                    translate ([lu/2 + ru - du, i * (wl/2 - ru + yu), h])
                        cylinder (r = ru, epsilon);
                        
                    translate ([lu/2 + ru - du, -wl/2, h])
                        cube ([ru, wl, 0.1]);
                }

                translate ([lu/2 - r2u, i * (wl/2 - r2u + yu), h])
                    cylinder (r = r2u, epsilon);
            }
        }
    }
}