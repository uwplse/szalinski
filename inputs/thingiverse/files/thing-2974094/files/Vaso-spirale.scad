Amplitude=25;

Bars=100;

Rotation_Degrees=720;

Constant_X_C=20;

Constant_Y_C=2;

Forward=10;

Backward=12;

Scale_X=2;

Scale_Y=0.75;

Scale_Z=1;

Double=true;

Start=10;

Vase_radius_bottom=100;

Vase_radius_top=200;

Vase_height=200;

Vase_wall_thickness=3;

Vase_bottom_radius=100;

Vase_bottom_thickness=3;

Topside_ring_height=10;

Bottomside_ring_height=10;

$fn=36;

b=Amplitude;            //Ampiezza

c=Bars;      //Inizio
d=Rotation_Degrees;       //Gradi giro

kxc=Constant_X_C;          //Coeffieciente divisione x del cubo
kyc=Constant_Y_C;          //Coeffieciente divisione y del cubo
x=Forward;
y=Backward;

spessore=Vase_height;
scalex=Scale_X;
scaley=Scale_Y;
scalez=Scale_Z;


difference()
{
    union()
    {
    intersection()
        {
        union()
            {
            for(a=[b/c*Start:b/c:b])
                {
                if(a<b/2)
                rotate([0,0,d/b*a])
                translate([a*x,a*y,0])
                 rotate([0,0,a])
                  scale([scalex,scaley,scalez])
                    {
                   cylinder(r=a,h=spessore,center=true);
                    rotate([0,0,0])
                   cube([a*kxc,a/kyc,spessore],center=true);
                    }
                if(a>=b/2)
                rotate([0,0,d/b*a])
                translate([(b-a)*x,a*y,0])
                 rotate([0,0,a])
                  scale([scalex,scaley,scalez])
                    {
                   cylinder(r=b-a,h=spessore,center=true);
                    rotate([0,0,0])
                   cube([(b-a)*kxc,(b-a)/kyc,spessore],center=true);
                    }
                }
    if(Double==true)
    rotate([0,0,180])
    for(a=[b/c*Start:b/c:b])
                {
                if(a<b/2)
                rotate([0,0,d/b*a])
                translate([a*x,a*y,0])
                 rotate([0,0,a])
                  scale([scalex,scaley,scalez])
                    {
                   cylinder(r=a,h=spessore,center=true);
                    rotate([0,0,0])
                   cube([a*kxc,a/kyc,spessore],center=true);
                    }
                if(a>=b/2)
                rotate([0,0,d/b*a])
                translate([(b-a)*x,a*y,0])
                 rotate([0,0,a])
                  scale([scalex,scaley,scalez])
                    {
                   cylinder(r=b-a,h=spessore,center=true);
                    rotate([0,0,0])
                   cube([(b-a)*kxc,(b-a)/kyc,spessore],center=true);
                    }
                }
            translate([0,0,spessore/2-Topside_ring_height])
            cylinder(r=500,h=Topside_ring_height);
            translate([0,0,-spessore/2+Bottomside_ring_height/2])
            cylinder(r=500,h=Bottomside_ring_height);
            }
        cylinder(r1=Vase_radius_bottom,r2=Vase_radius_top,h=spessore,center=true);
        }
    translate([0,0,-spessore/2])
    cylinder(r=Vase_bottom_radius,h=Vase_bottom_thickness,center=true);
    }
    translate([0,0,Vase_bottom_thickness])
    cylinder(r1=Vase_radius_bottom-Vase_wall_thickness,r2=Vase_radius_top-Vase_wall_thickness,h=spessore,center=true);
}