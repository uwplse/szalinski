/***********************************************************************
Name ......... : parametricHangingStorageBox.scad
Description....: Parametric Hanging Storage Box
Author ....... : Garrett Melenka
Version ...... : V1.0 2016/05/21
Licence ...... : GPL
***********************************************************************/

//Thickness of Bin Dividers
dividerThickness = 2;
//Width of Each Bin
binWidth = 30;
//Height of Each Bin
binHeight = 70;
//Depth of Each Bin
binDepth = 50;
//Height of back mounting plate above bin
backHeight = 20;
//Diameter of Mounting Holes
mountHoleDiameter = 5.5;
//Radius of bin cornder
cornerRadius = dividerThickness;
//Thickness of Mounting Plate
mountingBackThickness = dividerThickness;
//Specify Number of Bins
numberOfBins = 3;

numberOfMountHoles = numberOfBins;



module hangingToolHolderBin()
{
    difference()
    {
    hull(){
    
    cube(size = [binWidth, binDepth, binHeight], center = true);
    
    
    
    translate([-binWidth*0.5,-binDepth*0.5, 0]){
    cylinder(r = cornerRadius, h = binHeight, center = true);
    }
    
    translate([binWidth*0.5,-binDepth*0.5, 0]){
    cylinder(r = cornerRadius, h = binHeight, center = true);
    }
    
    translate([binWidth*0.5,binDepth*0.5, 0]){
    cylinder(r = cornerRadius, h = binHeight, center = true);
    }
    
    translate([-binWidth*0.5,binDepth*0.5, 0]){
    cylinder(r = cornerRadius, h = binHeight, center = true);
    }
    }
    
    
    translate([0,0,dividerThickness]){    
    cube(size = [binWidth - dividerThickness*2, binDepth-dividerThickness*2, binHeight-dividerThickness], center = true);
    }
    }
    
    
}

module hangingToolHolder()
{
    
    if(numberOfBins >=1)
    {
    union()
    {
    for (i = [0:1:numberOfBins-1])
    {
        
        translate([i*binWidth, 0,0])
        {
        hangingToolHolderBin();
        }
        
        
    }
    
    difference(){
    translate([binWidth*numberOfBins*0.5-binWidth*0.5,binDepth*0.5-cornerRadius*0.5,binHeight*0.5+backHeight*0.5])
        {
    
    hull(){    
    cube(size = [binWidth*numberOfBins, mountingBackThickness, backHeight], center = true);
    translate([-binWidth*numberOfBins*0.5,mountingBackThickness*0.5, 0]){    
    cylinder(r = cornerRadius, h = backHeight, center = true);
    }
    translate([binWidth*numberOfBins*0.5,mountingBackThickness*0.5, 0]){    
    cylinder(r = cornerRadius, h = backHeight, center = true);
    }
    }    
    }
    
    for (i = [0:1:numberOfMountHoles-1])
    {
    translate([i*binWidth,binDepth*0.5, backHeight*0.5+binHeight*0.5]){
    rotate([90,0,0])
    {
    cylinder(r=mountHoleDiameter*0.5, h = mountingBackThickness+cornerRadius*2, center = true);
    }
    }
    }
    }
    }
    }
    else
    {
        echo("Zero bins not possible!");
    }
}


$fn = 20;
hangingToolHolder();