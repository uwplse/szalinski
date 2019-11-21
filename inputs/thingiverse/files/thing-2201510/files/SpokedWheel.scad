//George Miller
//3-24-17
//this is the latest version of my customizable spoked wheel.

//12-5-17 - revising for better preview display

//here are instructions for makign it customizable for thingiverse
// http://customizer.makerbot.com/docs

//user defined variables

/* [Global] */

/* [Wheel] */
//Outer diameter of the wheel
WheelDiameter = 50; //  [10:100]
//Diameter of the axle hole
AxleDiameter = 4.9; //  [1:.1:50]

/* [Rim] */
//Thickness of the wheel Rim.
RimThickness = 2; //  [1:50]
//Width of the wheel Rim.  Or "How wide is the tire:
RimWidth = 6.2; //  [1:.1:50]
//Percent of rim thickness dedicated to a crown.  This is used to calulate the rimthick and rounding of the wheel surface.  A crown helps to minimize contact surface.
Crown = 0.5;  //  [0:.01:1]      

/* [Hub] */
//diameter of the wheel Hub
HubDiameter = 10; //  [1:50]
//Width of the wheel Hub
HubWidth = 6.2; //  [1:.1:50]

/* [Spokes] */
//Width of the spokes.
SpokeThick = 1.5; //  [1:.1:10]
//number of spokes for the wheel
SpokeCount = 15;  //  [5:25]
//Percentage of the average wheel width.  This is used to calculate wheel web thickness.
WebRatio = .5;  //  [.1:.01:.99]


/* [Hidden] */
$fn=180;


//safety calculation
HubDia = HubDiameter<AxleDiameter ? AxleDiameter:HubDiameter;
WheelDia = WheelDiameter < HubDia ? HubDia : WheelDiameter;
RimThickn = RimThickness>((WheelDia-HubDia)/4)?((WheelDia-HubDia)/4):RimThickness;

//calculated variables
WRad = WheelDia/2;
ARad = AxleDiameter/2;
Hrad = HubDia/2;
innerRimRad = WRad-RimThickn;

//cut out spokes
union(){
    difference(){
        WheelBlank();
        SpokeCutoutThick = HubWidth>RimWidth?HubWidth+.1:RimWidth+.1;
        translate([0,0,-.01])
        SpokeCutoutArray(Hrad+(2/10)*HubWidth+(SpokeThick/2),innerRimRad-(SpokeThick/2)-(1/10)*RimWidth,SpokeCount,SpokeThick,SpokeCutoutThick);
    }
}

//SpokeCutoutArray();
module SpokeCutoutArray(innerRad=10,outerRad=50,Count=12,Spacing=1,Thick=5){
    linear_extrude(height=Thick, convexity = 10){ 
        S=sin(180/Count);
        //took a lot to work out this formula
        smallRad = (Spacing-2*S*innerRad)/(2*(S-1));
        largeRad = ((2*S*outerRad)-Spacing)/(2*(1+S));
        
        RotaryCluster(radius=0,number=Count)
        SpokeCutOut(sRad=smallRad,lRad=largeRad,iRad=innerRad,oRad=outerRad);
    }
}

//SpokeCutOut();
module SpokeCutOut(sRad=2,lRad=4,iRad=4,oRad=30){
    
    hull(){
    translate([iRad+sRad,0,0])
    circle(sRad);
    translate([oRad-lRad,0,0])
    circle(lRad);
    }
}



//WheelBlank();
module WheelBlank(){
    rotate_extrude(convexity = 10)
    WheelBlankProfile();
}
module WheelBlankProfile(){
    union(){
        //Hub
        translate([0,0,0]){
            //square([Hrad-ARad,HubWidth]);
            A = [ARad,0];
            B = [Hrad+(2/10)*HubWidth,0];
            C = [Hrad,HubWidth];
            D = [ARad,HubWidth];
            polygon([A,B,C,D]);
            }
        
        //Rim
        translate([WRad-RimThickn,0,0]){
            //square([(3/4)*RimThickn,RimWidth]);
            A = [-(1/10)*RimWidth,0];
            B = [(1-Crown)*RimThickn,0];
            C = [(1-Crown)*RimThickn,RimWidth];
            D = [0,RimWidth];
            polygon([A,B,C,D]);
            
            translate([(1-Crown)*RimThickn,0,0])
            rotate([0,0,-90])
            intersection(){
                CutCircle(RimWidth*2,(Crown)*RimThickn);
                translate([-RimWidth,0,0])
                square([RimWidth,(Crown)*RimThickn]);
            }
        }
        
        //Web
        A = [Hrad-.01,0];
        B = [WRad-RimThickn+.01,0];
        C = [WRad-RimThickn+.01,WebRatio*RimWidth];
        D = [Hrad-.01,WebRatio*HubWidth];
        polygon([A,B,C,D]);
    }
}


//CutCircle();
module CutCircle(Width=10,Height=2){
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
    for (azimuth =[0:360/number:359])
      rotate([0,0,azimuth])    
        translate([radius,0,0])children();
            