// 0=AlleMitBase1
// 1=AlleMitBase2
// 2=Haube - Fuer Druck gedreht
// 3=FuehlerX
// 4=FuehlerKonter
// 5=FuehlerBase - Fuer Druck gedreht
// 6=Deckel
// 7=Stellrad
// 8=Opto - Fuer Druck gedreht
// 9=Base1
// 10=Base2
DoIt=0; 

include <knurledFinishLib.scad>

$fn=360;

// a lower number makes finer points: 180 felt good, 250 is sharp but better grip, 400 previews quickly.
knob_knurled_finish=250;
knurled_finish=(knob_knurled_finish/50);

StellradH=5;
StellradA=7;
StellradD=32;
StellradB=3.0;

OptoZ=10;
OptoX=40;
OptoY=20;
OptoB=2.1;

BaseZ=10;
BaseX=40;
BaseY=15.5;
BaseDiff=0.1;
BaseFH=35;
BaseB=5.8;
BaseGB=11.0;

DeckelZ=5;
DeckelB=3;
DeckelGB=6.2;
DeckelHB=3;

Nema17XY=42;
Nema17XYB=31;
Nema17Innen=25;
Nema17B=3.5;

FuehlerM=5;

HaubeRD=2;
HaubeWD=2.5;
HaubeIY=11;
HaubeIX=34;
HaubeIZ=12;


nr=0;

module Stellrad()
{
    difference()
    {
        union()
        {
            knurled_cyl(StellradH,StellradD,5,5,1,1,10);
            translate([0,0,StellradH]) cylinder(r1=5.5,r2=4.2,h=StellradA);
            translate([0,0,StellradH]) 
            for (step=[1:5])            
            {
                rotate([0,0,step*72+36])  {translate([StellradD/2-9,0,0]) rotate([0,0,90]) cube([0.8,StellradD/2,1.6], center=true);}
                rotate([0,0,step*72]) 
                {
                    translate([StellradD/2-9,0,0]) rotate([0,0,90]) cube([0.8,StellradD/10,1.6], center=true);

                    translate([StellradD/2-1,0,0]) 
                        linear_extrude(height=0.8) 
                        rotate([0,0,90]) 
                        text(str(step),font="Open Sans:style=Bold",size=6,halign="center",valign="bottom"); 
                }
 
                }
        }
        union()
        {
            translate([0,0,StellradH+StellradA-3.2]) cylinder(d=6.7,h=3.3,$fn=6); // M3=6.7; M4=7.8; M5=9.0; M6=11.8; M8=14.5
            translate([0,0,-0.1]) cylinder(d=7.4,h=4);
            translate([0,0,-0.1]) cylinder(d=StellradB,h=0.2+StellradH+StellradA);
        }
    }
}

