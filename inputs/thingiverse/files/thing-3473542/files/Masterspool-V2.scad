// Parametric Lightweight MasterSpool V2
//
// by Bikecyclist
// https://www.thingiverse.com/Bikecyclist
//
// Based on the MasterSpool specifications by RichRap
// https://www.thingiverse.com/RichRap


/* [Rendering] */

// How to render the spool
rendering = "Exploded"; // ["Assembled", "Assembled, cutaway", "Exploded", "Exploded, cutaway", "Part A", "Part B"]

/* [Main Dimensions] */

// Outer diameter of spool
d_side = 195;

// Outer Diameter of spool body (Masterspool: 102 mm)
d_spool = 102;

// Inner Diameter of spool body (Masterspool: 52.5 mm)
d_center = 52.5;

// Width of spool:
w_spool = 50;

/* [Secondary Dimensions] */

// Width of the sideplates
w_side = 1.5;

// Radial width of the sideplate rim
w_rim = 2;

// Thickness of the sideplate rim
th_rim = 1;

// Wall thickness for the spool walls
th_spool = 1.2;

// End radius of the oval zip tie cutouts
r_tiehole = 7;

// Width of the connecting cone
w_cone = 10;

// Minimum thickness of the connecting cone
th_cone = 1;

// Taper of the connecting cone
taper_cone = 1;

/* [Screws] */

// Nominal diameter of screw
d_screw = 4;

// Diameter of screwhead
d_screwhead = 7;

// Thickness of screwhead
h_screwhead = 2.6;

// Length of screw (threaded bolt, head no included)
l_screw = 40;

// Wrench size for hex nut
d_wrench = 7;

// Thickness of hex nut
h_nut = 3.2;

// Tolerance for screw holes
tol = 1;

/* [Filament Retainment Holes] */

// Size of first set of filament retainment holes
d_filament_1 = 2.75;

// Size of second set of filament retainment holes
d_filament_2 = 4.5;

// Angular distance between two sets of filament retainment holes (in degrees)
delta_a_filament = 20;

/* [Lightening Holes] */

// Style of lightening holes
hole_style = 1; // [0:Circular, 1:Radial Sectors]

// Number of lightening holes per 30 degree sector
n_holes = 5;

// Diameter of lightening holes
d_holes = 22;

// Corner radius of lightening holes
rc_holes = 5;

// Style of the inner spool surface
spool_surface = 1; // [0:complete, 1:minimal]

/* [Hidden] */

// Number of facets per 360 degrees
$fn=64;

// Small Distance to ensure proper meshing
eps = 0.01;

d_tiehole = 2 * r_tiehole;

d_screwcylinder = d_screw + tol +  2 * th_spool;

if (rendering == "Part A")
    part_a ();
else if (rendering == "Part B")
    part_b ();
else if (rendering == "Assembled")
{
    part_a ();
    
    translate ([0, 0, 2 * w_side + w_spool])
    mirror ([0, 0, 1])
    part_b ();
}
else if (rendering == "Assembled, cutaway")
    cutdup (50)
    rotate ([0, 0, 30])
    {
        part_a ();
        
        translate ([0, 0, 2 * w_side + w_spool])
        mirror ([0, 0, 1])
        part_b ();
    }
else if (rendering == "Exploded")
{
    part_a ();
    
    translate ([0, 0, 2 * w_side + w_spool])
    translate ([0, 0, 50])
    part_b ();
}
else if (rendering == "Exploded, cutaway")
    cutdup (50)
    rotate ([0, 0, 30])
    {
        part_a ();
        
        translate ([0, 0, 2 * w_side + w_spool])
        translate ([0, 0, 50])
        part_b ();
    }
else
    echo ("Error: Selected rendering mode not found");


module part_a ()
{
    difference ()
    {
        union ()
        {
            difference ()
            {
                spoolside ();
                screwholes ();
            }
            
            translate ([0, 0, w_side])
            spoolbody ();
        }
        center_hole ();
    }
}

