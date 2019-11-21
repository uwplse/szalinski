/***********************************************************************
Name ......... : nikonFBodyCap.scad
Description....: Cap for Body of F-mount Nikon Camera
Author ....... : Garrett Melenka
Version ...... : V1.0 2016/06/29
Licence ...... : GPL
***********************************************************************/


//Include arc module
//Module source: http://www.thingiverse.com/thing:1092611
//Author:chickenchuck040
include <arc.scad>;

//Outer Diameter of cap
capOD = 59;
//Thickness of cap
capODThickness = 2;

capODThicknessD = capOD-2*capODThickness;
echo(capODThicknessD);

numKnurl = 100;
knurlHeight = 1;

//Height of main cap
capODHeight = 9;

//Outer diameter of camera body mating cylinder
cameraMountOD = 44;
//Inner diameter of camera body mating cylinder
cameraMountID = 39.9;
//Height of camera body mating cylinder
innerCapHeight = 10;
//Flanges to secure cap to camera body
arcThickness = 3;
//Depth of the arc flanges
arcDepth = 1;

//Create hole to make body cap into a pin hole lens
pinHoleOption= 0; ////[0:No Pin Hole, 1:Pin Hole]
//Pin Hole
pinHoleDiameter = 0.5;





module NikonBodyCap()
{
    //create outer diameter of f-mount cap
    
    difference(){
    cylinder(r=capOD*0.5, h = capODThickness, center = false);
    
    if (pinHoleOption ==1){
    cylinder(r=pinHoleDiameter*0.5, h = capODThickness, center = false);
    }
    }
    
    translate([0,0,capODThickness]){
        
    difference(){
    cylinder(r=capOD*0.5, h = capODHeight-capODThickness, center = false);
        
    
        
    cylinder(r=capODThicknessD*0.5, h = capODHeight-capODThickness, center = false);
    }
    
    for(j = [1:1:numKnurl]){
    
    rotate([0,0,(360 / (numKnurl))*j]){ 
    translate([capOD*0.5, 0, -capODThickness]){
    cylinder(r=knurlHeight, h = capODHeight, center = false);
    }
    }
}
    
    //create inner mating diameter to mate cap to camera body
    difference(){
    cylinder(r=cameraMountOD*0.5, h = innerCapHeight, center = false);
    
    cylinder(r=cameraMountID*0.5, h = innerCapHeight, center = false);
    }
    
    //add f-mount flanges to lock cap to camera body
    for(i = [1:1:3]){
    
    rotate([0,0,(360/3) * i]){
    translate([0,0,innerCapHeight-arcDepth])
        {
    linear_extrude(arcDepth) {        
    arc((cameraMountOD - 2*capODThickness)*0.5, arcThickness, 60);
    }
    }
    }
}
    
    
    }
}
//render the camera cap
NikonBodyCap($fn = 100);