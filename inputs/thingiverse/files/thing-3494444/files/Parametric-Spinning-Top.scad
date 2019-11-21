// Parametric Spinning Top
// https://www.thingiverse.com/thing:3494444
// by Bike Cyclist
// https://www.thingiverse.com/Bikecyclist
//
// Remix of
//
// spinning disk top / gyroscope, three-part, can be assembled without gluing 
// https://www.thingiverse.com/thing:3490151
// by schutzi99
// https://www.thingiverse.com/schuetzi99


/* [Rendering] */

// Rendering
rendering = 1; // [0:assembled, 1:for printing]

/* [Main Dimensions] */

// Total diameter of the top
d_top = 75;

// Thickness of the outer ring (greater for more inertia)
d_ring = 8;

// Thickness of the disk
th_body = 2;

/* [Stalk Dimensions] */

// Diameter of the stalk near the tip
d_upper = 5;

// Length of the stalk
h_upper = 50;

/* [Foot Dimensions] */

// Length of the foot
h_bottom = 15;

// How war down the foot does the foot taper into the point? (Default: 0.9 = 90% of the distance)
taper_point = 0.9;

// Diameter of the foot body at the taper point
d_foot = 5;

// Diameter of the ground contact point
d_point = 1;

/* [Centering Hole Dimensions] */

// Diameter of the centering holes (fit in piece of 1.75 mm filament to center both halves)
d_centering_hole = 2.3;

// Depth of the centering hole in each side (piece of filament used for centering needs to be just short of twice that length)
z_centering_hole = 5;

/* [Hidden] */

// Small distance to ensure proper meshing
eps = 0.01;

// Number of facets
$fn = 64;

if (rendering == 0)
{
    upper_part ();
 
    mirror ([0, 0, 1])   
    lower_part ();
}
else
{
    translate ([-d_top/2 - d_ring, 0])
    upper_part ();

    translate ([d_top/2 + d_ring, 0])
    lower_part ();
}

module upper_part ()
{
    centering_pin_hole ()
    intersection ()
    {
        lift (-h_bottom - th_body/2)
        spinning_top ();
        
        cylinder (d = d_top + 2 * eps, h = h_upper + th_body/2 + d_upper + eps);
    }
}

module lower_part ()
{
    centering_pin_hole ()
    intersection ()
    {
        mirror ([0, 0, 1])
        lift (-h_bottom - th_body/2)
        spinning_top ();
        
        cylinder (d = d_top + 2 * eps, h = h_bottom + th_body/2 + eps);
    }
}

module centering_pin_hole ()
{
    difference ()
    {
        children ();
        
        lift (-eps)
        cylinder (d = d_centering_hole, h = z_centering_hole);
    }
}

module spinning_top ()
{
    bottom ();
    upper ();
    ring ();
}

module ring ()
{
    lift (h_bottom + th_body/2)
    rotate_extrude ()
    translate ([d_top/2 - d_ring/2, 0])
    circle (d = d_ring);
}

module upper ()
{
    lift (h_bottom + th_body/2)
    cylinder (d = d_top - d_ring, h = th_body/2);
    
    lift (h_bottom + th_body)
    cylinder (d1 = 2 * d_upper, d2 = d_upper, h = h_upper);
    
    lift (h_bottom + th_body + h_upper)
    sphere (d = d_upper);
}

module bottom ()
{
    cylinder (d1 = d_point, d2 = d_foot, h = h_bottom * (1 - taper_point));

    lift (h_bottom * (1 - taper_point))
    cylinder (d1 = d_foot, d2 = 2 * d_foot, h = h_bottom * taper_point);

    lift (h_bottom)
    cylinder (d = d_top - d_ring, h = th_body/2);
}


module lift (z)
{
    translate ([0, 0, z])
        children ();
}