module part_b ()
{
    intersection ()
    {
        difference ()
        {
            union ()
            {
                spoolside ();
                
                translate ([0, 0, w_side])
                {
                    difference ()
                    {
                        cylinder (d1 = d_spool - 2 * th_spool, d2 = d_spool - 2 * th_spool - 2 * taper_cone, h = w_cone);
                        
                        translate ([0, 0, -eps])
                        cylinder (d = d_spool- 2 * th_spool - 2 * taper_cone - 2 * th_cone, h = w_cone + 2 * eps);
                    }
                    
                    if (spool_surface == 0)
                        // Inner Fitting Cone
                        difference ()
                        {
                            cylinder (d = d_center + 2 * th_spool + 2 * taper_cone + 2 * th_cone, h = w_cone);
                            
                            translate ([0, 0, -eps])
                            cylinder (d1 = d_center + 2 * th_spool, d2 = d_center + 2 * th_spool + 2 * taper_cone, h = w_cone + 2 * eps);
                        }
                    else
                        difference ()
                        {
                            cylinder (d = d_center + 2 * th_spool, h = w_cone);
                            
                            translate ([0, 0, -eps])
                            cylinder (d = d_center, h = w_cone + 2 * eps);
                        }
                }
                
                mirror ([0, 0, 1])
                translate ([0, 0, -(w_spool - eps)])
                screwtubes ();
            }
            
            even_rest = (w_spool + 2 * w_side)/2 - (l_screw - h_nut)/2;
            mirror ([0, 0, 1])
            translate ([0, 0, - w_spool - w_side])
            screwholes ();
            
            tieholes (0, 1);
            
            translate ([0, 0, w_side])
            tieholes (2 * th_spool, -eps);
            
            center_hole ();
            
            for (i = [1, 2])
                translate ([0, 0, d_filament_2 + w_side/2])
                place_filament_retaining_holes ()
                hull ()
                {
                    filament_retaining_holes (i, i==1?1:-1);
                    
                    translate ([0, 0, w_cone])
                    filament_retaining_holes (i, i==1?1:-1);
            }
        }
        
        cylinder (d = d_side, h = w_side + w_cone);
    }
}

module spoolside (flip = 0)
{
    translate ([0, 0, flip * w_side])
    mirror ([0, 0, flip])
    difference ()
    {
        union ()
        {
            cylinder (d = d_side, h = w_side);
            
            translate ([0, 0, w_side])
            difference ()
            {
                cylinder (d = d_side, h = th_rim);
                
                translate ([0, 0, -1])
                cylinder (d = d_side - 2 * w_rim, h = th_rim + 2);
            }
        }
        
        lightening_holes (hole_style);
        
        for (i = [0:2])
            rotate ([0, 0, i * 120])
            hull ()
            {
                tiehole (0, 1, 0);
                tiehole (0, 1, d_side/2 - d_spool/2 - d_tiehole);
            }
    }
}

module lightening_holes (shape = 0)
{
    for (j = [0:2], i = [0:n_holes - 1])
    if (shape == 0)
    {
        rotate ([0, 0, 120 * j + 20 + i * (80/(n_holes - 1))])
        translate ([d_spool/2 + (d_side - d_spool)/4, 0, -eps])
        cylinder (d = d_holes, h = w_side + 2 * eps);
    }
    else
    {
        translate ([0, 0, -eps])
        rotate ([0, 0, 120 * j + 20 + i * (80/(n_holes - 1))])
        linear_extrude (w_side + 2 * eps)
        offset (rc_holes)
        offset (-rc_holes)
        intersection ()
        {
            hull ()
            for (k = [-1, 1])
                rotate ([0, 0, k * (80/(n_holes - 1))/3])
                {
                    translate ([d_side/2, 0])
                    circle (eps, $fn = 6);
                    
                    translate ([d_spool/2, 0])
                    circle (eps, $fn = 6);
                }
                
            difference ()
            {
                circle (r = d_side/2 - w_rim - th_spool);
                circle (r = d_spool/2 + th_spool);
            }
        }
    }
        
}