module Opto()
{
 //   translate([0,-10,5]) rotate([90,0,0]) color("LightBlue",1.0) import("optical_endstop.stl",convexity=5);
    difference()
    {
        translate([-OptoX/2,-OptoY/2,0]) cube([OptoX,OptoY,OptoZ], center=false);
        union()
        {
            hull()
            {
                translate([0,-OptoY/2,0]) cylinder(h=40,d=5,center=true);
                translate([9,-OptoY/2,0]) cylinder(h=40,d=5,center=true);
            }
             hull()
            {
                translate([-25,-OptoY/2,0]) cylinder(h=40,d=5,center=true);
                translate([-10,-OptoY/2,0]) cylinder(h=40,d=5,center=true);
            }
             hull()
            {
                translate([50,-OptoY/2,0]) cylinder(h=40,d=5,center=true);
                translate([19,-OptoY/2,0]) cylinder(h=40,d=5,center=true);
            }
            translate([-5,-OptoY/2+OptoY/3,OptoZ/2]) rotate([90,0,0]) cylinder(h=OptoY,d=OptoB,center=true);
            translate([-5+19,-OptoY/2+OptoY/3,OptoZ/2]) rotate([90,0,0]) cylinder(h=OptoY,d=OptoB,center=true);
            translate([0,0,0]) cylinder(h=40,d=StellradB,center=true);
            translate([0,0,OptoZ/2]) cylinder(d=6.7,h=6.6,$fn=6); // M3=6.7; M4=7.8; M5=9.0; M6=11.8;
            translate([-10,0,0]) cylinder(h=40,d=StellradB,center=true);
            translate([10,0,0]) cylinder(h=40,d=StellradB,center=true);
            translate([-10,0,OptoZ-1]) cylinder(h=3.1,d=6.5,center=false);
            translate([10,0,OptoZ-1]) cylinder(h=3.1,d=6.5,center=false);
            translate([-10,0,OptoZ-3.5]) cylinder(h=2.6,d2=6.5,d1=3,center=false);
            translate([10,0,OptoZ-3.5]) cylinder(h=2.6,d2=6.5,d1=3,center=false);
            translate([-10,0,-0.1]) cylinder(d=6.7,h=4.3,$fn=6); // M3=6.7; M4=7.8; M5=9.0; M6=11.8;
            translate([10,0,-0.1]) cylinder(d=6.7,h=4.3,$fn=6); // M3=6.7; M4=7.8; M5=9.0; M6=11.8;
            translate([0,0,-.1]) cylinder(d=6.5,h=2.1); 
            hull()
            {
                translate([-OptoX/2,-OptoY/4+2.5,0]) cylinder(h=40,d=8,center=true);
                translate([-OptoX/2,+OptoY/4,0]) cylinder(h=40,d=8,center=true);
            }
            hull()
            {
                translate([OptoX/2,-OptoY/4+2.5,0]) cylinder(h=40,d=8,center=true);
                translate([OptoX/2,+OptoY/4,0]) cylinder(h=40,d=8,center=true);
            }
        }
    }
    translate([0,0,4.8]) cube([8,8,0.4],center=true);            
}

module Base1()
{
    difference()
    {
        union()
        {
            translate([-BaseX/2,-BaseY/2+1.25,0]) cube([BaseX,BaseY,BaseZ], center=false);
            hull()
            {
                translate([-OptoX/2-BaseDiff,-OptoY/4+2.5,0]) cylinder(h=BaseFH,d=8,center=false);
                translate([-OptoX/2-BaseDiff,+OptoY/4,0]) cylinder(h=BaseFH,d=8,center=false);
            }
           hull()
            {
                translate([OptoX/2+BaseDiff,-OptoY/4+2.5,0]) cylinder(h=BaseFH,d=8,center=false);
                translate([OptoX/2+BaseDiff,+OptoY/4,0]) cylinder(h=BaseFH,d=8,center=false);
            }
            hull()
            {
                translate([OptoX/2+BaseDiff,-OptoY/4+2.5,0]) cylinder(h=15,d=8,center=false);
                translate([OptoX/2+BaseDiff,+OptoY/4+10,0]) cylinder(h=15,d=8,center=false);
                translate([OptoX/2+64,+OptoY/4+10,0]) cylinder(h=15,d=8,center=false);
           }
           translate([OptoX/2+64,+OptoY/4+10,0]) cube([4,4,15],center=false);
           translate([OptoX/2+BaseDiff-2.8,+OptoY/4-9,0]) rotate([0,0,45]) cube([BaseY,BaseY,BaseZ],center=false);
        }
        union()
        {
            translate([0,0,0]) cylinder(h=40,d=StellradB,center=true);
            translate([-10,0,0]) cylinder(h=40,d=StellradB,center=true);
            translate([10,0,0]) cylinder(h=40,d=StellradB,center=true);
            translate([-10,0,BaseZ-2]) cylinder(d=6.5,h=2.1); 
            translate([10,0,BaseZ-2]) cylinder(d=6.5,h=2.1); 
            translate([0,0,BaseZ-2]) cylinder(d=6.5,h=2.1); 

            translate([OptoX/2+54+4,+OptoY/4+14.1,7.5]) rotate([90,0,0]) cylinder(h=20,d=BaseB,center=false);
            translate([OptoX/2+34+4,+OptoY/4+14.1,7.5]) rotate([90,0,0]) cylinder(h=20,d=BaseB,center=false);
            translate([OptoX/2+54+4,+OptoY/4+14.1-4.1,7.5]) rotate([90,0,0]) cylinder(h=20,d=BaseGB,center=false);
            translate([OptoX/2+34+4,+OptoY/4+14.1-4.1,7.5]) rotate([90,0,0]) cylinder(h=20,d=BaseGB,center=false);

            translate([OptoX/2+14,+OptoY/4+3,-0.1]) cylinder(h=20,d=16,center=false);
            translate([-OptoX/2-BaseDiff,+1.25,BaseFH-15+0.1]) cylinder(h=15,d=OptoB,center=false);
            translate([OptoX/2-BaseDiff,+1.25,BaseFH-15+0.1]) cylinder(h=15,d=OptoB,center=false);
        }
    }
    
}

