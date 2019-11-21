/**************************************
Redbull can tank v3
George Miller
04-24-17
**************************************/

/**************************************
The goal is to make a customizable version of ye'ol redbull can endcap.
this endcap is designed to be printed in pairs to turn a redbull can, or other cylinder, into an easy studded tank for a terrain feature.
the part has 3 major features
  a dome
  a belt
  a foot

**************************************/


/* TODO LIST
90% - Add customizer variable declarations
DONE - modify for rotational extrude
DONE - import standard functions from newer files.
50% - add safety checks
*/

/* [Global] */


//The diameter of the cylinder you will be fitting this cap onto
CylinderDia = 54; //[1:.5:100]
//Wall Thickness at the thinnest point of the dome.  The inside of the dome will not be a sphere because we want this to print well without support.
WallThickness = 1.5; //[1:.1:3]

NubDia = 4; //[1:.5:20]
NubHeight = 1; //[0:.1:5]


//This is the amount the belt sticks out from the cylinder.
beltthick = 2; //[0:.1:5]

//This is the width of the belt
beltwidth = 9; //[0:20]

//Height of the rivet head
RivetHeight = 1; //[0:.1:5]
//RivetDiameter
RivetDiameter = 4; //[1:.5:20]
//How many rivets should there be
RivetCount = 13; //[0:1:20]

//1 if you need the foot on the dome
UseFoot = 1; //[0:1]
FHeight = 0;

ScrewHoleCount = 3; //[1:3]
//you can set the screw hole diameter to 0 to turn off the screw holes
ScrewHoleDiameter = 5;


/* [Hidden] */
DomeRad = CylinderDia/2;
beltrad = DomeRad+beltthick;
FootWidth = beltrad;

//safety calculations
tempFH = FHeight<0?0:FHeight;
FootHeight = UseFoot==1?tempFH:-8;
ScrewHoleDia = ScrewHoleDiameter>(beltwidth)?(beltwidth):ScrewHoleDiameter;
WallThick = WallThickness>(DomeRad+1)?(DomeRad+1):WallThickness;
//beltCanOverlap = CanOverlap>(beltwidth-WallThick)?(beltwidth-WallThick):CanOverlap;
beltCanOverlap = (beltwidth-WallThick);
RivetDia= RivetDiameter>((3/4)*beltwidth)?((3/4)*beltwidth):RivetDiameter;


//Calculations
innerRad = DomeRad-WallThick;
ScrewSpacing=(FootWidth-(ScrewHoleDia*ScrewHoleCount))/(ScrewHoleCount+1);
RivetRad = RivetDia/2;


footangle = UseFoot==1?asin(((FootWidth/2)+(2*RivetDia))/(beltrad)):0;

Part();
module Part(){
    union(){
        difference(){
            rotate_extrude(convexity = 15, $fn = 180)
            difference(){
                union(){
                    //OuterDome
                    translate([0,beltCanOverlap,0])
                    intersection(){
                        circle(DomeRad,$fn=90);
                        square([DomeRad+1,DomeRad+1]);
                    }
                    
                    //Belt
                    square([beltrad,beltwidth]);
                    
                    //nub
                    translate([0,DomeRad+beltCanOverlap,0]){
                        intersection(){
                            union(){
                                CutCircle(Width=NubDia,Height=NubHeight);
                                translate([-NubDia/2,-(WallThick/2)+.01,0])
                                square([4,(WallThick/2)]);
                            }
                            translate([0,-(WallThick/2)+.01,0])
                            square([NubDia,(WallThick/2)+1]);
                        }
                    }
                   
                }
                
                //socket for cylinder
                square([DomeRad,beltCanOverlap]);
                
                //inner dome
                translate([0,beltCanOverlap-.01,0])
                intersection(){
                    resize(newsize=[(2*innerRad)-WallThick,2*innerRad,0]){
                        circle(innerRad);
                    }
                    square([innerRad+1,innerRad+1]);
                }
            
                //chamfer on inner lip for printability
                translate([DomeRad,beltCanOverlap,0])
                rotate([0,0,55])
                translate([-(WallThick*2),0,0])
                square([WallThick*2,WallThick*3]);
                
                //hole under nub
                translate([-NubDia/2,DomeRad+beltCanOverlap-WallThick,0])
                LineOfDiamonds(Length=NubDia,DiamondCount=1,Spacing=(WallThick/3),$fn=90);
                
                
            }
            
            translate([-((FootWidth-.002)/2),-(beltrad+RivetHeight)-FootHeight,-.001])
            cube([(FootWidth-.002),FootHeight+10,beltCanOverlap]);
        }
        //rivets
        translate([0,0,beltwidth/2])
        rotate([0,0,-90])
        MyModRotaryCluster(radius=beltrad,number=RivetCount,wedgeangle=footangle)
        rotate([0,90,0])
        Rivet(RivetRad,RivetHeight);
            
    }
        
