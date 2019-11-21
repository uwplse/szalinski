// Parametric Teabag Holder
// V1.0 by BikeCyclist
// https://www.thingiverse.com/thing:3117550


// Inner Diameter
d0 = 105;

// Width of Brim
width = 8;

// Elongation of Elliptical "Tail" in relation to circle (1.3)
elongation = 1.3;

// Number of Facets
$fn = 256;


difference ()
{
    clamp ();
    
    for (i = [0, 1])
        translate ([25 - width/2, (2 * i - 1) * 48.3, 5])
            mirror ([0, i, 0])
                difference ()
                {
                    translate ([d0/2, 0, 0])
                        cube ([d0, d0, 12], center = true);
                    
                    cylinder (d = width * elongation, h = 14, center = true);
                }
}



module clamp ()
{
    difference ()
    {
        // Main Body
        scale ([elongation, 1, 1])
            cylinder (d = d0 + width/2, h = 10);
            
        // Cutout for Tea Can Top Brim
        translate ([0, 0, 3 - 0.01])
            cylinder (d = d0, h = 2);
        
        // Conical Transition from Top Brim to Main Can Diameter
        translate ([0, 0, -0.1])
            cylinder (d2 = d0, d1 = d0 - 1, h = 3.1);
        
        // Through Hole
        translate ([0, 0, -5])
            cylinder (d = d0 - width/2, h = 20);
        
        // Cutoff
        translate ([d0 + 25 + width/2, 0, 0])
            cube ([2 * d0, 2 * d0, 2 * 20], center = true);
        
        // Cuts for Teabag String
        for (i = [-1:1:1])
            translate ([-d0/2 - d0 * elongation/2 - width/2, 5 * i, 5])
                cube ([d0 * elongation, 1, 20], center = true);
        
        // Cut for Teabag Cardboard
        translate ([-d0/2 - width, 0, 0])
            cube ([1, 60, 10], center = true);
    }
}