module spoolbody ()
{
    intersection ()
    {
        difference ()
        {
            union ()
            {
                difference ()
                {
                    cylinder (d = d_spool, h = w_spool);
                
                    translate ([0, 0, -1])
                    cylinder (d = d_spool - 2 * th_spool, h = w_spool + 2);
                    
                    tieholes (0, 1);
                }
                
                difference ()
                {
                    tieholes (2 * th_spool, 0);
                    tieholes (0, 1);
                }
                
                //Screwhole cylinders
                intersection ()
                {
                    screwtubes ();
                    
                    cylinder (d = d_side, h = w_spool - w_cone);
                }
                
                cylinder (d = d_center + 2 * th_spool, h = w_spool);
            }

            screwholes ();
            
            place_filament_retaining_holes ()
            translate ([0, 0, w_spool - d_filament_2])
            {
                filament_retaining_holes (1, -1);
                filament_retaining_holes (2, 1);
            }
            
            if (spool_surface == 1)
                translate ([0, 0, w_cone])
                cylinder (d = d_center + 2 * th_spool + 2 * eps, h = w_spool - w_cone + eps);

        }        
        cylinder (d = d_spool, h = w_spool);
        
    }
}

module place_filament_retaining_holes ()
{
    for (i = [-1:1])
        rotate ([0, 0, 30 + i * 120])
            children ();
}

module filament_retaining_holes (n, dir)
{
    rotate ([90, 0, dir * delta_a_filament/2])
    translate ([0, 0, d_spool/2 - 2 * th_spool - th_cone - taper_cone - eps])
    cylinder (d = n==1?d_filament_1:d_filament_2, h = 2 * th_spool + th_cone + taper_cone + 2 * eps);
}

module tieholes (xtra = 0, xh = 0, offset = 0)
{
    for (i = [0:2])
        rotate ([0, 0, i * 120])
        tiehole (xtra, xh, offset);
}

module tiehole (xtra = 0, xh = 0, offset = 0)
{
    translate ([d_spool/2 + offset, 0, -xh])
    cylinder (d = d_tiehole + xtra, h = w_spool + 2 * xh);
}


module center_hole ()
{
    translate ([0, 0, -1])
    cylinder (d = d_center, h = w_spool + 2 * w_side + 2);
}

module screwtubes ()
{
    even_rest = (w_spool + 2 * w_side)/2 - (l_screw - h_nut)/2;
    
    for (i = [0:2])
        rotate ([0, 0, 60 + i * 120])
        translate ([d_center/2 + (d_spool/2 - d_center/2)/2, 0, 0])
        union ()
        {
            cylinder (d = d_screwhead + tol + 2 * th_spool, h = w_spool);
            
            nut (even_rest + th_spool, th_spool);
            
            translate ([0, 0, w_spool - even_rest - th_spool])
            cylinder (h = even_rest + th_spool, d = d_screwhead + 2 * th_spool);
        }
}

module screwholes ()
{
    even_rest = (w_spool + 2 * w_side)/2 - (l_screw - h_nut)/2;
    
    for (i = [0:2])
        rotate ([0, 0, 60 + i * 120])
        translate ([d_center/2 + (d_spool/2 - d_center/2)/2, 0, even_rest/2])
        {
            screw (l_screw, tol);
            
            nut ();
            
            translate ([0, 0, l_screw + even_rest/2 - w_side - eps])
            cylinder (d = d_screwhead + tol, h = even_rest);
            
            translate ([0, 0, -even_rest/2 - w_side - eps])
            nut (even_rest + w_side + eps);
        }
}

module screw (l = 40, padding = 0)
{
    cylinder (d = d_screw + padding, h = l);
    
    translate ([0, 0, l])
    cylinder (d = d_screwhead + tol, h = h_screwhead);
}

module nut (l = h_nut, padding = 0)
{
    cylinder (d = d_wrench/cos(30) + tol + 2 * padding, h = l, $fn = 6);
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