    Foot();
}

//Foot();
module Foot(){
    translate([0,-DomeRad,0])
    render(convexity = 2)
    intersection(){    
        union(){
            linear_extrude(beltwidth)
            difference(){
                translate([-(FootWidth/2),-(FootHeight+(beltthick)),0])
                square([FootWidth,FootHeight+beltrad+(beltthick+RivetHeight)]);
                translate([0,DomeRad,0])
                circle(DomeRad,$fn=180);
            }
        }
        union(){
            translate([0,beltrad,0])
            rotate([90,0,0])
            linear_extrude(FootHeight+beltrad+(beltthick+RivetHeight))
            translate([-(FootWidth/2),0,0])
            difference()
            {
                square([FootWidth,beltwidth]);
                
                translate([0,(beltwidth/2),0])
                LineOfCircles(Length=FootWidth,CircleCount=ScrewHoleCount,Spacing=ScrewSpacing,$fn=45);
            }
        }
    }
}

module Foot_old(){
    difference(){
        translate([-(FootWidth/2),-(beltrad+RivetHeight)-FootHeight,0])
        cube([FootWidth,FootHeight+10,beltwidth]);
        translate([0,0,-1])
        cylinder(beltwidth+2,DomeRad+.01,DomeRad+.01,$fn=90);
        ScrewHoles();
    }
    
}
//ScrewHoles();
module ScrewHoles(){
    //screwholes
    translate([-(FootWidth/2),-(beltrad-(10/2)),(beltwidth/2)])
    rotate([90,0,0])
    linear_extrude(10)
    LineOfCircles(Length=FootWidth,CircleCount=ScrewHoleCount,Spacing=(FootWidth-(ScrewHoleDia*ScrewHoleCount))/(ScrewHoleCount+1),$fn=45);
}

//Rivet(RivetRad,RivetHeight);
module Rivet(RRad=5,RHeight=2){
    //render(convexity = 2)
    //union()
    {
        ButtonTop(Rad=RRad,Height=RHeight,$fn = 90);
        translate([0,0,-RHeight+.01])
        cylinder(RHeight,RRad,RRad,$fn = 90);
    }
}


//*********************************************
//Reference Functions
//*********************************************

//torus(5,2);
//cylinder(2,5,5);
module torus(rad,tuberad){
    rotate_extrude(convexity = 15, $fn = 100)
    translate([rad, 0, 0])
    circle(tuberad, $fn = 180);
}

module QuarterTorusOuterRad(radius,tuberad){
    QuarterTorus(radius-tuberad,tuberad);
}

//QuarterTorus(5,2);
//cylinder(2,5,5);
module QuarterTorus(rad,tuberad){
    rotate_extrude(convexity = 15, $fn = 100)
    translate([rad, 0, 0])
    intersection(){
        circle(tuberad, $fn = 180);
        square([tuberad,tuberad]);
    }
}

