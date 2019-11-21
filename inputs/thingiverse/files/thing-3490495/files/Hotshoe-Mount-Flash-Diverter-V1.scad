// Parametric Hotshoe Mount Flash Diverter V1
// https://www.thingiverse.com/thing:3490495
// by Bikecyclist
// https://www.thingiverse.com/Bikecyclist


/* [Reflector Parameters] */

// Reflector vertical extension (when mounted)
z_reflector = 50;

// Reflector horizontal width
w_reflector = 65;

// Reflector angle from horizontal (degrees)
a_reflector = 45;

// Reflector horizontal distance (bottom edge, from forward hotshoe foot surface)
d_reflector = 60;

/* [Mount Parameters] */

// Thickness of mount and reflector plate
th_mount = 2;

// Mount width at the rear
w_rear_center = 22;

// Mount height at the rear (above hotshoe foot and leg)
h_rear = 2;

// Horizontal distance where the mount is clear from the flash(from forward hotshoe foot surface)
d_clear_rear = 8;

// Minimum width needed to clear the extending flash (flash width plus generous tolerance)
w_min_clear = 45;

// Chamfer radius for mount parts
r_frame = 1;

/* [Hot Shoe Dimensions] */

// Tolerance for the hot-shoe foot and leg
foot_tol = 0.5; // default = 0.5

// Nominal width of the hot shoe "leg"
w_leg_nominal = 12.5; // default = 12.5

// Height of the hot shoe leg
h_leg = 2; // default = 2

// Nominal width of the hot shoe foot
w_foot_nominal = 18.1;

// Nominal length of the hot shoe foot
l_foot = 16.5;

// Nominal height of the hot shoe foot
h_foot_nominal = 1.99;

// Corner radius of the hot shoe foot
r_foot = 2;

w_foot = w_foot_nominal - foot_tol;
h_foot = h_foot_nominal - foot_tol;
w_leg = w_leg_nominal - foot_tol;

/* [Hidden] */

// Minimum Facet Angle
$fa = 8;

// Minimum Facet Size
$fs = 0.2;

// Small distance to ensure proper meshing
eps = 0.01;




translate ([0, -l_foot/2, 0])
{
    foot ();
    body ();
    
    translate ([0, l_foot + d_reflector + th_mount / cos (a_reflector), th_mount/2])
    rotate ([-90 + a_reflector, 0, 0])
    translate ([0, -(l_foot/2 + 0.5 * th_mount/cos (a_reflector) + d_reflector), 0])
    adapter (z_reflector);
}

module foot ()
{
    translate ([0, 0, h_foot])
        rcube ([w_leg, l_foot, h_leg], r_foot);

    rcube ([w_foot, l_foot, h_foot], r_foot);
}

module adapter (h_adapter)
{
    translate ([0, l_foot/2 + 0.5 * th_mount/cos (a_reflector) + d_reflector, 0])
    hull ()
    {
        rcube ([w_reflector, th_mount/cos (a_reflector), eps], r_frame);
        
        translate ([0, h_adapter * tan (a_reflector), h_adapter])
        rcube ([w_reflector, th_mount/cos (a_reflector), eps], r_frame);
    }
}

module body ()
{
    intersection ()
    {
        union ()
        {
            // Rear Top
            translate ([0, 0, h_leg + h_foot - eps])
            rcube ([w_rear_center + 2 * th_mount, l_foot, h_rear], r_frame);
            
            for (i = [-1, 1])
            hull ()
            {
                // Rear Sides
                translate ([i * (w_rear_center/2 + th_mount/2), 0, 0])
                rcube ([th_mount, l_foot, h_leg + h_foot + h_rear], r_frame);
                
                // Rear Min Width
                translate ([i * (w_min_clear/2 + th_mount/2), l_foot/2 + d_clear_rear, 0])
                cylinder (d = th_mount, h = h_leg + h_foot + h_rear);
            }
            
            for (i = [-1, 1])
            hull ()
            {
                // Rear Min Width
                translate ([i * (w_min_clear/2 + th_mount/2), l_foot/2 + d_clear_rear, 0])
                cylinder (d = th_mount, h = h_leg + h_foot + h_rear);
                
                // Front reflector carrier
                l = (h_leg + h_foot + h_rear)/cos (a_reflector);
                translate ([i * (w_reflector - th_mount)/2, d_reflector + l_foot + (l - l_foot + th_mount)/2, 0])
                rcube ([th_mount, l + th_mount, h_leg + h_foot + h_rear], r_frame);
            }
            
            adapter (h_leg + h_foot + h_rear);
        }
        
        hull ()
        {
            adapter (h_leg + h_foot + h_rear);
            
            translate ([0, -2 * d_reflector, 0])
            adapter (h_leg + h_foot + h_rear);
        }
    }
    
}

module rcube (dim, r)
{
    linear_extrude (dim [2])
    hull ()
    for (i = [-1, 1], k = [-1, 1])
        translate ([i/2 * (dim [0] - 2 * r), k/2 * (dim [1] - 2 * r)])
        circle (r = r);
}
