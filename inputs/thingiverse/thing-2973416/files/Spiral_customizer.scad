Resolution=36;  //AHSKJDHJDBDKJBDKJ

Amplitude=10;

Bars=100;

Rotation_Degrees=360;

Constant_X_C=20;

Constant_Y_C=1;

Forward=40;

Backward=70;

Thickness=2;

Scale_X=15;

Scale_Y=1;

Scale_Z=1;

Double=false;

$fn=Resolution;

b=Amplitude;            //Ampiezza

c=Bars;      //Inizio
d=Rotation_Degrees;       //Gradi giro

kxc=Constant_X_C;          //Coeffieciente divisione x del cubo
kyc=Constant_Y_C;          //Coeffieciente divisione y del cubo
x=Forward;
y=Backward;

spessore=Thickness;
scalex=Scale_X;
scaley=Scale_Y;
scalez=Scale_Z;



difference()
    {
    union()
        {
        for(a=[b/c:b/c:b])
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
for(a=[b/c:b/c:b])
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
        }
    }