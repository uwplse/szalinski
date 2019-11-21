/***********************************************************************
Name ......... : Cannon.scad
Description....: Cannon
Author ....... : Garrett Melenka
Version ...... : V1.0 2016/11/04
Licence ...... : GPL
***********************************************************************/

partSelect = 1; //[1:Cannon Assembly, 2:Cannon Body,  3:Cannon Wheel, 4:Cannon]

//*********************************************************************
//Wheel Dimensions
//*********************************************************************
//Wheel Diameter
wheelDiameter = 76.2;
//Wheel Thickness
wheelThickness = 6.35; 
//Internal Wheel Hub Diameter
wheelHubDiameter = 6.35; 
//Clearance so wheel rotates
wheelHubDiameterClearance = 0.2; 
//Number of Wheel spokes
numberOfSpokes = 15; 
//Offset of wheel spokes from outer and inner hubs
spokeOffset = 3.175; 
//Maximum width of the spoke opening
spokeMaxWidth = 10; 

//Number of fragements for outer wheel circle. Reduce to 12 for a low poly wheel
wheelCylinderFragments = 50; 

//**********************************************************************
//Cannon Dimensions
//**********************************************************************
//Barrel Segment 1 Diameter 1
D1a = 19.05; 
//Barrel Segment 1 Diameter 2
D1b = 15.875; 
//Barrel Segment 1 Length 
L1 = 6.35; 

//Barrel Segment 2 Diameter 1
D2a = D1b; 
//Barrel Segment 2 Diameter 2
D2b = 20.995;
//Barrel Segment 2 Length 
L2 = 50.4; 

//Barrel Segment 3 Diameter 1
D3a = 22; 
//Barrel Segment 3 Diameter 2
D3b = 22; 
//Barrel Segment 3 Length 
L3 = 3; 

//Barrel Segment 4 Diameter 1
D4a = 20.995; 
//Barrel Segment 4 Diameter 2
D4b = 20.995;
//Barrel Segment 4 Length
L4 = 19.05; 
//Barrel Segment 5 Diameter 1
D5a = 22; 
//Barrel Segment 5 Diameter 2
D5b = 22; 
 //Barrel Segment 5 Length
L5 = 3;

//Barrel Segment 6 Diameter 1
D6a = 20.995;
//Barrel Segment 6 Diameter 2
D6b = 20.995; 
//Barrel Segment 6 Length
L6 = 50.4; 
//Barrel Segment 7 Diameter 1
D7a = 15.875;
//Barrel Segment 7 Diameter 2
D7b = 15.875; 
//Barrel Segment 7 Length
L7 = 12.7; 

diameters = [D1a,D1b,D2a,D2b,D3a,D3b, D4a,D4b,D5a,D5b,D6a,D6b, D7a,D7b];

//Diameter of pin to connect Cannon to Cannon Body
cannonMountHoleDiameter = 6.35; 
//Clearance for mounting pin
cannonMountHoleDiameterClearance = 0.5; 
//Diamter of barrel hole
BarrelDiameter = 6.0; 
BarrelHoleLength = L1+L2;
//Number of fragments to make cannon cylinder. Use 6 for a low poly version
cannonCylinderFragments = 100; 

//***********************************************************************
//Cannon Body Dimensions
//***********************************************************************
//Diameter of wheel shoulder
wheelShoulderDiameter = 12.7; 
//Thickness of wheel shoulder
wheelShoulderThickness = 6.35; 
//Overall width of cannon body
CannonBodyWidth = 38.1; 
//Internal width of body
CannonBodyInternalWidth = max(diameters) + 5; 
//Thickness of cannon body sides
CannonBodyOffset = 3.175; 

