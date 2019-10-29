R0 = 12/2;   // Radius of the central screw hole.
Ri = 100/2;  // Radius of the base of the mount.
Ro = 190/2;  // Outer radius of the ray --limited by printer size.
Th = 4;   // Thickness.
W = 56; // Leg width.
Re = 31.9/2;  // Eyepiece radius, plus a bit.

$fn = 50;

// The tray is divided in three thirds, each is customisable as follows:

// Do you want eyepiece holes (two per third):
Eyepieces = [true, true, true];

// Do you want hooks:
Hooks = [true, false, true];
hookHeight = [20, 0, 20] ;
hookShift = [10, 0, 10];  // Can't shift second because of printer bed size.
hookBase = [8, 0, 8] ;
hookTh = 3;

// Do you want slits (I use it to hang my eyeglasses):
Slits = [false, true, false];
slitWidth = 5;
slitLength = 10 ;
slitDistance = 7.5 ; // Distance between slit and edge.


// Ignore the rest, internal calculations:
e = 1;  // Epsilon for subtraction.
// rad to deg:
rad2deg = 180/PI;

// Angle leg to leg on outer circle:
All = (2*PI/3 - 50/Ro) * rad2deg;

// Approximate distance centre to eyepiece centre:
Rec = (Ro + Ri)/2 ;
// Circular distance from leg to leg through eyepiece centres:
Dll = Rec*2*PI/3 - 50;
// Half distance eyepiece to eyepiece:
Dee = Dll/6;
// Resulting rotation angle:
Ar = Dee/Rec * rad2deg *1.1;


difference()
{
    cylinder(r=Ro, h=Th, center=true);
    cylinder(r=R0, h=Th+e, center=true); // Central screw hole
    for(i=[0:2])
    {
        rotate([0, 0, i*120]) translate([(Ro-Ri+e)/2 + Ri, 0, 0])
            cube([Ro-Ri+e, W, Th+e], center=true);   // Leg cuts.
        if(Slits[i])
        {
            rotate([0, 0, i*120+60]) translate([Ro-slitDistance, 0, 0])
                cube([slitWidth, slitLength, Th+e], center=true);  // Slits
        }
        if(Eyepieces[i])
        {
            rotate([0, 0, 60+120*i])
            {
                rotate([0,0,-Ar]) translate([Rec, 0, 0])
                    cylinder(r=Re, h=Th+e, center=true);
                rotate([0,0,Ar]) translate([Rec, 0, 0])
                    cylinder(r=Re, h=Th+e, center=true);
            }
        }
    }

}

for(i=[0:2])
{
    if(Hooks[i])
    {
        echo("height=", hookHeight[i]);
        rotate([0, 0, i*120+60])
        {
            translate([Ro + hookShift[i]/2-e, 0, 0])
                cube([hookShift[i], hookBase[i], Th], true);
            translate([Ro + hookTh/2 + hookShift[i]-e, 0, -Th/2])
            scale([hookTh, hookBase[i]/2, hookHeight[i]+Th])
            difference()
            {
                rotate([0, -90, 0])
                    cylinder(r = 1, h = 1, center=true, $fn=50);
                translate([0,0,-(1+e)/2])
                    cube([1+e, 1+e, 1+e], center=true);
            }
        }
    }
}

