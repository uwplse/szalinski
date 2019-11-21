/***********************************************************************
Name ......... : usbCase.scad
Description....: Customizable USB Case
Author ....... : Garrett Melenka
Version ...... : V1.0 2016/12/17
Licence ...... : GPL
***********************************************************************/

//Outer Diameter of Usb Case
diameter = 40;
//Height of Usb Case
usbHeight = 50;
//Height of Use Case Cap
capHeight = 25;

//Measure Dimensions of Usb circuit board
//Width of Circuit portion of usb 
usbCircuitWidth = 14;
//Thickness of circuit portion of usb
usbCircuitThickness = 6;
//Length of Circuit Portion of USB
usbCircuitDepth = 38;

//Measure dimensions of USB/ PC connection
//Width of USB that connects to PC
usbWidth = 13.5;
//THickness of USB that connects to PC
usbThickness = 6;
//Depth USB will fit into cap
usbDepth = 10;


//Add magnet to cap 
magnetSize = 5.3;

//Change the shape of the case
facets = 3; //[3:1:100]
//Add a degree of twist to case
twist = 20;
//Convexity
convex = 0;

module usbCaseBottom()
{
    difference(){
        
    linear_extrude(height = usbHeight, center = true, convexity =convex, twist = twist)
        circle(r=diameter*0.5, $fn=facets);
        
    //cylinder(r = diameter*0.5, h = height, center = true, $fn=facets);
    
    translate([0,0,usbHeight*0.5-usbCircuitDepth*0.5]){
    
    cube(size = [usbCircuitThickness, usbCircuitWidth, usbCircuitDepth], center = true);
    }
    }
}

module usbCaseTop()
{
    
    twistPerHeight = twist / usbHeight;
    
    echo(twistPerHeight);
    
    twistCap = twistPerHeight * capHeight;
    
    
    
    
    difference()
    {
    linear_extrude(height = capHeight, center = true, convexity = convex, twist = twist)     circle(r=diameter*0.5, $fn = facets);    
    //cylinder(r = diameter*0.5, h = capHeight, center = true, $fn = facets);
    
        
    rotate([0,0,twist]){    
        
    translate([0,0,-capHeight*0.5 + usbDepth*0.5]){
    cube(size = [usbThickness,usbWidth, usbDepth], center = true);
    }
    
    translate([0,0,capHeight*0.5-magnetSize*0.5-usbDepth]){
    cube(size = [magnetSize, magnetSize, magnetSize], center = true);
    }
    }
    
    
}

    
}

usbCaseBottom();



//translate([0,0,usbHeight*0.5+capHeight*0.5+10])
translate([0, diameter+10, -capHeight*0.5])
{
    
 rotate([180,0,0]){
    
 rotate([0,0,-twist])
    {
 //mirror([1,0,0])
     {    
usbCaseTop();
 }
}
}
}