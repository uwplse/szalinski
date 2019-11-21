use <Thread_Library.scad>
$fn = 120;

GewindeSteps=60;
GewindeLaenge=90+60;
SegmentLaenge=90;
BohrD=38;
MutterH=20;
MutterD=80;

Mutter1Code=["323424","242314","423423","321423","314234","413234"];
Mutter2Code=["342323","314313","432324","343143","324142","413234"];
Mutter3Code=["434343","343434","434343","343434","434343","432243"];

module BolzenGewinde()
{
    difference()
    {  
        union()
        {
         translate([0,0,-MutterH/2]) trapezoidThread(length=GewindeLaenge+MutterH,threadAngle=90,stepsPerTurn=GewindeSteps,pitch=5,pitchRadius=25,clearance=0.1); 
         translate([0,0,10]) cylinder(h=GewindeLaenge-20,d=47.5,center=false);
        }
        union()
        {  
            translate([0,0,10]) cylinder(h=GewindeLaenge-20,d=BohrD,center=false);
            translate([0,0,3]) cylinder(h=7,d2=BohrD,d1=BohrD/2,center=false);
            translate([0,0,GewindeLaenge-10]) cylinder(h=7,d1=BohrD,d2=BohrD/2,center=false);
            translate([0,0,-MutterH/2]) cylinder(h=MutterH/2,d=60,center=false);
            translate([0,0,GewindeLaenge]) cylinder(h=MutterH,d=60,center=false);
             translate([0,2,0]) cylinder(h=GewindeLaenge,d=10.5,center=false);
             translate([0,-2,0]) cylinder(h=GewindeLaenge,d=10.5,center=false);
             translate([0,2,1.5]) cylinder(h=3,d1=10.5,d2=10.5+3,center=false);
             translate([0,-2,1.5]) cylinder(h=3,d1=10.5,d2=10.5+3,center=false);
             translate([0,2,GewindeLaenge-4.5]) cylinder(h=3,d2=10.5,d1=10.5+3,center=false);
             translate([0,-2,GewindeLaenge-4.5]) cylinder(h=3,d2=10.5,d1=10.5+3,center=false);
            difference()
            {  
                translate([0,0,0]) cylinder(h=MutterH/2,d=BohrD+MutterH,center=false);
                translate([0,0,0]) cylinder(h=MutterH/2,d1=BohrD,d2=BohrD+MutterH,center=false);
            }
            difference()
            {  
                translate([0,0,GewindeLaenge-MutterH/2]) cylinder(h=MutterH/2,d=BohrD+MutterH,center=false);
                translate([0,0,GewindeLaenge-MutterH/2]) cylinder(h=MutterH/2,d1=BohrD+MutterH,d2=BohrD,center=false);
            }
       }
    }
}

module Schnitt(StartWinkel=0,AnzWinkel=0,SchnittLaenge=0)
{
    hull() for(step=[StartWinkel:0.5:StartWinkel+AnzWinkel]) rotate([0,0,step]) translate([0,0,(GewindeLaenge-SegmentLaenge)/2]) cube([SchnittLaenge,0.1,SegmentLaenge],center=false);
}

module SchnittMutter(StartWinkel=0,AnzWinkel=0,SchnittLaenge=0)
{
    hull() for(step=[StartWinkel:0.5:StartWinkel+AnzWinkel]) rotate([0,0,step]) translate([0,0,0]) cube([SchnittLaenge,0.1,SegmentLaenge],center=false);
}

module SchnittAussen(StartWinkel=0,AnzWinkel=0,SchnittLaenge=0,InnenKreis=0)
{
    difference()
    {
        hull() for(step=[StartWinkel:0.5:StartWinkel+AnzWinkel]) rotate([0,0,step]) translate([0,0,(GewindeLaenge-SegmentLaenge)/2]) cube([SchnittLaenge,0.1,SegmentLaenge],center=false);
        hull() for(step=[StartWinkel:0.5:StartWinkel+AnzWinkel]) rotate([0,0,step]) translate([0,0,(GewindeLaenge-SegmentLaenge)/2]) cube([InnenKreis,0.1,SegmentLaenge],center=false);
    }
}

module SegmentSchnitt(SchnittWinkel=0)
{
    SchnittAussen(StartWinkel=SchnittWinkel,AnzWinkel=1,SchnittLaenge=30,InnenKreis=BohrD/2+2);
    Schnitt(StartWinkel=SchnittWinkel+5,AnzWinkel=1,SchnittLaenge=BohrD/2+2+0.5);
    SchnittAussen(StartWinkel=SchnittWinkel+1,AnzWinkel=4,SchnittLaenge=BohrD/2+2+0.5,InnenKreis=BohrD/2+2);
}