module Base2()
{
    difference()
    {
        union()
        {
            translate([-BaseX/2,-BaseY/2+1.25,0]) cube([BaseX,BaseY,BaseZ], center=false);
            hull()
            {
                translate([-OptoX/2-BaseDiff,-OptoY/4+2.5,0]) cylinder(h=BaseFH,d=8,center=false);
                translate([-OptoX/2-BaseDiff,+OptoY/4,0]) cylinder(h=BaseFH,d=8,center=false);
            }
            hull()
            {
                translate([OptoX/2+BaseDiff,-OptoY/4+2.5,0]) cylinder(h=BaseFH,d=8,center=false);
                translate([OptoX/2+BaseDiff,+OptoY/4,0]) cylinder(h=BaseFH,d=8,center=false);
            }
            hull()
            {
                translate([-OptoX/2-BaseDiff,+OptoY/4+38,0]) cylinder(h=20,d=8,center=false);
                translate([OptoX/2+74,+OptoY/4+38,0]) cylinder(h=20,d=8,center=false);
            }
            translate([OptoX/2+74,+OptoY/4+34,0]) cube([4,4,20],center=false);
            hull()
            {
                difference()
                {
                    union()
                    {
                        translate([0,+OptoY/4+38+4,+10]) rotate([0,0,45]) cube([4,4,16],center=true);
                        translate([OptoX/2+39,+OptoY/4+38+4,+10]) rotate([0,0,45]) cube([4,4,16],center=true);
                    }
                    union()
                    {
                        translate([0,+OptoY/4+38+4.5,20]) rotate([45,0,0]) cube([8,4,16],center=true);
                        translate([0,+OptoY/4+38+4.5,20-20]) rotate([-45,0,0]) cube([8,4,16],center=true);
                        translate([OptoX/2+39,+OptoY/4+38+4.5,20]) rotate([45,0,0]) cube([8,4,16],center=true);
                        translate([OptoX/2+39,+OptoY/4+38+4.5,0]) rotate([-45,0,0]) cube([8,4,16],center=true);
                    }
                }
            }            
            hull()
            {
                translate([-OptoX/2-BaseDiff,+OptoY/4,0]) cylinder(h=10,d=8,center=false);
                translate([-OptoX/2-BaseDiff,+OptoY/4+8,0]) cylinder(h=10,d=8,center=false);
                translate([OptoX/2+BaseDiff,+OptoY/4,0]) cylinder(h=10,d=8,center=false);
                translate([OptoX/2+BaseDiff,+OptoY/4+8,0]) cylinder(h=10,d=8,center=false);
            }
            hull()
            {
                translate([-OptoX/2-BaseDiff,+OptoY/4+38,0]) cylinder(h=20,d=8,center=false);
                translate([-OptoX/2-BaseDiff,+OptoY/4+8,0]) cylinder(h=10,d=8,center=false);
                translate([OptoX/2+BaseDiff,+OptoY/4+38,0]) cylinder(h=20,d=8,center=false);
                translate([OptoX/2+BaseDiff,+OptoY/4+8,0]) cylinder(h=10,d=8,center=false);
           }
           translate([OptoX/2+BaseDiff+4,+OptoY/4+30,0]) cube([4,4,17],center=false);
        }
        union()
        {
            translate([0,0,0]) cylinder(h=40,d=StellradB,center=true);
            translate([-10,0,0]) cylinder(h=40,d=StellradB,center=true);
            translate([10,0,0]) cylinder(h=40,d=StellradB,center=true);
            translate([-10,0,BaseZ-2]) cylinder(d=6.5,h=2.1); 
            translate([10,0,BaseZ-2]) cylinder(d=6.5,h=2.1); 
            translate([0,0,BaseZ-2]) cylinder(d=6.5,h=2.1); 

            translate([OptoX/2+68,40,10]) rotate([90,0,0]) cylinder(h=20,d=BaseB,center=true);
            translate([OptoX/2+48,40,10]) rotate([90,0,0]) cylinder(h=20,d=BaseB,center=true);
            translate([OptoX/2+68,40+7.4,10]) rotate([90,0,0]) cylinder(h=4.1,d=BaseGB,center=false);
            translate([OptoX/2+48,40+7.4,10]) rotate([90,0,0]) cylinder(h=4.1,d=BaseGB,center=false);

            translate([-OptoX/2-BaseDiff,+1.25,BaseFH-15+0.1]) cylinder(h=15,d=OptoB,center=false);
            translate([OptoX/2-BaseDiff,+1.25,BaseFH-15+0.1]) cylinder(h=15,d=OptoB,center=false);
            translate([OptoX/2+BaseDiff+8,+OptoY/4+30,-0.1]) cylinder(h=20.2,d=8,center=false);
            hull()
            {
                translate([10-OptoX/2-BaseDiff,+OptoY/4+24,-0.1]) cylinder(h=20,d=14,center=false);
                translate([10-OptoX/2-BaseDiff,+OptoY/4+14,-0.1]) cylinder(h=20,d=14,center=false);
            }
            hull()
            {
                translate([-10+OptoX/2-BaseDiff,+OptoY/4+24,-0.1]) cylinder(h=20,d=14,center=false);
                translate([-10+OptoX/2-BaseDiff,+OptoY/4+14,-0.1]) cylinder(h=20,d=14,center=false);
            }
            translate([OptoX/2+29,+OptoY/4+38+9.7,10]) rotate([45,0,0]) cube([140,8,8],center=true);
        }
    }
}

