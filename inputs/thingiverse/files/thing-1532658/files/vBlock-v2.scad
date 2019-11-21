/***********************************************************************
Name ......... : vBlock.scad
Description....: Parametric V Block and Clamp for Cylindrical Work
Author ....... : Garrett Melenka
Version ...... : V1.0 2016/04/29
Licence ...... : GPL
***********************************************************************/
//Part Display Options [0:All, 1:V Block, 2: Clamp, 3: Bolt Knob]
part = 0; 

//Clamp Option [0: For Clamping Round Materials, 45: For Clamping Rectangular Materials]
clampAngle = 0;



//V Block Dimensions
//Total V Block Length
Length = 75;
//V Block Height
Height = 50;
//V Block Width
Width = 50;
//Width of v Groove
vGrooveWidth = 40;
//v Groove notch depth
vNotchDepth = 2;
//v Groove notch width
vNotchWidth = 2;

//Notches in side of v block to allow for the attachment of v block clamp
sideDepth = 10;
sideWidth = 10;
//Tolerance of side notches to ensure good fit between clamp and v block
clampSideTolerance = 0.1;



//V Block Clamp Dimensions
//Thickness of Clamp
clampThickness = 10;
//Width of Clamp
clampWidth = 18.75;
//Height of Clamp above v block
clampHeight = 35;

//Dimensions of nut/ bolt support on top of v block clamp
//Thickness of Nut support
clampNutSupportThickness = 15;
//Width of nut Support
clampNutSupportWidth = 20;

//Dimensions of Nut and Bolt for securing parts in V block
//Diameter of bolt
boltDiameter = 8.25;
boltLength = 50;

//Width of nut- measure corner to corner distance on nut
nutWidth = 14.75;
//Nut thickness- measure thickness of nut
nutThickness = 7.0;

//Diameter of Bolt Knob
boltKnobDiameter = 20;
//Height of Bolt Knob;
boltKnobLength = 20;
//Number of knurls around Knob Diameter
boltKnobKnurlNum = 15;
//Depth of knurls
boltKnobKnurlDepth = 1;
//Width of knurls
boltKnobKnurlWidth = 1;
//Angle of knurling
boltKnobKnurlAngle = 100;

//******************************************************************************** 
//V Block
//********************************************************************************
module vBlock()
{
    
    vSide = vGrooveWidth*cos(45);
    difference(){
    difference(){
        
        //main body of v block
    cube(size = [Width, Length, Height], center = true);
    
    
        //Main Body V
        translate([0,0,Height*0.5]){
            rotate([0, 45, 0]){
                //echo(vSide);
            cube(size = [vSide, Length, vSide], center = true);
            }
        }
        
        translate([0,0,-Height*0.5]){
            rotate([0, 45, 0]){
                //echo(vSide);
            cube(size = [vSide, Length, vSide], center = true);
            }
        }
    }
    //V Notches
    translate([0,0, Height*0.5 - vSide*cos(45)]){
    cube(size = [vNotchWidth, Length, vNotchDepth], center = true);
    }
    
    translate([0,0, -(Height*0.5 - vSide*cos(45))]){
    cube(size = [vNotchWidth, Length, vNotchDepth], center = true);
    }
    
    //Side Grooves to allow for clamp
    translate([Width*0.5, 0, 0]){
    cube(size = [sideDepth, Length, sideWidth], center = true);
    }
    
    translate([-Width*0.5, 0, 0]){
    cube(size = [sideDepth, Length, sideWidth], center = true);
    }
    }

}

//******************************************************************************** 
//V Block Clamp
//********************************************************************************
module vClamp(){
        
    union(){
    difference(){
    difference()
    {
    union(){
    rotate([90,0,0]){
        difference(){
        cylinder(r = (Width+clampThickness)*0.5, h = clampWidth, center = true);
        
       cylinder(r = Width*0.5, h = Length, center = true);
       translate([0, -Width*0.5, 0]){  
        cube(size = [Width*3*0.5, Width*2*0.5, clampWidth], center = true);
       }
        }
    }    
    
    rotate([0,clampAngle,0]){
    translate([0,0, (Width+clampThickness)*0.5]){
    cube(size = [clampNutSupportWidth, clampWidth, clampNutSupportThickness], center = true);
    }
    }
    }
    rotate([0,clampAngle,0]){
    //Bolt Hole
    translate([0,0,(Width + clampThickness)*0.5])
    //translate([0,0,0])
    {
    cylinder(r = boltDiameter*0.5, h =  clampNutSupportThickness*2, center = true);
    }
    //Nut
    translate([0,0, (Width+clampThickness)*0.5+clampNutSupportThickness*0.5-nutThickness*0.5]){
    cylinder(r = nutWidth*0.5, h= nutThickness, center = true, $fn = 6);
    }
    }
    }
    }
    
    
    //Left Side Wall
    translate([-0.5*(Width+0.5*(Width+clampThickness-Width)), 0, -clampHeight*0.5]){
    cube(size = [0.5*(Width+clampThickness-Width), clampWidth, clampHeight], center = true);
    }
    
