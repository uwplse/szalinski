/***********************************************************************
Name ......... : toolmakersClamp.scad
Description....: Parametric Tool Makers Clamp
Author ....... : Garrett Melenka
Version ...... : V1.0 2016/12/11
Licence ...... : GPL
***********************************************************************/

//Part Selection Dropdown Menu
part = 0; //[0:All, 1:Clamps, 2: Bolt Knob]


//**********************************************************************
//Dimensions for 3mm Screw
//**********************************************************************
//clampLength = 50;
//clampThickness = 6.35;
//clampWidth = 8;
//nutWidth = 6.1;
//nutThickness = 2.4;
//screwDiameter = 3.0;

//***********************************************************************
//Dimensions for 1/4-20 Threaded Rod
//***********************************************************************
//Total Length of Clamp
clampLength = 114;


//Thickness of Clamp in z direction
clampThickness = 12.7;

//Width of Clamp in y direction
clampWidth = 15.875;


//Angle of the Clamp Nose
clampAngle = 15;

//Tolerance to oversize fixed clamp hole
clampFixedTolerance = 0.1;

//Measure Point to Point distance on nut
nutWidth = 12.5;

//Measure Nut Thickness
nutThickness = 5.5;


//Diameter of screw to be used
screwDiameter = 6.35;


//Set spacing between clamps for printing
clampSpacing = 20;

//********************************************************************
//Dimensions for bolt knob
//********************************************************************
//Diameter of bolt knob
boltKnobDiameter = 15;
//Length of bolt knob
boltKnobLength = 15;
//Number of knurls around Knob Diameter
boltKnobKnurlNum = 15;
//Depth of knurls
boltKnobKnurlDepth = 0.5;
//Width of knurls
boltKnobKnurlWidth = 0.5;
//Angle of knurling
boltKnobKnurlAngle = 100;


module clampMovable()
{
    
    difference()
    {
    cube(size = [clampLength, clampWidth, clampThickness], center = true);
    
     translate([clampLength*(1/8),0,0]){
     
         cylinder(r=screwDiameter*0.5, h = clampThickness+0.2, center = true, $fn=100);
     }
 
     translate([-0.5*clampLength+clampLength*(1/8),0,0]){
     
         cylinder(r=screwDiameter*0.5, h = clampThickness+0.2, center = true, $fn=100);
     }      
    
    
    translate([clampLength*(1/8),-clampWidth*0.5+nutWidth*0.5,0]){
                
        cube(size = [nutWidth, clampWidth, nutThickness], center = true);
    }
    
    
    
    translate([-0.5*clampLength+clampLength*(1/8),-clampWidth*0.5+nutWidth*0.5,0]){
        cube(size = [nutWidth, clampWidth, nutThickness], center = true);
    }
    
    translate([clampLength*0.5, 0, clampThickness*0.5]){
    rotate([0,clampAngle,0]){
    cube(size = [clampLength, clampWidth+0.2, clampThickness], center = true);
    }
    }
    
    
    }
    
}

module clampFixed()
{
    
    difference()
    {
    cube(size = [clampLength, clampWidth, clampThickness], center = true);
    
     translate([clampLength*(1/8),0,0]){
     
         cylinder(r=screwDiameter*0.5+clampFixedTolerance, h = clampThickness+0.2, center = true, $fn=100);
     }
     
     translate([-0.5*clampLength+clampLength*(1/8),0,-clampThickness*0.5]){
     
         cylinder(r=screwDiameter*0.5+clampFixedTolerance, h = clampThickness+0.2, center = true, $fn=100);
     } 
 
      
    translate([clampLength*0.5, 0, clampThickness*0.5]){
    rotate([0,clampAngle,0]){
    cube(size = [clampLength, clampWidth+0.2, clampThickness], center = true);
    }
    }
    
    
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
    cylinder(r=boltKnobDiameter*0.5, h=boltKnobLength, center = true, $fn=100);
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
     }
    }
}
}
    else
    {
        echo("Knob diameter is less than nut width");
    }
}

if (part == 0)
{
clampMovable();

translate([0,clampSpacing, 0]){
clampFixed();
}

translate([0,clampSpacing*2, 0]){
    rotate([0,180,0]){
    boltKnob();
    }
}

translate([0,clampSpacing*3, 0]){
    rotate([0,180,0]){
    boltKnob();
    }
}


}

if (part == 1)
{
clampMovable();

translate([0,clampSpacing, 0]){
clampFixed();
}
}

if (part == 2)
 {
    rotate([0,180,0]){
    boltKnob();
    }
}