//CutCircleWithPad();
module CutCircleWithPad(Width=10,Height=2,Padding=2,Percent=0.75,$fn=90){
    RealWidth = Width<(2*Padding) ? (Width*Percent):((Width)-(2*Padding));
    Height = Height>(RealWidth/2) ? (RealWidth/2):Height;
    halfWidth = RealWidth/2;
    CircleRad = ((Height*Height)+(halfWidth*halfWidth)) / (2*Height);
    intersection(){
        //Arc
        translate([0,Height-CircleRad,0])
        circle(CircleRad);
        
        //mask
        translate([-halfWidth,0,0])
        square([Width,Height+.01]);
    }
}
//CutCircle();
module CutCircle(Width=10,Height=2,$fn=90){
    Height = Height>(Width/2) ? (Width/2):Height;
    halfWidth = Width/2;
    CircleRad = ((Height*Height)+(halfWidth*halfWidth)) / (2*Height);
    intersection(){
        //Arc
        translate([0,Height-CircleRad,0])
        circle(CircleRad);
        
        //mask
        translate([-halfWidth,0,0])
        square([Width,Height+.01]);
    }
}

module DirtyDiamond(Length=20){
    LineOfDiamonds(Length=Length,DiamondCount=1,Spacing=0,$fn=90);
}

//LineOfDiamonds();
module LineOfDiamonds(Length=20,DiamondCount=4,Spacing=1,$fn=90){
    DCount = (DiamondCount*Spacing)>Length ? (DiamondCount/2):DiamondCount;
    DLength = ((Length/DCount)-Spacing-(Spacing/DCount));
    SsideLen = sqrt((DLength*DLength)/2);
    
    UnitLength = (DLength+Spacing);
    translate([Spacing,0,0])
    for (i =[0:1:DCount-1]){
        translate([i*UnitLength,0,0])
        rotate([0,0,-45])
        square([SsideLen,SsideLen]);
    }
}

//LineOfCircles();
module LineOfCircles(Length=20,CircleCount=4,Spacing=1,$fn=90){
    CCount = (CircleCount*Spacing)>Length ? (CircleCount/2):CircleCount;
    CircleRad = ((Length/CCount)-Spacing-(Spacing/CCount))/2;
    
    UnitLength = (2*CircleRad+Spacing);
    translate([(CircleRad+Spacing),0,0])
    for (i =[0:1:CCount-1]){
        translate([i*UnitLength,0,0])
        circle(CircleRad);
    }
}

//Ring(20,10,2);
module Ring(OuterRad,InnerRad,Thick){
    rotate_extrude(convexity = 15, $fn = 100)
    {
        translate([InnerRad,0,0])
        square([OuterRad-InnerRad,Thick]);
    }
}

//ButtonTop();
module ButtonTop(Rad=20,Height=5,$fn = 180){
    Height = Height>Rad ? Rad:Height;
    rotate_extrude(convexity = 15)
    union(){
        square([Rad-Height+.001,Height]);
        translate([Rad-Height,0,0])
        intersection(){
            circle(Height);
            square([Height,Height]);
        }
    }
}

//RoundTop();
module RoundTop(Rad=20,Height=5,$fn=180){
    Height = Height>Rad ? Rad:Height;
    DomeRad = ((Height*Height)+(Rad*Rad)) / (2*Height);
    rotate_extrude(convexity = 15)
    intersection(){
        square([(DomeRad),Height]);
        
        translate([0,-(DomeRad-Height),0])
        circle(DomeRad);
    }
}

//CutCircle();
module CutCircle(Width=10,Height=2,$fn=90){
    Height = Height>(Width/2) ? (Width/2):Height;
    halfWidth = Width/2;
    CircleRad = ((Height*Height)+(halfWidth*halfWidth)) / (2*Height);
    intersection(){
        //Arc
        translate([0,Height-CircleRad,0])
        circle(CircleRad);
        
        //mask
        translate([-halfWidth,0,0])
        square([Width,Height+.01]);
    }
}

//shamelessly stolen from the Openscad Cheatsheet
//https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/User-Defined_Functions_and_Modules#Children
module RotaryCluster(radius=30,number=8)
    for (azimuth =[0:360/number:(359)])
      rotate([0,0,azimuth])    
        translate([radius,0,0])children();

module MyModRotaryCluster(radius=30,number=8,wedgeangle=30){
    angle = (360-wedgeangle)/number;
    rotate([0,0,(angle/2)+(wedgeangle/2)])
    for (azimuth =[0:1:number-1])
      rotate([0,0,azimuth*angle])    
        translate([radius,0,0])
        children();
}

