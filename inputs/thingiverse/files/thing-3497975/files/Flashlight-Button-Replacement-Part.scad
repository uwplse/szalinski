// Flashlight Button Replacement Part
// https://www.thingiverse.com/thing:3497975
// by Bike Cyclist
// https://www.thingiverse.com/Bikecyclist

// Tolerance in circumference
tol = 0.5;

// Thickness of the button top
d = 1;

// Height of the button
h =  7;

// Width of the button
w = 12;

// Length of the button
l = 18;

// Edge Radius of the button
r_edge = 8;

// Diameter of the flashlight body
dia = 30;


/* [Hidden] */
// number of facets
$fn = 64;

// Small number to ensure proper meshing - normally no need to change
epsilon = 0.01;

union ()
{
    intersection ()
    {
        difference ()
        {
            oval_cube (l, w, h);
            
            up (d)
                eps (1)
                    oval_cube (l - 2 * d, w - 2 * d, h - d);
            
            up (15 + 5)
                rotate ([90, 0, 90])
                    cylinder (d = dia, h = l + 2 * epsilon, center = true);
        }
        
        hull ()
            for (i = [-1, 1], j = [0, 1])
                translate ([i * 3, 0, h + 10 * j])
                    sphere (r = r_edge);

    }

    up (d)
    {
        oval_cube (11 - tol, 4 - tol, h - d);
        
        
        up (h - d)
            {
                oval_cube (10 - tol, 3 - tol, 11);
            

            up (4)
            {
                hull ()
                {
                    oval_cube (6, 2, epsilon);
                    
                    up (1)
                        oval_cube (6, 3.5, epsilon);
                    
                    up (3)
                        oval_cube (6, 2, epsilon);
                }
            }
        }
    }
}

module oval_cube (w, d, h)
{
    linear_extrude (h)
        hull ()
            for (i = [-1, 1])
                translate ([i * (w/2 - d/2), 0])
                    circle (r = d/2);
}

module eps (f = 1)
{
    up (f * epsilon)
        children ();
}

module up (d = 0)
{
    translate ([0, 0, d])
        children ();
}