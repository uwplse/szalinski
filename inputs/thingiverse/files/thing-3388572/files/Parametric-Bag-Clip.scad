// Parametric Bag Clip - PLA compatible
// https://www.thingiverse.com/thing:3388572
// by Bikecyclist
// https://www.thingiverse.com/Bikecyclist
//
// Remixed from Bag Clip - PLA compatible
// https://www.thingiverse.com/thing:330151
// by MasterFX
// https://www.thingiverse.com/MasterFX


// Effective clip length - clamp bags of this width.
l_clip = 100;

// Width of clip (per arm)
w_clip = 5;

// Height of clip
h_clip = 10;

// Thickness of the hook
th_hook = 2;

// Thickness of the ridge
th_ridge = 1.5;

// Tolerance between parts
tol = 1;

// Opening angle for print (must be < 90 or parts will fuse)
alpha = 10;

/* [Hidden] */

// Number of facets
$fn = 64;

// Small distance to ensure proper meshing
eps = 0.01;


translate ([-(l_clip/2 + w_clip + tol), -w_clip/2, 0])
difference ()
{
    union ()
    {
        //Clip Body
        translate ([-tol/2, 0, 0])
        ccube ([l_clip + tol, w_clip, h_clip]);

        //Axle to Body Connection
        eye ();
        
        linear_extrude (h_clip, convexity = 10)
        projection (cut = false)
        intersection ()
        {
            eye ();
            
            translate ([2 * w_clip + tol + eps, 0, 0])
            ccube ([l_clip, w_clip, h_clip]);
        }
        
        //Hook Body
        translate ([-l_clip/2 - th_hook/2 - tol, (w_clip + th_hook + tol)/2, 0])
        ccube ([th_hook, 2 * w_clip + th_hook + tol, h_clip]);

        //Hook Barb
        translate ([-l_clip/2 - th_hook/2 - tol, 3/2 * w_clip + th_hook, 0])
        linear_extrude (h_clip)
        polygon 
        ([
            [0, th_hook/2 + tol],
            [3/2*th_hook, -tol],
            [-th_hook/2, -tol],
            [-th_hook/2, th_hook/2 + tol],
        ]);
    }
    
    //Hook Gap
    translate ([-l_clip/2 - tol/2, th_hook, -eps])
    ccube ([tol, w_clip, h_clip + 2 * eps]);
    
    //Flexibility Cut
    translate ([-(l_clip + tol)/2 + w_clip/2 + tol/2 - eps, -w_clip/2 + th_hook + tol/2, -eps])
    ccube ([w_clip, tol, h_clip + 2 * eps]);
    
    //Ridge Recess
    translate ([0, w_clip/2, h_clip/2])
    rotate ([45, 0, 0])
    cube ([l_clip + 2 * eps, sqrt(2) * th_ridge + tol/2, sqrt(2) * th_ridge + tol/2], center = true);
}

rotate ([0, 0, -alpha])
translate ([-(l_clip/2 + w_clip) - tol, -w_clip/2, 0])
translate ([0, w_clip, 0])
mirror ([0, 1, 0])
{
    //Axle
    translate ([l_clip/2 + w_clip + tol, 1/2 * w_clip, 0])
    cylinder (d = w_clip, h = h_clip);

    //Clip Body
    translate ([-tol/4, 0, 0])
    ccube ([l_clip + tol/2, w_clip, h_clip]);
    
    //Axle to Body Connection
    translate ([w_clip/2 + tol, 0, h_clip/2])
    cube ([l_clip + w_clip, w_clip, h_clip/2], center = true);
    
    //Ridge
    translate ([-tol/4, w_clip/2, h_clip/2])
    rotate ([45, 0, 0])
    cube ([l_clip + tol/2, sqrt(2) * th_ridge, sqrt(2) * th_ridge], center = true);

}

module eye ()
{
    for (i = [-1, 1])
    translate ([w_clip + tol, 0, h_clip/2 - (h_clip/4 - tol)/2 + i * (h_clip/2 - (h_clip/4 - tol)/2)])
    difference ()
    {
        union ()
        {
            translate ([l_clip/2, w_clip/2, 0])
            cylinder (d = 2 * w_clip, h = h_clip/4 - tol);
            
            ccube ([l_clip, w_clip, h_clip/4 - tol]);
        }
        
        translate ([l_clip/2, w_clip/2, 0])
        translate ([0, 0, -eps])
        cylinder (d = w_clip + tol, h = h_clip + 2 * eps);
    }

}

module ccube (dim)
{
    translate ([0, 0, dim [2]/2])
    cube ([dim [0], dim [1], dim [2]], center = true);
}