// Parametric Power Strip Tray
// Designed by BikeCyclist
// https://www.thingiverse.com/thing:3095108
// V1: 11 September 2018

// Inner Width of the Tray at the Bottom - Size to match your Power Strip
w_bottom_inner = 56;

// Inner Width of the Tray at Middle Height - Size to match your Power Strip
w_middle_inner = 62;

// Inner Width of the Clamp at the Top - Size to match your Board for Mounting
w_clamp_top = 22.5;

// Inner Width of the Clamp at the Bottom - slightly smaller than Top Width for Springiness
w_clamp_bottom = 21;

// Inner Length of the Tray at the Bottom - Size to match your Power Strip
l_bottom = 137;

// Inner Length of the Tray at Middle Height - Size to match your Power Strip
l_middle = 145;

// Height of Middle Height - Size to match your Power Strip
h_middle = 18;

h_total = 2 * h_middle;

// Wall Thickness for Tray
th_wall = 0.7;

// Wall Thickness for Hook
th_wall_hook = 2;

w_bottom = w_bottom_inner + th_wall;
w_middle = w_middle_inner + th_wall;

// Controls Brim for Printing
STL_has_brims = false; //[false, true]

// Diameter of Extension Cord Cable
dia_cable = 10;

// Number of Facets
$fn = 128;

// Small Distance to ensure Proper Meshing
epsilon = 0.01;

rotate ([0, 0, 180])
{
    if (STL_has_brims)
    {
        for (i = [-1,1], j = [-1, 1])
            translate ([-i * w_bottom/2, j * l_bottom/2, 0])
                cylinder (d = 30, h = 0.3);

        hull ()
            for (j = [-1, 1])
                translate ([-w_bottom/2 - w_clamp_bottom, j * l_bottom/2, 0])
                    cylinder (d = 30, h = 0.3);
            
        *for (j = [-1, 1])
                translate ([-w_bottom/2 - w_clamp_bottom , j * l_bottom/2 - 0.5, 10])
                    cube ([13, 0.5, 20], center = true);
    }

    difference ()
    {
        union ()
        {
            hull ()
            {
                hook ();
                
                difference ()
                {
                    tray_shape ();
                    
                    translate ([- dia_cable/2, -l_middle/2 - epsilon, -epsilon])
                        cube ([w_middle, l_middle + 2 * epsilon, h_middle + 2 * epsilon]);
                }
            }
            tray_shape ();
        }
        
        tray_cutouts ();
        hook_cutouts ();
    }
}

module hook ()
{
    translate ([-(w_middle + w_clamp_top)/2, 0, 0])    
    {
        hull()
        {
            translate ([0, 0, h_middle + epsilon/2])
                cube ([2 * th_wall_hook + w_clamp_top, l_middle, epsilon], center = true);
            
            translate ([0, 0, h_total/2 - (2 * th_wall_hook - w_clamp_top)/2])
                rotate ([90, 0, 0])
                    difference ()
                    {
                        cylinder (d = 2 * th_wall_hook + w_clamp_top, h = l_middle, center = true);
                        translate ([0, -(2 * th_wall_hook + w_clamp_top)/2, 0])
                            cube ([(2 * th_wall_hook + w_clamp_top), (2 * th_wall_hook + w_clamp_top), l_middle + 2 * epsilon], center = true);
                    }
        }
        
        hull()
        {
            translate ([0, 0, h_middle + epsilon/2])
                cube ([2 * th_wall_hook + w_clamp_top, l_middle, epsilon], center = true);
            
            translate ([0, 0, epsilon/2])
                cube ([2 * th_wall_hook + w_clamp_top, l_bottom, epsilon], center = true);
        }
    }
}

module hook_cutouts ()
{
    translate ([-(w_middle + w_clamp_top)/2, 0, 0])    
        union ()
        {
            hull ()
            {
                translate ([0, -epsilon, h_middle])
                    cube ([w_clamp_top, l_middle + 2 * epsilon, epsilon], center = true);
                
                translate ([0, 0, -epsilon/2])
                    cube ([w_clamp_bottom, l_middle, epsilon], center = true);
            }
            
            hull ()
            {
                translate ([0, 0, h_middle])
                    cube ([w_clamp_top, l_middle, epsilon], center = true);
                
                translate ([0, 0, h_total/2 - (2 * th_wall_hook - w_clamp_top)/2])
                    rotate ([90, 0, 0])
                        cylinder (d = w_clamp_top, h = l_middle + 4 * epsilon, center = true);
            }
        }
}


module tray ()
{
    difference ()
    {
        tray_shape ();
        
    }
}

module tray_cutouts ()
{
    translate ([0, 0, th_wall + 2 * epsilon])
        resize ([w_middle - 2 * th_wall, l_middle - 2 * th_wall, h_middle - th_wall])
                tray_shape ();
        
    translate ([0, 0, h_middle - epsilon + h_total/2])
        resize ([w_middle - 2 * th_wall, l_middle - 2 * th_wall, h_total])
            cube ([1, 1, 1], center = true);
    
    translate ([0, -l_bottom/2 + th_wall + epsilon, h_middle])
        rotate ([90, 0, 0])
            cylinder (d = dia_cable, h = l_bottom/2);
    
    translate ([0, -(-l_bottom/2 + th_wall + epsilon), h_middle])
        rotate ([-90, 0, 0])
            cylinder (d = dia_cable, h = l_bottom/2);
}


module tray_shape ()
hull ()
{
    cube ([w_bottom, l_bottom, epsilon], center = true);
    
    translate ([0, 0, h_middle])
        cube ([w_middle, l_middle, epsilon], center = true);
}