CannonWheelOffset = 3.175;
//Width of cannon body which contacts the ground
baseWidth = 19.05; 
//Thickness of cannon body that contacts the ground
baseThickness = 12.7; 
//Width of cannon body at the cannon support
cannonSupportWidth = 28.575; 
//Hight of cannon body at the cannon support
cannonSupportHeight = 25.4; 
//Length of the angular portion of cannon body
cannonBodyAngleLength = 63.5; 
 
maxHeight = cannonSupportHeight + wheelDiameter*0.5 - CannonWheelOffset;





module CannonAssembly()
{
    
    rotate([90,0,0])
    {
    
    CannonBody();
    }
    
    
    translate([-(cannonBodyAngleLength+cannonSupportWidth*0.5), CannonBodyWidth*0.5+wheelThickness*0.5 + wheelShoulderThickness, wheelDiameter*0.5+CannonWheelOffset]){
    rotate([90,0,0])
    {
    
    CannonWheel();
    }
    }
    
    translate([-(cannonBodyAngleLength+cannonSupportWidth*0.5), -(CannonBodyWidth*0.5+wheelThickness*0.5 + wheelShoulderThickness), wheelDiameter*0.5+CannonWheelOffset]){
    rotate([90,0,0])
    {
    
    CannonWheel();
    }
    }
    
    
    translate([-(L1+L2+L3+L4*0.5)-(cannonBodyAngleLength+cannonSupportWidth*0.5),0,maxHeight-cannonMountHoleDiameter*0.5*1.5]){
    
    rotate([0,90,0])
    {
    rotate([0,0,90]){    
    Cannon();
    }
    }
    }
}

module CannonBody()
{
    
     
    difference()
    {
    
    linear_extrude(height = CannonBodyWidth, center = true){    
    polygon(points = [[0,0], [baseWidth,0], [baseWidth, baseThickness], [0,baseThickness], [-cannonBodyAngleLength,maxHeight], [-(cannonBodyAngleLength+cannonSupportWidth), maxHeight], [-(cannonBodyAngleLength+cannonSupportWidth), wheelDiameter*0.5-CannonWheelOffset], [-cannonBodyAngleLength, wheelDiameter*0.5-CannonWheelOffset]]);
    }
    
    linear_extrude(height = CannonBodyInternalWidth, center = true){    
    polygon(points = [[0,CannonBodyOffset], [baseWidth,0+CannonBodyOffset], [baseWidth, baseThickness+CannonBodyOffset], [0,baseThickness+CannonBodyOffset], [-cannonBodyAngleLength,maxHeight+CannonBodyOffset], [-(cannonBodyAngleLength+cannonSupportWidth), maxHeight+CannonBodyOffset], [-(cannonBodyAngleLength+cannonSupportWidth), wheelDiameter*0.5-CannonWheelOffset+CannonBodyOffset], [-cannonBodyAngleLength, wheelDiameter*0.5-CannonWheelOffset+CannonBodyOffset]]);
    }
    
    //echo(wheelDiameter*0.5-CannonWheelOffset+CannonBodyOffset);
    
    translate([-(cannonBodyAngleLength+cannonSupportWidth*0.5), maxHeight-cannonMountHoleDiameter*0.5*1.5, 0])
    {
    
    cylinder(r = cannonMountHoleDiameter*0.5 + cannonMountHoleDiameterClearance, h = CannonBodyWidth+5, center = true);
    }
    
    }
    
    //Wheel Hubs
    translate([-(cannonBodyAngleLength+cannonSupportWidth*0.5), wheelDiameter*0.5+CannonWheelOffset, CannonBodyWidth*0.5+CannonBodyOffset*0.5]){
    cylinder(r = wheelShoulderDiameter*0.5, h = wheelShoulderThickness, center = true);
    }
    
    translate([-(cannonBodyAngleLength+cannonSupportWidth*0.5), wheelDiameter*0.5+CannonWheelOffset, CannonBodyWidth*0.5+CannonBodyOffset*0.5+ wheelShoulderThickness]){
    cylinder(r = wheelHubDiameter*0.5, h = wheelThickness, center = true);
    }
    
