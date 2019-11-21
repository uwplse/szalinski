// Parametric Headphone Holder for Monitor
// May 08, 2019
// https://www.thingiverse.com/thing:3617042
// by Bikecyclist
// https://www.thingiverse.com/Bikecyclist
//
// Remix of
//
// Headphonestand for Monitor
// https://www.thingiverse.com/thing:3483155
// by 
// https://www.thingiverse.com/ZibbiDasZebra

/* [Main Parameters] */

// Length of monitor top (front to back)
monitor_len = 30;

// Height of hook on monitor front edge (bottom to top)
h_front = 20;

// Angle of support on monitor backside (0 = vertical)
a_sup = 35;

// Number of facets
$fn = 32;

/* [Secondary Parameters] */

// Length of hook for headphone
l_hook = 60;

// Depth of curved indentation in hook (don't go too deep - remember Moria!)
d_hook = 10;

// Length of monitor support (can usually remain unchanged)
l_sup = 35;

// Width of the hook (left to right)
w_hook = 10;

// Thickness of hook material
th = 2.25;

/* [Hidden] */

// Small distance to ensure proper meshing
eps = 0.01;

/* Now unused code for important ZibbiDasZebra's original design for reference
color ("red")
mirror ([0, 1, 0])
translate ([44.25 + 2.25/2, -1.8, -11])
import ("headphonestand_for_monitor.stl");
*/

hook (w_hook);

module hook (h)
{
    linear_extrude (h)
    {
        offset (-th/2 * 0.9)
        offset (th/2 * 0.9)
        difference ()
        {
            offset (th/2 * 0.9)
            offset (-th/2 * 0.9)
            hook_xsection ();
            
            offset (-th)
            hook_xsection ();
        }
    }
}

module hook_xsection ()
{
    translate ([0, -th])
    square ([th, monitor_len + 2 * th]);

    translate ([-h_front, monitor_len])
    square ([h_front + th, th]);

    difference ()
    {
        hull ()
        {
            rotate ([0, 0, a_sup])
            translate ([-l_sup/2, -th/2])
            square ([l_sup, th], center = true);
            
            translate ([th/2, -l_hook + th])
            square ([th, th], center = true);
            
            translate ([th/2, -th/2])
            square ([th, th], center = true);
        }
        
        translate ([th + th, -(l_hook - th)/2])
        resize ([2 * d_hook, l_hook - 2 * th])
        circle (d = l_hook);
    }
}