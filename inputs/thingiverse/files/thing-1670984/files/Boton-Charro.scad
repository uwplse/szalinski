// Boton charro by Magonegro JUL-2016
// Radius (mm):
Radius=15;
// Number of balls:
Balls=12;
// Keyring or not:
KeyRing=1; // [0:No, 1:Yes]
// Height of the base:
BaseHeight=3;
// Inner Rings or not:
InnerRings=1; // [0:No, 1:Yes]
// Inner Rings or not:
OuterRing=0; // [0:No, 1:Yes]
// Resolution (typ. 30): 
Facets=30;

/* [Hidden] */
Angle=360/Balls;
BallRadius=(3.1415926535*Radius/Balls)/1.2;

module Ball(X,Y,R)
{
    translate([X,Y,0])
    union()
    {
    difference()
        {
        sphere(r=R,center=true,$fn=Facets);
        translate([0,0,-R]) cylinder(r=R,h=R,$fn=Facets);
        }
    translate([0,0,-BaseHeight])
        cylinder(r=R,h=BaseHeight,$fn=Facets);
    }
}

module Ring(X,R,H)
{
translate([0,0,H])
rotate_extrude(convexity = 10,$fn=Facets)
translate([R, 0, 0])
    union()
    {
    circle(r = X, $fn = Facets);    
    translate([-X,-(BaseHeight+H)])
        square([X*2,BaseHeight+H]);
    }
}


// Main
union()
{
    translate([0,0,-BaseHeight])
    cylinder(r=Radius,h=BaseHeight,$fn=Facets);
    difference()
    {
    translate([0,0,-Radius/1.3]) sphere(r=Radius*1.2,centre=true,$fn=Facets);
    translate([0,0,-Radius*2-BaseHeight]) cube([Radius*4,Radius*4,Radius*4],center=true);
    }
    translate([0,0,Radius/2.5]) Ball(0,0,BallRadius);
    for(i=[0:Balls-1])
    {
        Ball(Radius*cos(i*Angle),Radius*sin(i*Angle),BallRadius);
    }
    for(i=[0:Balls-1])
    {
        translate([0,0,Radius/3.5]) Ball(Radius/2*cos(i*Angle),Radius/2*sin(i*Angle),BallRadius/1.7);
    }
    if(InnerRings==1)
    {
    translate([0,0,Radius/5.5]) Ring(1,Radius-BallRadius-1,BallRadius/3);
    translate([0,0,Radius/3]) Ring(1,BallRadius+2,BallRadius/4);
    }
    if(OuterRing==1)
    {
    Ring(1,Radius+BallRadius-1,BallRadius/3);
    translate([0,0,-BaseHeight])
    cylinder(r=Radius+BallRadius-1,h=BaseHeight,$fn=Facets);
    }
    if(KeyRing==1)
    {
        translate([Radius+BallRadius+3,0,-BaseHeight])
        difference()
        {
        cylinder(r=6,h=BaseHeight,$fn=Facets);
        cylinder(r=3,h=BaseHeight,$fn=Facets);
        }
    }
}
    
