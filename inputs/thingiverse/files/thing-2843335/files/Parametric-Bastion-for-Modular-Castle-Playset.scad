$fn=32;

//CUSTOMIZER VARIABLES

//Bastion radius in playset raster size multiples

bastion_size = 2; //    [1:4]

//CUSTOMIZER VARIABLES END

//	Bastion radius
r_bastion = 40 * bastion_size;


translate ([-20, 0, 0])
    half_shell (true);
    
translate ([20, 0, 0])
    half_shell (false);

module half_shell (left_half)
{
    difference ()
    {
        shell_tower (d = 2 * r_bastion, h_tower = 46, n_connects = 2);
            
        translate ([0, -40, -1])
            mirror ([left_half?0:1, 0, 0])
                cube (4 * r_bastion, 4 * r_bastion, 2 * 46);
    }
}

module shell_tower (d, h_tower, n_connects)
{
    d_tower = d - 1e-2;
    h_battlement = 12;
    h_crenel = 6;
    d_crannellation = 10;
    
    translate ([0, 20, 0])
    difference ()
    {
        union ()
        {
            difference ()
            {
                cylinder (d = d_tower, h = h_tower);
                cylinder (d = d_tower - 80, h = 2 * h_tower + 2, center=true);
                translate ([0, -d, 0])
                    cube ([2 * d, 2 * d, 2 * h_tower + 2], center = true);
            
                translate ([0, 0, h_tower - h_battlement])
                    cylinder (d = d_tower - 2 * d_crannellation, h = h_battlement + 1e-2);
                
                translate ([0, 0, h_tower - h_crenel])
                    for (i=[0:6])
                        rotate ([0, 0, 30 * i - (12)/2])
                            rotate_extrude (angle = 12)
                                square ([d_tower, 20]);
            }
            
            //Straight wall segments
            for (i=[-1,1])
            {
                translate ([-20 + (r_bastion - 20) * i, -40, 0])
                    difference ()
                    {
                        cube ([40, 40, h_tower - h_battlement + h_crenel]);
                        
                        translate ([-1, d_crannellation, h_tower - h_battlement])
                            cube ([40 + 2, 40, h_tower - h_battlement + h_crenel]);
                        
                            translate ([20 + i * 20, 20, -1e-2])
                                connectivity (i);
                    }
                
                translate ([r_bastion * i, 0, h_tower - h_battlement])
                    difference ()
                    {
                        rotate ([0, 0, 90 * i])
                            mirror ([(i + 1)/2, 0, 0])
                                rotate_extrude (angle = 90)
                                    square ([d_crannellation, h_crenel]);
                        
                        mirror ([(i + 1)/2, 0, 0])
                            translate ([0, 0, -20])
                                cube (40, 40, 40);
                        
                        mirror ([(i + 1)/2, 0, 0])
                            translate ([-40, -20, -20])
                                cube (40, 40, 40);
                    }
            }
        }
        for (i = [-1, 1])
        {
            translate ([0, r_bastion - 20, -1e-2])
                connectivity (i);
        }
    }
}


module connectivity (i)
{
    connector_hole ();

    rotate ([0, 0, -i * 90])
    {
        translate ([0, 0, 27.5])
            rotate ([90, 0, 0])
                cylinder (d1 = 2.2, d2 = 1.75, h = 7.5);

        translate ([0, 0 + 1e-2, 27.5])
            rotate ([90, 0, 0])
                cylinder (d1 = 3.2, d2 = 0, h = 1.6);
    }
}


module connector_hole ()
{
    h = 17;
    wl = 15.7;
    
    wcl = 5.82;
    ll = 23.75;
    rl = 3.25;
    r2l = 1;
    offl = 7.75;
    
    wcu = 3.44;
    lu = 20.68;
    ru = 3;
    r2u = 1;
    off1u = 8.15;
    yu = -1.5;
    du = 0.81 + ru + r2u;
    
    hull()
    {
        cube ([ll, wcl, 0.001], center = true);
        
        translate ([0, 0, h])
            cube ([lu, wcu, 0.001], center = true);
    }
 
    connector_hole_dovetail ();
    
    mirror ([1, 0, 0])
        connector_hole_dovetail ();
    
    module connector_hole_dovetail ()    
    {
        hull()
        {
            for (i = [-1, 1])
            {
                translate ([offl, i * (wl/2 - rl), 0])
                    cylinder (r = rl, 0.001);
                
                translate ([ll/2 - r2l, i * (wl/2 - r2l), 0])
                    cylinder (r = r2l, 0.001);
                    
                difference ()
                {
                    translate ([lu/2 + ru - du, i * (wl/2 - ru + yu), h])
                        cylinder (r = ru, 0.001);
                        
                    translate ([lu/2 + ru - du, -wl/2, h])
                        cube ([ru, wl, 0.1]);
                }

                translate ([lu/2 - r2u, i * (wl/2 - r2u + yu), h])
                    cylinder (r = r2u, 0.001);                
            }
        }
    }
}