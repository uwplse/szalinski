
// Make sure everything is nice and round..
$fn=80;


//
// pulley settings...
//
PulleyDiameter=50; // diameter of the pulley
Wall=1; // thickness of the wallof the pulley
WheelHeight=2;// height of the inner wheel
HubDiam=10; // hub diameter
HubHeight=10;  // height of the hub
AxleDiam=2.5; // Axle diameter
BeltDiam=2; // diameter of the belt
WheelHoles=1;  // [0,1] 
               //do the wheel holes or not. . .

Squarebelt=0;  // [0,1]
               //normally a round belt

SecondLayer=1;  // [0,1]
                //a second layer ?
SecondDiam=12;     // the second layer preferably smaller and forced to no holes.. .



module torus(diam,rad)
{
    rotate_extrude($fn = 100)
    {
       if (Squarebelt)
       {
            translate([rad/2-diam/2,-diam/2,0])square(diam);
       }
       else
       {
            translate([rad/2,0,0])circle(d=diam);
       }
    }
    
}


module Inner(diam=20,h=2)
{
    cylinder(d=diam,h=h);
}

module Hub(hubD=10,hubH=10)
{
    cylinder(d=hubD,h=hubH);
}

module Axle(axleD=1)
{
    cylinder(d=axleD,h=100,center=true);
}

module PulleyWheel(diam=20,belt=2,wheelHeight=2,hubdiam=10,hubHeight=10,axled=1,wheelHoles=1)
{
    
    WheelHoleD = (diam/2-hubdiam/2-3*Wall)/3;
 
    WheelHoleTranslate = diam/20+(hubdiam/2+(diam/2-4*Wall)-(hubdiam/2))/2;
    
    
    
    difference()
    {
        union()
        {
            difference()
            {
                cylinder(d=diam,h=belt+2*Wall);
                translate([0,0,belt/2+Wall])torus(diam=belt,rad=diam);
                translate([0,0,-0.5])cylinder(d=diam-belt-(2*Wall),h=belt+2*Wall+1);
            }
        
    
            Inner(diam=diam-belt-Wall,h=wheelHeight);

            Hub(hubD=hubdiam,hubH=hubHeight);
        }
        
        Axle(axleD=axled);
        
        if(wheelHoles==1)
        {
            for(i=[0:3])
            {
                rotate([0,0,i*360/4])
                   translate([WheelHoleTranslate,0,0])cylinder(r=WheelHoleD,h=100,center=true);
            }
        }
        
    }
}



//torus(diam=2,rad=20);

PulleyWheel(diam=PulleyDiameter,belt=BeltDiam,wheelHeight=WheelHeight,hubdiam=HubDiam,hubHeight=HubHeight,axled=AxleDiam,wheelHoles=WheelHoles);


if (SecondLayer==1)
{
  //
  // a second small wheel
  //
  translate([0,0,2*Wall+BeltDiam])PulleyWheel(diam=SecondDiam,belt=BeltDiam,wheelHeight=  WheelHeight,hubdiam=HubDiam,hubHeight=1,axled=AxleDiam,wheelHoles=0);
}