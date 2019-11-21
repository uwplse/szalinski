//Cat feeder
tol = 0.2;
ep = 3;

//cylindre
h = 350;
r1 = 120*0.5;
r2 = r1-ep;
r2tol = r2-tol;

x_base = 2*(r1+ep);
y_base = x_base;
z_base = 3*r1;


//coupolle de soutien
r3 = 150*0.5;
h_bord = 35;

//mode preview
//$fn=10;
//d_angle = 5;
//mode rendering very long !!!
$fn=200;
d_angle = 0.2;

//tube(0,0,z_base-r1);
//rotate([180,0,0])
//chapeau(0,0,0);
//chapeau(0,0,h+z_base-r1);

//%tobogan(0,0,0);
//tobogan2(0,0,0);
deversoir(0,0,0);
//receptacle(0,0,0);

module tube(x,y,z)
{
    translate([x,y,z+h*0.5])
    {
        difference()
        {
            cylinder(h,r1,r1,true,$fn=200);
            cylinder(h,r2,r2,true,$fn=200);
        }
    }
}

module chapeau(x,y,z)
{
    translate([x,y,z-2*ep])
    {
        difference()
        {
            translate([0,0,3*ep*0.5])
            cylinder(3*ep,r1+ep,r1+ep,true,$fn=200);
            translate([0,0,ep])
            cylinder(2*ep,r1+tol,r1+tol,true,$fn=200);
        }
    }
}

module deversoir(x,y,z)
{
    
    //base_points = [[0,0],[x_base,0],[x_base,0],[0,z_base]];
    
    translate([x,y,z])
    {
        difference()
        {
            union()
            {
                translate([0,0,-ep+z_base*0.5])
                cylinder(z_base,x_base*0.5,x_base*0.5,true);
                receptacle(0,-r3,0);
            }
            tobogan2(0,0,0);
        }
    }
}

module tobogan(x,y,z)
{
    dz = 2*r1-ep;
    
    z1 = 2*r1;
    
    translate([x,y,z])
    {
        union()
        {
            //cylindre partie haute
            translate([0,00,z1*0.5+dz-0.1])
            cylinder(z1,r1,r1,true,$fn=100);
            //tobogan
            translate([0,-r1,dz])
            rotate([90,180,-90]) 
            rotate_extrude(angle=90, convexity=10, $fn=100)
            translate([r1, 0]) circle(r2);
            
            //cylindre sortie
            translate([0,-r1-ep,r2])
            rotate([90,0,0])
            cylinder(10,r2,r2,true,$fn=100);
        
        }
        
    }
}

module tobogan2(x,y,z)
{
    dz = 2*r1-ep;
    z1 = 2*r1;
    angle_fin = 65;
    r_extrude = r1+60;
    r4 = r2-(r2*angle_fin*0.01);
    //echo(r4);
    
    translate([x,y,z])
    {
        difference()
        {
        union()
        {
            //cylindre partie haute
            translate([0,00,z1*0.5+dz-0.5])
            cylinder(z1,r1+1*tol,r1+2*tol,true);
            
            //tobogan
            translate([0,-r_extrude,dz])
            rotate([90,180,-90])
            for (az = [0:d_angle:angle_fin])
            {
                rotate([0,0,az])
                rotate_extrude(angle=d_angle, convexity=10)
            translate([r_extrude, 0]) circle(r2-(r2*az*0.01));
            }
            
            //cylindre sortie
            /*
            translate([0,-r1,r4*0.5+ep])
            rotate([90,0,0])
            cylinder(10,r4,r4,true);
            */
        }
        translate([0,0,-20+0.01])
        cylinder(20,z1,z1,$fn=10);
        }
    }
}

module receptacle(x,y,z)
{
    
    translate([x,y,z])
    {
        difference()
        {
            translate([0,0,-ep])
            cylinder(h_bord,r3,r3);
            
            translate([0,0,0])
            cylinder(h_bord-ep,r3-ep,r3-ep);
            
        
        }
        
    }
}
