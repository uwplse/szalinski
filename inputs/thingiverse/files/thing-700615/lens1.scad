// Not an actual lens, useful as frosted cover for a light.
// Hari Wiguna, 2015

// Outer radius of the base of the lens
r = 30;

// Height of the lens (from base to center top of lens)
h = 10;

// How thick is the lens itself
thickness = 1;

// Resolution
res = 50;

$fn = res;
rs = r - thickness;

translate([0,0,-(r-h)])
    lens();

module lens()
{
    difference()
    {
        intersection()
        {
            sphere(r);        

            translate([-r,-r,r-h])
                cube([2*r,2*r,h]);    
        }

        sphere(rs);        
    }
}