    //Right Side Wall
    translate([0.5*(Width+0.5*(Width+clampThickness-Width)), 0, -clampHeight*0.5]){
    cube(size = [0.5*(Width+clampThickness-Width), clampWidth, clampHeight], center = true);
    }
    
    //Right V Block Guide
    translate([Width*0.5-sideWidth*0.25, 0, -clampHeight+sideWidth*0.5]){
    cube(size = [sideDepth*0.5, clampWidth, sideWidth-clampSideTolerance], center = true);
    }
    //Left V Block Guide
    translate([-Width*0.5+sideWidth*0.25, 0, -clampHeight+sideWidth*0.5]){
    cube(size = [sideDepth*0.5, clampWidth, sideWidth-clampSideTolerance], center = true);
    }
    }
}

//******************************************************************************** 
//Nut which is glued into the V Block Clamp
//********************************************************************************
module nut()
{
    difference(){
    cylinder(r=nutWidth*0.5, h = nutThickness, center = true, $fn=6);
    
    cylinder(r = boltDiameter*0.5, h=nutThickness, center = true);
    }
    
}
//******************************************************************************** 
//Bolt Used to secure round Stock
//********************************************************************************
module bolt()
{
    
    cylinder(r=boltDiameter*0.5, h = boltLength, center = true);
    
    translate([0,0,boltLength*0.5]){
    cylinder(r=nutWidth*0.5, h = nutThickness, center = true, $fn=6);
    }
    
}
//******************************************************************************** 
//Knob that allows for the bolt to be adjusted
//********************************************************************************
module boltKnob()
{
    
    if(boltKnobDiameter> nutWidth)
    {
    
    difference(){
    cylinder(r=boltKnobDiameter*0.5, h=boltKnobLength, center = true);
    translate([0,0,-(boltKnobLength*0.5)+nutThickness*0.5]){
    cylinder(r= nutWidth*0.5, h = nutThickness, center = true, $fn=6);
    }
    
    //translate([boltKnobDiameter*0.5, 0,0])
    
    for (i = [1:1:boltKnobKnurlNum])
        
    rotate([0,0,360*i/boltKnobKnurlNum]){
    {
        
        linear_extrude(height = boltKnobLength, center = true, twist = boltKnobKnurlAngle){
            translate([boltKnobDiameter*0.5, 0,0]){
        square(size = [boltKnobKnurlDepth,boltKnobKnurlWidth], center = true);
            }
        }
        
        linear_extrude(height = boltKnobLength, center = true, twist = -boltKnobKnurlAngle){
            translate([boltKnobDiameter*0.5, 0,0]){
        square(size = [boltKnobKnurlDepth,boltKnobKnurlWidth], center = true);
            }
        }
    //cube(size = [2,2, boltKnobLength], center = true);
    }
    }
}
}
    else
    {
        echo("Knob diameter is less than nut width");
    }
}


//******************************************************************************** 
//Rendering and Display of Parts
//********************************************************************************
$fn = 60;
if (part == 0)
{
//Display V Block
vBlock();
    
//Display Clamp
translate([0,0,clampHeight-sideWidth*0.5])
{
color("blue")
vClamp();
    

}


if (clampAngle == 0)
{  
  
   //Display Nut
translate([0,0,clampHeight+clampNutSupportThickness+clampThickness+ nutThickness*0.5]){
color("green")
nut();
}     
//Display Bolt
translate([0,0,clampHeight+clampNutSupportThickness+boltLength*0.5]){
color("RosyBrown")
bolt();
}

//Display Bolt Knob
color("Teal")
translate([0,0, clampHeight+clampNutSupportThickness+boltLength]){
boltKnob();
}



//Display Example cylinder clamped using V Block
translate([0,0,Height*0.5+0.5*5]){
rotate([90,0,0])
{
color("red")
    cylinder(r=vGrooveWidth*0.5, h = Length, center = true);
}
}
}
//Display cube stock and clamp with 45 degree angle for nut and bolt
if (clampAngle == 45)
{
    
    
    vSide = vGrooveWidth*cos(45);
    translate([0,0, Width*0.5])
    {
    rotate([0,45,0]){
    color("red")
    cube(size = [vSide, Length, vSide], center = true);
    }
    }
    
}

}
//V-block Rendering Oriented for Printing
else if (part == 1)
{
    translate([0,0,Length*0.5]){
    rotate([90,0,0]){
    vBlock();
    }
    }
}
//Clamp Rending- Oriented for Printing
else if (part == 2)
{   
    rotate([90,0,0]){
    vClamp($fn = 50);
    }
}

//Bolt Knob Rending- Oriented for Printing
else if (part == 3)
{   
    
    boltKnob();
    
}