module Deckel()
{
    difference()
    {
        hull()
        {
            translate([-OptoX/2-BaseDiff,-OptoY/4+2.5,0]) cylinder(h=DeckelZ,d=8,center=false);
            translate([-OptoX/2-BaseDiff,+OptoY/4,0]) cylinder(h=DeckelZ,d=8,center=false);
            translate([OptoX/2+BaseDiff,-OptoY/4+2.5,0]) cylinder(h=DeckelZ,d=8,center=false);
            translate([OptoX/2+BaseDiff,+OptoY/4,0]) cylinder(h=DeckelZ,d=8,center=false);
        }
        union()
        {
            translate([0,0,0]) cylinder(h=DeckelZ-0.5,d=StellradB+0.5,center=true);
            translate([-OptoX/2-BaseDiff,+1.25,-0.10]) cylinder(h=15,d=DeckelB,center=false);
            translate([OptoX/2-BaseDiff,+1.25,-0.1]) cylinder(h=15,d=DeckelB,center=false);
            translate([-OptoX/2-BaseDiff,+1.25,DeckelZ+0.1-DeckelHB]) cylinder(h=DeckelHB,d=DeckelGB,center=false);
            translate([OptoX/2-BaseDiff,+1.25,DeckelZ+0.1-DeckelHB]) cylinder(h=DeckelHB,d=DeckelGB,center=false);
        }
    }
}

