lr = 12;    //12.2;
lg = 46;    //45.8;

h1 = 14;
h2 = 16.5;

dist_vis = 31.7;
delta_vis_h1 = 7;

lg_trou = 22;
dist_lg = 11;
ep_trou_h1 = 7;
ep_trou_h2 = 6.5;


h_cyl = 2.5;
d_cyl = 6.8;
//d_cyl_org = 7;
d_trou_vis = 3.1;   //3.5;


//-----------------------------------//

attache_valise(0,0,0);

module cylindre_vis(x,y,z,h)
{
    $fn = 200;
    hcyl = h + h_cyl;
    r1 = d_trou_vis * 0.5;
    r2 = d_cyl * 0.5;
    
    translate([x,y,z-h_cyl])
    {
        difference()
        {
            cylinder(hcyl,r2,r2);
            translate([0,0,0])
            cylinder(hcyl-1,r1,r1);
        }
    }
}

module trou_vis(x,y,z,h)
{
    $fn = 200;
    hcyl = h + h_cyl;
    r1 = d_trou_vis * 0.5;
    r2 = d_cyl * 0.5;
    
    translate([x,y,z-h_cyl])
    {
        cylinder(hcyl-1,r1,r1);
    }
}

module creux_sangle(x,y,z)
{
    $fn = 200;
    
    r_coin = 2;
    
    x1 = lg_trou;
    y1 = lr+2;
    z1 = h1 - ep_trou_h1;
    
    z2 = h2 - ep_trou_h2;
    
    //angle = 9.46;
    angle = atan2((z2-z1),lg_trou-2*r_coin);   //je ne tombe pas sur le bon angle !!!???
    
    x2 = sqrt(pow(x1,2)+pow(x1*tan(angle),2));
    y2 = lr;
    
    
    z3 = 3*r_coin;
    dx = 2*r_coin*sin(angle);
    dz = z1-r_coin*3+(2*r_coin*(1-cos(angle)));
    
    //echo(atan2((z2-z1),lg_trou-2*r_coin));
    //echo(angle);
    //echo(dz);
    //echo(r_coin*(1-cos(angle)));
    
    
    
    translate([x-ep_trou_h1+dist_lg,y-1-lr*0.5,z])
    {
        union()
        {
            translate([x1-2*r_coin,0,z1-r_coin-1])
            cube([r_coin*2,y1,z2-z1+1]);
            cube([x1,y1,z1-r_coin]);
            
            /*translate([r_coin,-0.2,z1-r_coin])
            rotate([0,-angle,0])
            #cube([x2-2*r_coin,y1,r_coin]);*/
            
            translate([dx+r_coin,0,dz])
            rotate([0,-angle,0])
            cube([x2-2*r_coin,y1,r_coin*3]);
                    
            //angles rond
            translate([r_coin,lr+2,z1-r_coin])
            rotate([90,0,0])
            cylinder(lr+2,r_coin,r_coin);
            
            translate([x1-r_coin,lr+2,z2-r_coin])
            rotate([90,0,0])
            cylinder(lr+2,r_coin,r_coin);
        }
    }
}
        
module part_ext(x,y,z)
{
    $fn = 200;
    
    r1 = lr*0.5;
    r2 = 3;
    
    x1 = delta_vis_h1+dist_vis;
    y1 = lr;
    z1 = h1-r2;
    
    translate([x,y,z])
    {
        hull()
        {
            translate([dist_vis,0,0])
            cylinder(h2,r1,r1);
            
            translate([-delta_vis_h1+r2,lr*0.5,h1-r2])
            rotate([90,0,0])
            cylinder(lr,r2,r2);
            
            translate([-delta_vis_h1,-y1*0.5,0])
            cube([x1,y1,z1]);
            
        }
    }
}

module attache_valise(x,y,z)
{
    translate([x,y,z])
    {
        difference()
        {
            union()
            {
                part_ext(0,0,0);
                cylindre_vis(0,0,0,h1-1);
                cylindre_vis(dist_vis,0,0,h2-1);
            }
            union()
            {
                trou_vis(0,0,0,h1-1);
                trou_vis(dist_vis,0,0,h2-1);
                creux_sangle(0,0,-0.05);
            }
        }
    }
}


