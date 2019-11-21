// Cycle Mirror Handlebar Plug Mount
// https://www.thingiverse.com/thing:3447542
// V2 by Bikecyclist
// https://www.thingiverse.com/Bikecyclist


// Physical length of M4 screw. 20 mm and shorter not recommended.
l_screw = 40;

// Screw overhang for easier installation. Should normally be 0 to 8 mm. With short screws use 0, with longer screws you can use overhang to make installation a bit easier.
l_screw_overhang = 3;

// Maximum diameter of the plug (at the outer end)
dia_max = 15;

// Taper of the plug (in mm)
taper = 1.5;

// Tolerance for screw
tol = 0.2;

// Extra size for the cone (in mm) - use this to increase friction if the plug still rotates with the cone against the stop)
cone_extra = 0;

/* [Hidden] */

$fn = 64;
eps = 0.01;

l_screw_eff = l_screw - l_screw_overhang;
dia_min = dia_max - taper;

//cutdup (25)
{
    translate ([30, 0, 0])
    plug ();
    
    translate ([-25, 0, l_screw - 2])
    mirror ([0, 0, 1]) 
    color ("green")
    cone ();
    
    color ("brown")
    mirror ([0, 0, 1]) 
    offset_crown ();
    
    *#translate ([0, 0, l_screw - 1.5])
    mirror ([0, 0, 1])
    {
        screw_m4 (l_screw);
        nut_m4 ();
    }
}

module cone ()
{
    translate ([0, 0, -cone_extra])
    difference ()
    {
        union ()
        {
            translate ([0, 0, l_screw_eff - 7])
            hull ()
            {
                cylinder (d = 9, h = 0.01, $fn = 6);
                
                translate ([0, 0, 8 + cone_extra])
                cylinder (d = 9 + ((dia_min - 1 - 9)/8)*(8 + cone_extra), h = 0.01, $fn = 6);
            }
            
            for (i = [0:2])
                rotate ([0, 0, 60 * i])
                translate ([0, 0, l_screw_eff - 7 + 
            (8 + cone_extra)/2])
                cube ([1, dia_min - 1, 8 + cone_extra], center = true);
        }
        
        translate ([0, 0, l_screw_eff - 7 + 2])
        cylinder (d2 = 8/cos(30), d1 = 7/cos (30) + tol, h = l_screw - 7 - 7 + cone_extra + eps, $fn = 6);
        
        cylinder (d = 5 + tol, h = l_screw);
    }
}

module plug ()
{
    difference ()
    {
        union ()
        {
            // Inner plug
            translate ([0, 0, 5])
            difference ()
            {
                hull ()
                {
                    translate ([0, 0, l_screw_eff - 6])
                    cylinder (d = dia_min, h = 0.01, $fn = 12);
                    
                    cylinder (d = dia_max, h = 0.01, $fn = 12);
                }
                
                translate ([0, 0, -2 + eps])
                hull ()
                {
                    translate ([0, 0, l_screw_eff - 4])
                    cylinder (d = dia_min - 3, h = 0.01, $fn = 6);
                    
                    cylinder (d = dia_min - 1.5, h = 0.01, $fn = 6);
                }
                
                for (i = [0:2])
                    rotate ([0, 0, 60 * i])
                    translate ([0, 0, l_screw_eff - 13 + 2 * eps])
                    cube ([1.5, dia_max + eps, 14], center = true);
            }

            // Centering Cone
            cylinder (d1 = 22.5, d2 = 15, h = 5);

            // Cup
            difference ()
            {
                union ()
                {
                    cylinder (d1 = 24, d2 = 28, h = 5);

                    translate ([0, 0, 5])
                    cylinder (d1 = 28, d2 = 28, h = 8);
                }
                
                translate ([0, 0, 2 + 0.01])
                cylinder (d1 = 23, d2 = 23, h = 11);
            }
        }
        // Screw hole
        translate ([0, 0, -5 + eps])
        cylinder (d = 5 + tol, h = l_screw);
        
        // Registering holes
        registering_holes ();
    }
}


module offset_crown ()
{
    difference ()
    {
        union ()
        {
            translate ([0, 10, -12])
            sphere (d = 10);
            
            hull ()
            {
                translate ([0, 10, -12])
                sphere (d = 1);
                
                translate ([0, 0, -1.5])
                cylinder (d = 22, , h = eps);
            }
            
            translate ([0, 0, -1.5])
            cylinder (d1 = 22, d2 = 24, h = 1.5);
        }
        translate ([0, 0, -7])
        cylinder (d = 5 + tol, h = 20);
        
        translate ([0, 0, -9.5])
        cylinder (d = 7.5 + tol, h = 8);
        
        registering_holes ();
    }    
}

module registering_holes ()
{
    for (i = [-1:1])
        rotate ([0, 0, i * 120])
        translate ([7, 0, 0])
        cylinder (d = 1.75 + 2 * tol, h = 5, center = true);
}

module screw_m4 (l = 40)
{
    cylinder (d = 4, h = l);
    
    translate ([0, 0, l])
    cylinder (d = 7, h = 2.6);
}

module nut_m4 ()
{
    cylinder (d = 7/cos(30), h = 3.2, $fn = 6);
}

module cutdup (d = 0)
{
    translate ([-d, 0, 0])
        intersection ()
        {
            children ();
            
            translate ([-1000, 0, 0])
                cube ([2000, 2000, 2000], center = true);
        }
        
       translate ([d, 0, 0])
        difference ()
        {
            children ();
            
            translate ([-1000, 0, 0])
                cube ([2000, 2000, 2000], center = true);
        }
}
