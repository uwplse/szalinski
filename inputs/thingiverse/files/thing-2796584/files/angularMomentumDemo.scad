/***********************************************************************
Name ......... : angularMomentumDemo.scad
Description....: Handles for an Angular Momentum Demo
Author ....... : Garrett Melenka
Version ...... : V1.0 2018/02/15
Licence ...... : GPL
***********************************************************************/

//Width of nut- measure corner to corner distance on nut
nutWidth = 20;
//Nut thickness- measure thickness of nut
nutThickness = 7.0;

//Diameter of Handle
handleDiameter = 38.1;
//Diameter of Handle Guard
handleGuardDiameter = 63.5;
//Handle Guard Facet Number
handleGuardFacetNum = 100;
//Height Handle
handleLength = 95.25;
//Height of Handle Guard;
handleGuardHeight = 20;
//Number of knurls
KnurlNum = 30;
//Depth of knurls
KnurlDepth = 2;
//Width of knurls
KnurlWidth = 1;
//Angle of knurling
KnurlAngle = 100;

holeDiameter = 9.0;


//******************************************************************************** 
//Customizable Handle
//********************************************************************************
module handle()
{
    
    if(handleDiameter> nutWidth)
    {
    difference(){
    union(){
    difference(){
   
        cylinder(r=handleDiameter*0.5, h=handleLength, center = true);
        
    
    
    
    //Knurling
    
    for (i = [1:1:KnurlNum])
        
    rotate([0,0,360*i/KnurlNum]){
    {
        
        linear_extrude(height = handleLength, center = true, twist = KnurlAngle){
            translate([handleDiameter*0.5, 0,0]){
        square(size = [KnurlDepth,KnurlWidth], center = true);
            }
        }
        
        linear_extrude(height = handleLength, center = true, twist = -KnurlAngle){
            translate([handleDiameter*0.5, 0,0]){
        square(size = [KnurlDepth,KnurlWidth], center = true);
            }
        }
    //cube(size = [2,2, handleLength], center = true);
    }
    }
    
    
}
translate([0,0,-handleLength*0.5+handleGuardHeight*0.5]){
        cylinder(r=handleGuardDiameter*0.5, h = handleGuardHeight, center=true, $fn=handleGuardFacetNum);  
    }
}


    
    
    cylinder(r=holeDiameter*0.5, h=handleLength+1, center = true);

    translate([0,0,-(handleLength*0.5)+nutThickness*0.5]){
    cylinder(r= nutWidth*0.5, h = nutThickness, center = true, $fn=4);
    }
    }
    

    
}
    else
    {
        echo("Knob diameter is less than nut width");
    }
}


handle();