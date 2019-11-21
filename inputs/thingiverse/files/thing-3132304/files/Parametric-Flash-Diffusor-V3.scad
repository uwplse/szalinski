// Parametric Flash Diffusor
// V2 by Bikecyclist, 20 October 2019
// V2 by Bikecyclist, 04 October 2018
// V1 by Bikecyclist, 02 October 2018
// https://www.thingiverse.com/thing:3132304


// Vertical angle between the flash body and the lens axis
alpha = 25;

// Radius of the circular diffusor (outer radius if it's a polygon)
r = 33;

// Ellipse ratio (1 = circular)
er = 1.0;

// Width of flash body section
wflash = 39;

// Height of flash body section
hflash = 12.5;

// Reduction of body section dimensions to achieve clamping effect
dclamp = 0.5;

// Funnel length ... total length is radius + funnel length
l = 20;

// Wall thickness - keep it thin so it remains transparent
th = 0.5;

// Number of facets - try 4 for a square diffusor, 6 for a hexagon-shaped one, etc.
front_facets = 128;

// Number of facets
$fn = 128;

// Small distance to ensure proper meshing - normally no need to change it
epsilon = 0.01;

// Rotation angle of polygonal front face
anglefront = 90 - 180/front_facets + 180/front_facets * (front_facets % 2);


union ()
{
    difference ()
    {
        funnel (wflash - dclamp, hflash - dclamp, l, th);
        
        translate ([0, 0, epsilon])
            funnel (wflash - dclamp, hflash - dclamp, l + 2 * epsilon, 0);
    }
    
    translate ([0, 0, -l - r])
        resize ([er * r, r, th])
            rotate ([0, 0, anglefront])
                cylinder (r = r, h = th, $fn = front_facets);
}

module funnel (x, y, l, d)
{
    hull ()
    {
        translate ([0, 0, -l/2])
            rotate ([alpha, 0, 0])
                cube ([x + 2 * d, y + 2 * d, l], center = true);
        
        translate ([0, 0, - r - l])
            resize ([er * (r + 2 * d), r + 2 * d, 0.01])
                rotate ([0, 0, anglefront])
                    cylinder (r = r + d, h = 0.01, center = true, $fn = front_facets);
    }
}