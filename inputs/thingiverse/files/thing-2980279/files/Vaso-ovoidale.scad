Pattern_amplitude=25;
Pattern_Bars=100;
Pattern_Rotation_Degrees=720;
Pattern_Constant_X_C=20;
Pattern_Constant_Y_C=2;
Pattern_Forward=10;
Pattern_Backward=12;
Pattern_Scale_X=2;
Pattern_Scale_Y=0.75;
Pattern_Scale_Z=1;
Pattern_Double=true;
Pattern_Start=10;

Vase_height=200;
Vase_wall_thickness=3;
Vase_bottom_radius=100;
Vase_bottom_thickness=3;
Topside_ring_height=10;
Topside_ring_offset=0;
Bottomside_ring_height=10;
Bottomside_ring_offset=0;
Vase_radius=200;
Offset=50;
Vase_scale_X=1;
Vase_scale_Y=1;
Vase_scale_Z=1;

$fn=36;

b=Pattern_amplitude;            //Ampiezza

c=Pattern_Bars;      //Inizio
d=Pattern_Rotation_Degrees;       //Gradi giro

kxc=Pattern_Constant_X_C;          //Coeffieciente divisione x del cubo
kyc=Pattern_Constant_Y_C;          //Coeffieciente divisione y del cubo
x=Pattern_Forward;
y=Pattern_Backward;

scalex=Pattern_Scale_X;
scaley=Pattern_Scale_Y;
scalez=Pattern_Scale_Z;

spessore=Vase_height;

difference()
{
    union()
    {
    intersection()
        {
        union()
            {
            for(a=[b/c*Pattern_Start:b/c:b])
                {
                if(a<b/2)
                rotate([0,0,d/b*a])
                translate([a*x,a*y,0])
                 rotate([0,0,a])
                  scale([scalex,scaley,scalez])
                    {
                   cylinder(r=a,h=spessore*2,center=true);
                    rotate([0,0,0])
                   cube([a*kxc,a/kyc,spessore*2],center=true);
                    }
                if(a>=b/2)
                rotate([0,0,d/b*a])
                translate([(b-a)*x,a*y,0])
                 rotate([0,0,a])
                  scale([scalex,scaley,scalez])
                    {
                   cylinder(r=b-a,h=spessore*2,center=true);
                    rotate([0,0,0])
                   cube([(b-a)*kxc,(b-a)/kyc,spessore*2],center=true);
                    }
                }
    if(Pattern_Double==true)
    rotate([0,0,180])
    for(a=[b/c*Pattern_Start:b/c:b])
                {
                if(a<b/2)
                rotate([0,0,d/b*a])
                translate([a*x,a*y,0])
                 rotate([0,0,a])
                  scale([scalex,scaley,scalez])
                    {
                   cylinder(r=a,h=spessore*2,center=true);
                    rotate([0,0,0])
                   cube([a*kxc,a/kyc,spessore*2],center=true);
                    }
                if(a>=b/2)
                rotate([0,0,d/b*a])
                translate([(b-a)*x,a*y,0])
                 rotate([0,0,a])
                  scale([scalex,scaley,scalez])
                    {
                   cylinder(r=b-a,h=spessore*2,center=true);
                    rotate([0,0,0])
                   cube([(b-a)*kxc,(b-a)/kyc,spessore*2],center=true);
                    }
                }
            translate([0,0,spessore-Topside_ring_height+Topside_ring_offset])
                cylinder(r=500,h=Topside_ring_height);
            translate([0,0,Bottomside_ring_offset])
                cylinder(r=500,h=Bottomside_ring_height);
            }

            difference()
                {
                difference()
                    {
                    scale([Vase_scale_X,Vase_scale_Y,Vase_scale_Z])
                        translate([0,0,Offset])
                            sphere(r=Vase_radius);
                    translate([0,0,-Vase_radius*Vase_scale_Z])
                        cylinder(r=Vase_radius*Vase_scale_Z,h=Vase_radius*Vase_scale_Z);
                    translate([0,0,Vase_height])
                        scale([Vase_scale_X,Vase_scale_Y,Vase_scale_Z])
                            cylinder(r=Vase_radius*Vase_scale_Z,h=Vase_radius*Vase_scale_Z);
                    }

                difference()
                    {
                    scale([Vase_scale_X,Vase_scale_Y,Vase_scale_Z])
                      translate([0,0,Offset])
                        sphere(r=Vase_radius-Vase_wall_thickness);
                    translate([0,0,-Vase_radius*2*Vase_scale_Z])
                        scale([Vase_scale_X,Vase_scale_Y,Vase_scale_Z])
                            cylinder(r=Vase_radius*Vase_scale_Z,h=Vase_radius*2);
                    }
                }
        }

   translate([0,0,0])
cylinder(r=Vase_bottom_radius,h=Vase_bottom_thickness);
    }
   

}
