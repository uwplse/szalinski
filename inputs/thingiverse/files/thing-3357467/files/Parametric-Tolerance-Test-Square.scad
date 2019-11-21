// Parametric Print-in-Place Test
// V1: 15 January 2019
// https://www.thingiverse.com/thing:3357467
// by Bikecyclist
// https://www.thingiverse.com/Bikecyclist

// Edge length of bolt
bolt_edge = 8;

// Tolerance between bolt edge and hole edge
tol = 0.25;

// Total height
h_total = 6;

// Wall thickness ("waist" is 50% of this)
th_wall = 4;

// Minimum chamfer depth (normally no need to change this)
chamfer_depth = 0.75;

/* [ HIDDEN ] */
// Small finite length to ensure proper meshing
epsilon = 0.01;

translate ([0, 0, epsilon])
{
    half_test_body ();

    rotate ([180, 0, 0])
    translate ([0, 0, -h_total])
    half_test_body ();
}

module half_test_body ()
{
    difference ()
    {
        union ()
        {
            difference ()
            {
                cylcube (d1 = bolt_edge + th_wall + 2 * tol, d2 = bolt_edge + th_wall/2 + 2 * tol, h = h_total/2);
                
                translate ([0, 0, -epsilon])
                cylcube (d = bolt_edge + 2 * tol, h = h_total/2 + 2 * epsilon);
            }
            cylcube (d = bolt_edge, h = h_total/2);
        }
        
        rotate ([0, 0, 45])
        rotate_extrude ($fn = 4)
        translate (sqrt(2) * [bolt_edge/2, 0])
        circle (r = tol + chamfer_depth, $fn = 4);
    }
}

module cylcube (d = 0, d1, d2, h)
{
    dd1 = d==0?d1:d;
    dd2 = d==0?d2:d;
    
    echo (dd1, dd2, h);
    
    hull ()
    {
        cube ([dd1, dd1, epsilon], center = true);
        
        translate ([0, 0, h])
        cube ([dd2, dd2, epsilon], center = true);
    }
}