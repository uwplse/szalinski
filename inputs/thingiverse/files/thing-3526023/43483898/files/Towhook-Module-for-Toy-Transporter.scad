// Towhook Module (Playmobil compatible) for Toy Transporter
// https://www.thingiverse.com/thing:3526023
// by Bikecyclist: 
// https://www.thingiverse.com/Bikecyclist
//
// Remix of/suitable for:
// Toy-Transporter
// https://www.thingiverse.com/thing:3449335
// by Schwiizer:
// https://www.thingiverse.com/Schwiizer

// Depth of the towhook module
dpt = 11;

// Small distance to ensure proper meshing
eps = 0.01;

// Diameter of cutout
d_cutout = 25;

// Diameter of hook
d_hook = 3.8;

// Length of hook
l_hook = 9.5;

// Distance the hook is behind the back plate
y_hook = 11;

// Height of hook
h_hook = 13;

// Extra width of the mounting block at the back of the truck
xw = 10;

// Total height of the mounting block
hh = 21.5;

// Number of facets
$fn = 64;

rotate ([0, 0, 180])
towhook ();

module towhook ()
{
    {
        difference ()
        {
            union ()
            {
                hull ()
                {
                    towblock (hh, xw);
                    
                    linear_extrude (eps)
                    offset (-0.5)
                    projection (cut = false)
                    towblock (hh, xw);
                }
                
                hull ()
                {
                    towblock (hh, xw);
                    
                    translate ([0, 0, hh - eps + 1])
                    linear_extrude (eps)
                    offset (-0.5)
                    projection (cut = true)
                    translate ([0, 0, -hh + eps])
                    towblock (hh, xw);
                }
            }
            
            translate ([0, d_cutout/2 + y_hook - 2 * d_hook, h_hook])
            cylinder (d = d_cutout, h = l_hook + eps);
            
            translate ([0, -1, h_hook - eps])
            cube ([32 + xw + 2 * eps, 4, 26], center = true);
            
            translate ([0, 0, 16/2 - eps])
            cube ([30, 4, 16], center = true);
        }
        
        hull ()
        {
            translate ([0, y_hook - d_hook/2, h_hook])
            cylinder (d = d_hook, h = l_hook - 0.5);
            
            translate ([0, y_hook - d_hook/2, h_hook])
            cylinder (d = d_hook - 1, h = l_hook);
        }
    }
}

module towblock (hh, xw = 0)
{
    hull ()
    {
        translate ([0, -1, hh/2 + 0.5])
        cube ([30 + xw, eps, hh], center = true);
        
        translate ([0, (dpt - 1)/2, hh/2 + 0.5])
        cube ([30, dpt - 0.5, hh], center = true);
            
        translate ([0, dpt/2, hh/2 + 0.5])
        cube ([29, dpt, hh], center = true);
    }
}