module Bolzen1()
{
    difference()
    {
        translate([0,0,0]) BolzenGewinde();  
        union()
        {
            SegmentSchnitt(SchnittWinkel=0);
            SegmentSchnitt(SchnittWinkel=60);
            SegmentSchnitt(SchnittWinkel=120);
            SegmentSchnitt(SchnittWinkel=240);
            SchnittAussen(StartWinkel=60.5,AnzWinkel=59.5,SchnittLaenge=31,InnenKreis=BohrD/2+2);
            Schnitt(StartWinkel=60+5+0.5,AnzWinkel=59.5,SchnittLaenge=BohrD/2+2+0.5/2);
            SchnittAussen(StartWinkel=240.5,AnzWinkel=119.5,SchnittLaenge=31,InnenKreis=BohrD/2+2);
            Schnitt(StartWinkel=240+5+0.5,AnzWinkel=119.5,SchnittLaenge=BohrD/2+2+0.5/2);
            translate([0,0,(GewindeLaenge-SegmentLaenge)/2+SegmentLaenge-0.2]) cylinder(h=(GewindeLaenge-SegmentLaenge)/2+0.2,d=60,center=false);
        }
    }
}

module Bolzen2()
{
    difference()
    {
        translate([0,0,0]) BolzenGewinde();  
        union()
        {
            SegmentSchnitt(SchnittWinkel=0);
            SegmentSchnitt(SchnittWinkel=60);
            SegmentSchnitt(SchnittWinkel=120);
            SegmentSchnitt(SchnittWinkel=240);
            SchnittAussen(StartWinkel=0.5,AnzWinkel=59.5,SchnittLaenge=31,InnenKreis=BohrD/2+2);
            Schnitt(StartWinkel=0+5+0.5,AnzWinkel=59.5,SchnittLaenge=BohrD/2+2+0.5/2);
            SchnittAussen(StartWinkel=120.5,AnzWinkel=119.5,SchnittLaenge=31,InnenKreis=BohrD/2+2);
            Schnitt(StartWinkel=120+5+0.5,AnzWinkel=119.5,SchnittLaenge=BohrD/2+2+0.5/2);
            translate([0,0,0]) cylinder(h=(GewindeLaenge-SegmentLaenge)/2+0.2,d=60,center=false);
        }
    }
}

