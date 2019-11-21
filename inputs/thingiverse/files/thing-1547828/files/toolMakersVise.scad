/***********************************************************************
Name ......... : toolMakersVise.scad
Description....: Parametric Tool Makers vise
Author ....... : Garrett Melenka
Version ...... : V1.0 2016/05/07
Licence ...... : GPL
***********************************************************************/
//Part Selection Dropdown Menu
part = 0; //[0:All, 1:Vise Base, 2: Movable Jaw,3: Movable Jaw Clamp, 4: Bolt Knob]

//Vise Width
viseWidth = 63.5; //[25.4:1", 50.8:2", 63.5:2.5", 76.2:3", 88.9:3.5", 101.6:4"]
//Vise Length
viseLength = 101; //[88.9:3.5", 101:4", 114.3:4.5", 127:5.0", 139.7:5.5", 152.4:6"]
//Height of Vise Base
viseBaseHeight = 20;

//Dimensions of Vise Grooves
//Width of Vise Groove
viseGrooveWidth = 10;
//Depth of Vise Groove
viseGrooveDepth = 10;
//Tolerance to be applied to grooves to ensure good fit
viseGrooveTolerance = 0.1;

//Width of slot along center of vise base
movableJawGuide = 20;

//V groove dimension for fixed and movable jaw
toolGroove = 5;
//Fixed Jaw Groove option
grooveSelectFixedJaw = 0; //[0:No Groove, 1:Groove]
//Movable Jaw Groove option
grooveSelectMovableJaw = 1; //[0:No Groove, 1:Groove]
//Height of Jaws
jawHeight = 40;
//Dimensions of Movable Jaw
//Width of Movable Jaw
movableJawWidth = viseWidth;
//Height of Movable Jaw
movableJawHeight = jawHeight;
//Movable Jaw Thickness
movableJawThickness = 20;

//Dimensions of Fixed Jaw
//Width of Fixed Jaw
fixedJawWidth = viseWidth;
//Fixed Jaw Height
fixedJawHeight = jawHeight;
//Fixed Jaw Thickness
fixedJawThickness = 20;

//movable Jaw Bolts
//Diameter of Bolt to connect Movable Jaw and Movable Jaw Clamp
movableJawBoltDiameter = 3.3;
//Length of Bolt to connect Movable Jaw and Movable Jaw Clamp
movableJawBoltLength = 25;
//Bolt head diameter
movableJawBoltHeadDiameter = 5.5;
//Bolt Head Thickness
movableJawBoltHeadLength = 3.0;
//Captive nuts to connect Movable Jaw to Movable Jaw Clamp
//Width of nut
movableJawNutWidth = 6.0;
//Thickness of nut
movableJawNutThickness = 2.75;
//Use scale factor to oversize central captive nut slot so that it spins freely
movableJawCaptiveNutScaleFactor = 1.2;


//Width of nut- measure corner to corner distance on nut
nutWidth = 14.75;
//Nut thickness- measure thickness of nut
nutThickness = 7.0;

//Dimensions of Nut and Bolt for securing parts in V block
//Diameter of bolt
boltDiameter = 8.25;
//boltLength = 101;
boltLength = viseLength - 2*fixedJawThickness+ movableJawThickness;
echo("Required Minimum Bolt Length:",boltLength);
//boltLength = 101;

//Diameter of Bolt Knob
boltKnobDiameter = 20;
//Height of Bolt Knob;
boltKnobLength = 30;
//Number of knurls around Knob Diameter
boltKnobKnurlNum = 15;
//Depth of knurls
boltKnobKnurlDepth = 1;
//Width of knurls
boltKnobKnurlWidth = 1;
//Angle of knurling
boltKnobKnurlAngle = 100;


