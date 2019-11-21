/***********************************************************************
Name ......... : guitarHanger.scad
Description....: Wall hanger for guitars
Author ....... : Garrett Melenka
Version ...... : V1.0 2016/10/07
Licence ...... : GPL
***********************************************************************/

//width of guitar hanger
width = 60; 
//depth of guitar hanger
depth = 100;
//length of guitar hanger
length = 100;

//Measured width of guitar neck
neckWidth = 45;

//Thickness of neck holder 
neckHolderThickness = 30;

//Fillet radius
filletRadius = 12.7;

//Diameter of holes for mounting screws
screwDiameter = 6.0;
//Number of mounting screws
numberOfHoles = 3;
//Spacing between mounting screws
holeSpacing = 25;


module GuitarHanger()
{
    difference()
    {
        
    hull(){
    linear_extrude(height = width, center = true){
    polygon(points = [[0,0], [depth,0], [depth,length]]);
        
    
    }
    
    
    translate([depth,length,0]){
    cylinder(h=width+1, r=filletRadius*0.5, center = true);
    }
    }
    
    
    translate([depth*0.5+10,neckHolderThickness,0]){
    rotate([0,90,0]){
    union(){
    cylinder(h=depth+10, r = neckWidth*0.5, center = true);
    translate([0,depth*0.5, 0]){
    cube(size = [neckWidth, depth, depth], center = true);
    }
    }
    }
    }
    
    for (i = [holeSpacing:holeSpacing:holeSpacing*numberOfHoles])
    
    {
    translate([i,0,0]){
    rotate([90,0,0]){
    cylinder(h = 30, r = screwDiameter*0.5, center = true);
    }
    
    }
    }
    }
}

rotate([90,0,0])
{
GuitarHanger();
}