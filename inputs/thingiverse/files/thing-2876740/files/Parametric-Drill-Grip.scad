$fn=32;

// Parametric Drill Handle by Bikecyclist
// https://www.thingiverse.com/thing:2876740
// V4: Even better use of thingiverse customizer interface!
// V3: Even better use of thingiverse customizer interface
// V2: Better use of thingiverse customizer interface, recessed knurls as optional style
// V1: First release

//CUSTOMIZER VARIABLES

/* [Grip] */

grip_diameter = 40;     // [0:100]

grip_length = 60;       // [0:200]

// (must be < grip diameter/2)
grip_roundness = 10;    // [0.0:49.9]

/* [Nut] */

// Nominal nut size, i. e. 6.35 mm = 1/4 inch 
nut_size = 6.35;

// Nut's outer opening is oversized and tapers down to nominal to allow squeeze-fit */
nut_recess_taper = 0.4;

/* [Knurls] */

// Diameter of cylindrical knurls
knurl_diameter = 10;    // [0:20]

// Style of knurls
knurls = 1;             // [0:protuding,1:recessed]

//CUSTOMIZER VARIABLES END

n_knurls = floor (PI * grip_diameter / knurl_diameter / 1.5);

if (knurls == 0)
    union ()
    {
        plain_grip ();
        knurls (1);
    }
else
    difference ()
    {
        plain_grip ();
        knurls (2);
    }

module plain_grip ()
{
    difference ()
    {
        minkowski()
        {
            cylinder (d = grip_diameter - 2 * grip_roundness, h = grip_length - 2 * grip_roundness);
            sphere (grip_roundness);
        }
        translate ([0, 0, - grip_roundness - 1])
            cylinder (d1 = nut_size / (sqrt(3)/2), d2 = nut_size / (sqrt(3)/2)+ nut_recess_taper, h = grip_length + 2, $fn=6);
    }
}

module knurls (z_scale)
{
    scale ([1, 1, z_scale])
        for (i = [1:n_knurls])
                rotate ([0, 0, 360 / n_knurls * i])
                    translate ([grip_diameter/2, 0, 0])
                        union ()
                        {
                            cylinder (d = knurl_diameter, h = grip_length - 2 * grip_roundness);
                            
                            translate ([0, 0, grip_length - 2 * grip_roundness])
                                sphere (d = knurl_diameter);
                            
                            translate ([0, 0, 0])
                                sphere (d = knurl_diameter);
                            
                        }
}