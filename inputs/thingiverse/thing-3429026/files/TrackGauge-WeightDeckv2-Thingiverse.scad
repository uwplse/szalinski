// TrackGauge-WeightDeckv2-Thingiverse.scad
// A gauge for setting railway tracks at a specific gauge with a deck
// to hold weights when setting glues.

// Created by Hamish Trolove - Feb 2019
//www.techmonkeybusiness.com

//Licensed under a Creative Commons license - attribution
// share alike. CC-BY-SA

//No extra libraries are required and it works under 
//      OpenSCAD 2014 and OpenSCAD 2015.


//Track Gauge
TrakGage = 36;

//Rail head width
RailHdWd = 3;

//Full depth of rail
RailHt = 6;

//Allowance for the sleeper attachment details
SlprAttAllow = 1;   
                    
// Top holder bar height
TopBar = 3;

//Holder corner radius
CnrRad = 4;

//Tool size
ToolDepth = 5;

//Tool Length
GageDist = 20;

//Material Spread Allowance
NozAll = 0.2;  // Allowance for spread of material around nozzle during printing


module GageBit()
{
    union()
    {
        translate([0.25*TrakGage-NozAll,0,0.5*(RailHt - SlprAttAllow)]) cylinder(r=0.25*TrakGage, h = RailHt - SlprAttAllow, center = true, $fn = 50);
        translate([-0.25*TrakGage+NozAll,0,0.5*(RailHt - SlprAttAllow)]) cylinder(r=0.25*TrakGage, h = RailHt - SlprAttAllow, center = true, $fn = 50);
        
        translate([0.75*TrakGage+RailHdWd+NozAll,0,0.5*(RailHt - SlprAttAllow)]) cylinder(r=0.25*TrakGage, h = RailHt - SlprAttAllow, center = true, $fn = 50);
        translate([-0.75*TrakGage-RailHdWd-NozAll,0,0.5*(RailHt - SlprAttAllow)]) cylinder(r=0.25*TrakGage, h = RailHt - SlprAttAllow, center = true, $fn = 50);
    }
}

module TopCap()
{
    //Top cap
    translate([0,0,RailHt - SlprAttAllow+0.75*TopBar])cube([(RailHdWd+TrakGage+0.2)*2,TrakGage,TopBar*1.5], center = true);
}

//Trimmer
module Trimmer()
{
    
    translate([0,0,0.5*(RailHt - SlprAttAllow+TopBar)])cube([TrakGage+4*CnrRad,ToolDepth,TopBar+RailHt-SlprAttAllow-0.5*CnrRad], center = true);
    translate([0.5*TrakGage+CnrRad,0,RailHt - SlprAttAllow+TopBar-0.5*CnrRad]) rotate([90,0,0]) cylinder(r = CnrRad, h = ToolDepth, center = true, $fn = 50);
     translate([-0.5*TrakGage-CnrRad,0,RailHt - SlprAttAllow+TopBar-0.5*CnrRad]) rotate([90,0,0]) cylinder(r = CnrRad, h = ToolDepth, center = true, $fn = 50);
    translate([0,0,0.5*(RailHt - SlprAttAllow)+TopBar+0.625*CnrRad])cube([TrakGage+CnrRad*2,ToolDepth,CnrRad], center = true);
}

//Cutouts
module Cutouts()
{
    union()
    {
        translate([0.25*(TrakGage-RailHt),0,0]) rotate([90,0,0])cylinder(r = RailHt, h = GageDist*1.5, center = true, $fn=50);
        translate([-0.25*(TrakGage-RailHt),0,0]) rotate([90,0,0])cylinder(r = RailHt, h = GageDist*1.5, center = true, $fn=50);
        cube([0.5*(TrakGage-RailHt),GageDist*1.5,2*RailHt],center = true);

    }
}

module WeightPlate()
{
    translate([0,0,RailHt - SlprAttAllow+TopBar])cube([TrakGage,GageDist,TopBar], center = true);
}



rotate([180,0,0]) difference()
{
    union()
    {
        translate([0,0.5*GageDist,0]) intersection()
        {
            Trimmer();
            union()
            {
                GageBit();
                TopCap();
            }
        }
       
        translate([0,-0.5*GageDist,0]) intersection()
        {
            Trimmer();
            union()
            {
                GageBit();
                TopCap();
            }
        }
        WeightPlate();
    }
    
    Cutouts();
}
