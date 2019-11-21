use <Thread_Library.scad>
 

$fn = 120;
GewindeSteps=120;
rWelle= 4.0;
lWelle= 10;
rDickeWelle= 6.3;
lDickeWelle= 110;
rStopper= 6;
lStopper= 2;
rSpulenStopper=20;
lSchraege= 3;
rMutter=13;
lMutter=65/2;
rFluegelMutter=65/2;
FluegelDicke=3;
GewindeSteps=120;
GewindePitsch=6;
GewindeThreadAngle=90;
GewindePitchRadius=8;
lGewindeAchse=80;

module SpulenStopper()
{
    translate([0,0,0]) 
    {
        difference()
        {
            union()
            {
                color("LightBlue", 1.0) cylinder(h=lSchraege*3,r1=rWelle,r2=rSpulenStopper,center=false);
                translate([0,0,lSchraege*3]) color("LightBlue", 1.0) cylinder(h=2,r1=rSpulenStopper,r2=rSpulenStopper,center=false);
                translate([0,0,lSchraege*3+2]) color("LightBlue", 1.0) cylinder(h=lSchraege*3,r1=rSpulenStopper,r2=rWelle,center=false);
            }
            for(step = [0:30:360])
            {
                rotate([0, 0, step]) 
                {
                    hull()
                    {
                       translate([rSpulenStopper-9,rSpulenStopper-9,-10]) sphere(3.5);
                       translate([rSpulenStopper-9,rSpulenStopper-9,25]) sphere(3.5);
                       translate([rDickeWelle,rDickeWelle,-10]) sphere(1.8);
                       translate([rDickeWelle,rDickeWelle,25]) sphere(1.8);
                    }
                }
            }           
       }
    }
}

module DruckStuetze()
{
    translate([0,0,0])
    {
        for(step = [0:120:360])
        {
            rotate([0,0,step]) 
            {
                translate([rSpulenStopper+rSpulenStopper/2+3,0,65]) color("LightGreen", 1.0) cube([24,2,130],true);
                translate([rMutter*2,0,lStopper+lSchraege+lWelle+lSchraege*3+1]) cube([24,1,2],true);
                translate([rMutter*2,0,lStopper+lSchraege+lWelle+lSchraege+lDickeWelle+lSchraege-lSchraege*6+lSchraege*3-1]) cube([24,1,2],true);
                translate([rMutter*2-0.5,0,50]) rotate([0,45,0]) color("LightGreen", 1.0) cube([24,2,31],true);
                translate([rMutter*2-0.5,0,95]) rotate([0,45,0]) color("LightGreen", 1.0) cube([24,2,31],true);
            }
        }           
    }
}


module Achse(MitGewinde)
{
    translate([0,0,0])
    {
        translate([0,0,0]) color("LightBlue", 1.0) cylinder(lStopper,rStopper,rStopper,false);
        translate([0,0,lStopper]) color("LightBlue", 1.0) cylinder(lSchraege,rStopper,rWelle,false);
        translate([0,0,lStopper+lSchraege]) color("LightBlue", 1.0) cylinder(lWelle,rWelle,rWelle,false);
        translate([0,0,lStopper+lSchraege+lWelle]) color("LightBlue", 1.0) cylinder(lSchraege,rWelle,rDickeWelle,false);
        translate([0,0,lStopper+lSchraege+lWelle+lSchraege]) color("LightBlue", 1.0) cylinder(lDickeWelle,rDickeWelle,rDickeWelle,false);
        translate([0,0,lStopper+lSchraege+lWelle+lSchraege+lDickeWelle]) color("LightBlue", 1.0) cylinder(lSchraege,rDickeWelle,rWelle,false);
        translate([0,0,lStopper+lSchraege+lWelle+lSchraege+lDickeWelle+lSchraege]) color("LightBlue", 1.0) cylinder(lWelle,rWelle,rWelle,false);
        translate([0,0,lStopper+lSchraege+lWelle+lSchraege+lDickeWelle+lSchraege+lWelle]) color("LightBlue", 1.0) cylinder(lSchraege,rWelle,rStopper,false);
        translate([0,0,lStopper+lSchraege+lWelle+lSchraege+lDickeWelle+lSchraege+lWelle+lSchraege]) color("LightBlue", 1.0) cylinder(lStopper,rStopper,rStopper,false);
        if (MitGewinde) 
        {
            translate([0,0,lStopper+lSchraege+lWelle+lSchraege*3]) FluegelMutter(MitGewinde=false);
            translate([0,0,lStopper+lSchraege+lWelle]) color("LightBlue", 1.0) cylinder(h=lSchraege*3,r1=rWelle,r2=rMutter,center=false);
            translate([0,0,lStopper+lSchraege+lWelle+lSchraege+lDickeWelle-lGewindeAchse]) trapezoidThread(length=lGewindeAchse-5,threadAngle=GewindeThreadAngle,stepsPerTurn=GewindeSteps,pitch=GewindePitsch,pitchRadius=GewindePitchRadius);
        } 
        else
        {
            translate([0,0,lStopper+lSchraege+lWelle]) SpulenStopper();
            translate([0,0,lStopper+lSchraege+lWelle+lSchraege+lDickeWelle+lSchraege-lSchraege*6-2]) SpulenStopper();
            DruckStuetze();
        }    
   }
}

module KonterMutter()
{
    translate([40,0,0])
    {
        difference()
        {  
           cylinder(h=lMutter, d=rMutter*2, center=false);
           translate([0,0,-10]) trapezoidThreadNegativeSpace(length=lMutter+20,threadAngle=GewindeThreadAngle,stepsPerTurn=GewindeSteps,pitch=GewindePitsch,pitchRadius=GewindePitchRadius);
        }
    }
}

module FluegelMutter(MitGewinde)
{
    translate([0,0,0])
    {
        difference()
        {
            union()
            {
                difference()
                {
                    cylinder(h=2*FluegelDicke,r1=rFluegelMutter,r2=rFluegelMutter,center=false);
                    cylinder(h=2*FluegelDicke,r1=rFluegelMutter-1*FluegelDicke,r2=rFluegelMutter-1*FluegelDicke,center=false);
                }
                cylinder(h=lMutter, r1=rMutter, r2=rMutter, center=false);
                translate([0,0,lMutter/2]) for(step=[0:360/6:360]) rotate([0,0,step]) cube([FluegelDicke, rFluegelMutter*2, lMutter], center=true);
            }
            translate([0,0,2]) difference()
            {
                cylinder(h=lMutter,r1=rFluegelMutter+10,r2=rFluegelMutter+10,center=false); 
                cylinder(h=lMutter,r1=rFluegelMutter,r2=rMutter-2,center=false);
            }
            if (MitGewinde) translate([0,0,-10]) trapezoidThreadNegativeSpace(length=lMutter+20,threadAngle=GewindeThreadAngle,stepsPerTurn=GewindeSteps,pitch=GewindePitsch,pitchRadius=GewindePitchRadius);
        }
    }
}
       


translate([-100,0,0]) Achse(MitGewinde=false);
Achse(MitGewinde=true);
translate([100,0,0]) FluegelMutter(MitGewinde=true);
//translate([100,100,0]) KonterMutter();

