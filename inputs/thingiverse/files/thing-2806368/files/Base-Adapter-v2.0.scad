//Base adapter for different G9 Sockets
//by: Brett Mattas
//date: February 24, 2018
//units: mm
//description:
//G9 Sockets I bought for lithophane lamp:
//https://www.thingiverse.com/thing:2656745
//don't fit on this base. Also have wires coming out
//of the bottom. This is an adapter bracket.
//version 2.0:
//Changed to make more customizable

/////////////////////////////////////////////
/////////  PARAMETERS ///////////////////////
/////////////////////////////////////////////


//Overall
Thickness = 3; //Disc, arm and tab thickness
Height = 15; //Height
TabWidth = 8; //Tab side dimension

//Top disc
TopOutD = 30; //Top disc outside diamter
TopInD = 22; //Top disc inside diamter

//Top Tabs
TopHoleD = 3.5; //Hole diameter for light socket screws
TopHoleS = 12.93; //Spacing of top holes

//Vertical arms
VertArmOut = 28; //Out-out dimension of the vertical arms

//Bottom tabs
BotHoleD = 4; //Bottom hole diameter
BotHoleS = 16.43; //Bottom hole spacing

//Global Parameters
Global_Scale = 1;
$fn = 200;
EPS = 0.01; //Small number to avoid coincident faces



/////////////////////////////////////////////
/////////  RENDERS //////////////////////////
/////////////////////////////////////////////

//Driver

scale(Global_Scale){

    Bracket();

}
/////////////////////////////////////////////
/////////  FUNCTIONS ////////////////////////
/////////////////////////////////////////////





/////////////////////////////////////////////
/////////  MODULES //////////////////////////
/////////////////////////////////////////////


//Main Module
module Bracket()
{
    
    //Elements added
    union(){
    
        //Top cylinder
        Disc(TopOutD, TopInD, Thickness);
        
        //Top hole tabs
        rotate([0, 0, 90]){
            TopTab(TopOutD, TopInD, TopHoleS, TabWidth, Thickness, TopHoleD);
            mirror([1, 0, 0])
                TopTab(TopOutD, TopInD, TopHoleS, TabWidth, Thickness, TopHoleD);
        }
        
        //Vertical arms
        TabArm(TopInD, VertArmOut, TabWidth, Thickness, Height);
        mirror([1, 0, 0])
            TabArm(TopInD, VertArmOut, TabWidth, Thickness, Height);
        
        //Bottom tabs
        BotTab(VertArmOut, BotHoleS, TabWidth, Thickness, Height, BotHoleD);
        mirror([1, 0, 0])
            BotTab(VertArmOut, BotHoleS, TabWidth, Thickness, Height, BotHoleD);
        
    }
        
        
}


module Disc(OutD, InD, T){
    //Hollow disc
    difference(){
        cylinder(r=OutD/2, h=T, center=false);
        translate([0, 0, -EPS])
            cylinder(r=InD/2, h=T+2*EPS, center=false);
    }
}


module TabArm(In, Out, W, T, H){
    //Arm for tabs
    //Should be outside of the inside D
    union(){
        translate([Out/2, -W/2, -H+T])
            cube([T, W, H], center=false);
        translate([In/2, -W/2, 0])
            cube([(Out-In)/2, W, T], center=false);
    }
}


module BotTab(Out, HoleS, W, T, H, HoleD){
    //Bottom tab
    if(HoleS > Out){
        //Holes are outside the vertical tab
        difference(){
            translate([Out/2, -W/2, -H+T])
                cube([(HoleS/2 + W/2 - Out/2), W, T], center=false);
            translate([HoleS/2, 0, -H+T-EPS])
                cylinder(r=HoleD/2, h=T+2*EPS, center=false);
        }
    } else {
        //Holes are inside the vertical tab
        difference(){
            translate([HoleS/2-W/2, -W/2, -H+T])
                cube([(Out/2 - HoleS/2 + W/2 + T), W, T], center=false);
            translate([HoleS/2, 0, -H+T-EPS])
                cylinder(r=HoleD/2, h=T+2*EPS, center=false);
        }
    }
    
}

module TopTab(Out, In, HoleS, W, T, HoleD){
    //Top tabs
    if(HoleS > Out){
        //Holes are outside the vertical tab
        difference(){
            translate([In/2, -W/2, 0])
                cube([(HoleS/2 + W/2 - In/2), W, T], center=false);
            translate([HoleS/2, 0, -EPS])
                cylinder(r=HoleD/2, h=T+2*EPS, center=false);
        }
    } else {
        //Holes are inside the vertical tab
        difference(){
            translate([HoleS/2-W/2, -W/2, 0])
                cube([(In/2 - HoleS/2 + W/2), W, T], center=false);
            translate([HoleS/2, 0, -EPS])
                cylinder(r=HoleD/2, h=T+2*EPS, center=false);
        }
    }
}