module viseBase()
{
    union(){
    difference(){
    //create base of vise
    cube(size = [viseWidth, viseLength, viseBaseHeight], center = true);
    
    //create slots on side of vise    
    translate([viseWidth*0.5-0.5*viseGrooveDepth-0.5*viseGrooveTolerance, 0,0]){
    cube(size = [viseGrooveWidth+viseGrooveTolerance, viseLength, viseGrooveDepth+viseGrooveTolerance], center = true);
    }
    translate([-viseWidth*0.5+0.5*viseGrooveDepth+0.5*viseGrooveTolerance, 0,0]){
    cube(size = [viseGrooveWidth+viseGrooveTolerance, viseLength, viseGrooveDepth+viseGrooveTolerance], center = true);
        
    
    }
    //create center slot in middle of vise
    cube([movableJawGuide+viseGrooveTolerance, viseLength-fixedJawThickness*2, viseBaseHeight], center = true);    
    
    translate([viseGrooveDepth, 0, -viseGrooveWidth]){
    cube([viseGrooveDepth+viseGrooveTolerance, viseLength-fixedJawThickness*2, viseGrooveWidth+viseGrooveTolerance], center = true);
    }
    
    translate([-viseGrooveDepth, 0, -viseGrooveWidth]){
    cube([viseGrooveDepth+viseGrooveTolerance, viseLength-fixedJawThickness*2, viseGrooveWidth+viseGrooveTolerance], center = true);
    }
    }
    
    //Create Vise Fixed Jaw
    translate([0, viseLength*0.5-0.5*fixedJawThickness, viseBaseHeight*0.5+0.5*fixedJawHeight]){
    viseFixedJaw();
    }
    
    //Create lead screw guide wall
    translate([0, -viseLength*0.5+0.5*fixedJawThickness, viseBaseHeight*0.5+0.5*fixedJawHeight])
    {
    viseLeadScrewGuide();
    }
    }

    
    
    
    
}



module viseFixedJaw()
{
    //create vise fixed jaw
    difference()
    {
    cube(size = [fixedJawWidth, fixedJawThickness, fixedJawHeight], center = true);
    // Add grooves for holding round work
    if (grooveSelectFixedJaw == 1)
    {    
    translate([0,-fixedJawThickness*0.5, 0]){
    rotate([45,0,0]){
    cube(size = [fixedJawWidth, toolGroove, toolGroove], center = true);
    }
    
    rotate([0,0,45]){
    cube(size = [toolGroove, toolGroove, fixedJawHeight], center = true);
    }


}
}
}
    
    
    
    
}


module viseLeadScrewGuide()
{
    //create vise lead screw guide wall
    difference(){
    cube(size = [fixedJawWidth, fixedJawThickness, fixedJawHeight], center = true);
    //create hole for lead screw and lead screw nut
     mirror([0,1,0]){   
    translate([0, nutThickness*0.5-0.1,0])
    {    
    rotate([90,0,0]){
    cylinder(r = boltDiameter*0.5, h =  fixedJawThickness, center = true);
    
    translate([0,0,fixedJawThickness*0.5]){
    cylinder(r = nutWidth*0.5, h= nutThickness, center = true, $fn = 6);
    }
    }
    }
}
    }     
}

module viseMovableJaw()
{
    
    difference()
    {
    union(){  
    cube(size = [movableJawWidth, movableJawThickness,movableJawHeight], center = true);
    
    translate([0,0,-0.5*(movableJawHeight)-0.5*(viseBaseHeight-viseGrooveDepth)])
        {
    cube(size = [movableJawGuide, movableJawThickness, viseBaseHeight], center = true);
    }
    }
    
    //Add two holes to connect movable jaw to movable jaw guide
    translate([movableJawGuide*0.25, 0, -0.5*movableJawHeight-(viseBaseHeight)])
    {
    cylinder(r = movableJawBoltDiameter*0.5, h = movableJawBoltLength, center =false); 
    }
    
    translate([-movableJawGuide*0.25, 0, -0.5*movableJawHeight-(viseBaseHeight)])
    {
    cylinder(r = movableJawBoltDiameter*0.5, h = movableJawBoltLength, center =false); 
    }
    //Add two slots for captive nuts
    translate([movableJawGuide*0.25,movableJawThickness*0.25, -movableJawHeight*0.5-0.5*movableJawNutThickness-0.5*viseBaseHeight*0.5]){
    cube(size = [movableJawNutWidth, movableJawThickness, movableJawNutThickness], center = true);
    }
    
    translate([-movableJawGuide*0.25,movableJawThickness*0.25, -movableJawHeight*0.5-0.5*movableJawNutThickness-0.5*viseBaseHeight*0.5]){
    cube(size = [movableJawNutWidth, movableJawThickness, movableJawNutThickness], center = true);
    }
    
    
    //Add grooves to movable jaw to hold round work
    if (grooveSelectMovableJaw == 1)
    {
    translate([0,movableJawThickness*0.5, 0]){
    rotate([45,0,0]){
    cube(size = [fixedJawWidth, toolGroove, toolGroove], center = true);
    }
    
    
    
    rotate([0,0,45]){
    cube(size = [toolGroove, toolGroove, fixedJawHeight], center = true);
    }
    }
    }
    
    //Add hole to allow for a 5/16-18 captive nut in center of movable jaw
    //nut width is oversized to allow for free rotation
    rotate([90,0,0]){
    cylinder(r = boltDiameter*0.5, h =  fixedJawThickness, center = false);
    }
   
   //cylinder(r = boltDiameter*0.5, h = movableJawThickness*0.5, center = true);

    translate([-nutWidth*movableJawCaptiveNutScaleFactor*0.5, -nutThickness*0.5,-0.25*movableJawHeight]){
    cube(size = [nutWidth*movableJawCaptiveNutScaleFactor, nutThickness*1.1, movableJawHeight*0.75], center = false);
    }
 }   
}