module FuehlerBase()
{
//        translate([0,16.8,0]) rotate([90,0,0]) color("LightBlue",1.0) import("Motor_NEMA17.stl",convexity=5);
    difference()
    {
        union()
        {
            translate([-Nema17XY/2,-FuehlerM,-Nema17XY/2]) cube([Nema17XY+7,FuehlerM,Nema17XY], center=false);
            hull()
            {
                translate([-Nema17XY/2+2,0,-Nema17XY/2]) rotate([90,0,0]) cylinder(h=FuehlerM,d=4,center=false);
                translate([+Nema17XY/2-2+7,0,-Nema17XY/2]) rotate([90,0,0]) cylinder(h=FuehlerM,d=4,center=false);
                translate([-Nema17XY/2+2,0,-Nema17XY/2-16]) rotate([90,0,0]) cylinder(h=FuehlerM,d=4,center=false);
                translate([+Nema17XY/2-2+7,0,-Nema17XY/2-16]) rotate([90,0,0]) cylinder(h=FuehlerM,d=4,center=false);
            }
        }
        union()
        {
            hull()
            {
                translate([-Nema17XY/2+5,0.1,-Nema17XY/2-12]) rotate([90,0,0]) cylinder(h=FuehlerM+0.2,d=3.5,center=false);
                translate([+Nema17XY/2-5+7,0.1,-Nema17XY/2-12]) rotate([90,0,0]) cylinder(h=FuehlerM+0.2,d=3.5,center=false);
            }
            hull()
            {
                translate([-Nema17XY/2+6,-FuehlerM+2,-Nema17XY/2-12]) rotate([90,0,0]) cylinder(h=2+0.2,d=10,center=false);
                translate([+Nema17XY/2-6+7,-FuehlerM+2,-Nema17XY/2-12]) rotate([90,0,0]) cylinder(h=2+0.2,d=10,center=false);
            }
            translate([0,0.1,0]) rotate([90,0,0]) cylinder(h=FuehlerM+0.2,d=Nema17Innen,center=false);
            translate([Nema17Innen/2-Nema17XY-2,-FuehlerM-0.1,0]) cube([Nema17XY,FuehlerM+0.2,Nema17XY], center=false);
            translate([-Nema17XY,-FuehlerM-0.1,-Nema17Innen/2+2]) cube([Nema17XY,FuehlerM+0.2,Nema17XY],center=false);
            rotate([0,-45,0]) translate([Nema17XY/1.3+4,-(FuehlerM-0.1)/2,0]) cube([10,FuehlerM+0.2,20],center=true);
            translate([-Nema17XYB/2,0,-Nema17XYB/2]) rotate([90,0,0]) cylinder(h=20,d=Nema17B,center=true);
            translate([Nema17XYB/2,0,-Nema17XYB/2]) rotate([90,0,0]) cylinder(h=20,d=Nema17B,center=true);
            translate([Nema17XYB/2,0,Nema17XYB/2]) rotate([90,0,0]) cylinder(h=20,d=Nema17B,center=true);
        }
    }
 }

module FuehlerX()
{
    difference()
    {
        union()
        {
             hull()
            {
                translate([-7,0,0]) cylinder(h=18,d=9.5,center=false);
                translate([+7,0,0]) cylinder(h=18,d=9.5,center=false);
            }
            translate([0,-10.25-10,14-3.25]) cube([7,50,21.5],center=true);           
        }
        union()
        {
            translate([-7,0,0]) cylinder(h=20,d=3.5,center=true);
            translate([+7,0,0]) cylinder(h=20,d=3.5,center=true);
            translate([3.5,-10,4]) cube([10,20,40],center=false);
            translate([-13.5,-10,4]) cube([10,20,40],center=false);
            difference()
            {
                translate([0,2.5,20]) cube([8,5,5],center=true);           
                translate([0,0,16.5]) rotate([0,90,0]) cylinder(h=40,d=10,center=true);         
            }
            translate([-5-0.75,-30,5]) cube([10,50,15],center=true);           
            translate([5+0.75,-30,5]) cube([10,50,15],center=true);           
            translate([5+0.75,-35,12]) rotate([90,0,0]) cylinder(h=60,d=10,center=true);         
            translate([-5-0.75,-35,12]) rotate([90,0,0]) cylinder(h=60,d=10,center=true);         
        }
    }
}

module FuehlerKonter()
{
    difference()
    {
        hull()
        {
            translate([-7,0,0]) cylinder(h=5,d=9.5,center=false);
            translate([+7,0,0]) cylinder(h=5,d=9.5,center=false);
        }
        union()
        {
            translate([-7,0,0]) cylinder(h=20,d=3.5,center=true);
            translate([+7,0,0]) cylinder(h=20,d=3.5,center=true);
            translate([-7,0,2]) cylinder(d=6.7,h=6.6,$fn=6); // M3=6.7; M4=7.8; M5=9.0; M6=11.8;
            translate([+7,0,2]) cylinder(d=6.7,h=6.6,$fn=6); // M3=6.7; M4=7.8; M5=9.0; M6=11.8;
        }
    }
}

