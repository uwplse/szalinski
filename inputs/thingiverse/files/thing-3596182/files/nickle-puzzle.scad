// Puzzle box
$fn=40;
in=25.4;
gap=.5;


show_explode = 0;   //set to 1 to show the exploded view
show_print = 1;     //set to 1 to build the printable model
show_ball_mold = 0; //set to 1 to build the ball mold (hot glue ball)



Dpin=.195*in;     // Diameter of screw 
D_ball=4;         // Diameter of ball
//D_ball=6;
//D_ball=8;


coin_diameter      = 21.21;   // Diameter of US Nickel 21.21 mm
                       // Diameter of US Dollar Gold 26.49 mm
coin_thickness = 1.95;  // Thickness of US Nickel 1.95 mm
                     // Depth of US Dollar Gold 2 mm
                     
// Pad the cutouts a smidgen
Dcavity = coin_diameter + .5;
depth_cavity = coin_thickness + .1;

////////////////////////////////////////////////////////////////////////

H_ball_pocket=D_ball+gap;

padding = 3.5;
width = Dcavity + 2 * padding;
length=Dcavity * 2.56;

D_CB=.5*in;
H_CB=.175*in;

Htop=H_ball_pocket+.07*in;
Hmiddle=H_ball_pocket+Htop;
Hbottom=H_CB+.1*in; //10


angle=60;
Dtap=Dpin; //.15*in is the tap drill size if you want to tap the plastic;
Xhole=12;
Lslot=Dpin/2+max(D_ball,Dpin)/2+gap;

Xcavity=width;

Dcavity_through= .7 * Dcavity;
tcavity=Hbottom-depth_cavity;
wx=50;


Wkey=Dpin;
Lkey=min(Dpin,D_ball);
radius=(width-Wkey)/2;

WkeyG=Wkey+2*gap;
D_ball_hole=D_ball+2*gap;

LkeyG=Lkey+gap;
Xcoin = (length - Dcavity) / 2 - Lkey - padding;


if (show_explode)
{
    explode_dist=20;
    Bottom_Part(explode_dist);
    Middle_Part(explode_dist);
    Top_Part(explode_dist);
}

if (show_print)
{
    translate([0,-width*1.2,0]) Bottom_Part();
    translate([0,0,-Hbottom]) Middle_Part();
    translate([0,width*1.2,-Hmiddle-Hbottom+Htop]) Top_Part();
}

if (show_ball_mold)
{
    Ball_mold();
    rotate([0,0,180])Ball_mold();
}

module Ball_mold(explode=0)
{
    Dnozzle=.4;
    Wmold=D_ball*3;
    Hmold=D_ball/2*1.5;
    hpin=D_ball/2;
    D_trough=D_ball/2;
    g=.2;
    
    translate([Wmold,0,Hmold])
    {
        rotate([180,0,0])
        {
            difference()
            {
                translate([0,0,Hmold/2]) cube([Wmold,Wmold,Hmold],center=true);
                sphere(d=D_ball);
                rotate_extrude()
                {
                    translate([D_ball/2+D_trough/2+Dnozzle,0])circle(d=D_trough);
                }
                translate([ Wmold/2*.7, Wmold/2*.7,0])
                    cylinder(d1=D_ball/2+g,d2=Dnozzle+g,h=hpin+g);
                rotate([0,90,0])
                    translate([0,0,D_ball/2+D_trough/2+Dnozzle])
                        cylinder(d=D_trough,h=Wmold);
                rotate([0,-90,0])
                    translate([0,0,D_ball/2+D_trough/2+Dnozzle])
                        cylinder(d=D_trough,h=Wmold);
                rotate([90,0,0])
                    translate([0,0,D_ball/2+D_trough/2+Dnozzle])
                        cylinder(d=D_trough,h=Wmold);
                rotate([-90,0,0])
                    translate([0,0,D_ball/2+D_trough/2+Dnozzle])
                        cylinder(d=D_trough,h=Wmold);
            }
            
            translate([-Wmold/2*.7,-Wmold/2*.7,-hpin])
                cylinder(d2=D_ball/2,d1=Dnozzle,h=hpin);
        }
    }
}



module Bottom_Part(explode=0)
{
    difference()
    {
        union()
        {
            box(length,width,Hbottom,radius);
            translate([length/2-Lkey/2,0,Hbottom])
                cube([Lkey,Wkey,Wkey*2],center=true);
        }
        translate([-length/2+Xhole,0,0])
                    cylinder(d=Dtap,h=Hbottom*2,center=true);
        translate([Xcoin,0,tcavity])
                    cylinder(d=Dcavity,h=Hbottom*2,center=false);
        translate([Xcoin,0,0])
            cylinder(d=Dcavity_through,h=Hbottom*2,center=true);
        translate([-length/2+Xhole,0,0])
                    cylinder(d=D_CB,h=H_CB*2,center=true);
    }
    
}

module Middle_Part(explode=0)
{
    color("blue")
    translate([0,0,Hbottom+explode])
    {
        difference()
        {
            box(length,width,Hmiddle,radius);
            
            translate([Xcoin,0,Hmiddle-Htop])
                    rotate([0,0,90-angle])
                        translate([-length,-width/2*wx,0])
                            cube([length,width*wx,Htop],center=false);            
            hull()
                {
                translate([-length/2+Xhole,0,0])
                    cylinder(d=Dpin,h=Hmiddle*2,center=true);
                translate([-length/2+Xhole+Lslot,0,0])
                    cylinder(d=max(D_ball_hole,Dpin),h=Hmiddle*2,center=true);

                }
                
            translate([length/2,0,0])
                cube([LkeyG*2,WkeyG,WkeyG*2],center=true);

            translate([Xcoin,0,0])
                    cylinder(d=Dcavity_through,h=Hmiddle*2,center=true);
                
        }
    }
}


module Top_Part(explode=0)
{
    color("red")
        translate([0,0,Hbottom+Hmiddle-Htop+explode+explode])
        {
            difference()
            {
                box(length,width,Htop,radius);                
                translate([Xcoin - gap,0,0])
                    rotate([0,0,(90-angle)])
                        translate([0,-width/2*wx,0])
                            cube([length,width*wx,Htop],center=false);
                
                
                translate([-length/2+Xhole,0,0])
                    cylinder(d=Dpin,h=Htop*2,center=true);
                
                hull()
                {
                    translate([-length/2+Xhole,0,0])
                        cylinder(d=Dpin,h=H_ball_pocket*2,center=true);
                    translate([-length/2+Xhole+Lslot,0,0])
                        cylinder(d=max(D_ball_hole,Dpin),h=H_ball_pocket*2,center=true);
                }
                
                translate([Xcoin,0,0])
                    cylinder(d=Dcavity_through,h=Htop*2,center=true);
            }  
    }
}


module box(L,W,H,R)
{
    hull()
    {
        translate([-L/2+R,-W/2+R,0])cylinder(r=R,h=H);
        translate([-L/2+R,W/2-R,0])cylinder(r=R,h=H);
        translate([L/2-R,-W/2+R,0])cylinder(r=R,h=H);
        translate([L/2-R,W/2-R,0])cylinder(r=R,h=H);
    }
}