module MutterCodeA(i=0,j=0)
{
    rotate([0,0,i*60]) 
    {
        hull()
        {
            translate([j*5-12+2.5,34,11.5+3]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
            translate([j*5-12-2.5,34,11.5+3]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
        }
        translate([j*5-12,34,11.5-6]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
    }    
}

module MutterCodeB(i=0,j=0)
{
    rotate([0,0,i*60]) 
    {
        hull()
        {
            translate([j*5-12,34,11.5+3]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
            translate([j*5-12,34,11.5-3]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
        }
        translate([j*5-12,34,11.5-6]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
    }    
}

module MutterCodeC(i=0,j=0)
{
    rotate([0,0,i*60]) 
    {
        hull()
        {
            translate([j*5-12+2.5,34,11.5+3]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
            translate([j*5-12-2.5,34,11.5-3]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
        }
        translate([j*5-12,34,11.5-6]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
    }    
}

module MutterCodeD(i=0,j=0)
{
    rotate([0,0,i*60]) 
    {
        hull()
        {
            translate([j*5-12+2.5,34,11.5-3]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
            translate([j*5-12-2.5,34,11.5+3]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
        } 
        translate([j*5-12,34,11.5-6]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
   }    
}

module Mutter1()
{
    difference()
    {  
         cylinder(h=MutterH,d=MutterD,center=false,$fn=6);
        union()
        {  
            translate([0,0,-10]) trapezoidThreadNegativeSpace(length=MutterH*2,threadAngle=90,stepsPerTurn=GewindeSteps,pitch=5,pitchRadius=25);
            translate([0,0,-10]) cylinder(h=MutterH*2,d=48.5,center=false);
            translate([0,0,MutterH-3.9]) cylinder(h=4,r1=24,r2=26.71+1,center=false);
            translate([0,0,-0.1]) cylinder(h=4,r1=26.71+1,r2=24,center=false);
            SchnittMutter(StartWinkel=0,AnzWinkel=64,SchnittLaenge=26.71);
            SchnittMutter(StartWinkel=120,AnzWinkel=124,SchnittLaenge=26.71);
            for(step=[0:60:360]) rotate([-45,0,step]) translate([-25,23,20]) cube([50,5,10],center=false);
            for(step=[0:60:360]) rotate([45,0,step]) translate([-25,37,-16]) cube([50,5,10],center=false);
            for(step=[0:60:360]) rotate([0,0,step]) 
                hull()
                {
                    translate([-18,34,10-6]) rotate([-90,0,0]) cylinder(h=1.3,d1=1,d2=2,center=true);
                    translate([18,34,10-6]) rotate([-90,0,0]) cylinder(h=1.3,d1=1,d2=2,center=true);
                    translate([-18,34,10+6]) rotate([-90,0,0]) cylinder(h=1.3,d1=1,d2=2,center=true);
                    translate([18,34,10+6]) rotate([-90,0,0]) cylinder(h=1.3,d1=1,d2=2,center=true);
                } 
        }
    }
    rotate([0,0,0])
    for (i=[0:5]) 
    {
         for (j=[0:5]) 
        {
            if(Mutter1Code[i][j]=="1") {MutterCodeA(i=i,j=j);}
            else if(Mutter1Code[i][j]=="2") {MutterCodeB(i=i,j=j);}
            else if(Mutter1Code[i][j]=="3") {MutterCodeC(i=i,j=j);}
            else {MutterCodeD(i=i,j=j);}           
         }
    }
}

module Mutter2()
{
    difference()
    {  
        cylinder(h=MutterH,d=MutterD,center=false,$fn=6);
        union()
        {  
            translate([0,0,-10]) trapezoidThreadNegativeSpace(length=MutterH*2,threadAngle=90,stepsPerTurn=GewindeSteps,pitch=5,pitchRadius=25);
            translate([0,0,-10]) cylinder(h=MutterH*2,d=48.5,center=false);
            translate([0,0,MutterH-3.9]) cylinder(h=4,r1=24,r2=26.71+1,center=false);
            translate([0,0,-0.1]) cylinder(h=4,r1=26.71+1,r2=24,center=false);
            SchnittMutter(StartWinkel=0,AnzWinkel=64,SchnittLaenge=26.71);
            SchnittMutter(StartWinkel=120,AnzWinkel=124,SchnittLaenge=26.71);
            for(step=[0:60:360]) rotate([-45,0,step]) translate([-25,23,20]) cube([50,5,10],center=false);
            for(step=[0:60:360]) rotate([45,0,step]) translate([-25,37,-16]) cube([50,5,10],center=false);
            for(step=[0:60:360]) rotate([0,0,step]) 
                hull()
                {
                    translate([-18,34,10-6]) rotate([-90,0,0]) cylinder(h=1.3,d1=1,d2=2,center=true);
                    translate([18,34,10-6]) rotate([-90,0,0]) cylinder(h=1.3,d1=1,d2=2,center=true);
                    translate([-18,34,10+6]) rotate([-90,0,0]) cylinder(h=1.3,d1=1,d2=2,center=true);
                    translate([18,34,10+6]) rotate([-90,0,0]) cylinder(h=1.3,d1=1,d2=2,center=true);
                } 
        }
    }
    rotate([0,0,0])
    for (i=[0:5]) 
    {
        for (j=[0:5]) 
        {
            if(Mutter2Code[i][j]=="1") {MutterCodeA(i=i,j=j);}
            else if(Mutter2Code[i][j]=="2") {MutterCodeB(i=i,j=j);}
            else if(Mutter2Code[i][j]=="3") {MutterCodeC(i=i,j=j);}
            else {MutterCodeD(i=i,j=j);}           
         }
    }
}

module Mutter3()
{
    difference()
    {  
        cylinder(h=MutterH,d=MutterD,center=false,$fn=6);
        union()
        {  
            translate([0,0,-10]) trapezoidThreadNegativeSpace(length=MutterH*2,threadAngle=90,stepsPerTurn=GewindeSteps,pitch=5,pitchRadius=25);
            translate([0,0,-10]) cylinder(h=MutterH*2,d=48.5,center=false);
            translate([0,0,MutterH-3.9]) cylinder(h=4,r1=24,r2=26.71+1,center=false);
            translate([0,0,-0.1]) cylinder(h=4,r1=26.71+1,r2=24,center=false);
            for(step=[0:60:360]) rotate([-45,0,step]) translate([-25,23,20]) cube([50,5,10],center=false);
            for(step=[0:60:360]) rotate([45,0,step]) translate([-25,37,-16]) cube([50,5,10],center=false);
            for(step=[0:60:360]) rotate([0,0,step]) 
                hull()
                {
                    translate([-18,34,10-6]) rotate([-90,0,0]) cylinder(h=1.3,d1=1,d2=2,center=true);
                    translate([18,34,10-6]) rotate([-90,0,0]) cylinder(h=1.3,d1=1,d2=2,center=true);
                    translate([-18,34,10+6]) rotate([-90,0,0]) cylinder(h=1.3,d1=1,d2=2,center=true);
                    translate([18,34,10+6]) rotate([-90,0,0]) cylinder(h=1.3,d1=1,d2=2,center=true);
                } 
        }
    }
    rotate([0,0,0])
    for (i=[0:5]) 
    {
         for (j=[0:5]) 
        {
            if(Mutter3Code[i][j]=="1") {MutterCodeA(i=i,j=j);}
            else if(Mutter3Code[i][j]=="2") {MutterCodeB(i=i,j=j);}
            else if(Mutter3Code[i][j]=="3") {MutterCodeC(i=i,j=j);}
            else {MutterCodeD(i=i,j=j);}           
         }
    }
}

module SchraubeCode2(i=0)
{
    rotate([0,0,i*60]) 
    {
        hull()
        {
            translate([2.0*5-12,13.2,6.5+2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
            translate([2.0*5-12,13.2,6.5-2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
        }
        hull()
        {
            translate([2.7*5-12,13.2,6.5+2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
            translate([2.7*5-12,13.2,6.5-2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
        }
    }    
}

module SchraubeCode3(i=0)
{
    rotate([0,0,i*60]) 
    {
        hull()
        {
            translate([1.7*5-12,13.2,6.5+2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
            translate([1.7*5-12,13.2,6.5-2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
        }
        hull()
        {
            translate([2.5*5-12,13.2,6.5+2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
            translate([2.5*5-12,13.2,6.5-2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
        }
         hull()
        {
            translate([3.2*5-12,13.2,6.5+2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
            translate([3.2*5-12,13.2,6.5-2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
        }
   }    
}

module SchraubeCode4(i=0)
{
    rotate([0,0,i*60]) 
    {
        hull()
        {
            translate([1.5*5-12,13.2,6.5+2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
            translate([2*5-12,13.2,6.5-2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
        }
        hull()
        {
            translate([2.5*5-12,13.2,6.5+2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
            translate([2*5-12,13.2,6.5-2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
        }
         hull()
        {
            translate([3*5-12,13.2,6.5+2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
            translate([3*5-12,13.2,6.5-2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
        }
   }    
}

module SchraubeCode5(i=0)
{
    rotate([0,0,i*60]) 
    {
        hull()
        {
            translate([2*5-12,13.2,6.5+2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
            translate([2.5*5-12,13.2,6.5-2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
        }
        hull()
        {
            translate([3*5-12,13.2,6.5+2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
            translate([2.5*5-12,13.2,6.5-2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
        }
   }    
}

module SchraubeCode6(i=0)
{
    rotate([0,0,i*60]) 
    {
        hull()
        {
            translate([3.2*5-12,13.2,6.5+2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
            translate([2.7*5-12,13.2,6.5-2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
        }
        hull()
        {
            translate([2.2*5-12,13.2,6.5+2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
            translate([2.7*5-12,13.2,6.5-2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
        }

        hull()
        {
            translate([1.7*5-12,13.2,6.5+2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
            translate([1.7*5-12,13.2,6.5-2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
        }

        } 
}

module SchraubeCode9(i=0)
{
    rotate([0,0,i*60]) 
    {
        hull()
        {
            translate([1.7*5-12,13.2,6.5+2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
            translate([2.7*5-12,13.2,6.5-2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
        }
        hull()
        {
            translate([2.7*5-12,13.2,6.5+2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
            translate([1.7*5-12,13.2,6.5-2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
        }
         hull()
        {
            translate([3.2*5-12,13.2,6.5+2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
            translate([3.2*5-12,13.2,6.5-2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
        }
   }    
}

module SchraubeCodeN(i=0)
{
    rotate([0,0,i*60]) 
    {
         hull()
        {
            translate([3*5-12,13.2,6.5+2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
            translate([3*5-12,13.2,6.5-2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
        }
       hull()
        {
            translate([3*5-12,13.2,6.5+2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
            translate([2*5-12,13.2,6.5-2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
        }
        hull()
        {
            translate([2*5-12,13.2,6.5+2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
            translate([2*5-12,13.2,6.5-2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
        }
   }    
}

module SchraubeCodeE(i=0)
{
    rotate([0,0,i*60]) 
    {
         hull()
        {
            translate([2.7*5-12,13.2,6.5+2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
            translate([2.7*5-12,13.2,6.5-2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
        }
       hull()
        {
            translate([2.7*5-12,13.2,6.5+2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
            translate([2.2*5-12,13.2,6.5+2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
        }
        hull()
        {
            translate([2.7*5-12,13.2,6.5-2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
            translate([2.2*5-12,13.2,6.5-2.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
        }
        hull()
        {
            translate([2.7*5-12,13.2,6.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
            translate([2.2*5-12,13.2,6.5]) rotate([-90,0,0]) cylinder(h=1.3,d2=1,d1=2,center=true);
        }
   }    
}

module DummySchraubeE()
{
    SchraubeCodeE(i=5);
    SchraubeCode3(i=0);
    SchraubeCode9(i=1);
    SchraubeCode2(i=2);
    SchraubeCode5(i=3);
    SchraubeCode4(i=4);
    difference()
    {  
        union()
        {  
            cylinder(h=14,d=32,center=false,$fn=6);
            translate([0,2,0]) cylinder(h=14+3+4,d=10,center=false);
            translate([0,-2,0]) cylinder(h=14+3+4,d=10,center=false);
       }
        union()
        {  
            for(step=[0:60:360]) rotate([0,0,step]) 
                hull()
                {
                    translate([-6.5,13.5,6.7-4]) rotate([-90,0,0]) cylinder(h=1.3,d1=1,d2=2,center=true);
                    translate([6.5,13.5,6.7-4]) rotate([-90,0,0]) cylinder(h=1.3,d1=1,d2=2,center=true);
                    translate([-6.5,13.5,6.7+4]) rotate([-90,0,0]) cylinder(h=1.3,d1=1,d2=2,center=true);
                    translate([6.5,13.5,6.7+4]) rotate([-90,0,0]) cylinder(h=1.3,d1=1,d2=2,center=true);
                } 
           for(step=[0:60:360]) rotate([-45,0,step]) translate([0,11.5,7]) cube([20,5,10],center=true);
           for(step=[0:60:360]) rotate([45,0,step]) translate([0,21,0]) cube([20,5,10],center=true);
           translate([110,-110,1]) rotate([0,180,0]) import ("geologo_17.stl", convexity = 5);
       }
    }
}

module DummySchraubeN()
{
    SchraubeCodeN(i=5);
    SchraubeCode5(i=0);
    SchraubeCode3(i=1);
    SchraubeCode2(i=2);
    SchraubeCode4(i=3);
    SchraubeCode9(i=4);
    difference()
    {  
        union()
        {  
            cylinder(h=14,d=32,center=false,$fn=6);
            translate([0,2,0]) cylinder(h=14+3+4,d=10,center=false);
            translate([0,-2,0]) cylinder(h=14+3+4,d=10,center=false);
        }
        union()
        {  
            for(step=[0:60:360]) rotate([0,0,step]) 
                hull()
                {
                    translate([-6.5,13.5,6.7-4]) rotate([-90,0,0]) cylinder(h=1.3,d1=1,d2=2,center=true);
                    translate([6.5,13.5,6.7-4]) rotate([-90,0,0]) cylinder(h=1.3,d1=1,d2=2,center=true);
                    translate([-6.5,13.5,6.7+4]) rotate([-90,0,0]) cylinder(h=1.3,d1=1,d2=2,center=true);
                    translate([6.5,13.5,6.7+4]) rotate([-90,0,0]) cylinder(h=1.3,d1=1,d2=2,center=true);
                } 
           for(step=[0:60:360]) rotate([-45,0,step]) translate([0,11.5,7]) cube([20,5,10],center=true);
           for(step=[0:60:360]) rotate([45,0,step]) translate([0,21,0]) cube([20,5,10],center=true);
           translate([110,-110,1]) rotate([0,180,0])  import ("geologo_17.stl", convexity = 5);
       }
    }
}

module SchraegeScheibe()
{
    difference()
    {  
        translate([0,0,1.2]) cylinder(h=2,d=37,center=false);
        translate([0,0,1.2]) cylinder(h=2,d1=37,d2=33,center=false);
   }
}

module Scheibe()
{
 difference()
    {  
        union()
        {  
            cylinder(h=3,d=35,center=false);
        }
        union()
        {  
             SchraegeScheibe();
            translate([0,0,3])  rotate([0,180,0]) SchraegeScheibe();
             translate([0,2,0]) cylinder(h=10+2+4,d=10.5,center=false);
             translate([0,-2,0]) cylinder(h=10+2+4,d=10.5,center=false);
       }
    }
}

//BolzenGewinde();
//Bolzen1();
//rotate([180,0,0])  translate([0,0,-GewindeLaenge]) Bolzen2();
//Mutter1();
Mutter2();
//Mutter3();
//DummySchraubeE();
//DummySchraubeN();
//Scheibe();




