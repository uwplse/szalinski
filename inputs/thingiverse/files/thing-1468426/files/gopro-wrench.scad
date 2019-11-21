
//
Twist  = 90;                // default "90"
//Height in mm
Height = 50;                // default "50"

Scale_top = 1.5;            // default "1.5"
//Flip the model for printing
Flip="no";                  // [yes:yes,no:no]
//

/* [Hidden] */

//Increase number of facets for a smoother model
Facets = 20;                // default "20"

in=25.4;
$fn=Facets;

hyp=15.7;
r1=20;
d1=20.3+.025*in;
indim=7.5+.025*in;
height_pocket = 7;

r2=2;
t1=1;

if (Flip=="yes")
{
    translate([0,0,Height+(t1+r2)*Scale_top])
    rotate([180,0,0])
        wrench();
} 
else
{
    wrench();
}
/*
difference()
{
    wrench();
    rotate([0,0,45])
    {
        translate([0,0,50+r2*1.5+t1*1.5-1])
        linear_extrude(1)
        {
            translate([0, 2.8,0]) text(size=6,"New",halign="center");
            translate([0,-4.2,0]) text(size=6,"Dorkee",halign="center");
        }
    }
}
*/

module wrench()
{
    difference()
    {
        linear_extrude(height=Height, scale=Scale_top, slices=20, twist=Twist)
        {
            minkowski()
            {
                profile();
                circle(r=r2);
            } 
        }
        linear_extrude(height=height_pocket, scale=1, slices=20, twist=0)
        {
            profile(); 
        }
        
        translate([0,0,7])
        linear_extrude(height=height_pocket, scale=.1, slices=20, twist=0)
        {
            $fn=40;
            profile(); 
        }
        
    }
    
    translate([0,0,Height])

    // Make the top of the wrench rounded
    //color("blue")
    
    difference()
    {
        scale(Scale_top)
        minkowski()
        {
            rotate(-Twist) linear_extrude(t1) profile();
            rotate([0,90,0])sphere(r=r2);
        }
        translate([0,0,-Height])cube([Height*2,Height*2,Height*2],center=true);
        
    }
    
}

module profile()
{

    $fn = max(40,Facets);
    difference()
    {
        circle(d=d1);
        union()
        {
            translate([  r1+indim ,  0        ,0]) circle(r=r1,h=height_pocket);
            translate([-(r1+indim),  0        ,0]) circle(r=r1,h=height_pocket);
            translate([  0        , (r1+indim),0]) circle(r=r1,h=height_pocket);
            translate([  0        ,-(r1+indim),0]) circle(r=r1,h=height_pocket);
        }
    }
}