    translate([-(cannonBodyAngleLength+cannonSupportWidth*0.5), wheelDiameter*0.5+CannonWheelOffset, -(CannonBodyWidth*0.5+CannonBodyOffset*0.5)]){
    cylinder(r = wheelShoulderDiameter*0.5, h = wheelShoulderThickness, center = true);
    }
    
    translate([-(cannonBodyAngleLength+cannonSupportWidth*0.5), wheelDiameter*0.5+CannonWheelOffset, -(CannonBodyWidth*0.5+CannonBodyOffset*0.5+ wheelShoulderThickness)]){
    cylinder(r = wheelHubDiameter*0.5, h = wheelThickness, center = true);
    }
    
}


//Cannon Wheel Module
module CannonWheel()
{
    
    
    difference(){
    cylinder(r = wheelDiameter*0.5, h= wheelThickness, center = true, $fn = wheelCylinderFragments);
    
    
    cylinder(r = wheelHubDiameter*0.5+wheelHubDiameterClearance, h=wheelThickness+2, center = true, $fn = 100);
    
    
        
    for(i=[1:1:numberOfSpokes])
    {
      rotate([0,0, (360/numberOfSpokes)*i])
        {
        linear_extrude(height = wheelThickness+2, center = true){    
            polygon(points = [[0, wheelThickness*0.5+spokeOffset], [spokeMaxWidth*0.5,wheelDiameter*0.5-spokeOffset], [-spokeMaxWidth*0.5,wheelDiameter*0.5-spokeOffset]]);
    }
    }
    
        
    }
    
    
}
}

//Cannon Module
module Cannon()
{
 
    difference()
    {
    union()
    {    
    cylinder(r1=D1a*0.5, r2=D1b*0.5, h=L1, center = false, $fn = cannonCylinderFragments);
    
    
    translate([0,0,L1]){
    cylinder(r1=D2a*0.5, r2 = D2b*0.5, h = L2, center = false, $fn = cannonCylinderFragments);
    }
    
    translate([0,0,L1 + L2]){
    cylinder(r1=D3a*0.5, r2=D3b*0.5, h = L3, center = false, $fn = cannonCylinderFragments);
    }
    
    translate([0,0,L1 + L2 + L3]){
    cylinder(r1=D4a*0.5,r2=D4b*0.5, h = L4, center = false, $fn = cannonCylinderFragments);
    }
    
    translate([0,0,L1 + L2 + L3 + L4]){
    cylinder(r1=D5a*0.5,r2=D5b*0.5, h = L5, center = false, $fn = cannonCylinderFragments);
    }
    
    translate([0,0,L1 + L2 + L3 + L4 + L5]){
    cylinder(r1=D6a*0.5,r2=D6b*0.5, h = L6, center = false, $fn = cannonCylinderFragments);
    }
    
    translate([0,0,L1 + L2 + L3 + L4 + L5 + L6]){
    cylinder(r1=D7a*0.5,r2=D7b*0.5, h = L7, center = false, $fn = cannonCylinderFragments);
    }
    }
    
    
    
    holeLength = max(diameters);
    
    
    
    
    translate([0,0,L1+L2+L3+L4*0.5])
    {
    rotate([0,90,0]){
    cylinder(r = cannonMountHoleDiameter*0.5, h = holeLength, center = true, $fn = 100);
    }
    }
    
    cylinder(r = BarrelDiameter*0.5, h = BarrelHoleLength, center = false, $fn = cannonCylinderFragments);
    
    }
       
}

//***********************************************************************
//Display Cannon Components
//***********************************************************************

if (partSelect == 1)
{
    CannonAssembly();
}

if (partSelect == 2)
{
    rotate([90,0,0])
    {
    
    CannonBody();
    }
}

if (partSelect == 3)
{
    CannonWheel();
}

if (partSelect == 4)
{
    Cannon();
}