module Haube()
{
    difference()
    {
        hull()
        {
            translate([13+HaubeWD-HaubeRD,HaubeIY/2+HaubeWD-HaubeRD,0]) sphere(HaubeRD);
            translate([13-HaubeIX-HaubeWD+HaubeRD,HaubeIY/2+HaubeWD-HaubeRD,0]) sphere(HaubeRD);
            translate([13+HaubeWD-HaubeRD,HaubeIY/2+HaubeWD-HaubeRD,HaubeIZ+HaubeWD-HaubeRD]) sphere(HaubeRD);
            translate([13-24-HaubeWD+HaubeRD,HaubeIY/2+HaubeWD-HaubeRD,HaubeIZ+HaubeWD-HaubeRD]) sphere(HaubeRD);
            translate([13-HaubeIX-HaubeWD+HaubeRD,HaubeIY/2+HaubeWD-HaubeRD,5+HaubeWD-HaubeRD]) sphere(HaubeRD);
            
            translate([13+HaubeWD-HaubeRD,-HaubeIY/2-HaubeWD+HaubeRD,0]) sphere(HaubeRD);
            translate([13-HaubeIX-HaubeWD+HaubeRD,-HaubeIY/2-HaubeWD+HaubeRD,0]) sphere(HaubeRD);
            translate([13+HaubeWD-HaubeRD,-HaubeIY/2-HaubeWD+HaubeRD,HaubeIZ+HaubeWD-HaubeRD]) sphere(HaubeRD);
            translate([13-24-HaubeWD+HaubeRD,-HaubeIY/2-HaubeWD+HaubeRD,HaubeIZ+HaubeWD-HaubeRD]) sphere(HaubeRD);
            translate([13-HaubeIX-HaubeWD+HaubeRD,-HaubeIY/2-HaubeWD+HaubeRD,5+HaubeWD-HaubeRD]) sphere(HaubeRD);
        }
        union()
        {
            translate([0,0,-5]) cube([50,50,10],center=true);    
            translate([13-HaubeIX,-HaubeIY/2,-0.1]) cube([HaubeIX,HaubeIY,5],center=false);   
            translate([13-HaubeIX+14.75,-3.5,-0.1]) cube([12.5,7,HaubeIZ],center=false);
            translate([13-HaubeIX+17,-HaubeIY/2-5,5.5-HaubeRD]) cube([8,HaubeIY+10,HaubeIZ],center=false);
            translate([5-HaubeIX,-4,-0.1]) cube([10,8,4],center=false);   
            hull()
            {
                translate([13-HaubeIX+HaubeRD/2,0,5]) rotate([90,0,0]) cylinder(h=HaubeIY,d=HaubeRD,center=true);         
                translate([13-HaubeIX+HaubeRD/2+6,0,5]) rotate([90,0,0]) cylinder(h=HaubeIY,d=HaubeRD,center=true);         
                translate([13-HaubeIX+HaubeRD/2+6,0,9]) rotate([90,0,0]) cylinder(h=HaubeIY,d=HaubeRD,center=true);         
            }
            translate([19/2,0,0]) cylinder(h=40,d=3.2,center=false);
            translate([-19/2,0,0]) cylinder(h=40,d=3.2,center=false);
            translate([19/2,0,5.5]) cylinder(h=1,d1=3.2,d2=6,center=false);
            translate([-19/2,0,5.5]) cylinder(h=1,d1=3.2,d2=6,center=false);
            translate([19/2,0,6.5]) cylinder(h=40,d=6,center=false);
            translate([-19/2,0,6.5]) cylinder(h=40,d=6,center=false);
        }
    }
    difference()
    {
        union()
        {
            hull()
            {
                translate([13-HaubeIX+17,HaubeIY/2+HaubeWD-HaubeRD,5.5-HaubeRD]) sphere(HaubeRD);
                translate([13-HaubeIX+17,HaubeIY/2+HaubeWD-HaubeRD,HaubeIZ+HaubeWD-HaubeRD]) sphere(HaubeRD);
                translate([13-HaubeIX+17,-HaubeIY/2-HaubeWD+HaubeRD,5.5-HaubeRD]) sphere(HaubeRD);
                translate([13-HaubeIX+17,-HaubeIY/2-HaubeWD+HaubeRD,HaubeIZ+HaubeWD-HaubeRD]) sphere(HaubeRD);
            }
            hull()
            {
                translate([13-HaubeIX+17+8,HaubeIY/2+HaubeWD-HaubeRD,5.5-HaubeRD]) sphere(HaubeRD);
                translate([13-HaubeIX+17+8,HaubeIY/2+HaubeWD-HaubeRD,HaubeIZ+HaubeWD-HaubeRD]) sphere(HaubeRD);
                translate([13-HaubeIX+17+8,-HaubeIY/2-HaubeWD+HaubeRD,5.5-HaubeRD]) sphere(HaubeRD);
                translate([13-HaubeIX+17+8,-HaubeIY/2-HaubeWD+HaubeRD,HaubeIZ+HaubeWD-HaubeRD]) sphere(HaubeRD);
            }
            hull()
            {
                translate([13-HaubeIX+17,HaubeIY/2+HaubeWD-HaubeRD,5.5-HaubeRD]) sphere(HaubeRD);
                translate([13-HaubeIX+17+8,HaubeIY/2+HaubeWD-HaubeRD,5.5-HaubeRD]) sphere(HaubeRD);
                translate([13-HaubeIX+17,-HaubeIY/2-HaubeWD+HaubeRD,5.5-HaubeRD]) sphere(HaubeRD);
                translate([13-HaubeIX+17+8,-HaubeIY/2-HaubeWD+HaubeRD,5.5-HaubeRD]) sphere(HaubeRD);
            }
        }
        union()
        {
            translate([13-HaubeIX,-HaubeIY/2,-0.1]) cube([HaubeIX,HaubeIY,5],center=false);   
            translate([13-HaubeIX+14.75,-3.5,-0.1]) cube([12.5,7,HaubeIZ],center=false);
         }
    }
}

