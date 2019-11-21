// Fidget spinner by Magonegro JAN-2017
// Bearing diameter (mm) defaults to 608Z Type:
BEARINGDIAMETER=22.2;
// Bearing height (mm) defaults to 7 (608Z Type):
BEARINGHEIGHT=7;
// Bearing hole (mm) defaults to 8( 608Z Type):
BEARINGHOLE=7.8;
// Number of bearings:
BEARINGCOUNT=6;
// Distance from bearing to bearing (mm) Also thickness:
BEARINGDISTANCE=6;
// Lock height (mm):
LOCKHEIGHT=2;
// Lock diameter (mm):
LOCKDIAMETER=18;
// Lock bevel
LOCKBEVEL=0; //[0:No, 1:Yes]
// Resolution (min.100 facets):
Facets=60;
// Type:
TYPE=2; // [1:Linear, 2:Star]
// Render Fidget or not:
RENDERFIDGET=1; // [0:No, 1:Yes]
// Render Locks or not (set linear to true):
RENDERLOCKS=1; // [0:No, 1:Yes]

/* [Hidden] */
// Hidden settings for normal users.
LOCKS=BEARINGCOUNT*2; // # of locks
LX=BEARINGCOUNT*BEARINGDIAMETER+(BEARINGCOUNT+1)*BEARINGDISTANCE;
LY=BEARINGDIAMETER+2*BEARINGDISTANCE;
// Here comes some logic about star arm length.
// Let's say that you want to put 10 608 bearings in a star shaped fidget.
// Depending on bearing diameter you should increase tha arm length to
// accomodate all of them without interfering each other and maintaining
// part integrity. So armlenght is choosen like this:
// As in the above example we then have 10 total bearings, 1 at the center
// and 9 on the arms. Each arm should have X=BEARINGDIAMETER+BEARINGDISTANCE
// between bearings centers. we have then a 9X perimeter circle whose radius
// is 9X=2*pi*R ==> R=9X/2pi, So, for 608 bearings, and a Bering dist. of 5mm
// R should be: 9*(22+5)/2*3.141592 = 38.67mm. 
// Pretty good but we also need to know that our calc is assuming that the
// perimeter of the circle equals the sum of linear distances between centers,
// and this is only true when we have infinite bearings (expensive fidget, you know)
// so, we are going to feature a magic number to compensate the error, let's say
// 1.25 in practice. We then multiply this obtained radius by this delta.
// In the end R=38.67*1.2=46.40 mm. We could calculate the exact radius but
// this is enough for a toy.
// Finally we have to add BEARINGDISTANCE plus BEARINGDIAMETER/2 to accomodate
// the whole bearing. So: ARMLENGTH=46.40+(5+11) = 62.40mm.
// Ok. But beside this we have the other side of the problem, where we have
// let's say only 3 arms. The minimum radius should be: 
// R=BEARINGDIAMETER+BEARINGDISTANCE;
DELTA=1.25;
RADIUSOPT=max(DELTA*((BEARINGCOUNT-1)*(BEARINGDIAMETER))/(2*3.141592),
    BEARINGDIAMETER+BEARINGDISTANCE);
ARMLEN=RADIUSOPT+BEARINGDISTANCE+BEARINGDIAMETER/2;
RADIUSBEARINGS=BEARINGDISTANCE+BEARINGDIAMETER/2-ARMLEN;

