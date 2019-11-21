/*
Common Guide Measurements, rrecently learnt about the scope variable, sad face.

All measurements in metric millimetres
*/

//If anyone knows of a guide to standardisation among sizings of linear guides and there carriages let me know so I can make this more accurate and add more options, would like to have the carriage generation as well eventually.

//Default Style (For custom measurements choose custom)
//type = "MGN7"; // [MGN12, MGN7, custom]


//Linear Rail Length
guideLength = 250;

//Guide Height
guideWidth = 7;

//Guide Height
guideHeight = 4.6;

//Ball Guide distance from top of the carriage
ballGuideTopDistance = 1.5;

//(spacing between holes not pitch)
holePitch = 60;

//Inner Hole Radius 
innerHoleDiameter = 1.1;

//Outer Hole Radius
outerHoleDiameter = 2.4;

//Depth of the top outer hole to the inner.
outerHoleDepth = 2;
 

module guideRail(){
    //Draw profile cube of width, length and height, cut cylinder and cube out for rollers then mirror on the x-axis.
        difference(){
            difference (){
                translate([guideWidth/4,0,0])
                cube([guideWidth/2, guideLength, guideHeight], true);
                    translate([guideWidth/2-1,0,guideHeight/2-ballGuideTopDistance])    cube([1,guideLength+1,1], true);
            };
            rotate(a = 90, v = [1,0,0]){
                translate([guideWidth/2,guideHeight/2-ballGuideTopDistance,0]){
                    cylinder(guideLength+2, 1.2, 1.2, $fn=100 ,true);
                }
            }
        };
    //mirror opposite side
    mirror([1,0,0]){
        difference(){
            difference (){
                translate([guideWidth/4,0,0])
                cube([guideWidth/2, guideLength, guideHeight], true);
                    translate([guideWidth/2-1,0,guideHeight/2-ballGuideTopDistance])    cube([1,guideLength+1,1], true);
            };
            rotate(a = 90, v = [1,0,0]){
                translate([guideWidth/2,guideHeight/2-ballGuideTopDistance,0]){
                    cylinder(guideLength+2, 1.2, 1.2, $fn=100 ,true);
                }
            }
        };
    }
}

module guideHoles(){
    

        for(a = [0:floor((guideLength/holePitch)/2)]){
            
            translate([0,(holePitch)*a,0]){
                union(){
                    cylinder(guideHeight+4, innerHoleDiameter,innerHoleDiameter, true);
                    translate([0,0,guideHeight-outerHoleDepth]){
                    cylinder(guideHeight, outerHoleDiameter, outerHoleDiameter, true);}
                }
            }
                        translate([0,-1*(holePitch)*a,0]){
                union(){
                    cylinder(guideHeight+4, innerHoleDiameter,innerHoleDiameter, true);
                    translate([0,0,guideHeight-outerHoleDepth]){
                    cylinder(guideHeight, outerHoleDiameter, outerHoleDiameter, true);}
                }
            }
        }
    }
    





difference(){
    guideRail();
    guideHoles();
}