module viseMovableJawClamp()
{
    difference(){
    cube([movableJawGuide+viseGrooveDepth, movableJawThickness-viseGrooveTolerance, viseGrooveDepth*0.5-viseGrooveTolerance], center = true);
    
    translate([-movableJawGuide*0.25, 0,-0.5*viseGrooveDepth])
    {
    cylinder(r = movableJawBoltDiameter*0.5, h = movableJawBoltLength, center =false);
    }
    
    translate([movableJawGuide*0.25, 0,-0.5*viseGrooveDepth])
    {
    cylinder(r = movableJawBoltDiameter*0.5, h = movableJawBoltLength, center =false);
    }
    translate([movableJawGuide*0.25, 0,-0.25*viseGrooveDepth])
    {
    cylinder(r= movableJawBoltHeadDiameter*0.5, h=movableJawBoltHeadLength);
    }
    translate([-movableJawGuide*0.25, 0,-0.25*viseGrooveDepth])
    {
    cylinder(r= movableJawBoltHeadDiameter*0.5, h=movableJawBoltHeadLength);
    }
}
    
}

module threadedRod()
{
    
    cylinder(r = boltDiameter*0.5, h = boltLength, center = true);
    
}

//******************************************************************************** 
//Nut which is glued into vise
//********************************************************************************
module nut()
{
    difference(){
    cylinder(r=nutWidth*0.5, h = nutThickness, center = true, $fn=6);
    
    cylinder(r = boltDiameter*0.5, h=nutThickness, center = true);
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
//Display Assembly
color("white")   
viseBase();
//Display nut
translate([0,-viseLength*0.5+fixedJawThickness-nutThickness*0.5,viseBaseHeight*0.5+fixedJawHeight*0.5]){
rotate([90,0,0]){
color("red")    
nut();
}
}
 //Display threaded rod     
translate([0,-boltLength*0.5, viseBaseHeight*0.5 +  fixedJawHeight*0.5]){   
rotate([90,0,0]){
color("green")    
threadedRod();
//Display nut
translate([0,0,boltLength*0.5-nutThickness*0.5]){
color("red")    
nut();    
}
//Display bolt knob
translate([0,0,boltLength*0.5+boltKnobLength*0.5-nutThickness]){
color("blue")
boltKnob();
}
}
}
color("cyan")
translate([0,0,-viseBaseHeight*0.5+viseGrooveDepth*0.25]){
viseMovableJawClamp();
}

//Display movable jaw
translate([0,0,movableJawHeight*0.5+viseBaseHeight*0.5])
    {
    viseMovableJaw();
    }
    

}

if (part == 1)
{
    viseBase();
}

if (part == 2)
{
    rotate([180,0,0]){
    viseMovableJaw();
    }
}

if (part == 3)
{
    rotate([180,0,0]){
    viseMovableJawClamp();
    }
}

if (part == 4)
{
    rotate([180,0,0]){
    boltKnob();
    }
}