module Fidget()
{
    difference()
    {
    cube([LX,LY,BEARINGHEIGHT]);
    for(i=[0:BEARINGCOUNT-1])
        {
        translate([((i+1)*BEARINGDISTANCE)+(i*BEARINGDIAMETER)+BEARINGDIAMETER/2,
                    BEARINGDISTANCE+BEARINGDIAMETER/2,
                    -BEARINGHEIGHT/3]) 
            cylinder(h=BEARINGHEIGHT*2,r=BEARINGDIAMETER/2,$fn=Facets);
        }
    difference()
        {
        cube([BEARINGDISTANCE+BEARINGDIAMETER/2,LY,BEARINGHEIGHT]);
        translate([BEARINGDISTANCE+BEARINGDIAMETER/2,
                    BEARINGDISTANCE+BEARINGDIAMETER/2,
                    -BEARINGHEIGHT/3])
            cylinder(h=BEARINGHEIGHT*2,r=(BEARINGDIAMETER/2+BEARINGDISTANCE)*1.01,
                $fn=Facets);
        }
    difference()
        {
        translate([(BEARINGCOUNT-1)*(BEARINGDISTANCE+BEARINGDIAMETER)+
                    BEARINGDISTANCE+BEARINGDIAMETER/2,0,0]) 
            cube([BEARINGDISTANCE+BEARINGDIAMETER/2,LY,BEARINGHEIGHT]);
        translate([(BEARINGCOUNT-1)*(BEARINGDISTANCE+BEARINGDIAMETER)+
                    BEARINGDISTANCE+BEARINGDIAMETER/2,
                    BEARINGDISTANCE+BEARINGDIAMETER/2,
                    -BEARINGHEIGHT/3]) 
            cylinder(h=BEARINGHEIGHT*2,
                r=(BEARINGDIAMETER/2+BEARINGDISTANCE)*1.01,$fn=Facets);
        }
    }
}

module StarArm()
{
    translate([-ARMLEN,0,0])
    difference()
    {
        translate([0,-LY/2,0]) cube([ARMLEN,LY,BEARINGHEIGHT]);
        difference()
        {
        translate([0,-LY/2,0]) 
            cube([BEARINGDISTANCE+BEARINGDIAMETER/2,LY,BEARINGHEIGHT]);
        translate([BEARINGDISTANCE+BEARINGDIAMETER/2,0,-BEARINGHEIGHT/3]) 
            cylinder(h=BEARINGHEIGHT*2,
                r=BEARINGDIAMETER/2+BEARINGDISTANCE*1.01,
                $fn=Facets);
        }
    }
}

module FidgetStar()
{
    difference()
    {
        union()
        {
            for(i=[0:BEARINGCOUNT-2])
            {
                rotate([0,0,i*(360/(BEARINGCOUNT-1))]) StarArm();
            }
        }
        translate([0,0,-BEARINGHEIGHT/3])
        cylinder(h=BEARINGHEIGHT*2,r=BEARINGDIAMETER/2,$fn=Facets);
        for(i=[0:BEARINGCOUNT-2])
        {
        rotate([0,0,i*(360/(BEARINGCOUNT-1))])
            translate([RADIUSBEARINGS,0,-BEARINGHEIGHT/3]) 
                cylinder(h=BEARINGHEIGHT*2,r=BEARINGDIAMETER/2,$fn=Facets);
         
        }

    }
}

module Lock()
{
    difference()
    {
        union()
        {
        cylinder(h=LOCKHEIGHT,r=LOCKDIAMETER/2,$fn=Facets);
        translate([0,0,LOCKHEIGHT/1.05]) 
            cylinder(h=BEARINGHEIGHT/2,r=BEARINGHOLE/2,$fn=Facets);
        }
        if(LOCKBEVEL)
        {
            translate([0,0,-LOCKDIAMETER+LOCKHEIGHT/2]) sphere(r=LOCKDIAMETER,$fn=Facets);
        }
    }
}

module Locks()
{
    for(i=[1:BEARINGCOUNT])
        {
        translate([BEARINGDISTANCE*i+BEARINGDIAMETER/2+BEARINGDIAMETER*(i-1),
            0,0]) 
            Lock();
        }
}

// Main
if(TYPE==1)
{
if(RENDERFIDGET) 
    Fidget();
if(RENDERLOCKS)
    {
    translate([0,-LOCKDIAMETER/2-BEARINGDISTANCE,0]) 
       Locks();
    translate([0,-(3*LOCKDIAMETER/2)-BEARINGDISTANCE*2,0])
       Locks();
    }
}

if(TYPE==2)
{
if(RENDERFIDGET)
    FidgetStar();
// Render locks separately for star type fidget
}
