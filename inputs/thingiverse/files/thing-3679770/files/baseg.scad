/*
 * Warhammer base genrator
 * Not an official GW product
 *
 * Édouard Denommée
 * 2019-06-08
 */



// Length of the base
length = 32;
// Width of the base
width = 32;

// Height of the base
height = 4;
// Top of base inset
retraction = 2.5;

// Circle resolution
$fn = 128;





module CircularBase (size = [length, width, height], inset = retraction)
{
    linear_extrude (height = size[2], scale = [
        (size[0] - inset) / size[0],
        (size[1] - inset) / size[1] ])
    {
        scale ([size[0], size[1]])
        {
            circle(d=1);
        }
    }
}
CircularBase();

