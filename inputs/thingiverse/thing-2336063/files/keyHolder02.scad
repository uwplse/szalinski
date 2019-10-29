/***********************************************************************
Name ......... : keyHolder.scad
Description....: Parametric Key Holder
Author ....... : Garrett Melenka
Version ...... : V1.0 2017/05/21
Licence ...... : GPL
***********************************************************************/


//Length of Key Holder
Length = 79.375;
//Width of Key Holder
Width = 31.75;

//Thickness of Holder Plates
Thickness = 6.350;

//Measured Thickness of Keys
keyThickness = 1.905;

//Length of Spacer to stop keys
keySpacerLength = 35;
//Width of key spacer
keySpaceWidth = 6.35;


//Measured bolt diameter- undersize so bolt with thread into hole
boltDiameter = 4.318;
//Measured length of bolt
boltLength = Thickness+1;
//Measured diameter of bolt head
boltHeadDiameter= 8.0;
//Measured bolt head thickness
boltHeadThickness = 4.75;
//Offset of bolts from sides of hey holder
boltOffset = 6.35;

//Diameter of thumb hole
thumbHoleDiameter = 50.8;
//Change number of facets for key thumb hole
thumHoleNumSides = 8; //[3:1:100]

//Chamfer Angle
chamferAngle=45;
//Chamfer Width
chamferWidth = 10;


module keyHolderBottom()
{
    
    difference(){
    union(){
    cube([Length, Width, Thickness], center = true);
    
    
    translate([0,Width*0.5-keySpaceWidth*0.5,Thickness*0.5+keyThickness*0.5]){
    cube([keySpacerLength, keySpaceWidth, keyThickness], center = true);
    }
    }
    
    translate([Length*0.5-boltOffset,0,0])
    {
    cylinder(r = boltDiameter*0.5, h = boltLength, center=true, $fn=50);
    }
 
    translate([-Length*0.5+boltOffset,0,0])
    {
    cylinder(r = boltDiameter*0.5, h = boltLength, center=true, $fn=50);
    }

    translate([Length*0.5, Width*0.5,0]){
    rotate([0,0,chamferAngle]){
    cube([chamferWidth, chamferWidth, Thickness+1], center= true);    
    }
    }
    
    translate([-Length*0.5, Width*0.5,0]){
    rotate([0,0,chamferAngle]){
    cube([chamferWidth, chamferWidth, Thickness+1], center= true);    
    }
    }
    
    translate([-Length*0.5, -Width*0.5,0]){
    rotate([0,0,chamferAngle]){
    cube([chamferWidth, chamferWidth, Thickness+1], center= true);    
    }
    }
    
    translate([Length*0.5, -Width*0.5,0]){
    rotate([0,0,chamferAngle]){
    cube([chamferWidth, chamferWidth, Thickness+1], center= true);    
    }
    }
    
    
    
    }
    
}



module keyHolderTop()
{
    
    difference(){
    cube([Length, Width, Thickness], center = true);
    
    translate([Length*0.5-boltOffset,0,0])
    {
    cylinder(r = boltDiameter*0.5, h = boltLength, center=true, $fn=50);
    }
    
    translate([Length*0.5-boltOffset,0,Thickness-boltHeadThickness])
    {
    cylinder(r = boltHeadDiameter*0.5, h = boltHeadThickness, center=true, $fn=50);
    }
    
    
 
    translate([-Length*0.5+boltOffset,0,Thickness-boltHeadThickness])
    {
    cylinder(r = boltHeadDiameter*0.5, h = boltHeadThickness, center=true, $fn=50);
    }
    
    translate([-Length*0.5+boltOffset,0,0])
    {
    cylinder(r = boltDiameter*0.5, h = boltLength, center=true, $fn=50);
    }

    translate([Length*0.5, Width*0.5,0]){
    rotate([0,0,chamferAngle]){
    cube([chamferWidth, chamferWidth, Thickness+1], center= true);    
    }
    }
    
    translate([-Length*0.5, Width*0.5,0]){
    rotate([0,0,chamferAngle]){
    cube([chamferWidth, chamferWidth, Thickness+1], center= true);    
    }
    }
    
    translate([-Length*0.5, -Width*0.5,0]){
    rotate([0,0,chamferAngle]){
    cube([chamferWidth, chamferWidth, Thickness+1], center= true);    
    }
    }
    
    translate([Length*0.5, -Width*0.5,0]){
    rotate([0,0,chamferAngle]){
    cube([chamferWidth, chamferWidth, Thickness+1], center= true);    
    }
    }
    
    
    translate([0,-Width*0.5,0]){
    cylinder(r=thumbHoleDiameter*0.5, h=Thickness+1, center=true, $fn=thumHoleNumSides);
    }
    
    
    }
    
    
    
}



keyHolderBottom();


translate([0, Width*1.75, 0]){
keyHolderTop();
}