module AlleMitBase1()
{
    translate([0,0,-10]) Stellrad();  
    translate([0,-10,5+18]) rotate([90,0,0]) color("LightBlue",1.0) import("optical_endstop.stl",convexity=5);
    translate([0,0,18]) Opto();    
    translate([0,0,0]) Base1(); 
    translate([0,0,35]) Deckel(); 
    translate([43-45,-7,86]) FuehlerBase();
    translate([4,-20+10,80-Nema17XY/2-6]) rotate([90,0,0]) FuehlerX();
    translate([4,-20+13,80-Nema17XY/2-6]) rotate([90,0,180]) FuehlerKonter();
//    translate([4.5,-9,23]) rotate([90,0,0]) Haube();

}

module AlleMitBase2()
{
    translate([0,0,-10]) Stellrad();  
    translate([0,-10,5+18]) rotate([90,0,0]) color("LightBlue",1.0) import("optical_endstop.stl",convexity=5);
    translate([0,0,18]) Opto();    
    translate([0,0,0]) Base2(); 
    translate([0,0,35]) Deckel(); 
    translate([43-45,-7,101]) FuehlerBase();
    translate([4,-20+10,95-Nema17XY/2-6]) rotate([90,0,0]) FuehlerX();
    translate([4,-20+13,95-Nema17XY/2-6]) rotate([90,0,180]) FuehlerKonter();
//    translate([4.5,-9,23]) rotate([90,0,0]) Haube();

}

if (DoIt==0) {AlleMitBase1();} 
else if (DoIt==1) {AlleMitBase2();} 
else if (DoIt==2) {rotate([-180,0,180]) Haube();}  // Fuer Druck gedreht
else if (DoIt==3) {FuehlerX();} 
else if (DoIt==4) {FuehlerKonter();} 
else if (DoIt==5) {rotate([-90,0,0]) FuehlerBase();} // Fuer Druck gedreht
else if (DoIt==6) {Deckel();} 
else if (DoIt==7) {Stellrad(); } 
else if (DoIt==8) {rotate([0,180,0]) Opto();} // Fuer Druck gedreht
else if (DoIt==9) {Base1();} 
else if (DoIt==10) {Base2();} 

//AlleMitBase1();
//AlleMitBase2();
//Haube();
//FuehlerX();
//FuehlerKonter();
//FuehlerBase();
//Deckel();
//Stellrad();  
//Opto();
//Base1();
//Base2();
// rotate([0,180,0]) Opto(); // Fuer Druck
//rotate([-90,0,0]) FuehlerBase(); // Fuer Druck
//rotate([-180,0,180]) Haube(); // Fuer Druck