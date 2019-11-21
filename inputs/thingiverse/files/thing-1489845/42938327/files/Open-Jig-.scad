/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *\
|* Parameterized Pocket Hole Jig                                               *|
|* Created By:  Corey Abate (@SpoonlessCorey)                                  *|
|* Last updated: 13APR2016                                                     *|
|*                                                                             *| 
|* This work is licensed under:                                                *|
|* Creative Commons Attribution-ShareAlike 4.0 International License           *|
|*                                                                             *|
|* To view a copy of this license, visit                                       *|
|* http://creativecommons.org/licenses/by-sa/4.0/.                             *|
|*                                                                             *| 
\* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

//Tweakables
//================================================

//Hole angle in degrees
holeAngle     = 22;

//Hole diameter in mm
holeSize      = 10;

//Hole depth in mm
holeDepth     = 30;

//Number of holes
numberOfHoles = 2;

//Center-to-center hole spacing
holeSpacing   = 20;   //mm (center to center)

//thickness around holes as a percent of holeSize
edgeSpacing   = 25;



//Some math and stuff
//================================================
edge         = edgeSpacing/100;
width        = (numberOfHoles - 1)*holeSpacing + holeSize + 2*edge*holeSize;
offsetWidth  = -edge*holeSize - holeSize/2;
guideHeight  = (1+2*edge)*holeSize;
baseHeight   = holeDepth*sin(holeAngle)-guideHeight*cos(holeAngle)/2;
baseLength   = guideHeight*sin(holeAngle) + holeDepth*cos(holeAngle)-((guideHeight/2)*sin(holeAngle)); 
baseOffsetV  = -guideHeight*cos(holeAngle)/2;
gripLength   = guideHeight/sin(holeAngle);
gripHeight   = guideHeight*cos(holeAngle);

//Creating the parts
//================================================
rotate([0,0,180])
difference(){
 

    //Block Geometry
    union(){

        //Guide Geometry
        rotate([90-holeAngle,0,90])
            translate([offsetWidth, offsetWidth, 0])
                cube([width,guideHeight,holeDepth]);
 
        //Base Geometry
        rotate([270,0,0])
            translate([0,0,offsetWidth])       
                linear_extrude(height = width)
                    polygon( points=[[0,-gripHeight/2],
                                    [baseLength,-baseHeight],
                                    [baseLength,-baseOffsetV],
                                    [-gripLength,-baseOffsetV],
                                    [-gripLength,-gripHeight/2]] );

    }

    //Hole Geometry
    for( i = [0: numberOfHoles-1]){

        rotate([90-holeAngle ,0,90])
            translate([i*holeSpacing,0,0])
                cylinder(r=holeSize/2,h=holeDepth+2 ,$fn=16);

        rotate([270-holeAngle ,0,90])
            translate([i*holeSpacing,0,-1])
                cylinder(r=holeSize/2,h=1000 ,$fn=16);
        
        translate([-holeSize/2,i*holeSpacing,holeSize*3/4])
            rotate([90,0,0])
                cylinder(r=holeSize*3/4,h=holeSize*0.9 ,$fn=16, center = true);

    }

   

}

