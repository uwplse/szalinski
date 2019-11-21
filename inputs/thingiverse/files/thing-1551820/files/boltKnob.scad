/***********************************************************************
Name ......... : boltKnob.scad
Description....: Parametric Hex Bolt/ Hex Nut knob
Author ....... : Garrett Melenka
Version ...... : V1.0 2016/05/09
Licence ...... : GPL
***********************************************************************/

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


boltKnob();