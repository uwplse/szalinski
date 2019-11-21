// uses the number of items in array to create holes
frontHoleType=["rrcircle","rrcircle","rrcircle","rrcircle","rrcircle","rrcircle","rrcircle","circle"];
// location from the exact left edge of the motherboard while looking at the side, must ahve same number of array items as type
frontHoleOffset=[71.5,62.25,53,43.75,34.5,26,16.5,4.5];  
// size of the hole in diameter , must have same number of array items as type, squares use size as [x,y], circles just use radius size
frontHoleSize=[2.5,2.5,2.5,2.5,2.5,2.5,2.5,5]; 
// exact center height of the hole, must have same number of array items as type
frontHoleHeight=[3.5,3.5,3.5,3.5,3.5,3.5,3.5,7]; 
frontHoleRecess=[[2,1.5,2,1],[2,1.5,2,1],[2,1.5,2,1],[2,1.5,2,1],[2,1.5,2,1],[2,1.5,2,1],[2,1.5,2,1],[]];
backHoleRecess=[[2,1,2,1],[2,1,2,1],[2,1,2,1],[2,1,2,1],[2,1,2,1]];
//uses the number of items in array to create holes
backHoleType=["square","circle","circle","circle","square"]; 
//location from the exact left edge of the motherboard while looking at the side, must ahve same number of array items as type
backHoleOffset=[16.5,41.5,55,69.5,90.5]; 
// size of the hole in diameter , must have same number of array items as type, squares use size as [x,y], circles just use radius size
backHoleSize=[[10,12],4,6,6,[16,16]];
// exact center height of the hole, must have same number of array items as type
backHoleHeight=[7.5,7.5,7.5,7.5,7.5];
// the roundness of the hole, the higher the value, the less jagged the hole is
circleRadiusPoints=50;  
// how tall the motherboard stand is off of the bottom of the box
standHeight=5; 
// radius of the screw hole in the stand
standScrewHole=1.5;
// radius of the screw post
standPostDiameter = 4;
// how many sides the posts have.
standPostSides = 5; // [4:20]
 // how thick the walls are
wallThickness=3;
// the inside distance between the outside and the motherboard, this is divided in half and the motherboard placed in the middle of the distance 8 = 4 mm on either side of the box. 
interiorOffset=12; 
// how tall the box will be
boxHeight=33; 
// this is how wide the motherboard is inside the box, do not add additional sizes (offsets) to the motherboard sizes, add those above.
motherboardWidth=100; 
// this is how high the motherboard is inside the box, do not add additional sizes (offsets) to the motherboard sizes, add those above.
motherboardDepth=130; 
// distance front the front/back of the motherboard to where the center of the mounting hole is 
standFrontLeftX=9.5;
// distance front the left/right of the motherboard to where the center of the mounting hole is 
standFrontLeftY=7.5; 
// distance front the front/back of the motherboard to where the center of the mounting hole is 
standFrontRightX=9.5;
// distance front the left/right of the motherboard to where the center of the mounting hole is 
standFrontRightY=7.5; 
// distance front the front/back of the motherboard to where the center of the mounting hole is 
standBackLeftX=9.5;
// distance front the left/right of the motherboard to where the center of the mounting hole is 
standBackLeftY=7.5;
// distance front the front/back of the motherboard to where the center of the mounting hole is 
standBackRightX=9.5;
// distance front the left/right of the motherboard to where the center of the mounting hole is 
standBackRightY=7.5;
//Enable or disable the words on the front of the box
enableWords=1; // [0:1]
// Words to embed into the front of the box
wordsToPrint="Jacks MP3 Player"; 
// Words to embed into the front of the box
wordsHeight=18; 
// How thick the motherboard is
boardThickness=1.5; 

textSize=1; // [0.25,0.5,0.75,1,1.25,1.5,1.75,2]

module Rail(length, width, height){
boxHeightHalf=boxHeight/2;
holeOffset=standHeight+boardThickness+wallThickness;
boxDepthHalf=motherboardDepth/2;
boxWidthHalf=motherboardWidth/2;
standFrontLeftPosX=-boxDepthHalf + (interiorOffset/2 ) + standFrontLeftX; //61.25
standFrontLeftPosY=-boxWidthHalf + (interiorOffset/2 )+ standFrontLeftY; //44.5;

standFrontRightPosX=boxDepthHalf - (interiorOffset/2 ) - standFrontRightX; //61.25
standFrontRightPosY=-boxWidthHalf + (interiorOffset/2 ) + standFrontRightY; //44.5;

standBackLeftPosX=-boxDepthHalf + (interiorOffset/2 ) + standBackLeftX; //61.25
standBackLeftPosY=boxWidthHalf - (interiorOffset/2 ) - standBackLeftY; //44.5

standBackRightPosX=boxDepthHalf - (interiorOffset/2 ) - standBackRightX; //61.25
standBackRightPosY=boxWidthHalf - (interiorOffset/2 ) - standBackRightY; //44.5
    union() {
        difference() {
            translate([0, 0,0]) cube([length, width, height], center=true);
        } //botom side
        difference() {
            rotate([0, -90,0]) 
                translate([boxHeightHalf, 0,-(length / 2)  + (wallThickness / 2)]) 
                cube([boxHeight, width, height], center=true); // right side
        }
        difference() {
            rotate([0, -90,0]) 
                translate([boxHeightHalf, 0, (length / 2)  - (wallThickness / 2) ]) 
                cube([boxHeight, width, height], center=true);
        } // left side
        difference() {  //backside
            rotate([90, 0,0]) 
                translate([0, boxHeightHalf, -(width / 2) + (wallThickness / 2)]) 
                cube([length, boxHeight, height], center=true);
            
                for(i=[0:len(backHoleType)-1] ){
                     if (backHoleType[i]=="circle"){
                         echo("This is a back cylinder with offset=", backHoleOffset[i], " and r=", backHoleSize[i]);
                        rotate([90,0,0]) 
                        translate([boxDepthHalf - (interiorOffset/2 ) - backHoleOffset[i] , holeOffset + backHoleHeight[i], -(width / 2) + (wallThickness / 2)])
                        cylinder(h = wallThickness * 2, r = backHoleSize[i], center = true, $fn = circleRadiusPoints); //back circular hole
                     } else if (backHoleType[i]=="square"){
                         echo("This is a back square with offset=", backHoleOffset[i], " x=", backHoleSize[i][0], " y=", backHoleSize[i][1]);
                        rotate([90, 0,0]) 
                        translate([boxDepthHalf - (interiorOffset/2 ) - backHoleOffset[i], holeOffset + backHoleHeight[i], -(width / 2) + (wallThickness / 2)]) 
                        cube([backHoleSize[i][0],backHoleSize[i][1], wallThickness * 2], center=true); //back square hole
                     } else if (backHoleType[i]=="frcircle"){
                        echo("This is a front recessed cylinder with offset=", backHoleOffset[i], " and r=", backHoleSize[i], " and recess depth=", backHoleRecess[i][1], " and recess width=", backHoleRecess[i][0]);
                        rotate([90,0,0]) 
                        translate([boxDepthHalf - (interiorOffset/2 ) - backHoleOffset[i] , holeOffset + backHoleHeight[i], -(width / 2) + ((wallThickness / 2) - backHoleRecess[i][1]) ])
                        cylinder(h = (backHoleRecess[i][1]) + 0.01, r = backHoleSize[i] + (backHoleRecess[i][0] /2), center = true, $fn = circleRadiusPoints); //front recessed hole

                         
                        rotate([90,0,0]) 
                        translate([boxDepthHalf - (interiorOffset/2 ) - backHoleOffset[i] , holeOffset + backHoleHeight[i], -(width / 2) + (wallThickness / 2)])
                        cylinder(h = wallThickness * 2, r = backHoleSize[i], center = true, $fn = circleRadiusPoints); //back circular hole
                     }else if (backHoleType[i]=="rrcircle"){
                        echo("This is a back recessed cylinder with offset=", backHoleOffset[i], " and r=", backHoleSize[i]);
                         
                        rotate([90,0,0]) 
                        translate([boxDepthHalf - (interiorOffset/2 ) - backHoleOffset[i] , holeOffset + backHoleHeight[i], -(width / 2) + ((wallThickness / 2) + backHoleRecess[i][1]) ])
                        cylinder(h = (backHoleRecess[i][1]) + 0.01, r = backHoleSize[i] + (backHoleRecess[i][0] /2), center = true, $fn = circleRadiusPoints); //back recessed hole
                         
                        rotate([90,0,0]) 
                        translate([boxDepthHalf - (interiorOffset/2 ) - backHoleOffset[i] , holeOffset + backHoleHeight[i], -(width / 2) + (wallThickness / 2)])
                        cylinder(h = wallThickness * 2, r = backHoleSize[i], center = true, $fn = circleRadiusPoints); //back circular hole
                     }else if (backHoleType[i]=="brcircle"){
                        echo("This is a both sides recessed cylinder with offset=", backHoleOffset[i], " and r=", backHoleSize[i]);
                         
                        rotate([90,0,0]) 
                        translate([boxDepthHalf - (interiorOffset/2 ) - backHoleOffset[i] , holeOffset + backHoleHeight[i], -(width / 2) + ((wallThickness / 2) - backHoleRecess[i][1]) ])
                        cylinder(h = (backHoleRecess[i][1]) + 0.01, r = backHoleSize[i] + (backHoleRecess[i][0] /2), center = true, $fn = circleRadiusPoints); //front recessed hole
                         
                        rotate([90,0,0]) 
                        translate([boxDepthHalf - (interiorOffset/2 ) - backHoleOffset[i] , holeOffset + backHoleHeight[i], -(width / 2) + (wallThickness / 2)])
                        cylinder(h = wallThickness * 2, r = backHoleSize[i], center = true, $fn = circleRadiusPoints); //back circular hole
                         
                        rotate([90,0,0]) 
                        translate([boxDepthHalf - (interiorOffset/2 ) - backHoleOffset[i] , holeOffset + backHoleHeight[i], -(width / 2) + ((wallThickness / 2) + backHoleRecess[i][1]) ])
                        cylinder(h = (backHoleRecess[i][1]) + 0.01, r = backHoleSize[i] + (backHoleRecess[i][0] /2), center = true, $fn = circleRadiusPoints); //back recessed hole
                     }else if (backHoleType[i]=="frsquare"){
                        echo("This is a front recessed square with offset=", backHoleOffset[i], " x=", backHoleSize[i][0], " y=", backHoleSize[i][1]);
                        
                         rotate([90,0,0]) 
                        translate([boxDepthHalf - (interiorOffset/2 ) - backHoleOffset[i] , holeOffset + backHoleHeight[i], -(width / 2) + ((wallThickness / 2) - backHoleRecess[i][1]) ])
                        cube([backHoleSize[i][0] + (backHoleRecess[i][0] /2),backHoleSize[i][1] + (backHoleRecess[i][0] /2), backHoleRecess[i][1] + 0.01], center=true); //front square recess
                         
                        rotate([90, 0,0]) 
                        translate([boxDepthHalf - (interiorOffset/2 ) - backHoleOffset[i], holeOffset + backHoleHeight[i], -(width / 2) + (wallThickness / 2)]) 
                        cube([backHoleSize[i][0],backHoleSize[i][1], wallThickness * 2], center=true); //back square hole
                     }else if (backHoleType[i]=="rrsquare"){
                        echo("This is a back recessed square with offset=", backHoleOffset[i], " x=", backHoleSize[i][0], " y=", backHoleSize[i][1]);
                        
                        rotate([90,0,0]) 
                        translate([boxDepthHalf - (interiorOffset/2 ) - backHoleOffset[i] , holeOffset + backHoleHeight[i], -(width / 2) + (wallThickness - backHoleRecess[i][1] / 2 ) ])
                        cube([backHoleSize[i][0] + (backHoleRecess[i][0] /2),backHoleSize[i][1] + (backHoleRecess[i][0] /2), backHoleRecess[i][1] + 0.01 ], center=true); //back square recess 
                         
                        rotate([90, 0,0]) 
                        translate([boxDepthHalf - (interiorOffset/2 ) - backHoleOffset[i], holeOffset + backHoleHeight[i], -(width / 2) + (wallThickness / 2)]) 
                        cube([backHoleSize[i][0],backHoleSize[i][1], wallThickness * 2], center=true); //back square hole
                     }else if (backHoleType[i]=="brsquare"){
                        echo("This is a both sides recessed square with offset=", backHoleOffset[i], " x=", backHoleSize[i][0], " y=", backHoleSize[i][1]);
                        
                        rotate([90,0,0]) 
                        translate([boxDepthHalf - (interiorOffset/2 ) - backHoleOffset[i] , holeOffset + backHoleHeight[i], -(width / 2) + ((wallThickness / 2) - backHoleRecess[i][1]) ])
                        cube([backHoleSize[i][0] + (backHoleRecess[i][0] /2),backHoleSize[i][1] + (backHoleRecess[i][0] /2), backHoleRecess[i][1] + 0.01], center=true); //front square recess
                         
                         
                        rotate([90, 0,0]) 
                        translate([boxDepthHalf - (interiorOffset/2 ) - backHoleOffset[i], holeOffset + backHoleHeight[i], -(width / 2) + (wallThickness / 2)]) 
                        cube([backHoleSize[i][0],backHoleSize[i][1], wallThickness * 2], center=true); //back square hole
                         
                        rotate([90,0,0]) 
                        translate([boxDepthHalf - (interiorOffset/2 ) - backHoleOffset[i] , holeOffset + backHoleHeight[i], -(width / 2) + (wallThickness - backHoleRecess[i][1] / 2 ) ])
                        cube([backHoleSize[i][0] + (backHoleRecess[i][0] /2),backHoleSize[i][1] + (backHoleRecess[i][0] /2), backHoleRecess[i][1] + 0.01 ], center=true); //back square recess 
                     }
                     

                }
             }
        
        difference() {

            rotate([90,0,0]) 
                translate([0, boxHeightHalf, ((width / 2) - (wallThickness / 2) ) ]) 
                cube([length, boxHeight, height], center=true); //translate([0, -15,-((width / 2)  - 1.5)])
            
                for(i=[0:len(frontHoleType)-1] ){
                     if (frontHoleType[i]=="circle"){
                         echo("This is a front cylinder with offset=", frontHoleOffset[i], " and r=", frontHoleSize[i]);
                        rotate([90,0,0]) 
                        translate([boxDepthHalf - (interiorOffset/2 ) - frontHoleOffset[i] , holeOffset + frontHoleHeight[i], ((width / 2) - (wallThickness / 2)   ) ])
                        cylinder(h = wallThickness * 2, r = frontHoleSize[i], center = true, $fn = circleRadiusPoints); //front round hole
                     } else if (frontHoleType[i]=="square"){
                         echo("This is a front square with offset=", frontHoleOffset[i], " x=", frontHoleSize[i][0], " y=", frontHoleSize[i][1]);
                        rotate([90, 0,0]) 
                        translate([boxDepthHalf - (interiorOffset/2 ) - frontHoleOffset[i], holeOffset + frontHoleHeight[i], ((width / 2) - (wallThickness / 2))])
                         cube([frontHoleSize[i][0],frontHoleSize[i][1], wallThickness * 2], center=true); //speaker wire hole
                     } else if (frontHoleType[i]=="frcircle"){
                         echo("This is a front recessed cylinder with offset=", frontHoleOffset[i], " and r=", frontHoleSize[i], " and recess depth=", frontHoleRecess[i][1], " and recess width=", frontHoleRecess[i][0]);
                         
                         rotate([90,0,0]) 
                        translate([boxDepthHalf - (interiorOffset/2 ) - frontHoleOffset[i], holeOffset + frontHoleHeight[i] , ((width / 2) - frontHoleRecess[i][1]/2 ) ])
                        cylinder(h = (frontHoleRecess[i][1]) + 0.01, r = frontHoleSize[i] + (frontHoleRecess[i][0]/2), center = true, $fn = circleRadiusPoints); //front recessed hole
                         
                          
                        rotate([90,0,0]) 
                        translate([boxDepthHalf - (interiorOffset/2 ) - frontHoleOffset[i] , holeOffset + frontHoleHeight[i], ((width / 2) - (wallThickness / 2)   ) ])
                        cylinder(h = wallThickness * 2, r = frontHoleSize[i], center = true, $fn = circleRadiusPoints); //front round hole
                     }else if (frontHoleType[i]=="rrcircle"){
                        echo("This is a back recessed cylinder with offset=", frontHoleOffset[i], " and r=", frontHoleSize[i]);
                         
                        rotate([90,0,0]) 
                        translate([boxDepthHalf - (interiorOffset/2 ) - frontHoleOffset[i], holeOffset + frontHoleHeight[i] , ((width / 2) - (wallThickness - frontHoleRecess[i][1]/2 ) ) ])
                        cylinder(h = (frontHoleRecess[i][1]) + 0.01, r = frontHoleSize[i] + (frontHoleRecess[i][0]/2) , center = true, $fn = circleRadiusPoints); //rear recessed hole
                         
                        rotate([90,0,0]) 
                        translate([boxDepthHalf - (interiorOffset/2 ) - frontHoleOffset[i] , holeOffset + frontHoleHeight[i], ((width / 2) - (wallThickness / 2)   ) ])
                        cylinder(h = wallThickness * 2, r = frontHoleSize[i], center = true, $fn = circleRadiusPoints); //front round hole
                     }else if (frontHoleType[i]=="brcircle"){
                        echo("This is a both sides recessed cylinder with offset=", frontHoleOffset[i], " and r=", frontHoleSize[i]);
                        
                         rotate([90,0,0]) 
                        translate([boxDepthHalf - (interiorOffset/2 ) - frontHoleOffset[i], holeOffset + frontHoleHeight[i] , ((width / 2) - 0.5 ) ])
                        cylinder(h = (frontHoleRecess[i][1]) + 0.01, r = frontHoleSize[i] + (frontHoleRecess[i][0]/2), center = true, $fn = circleRadiusPoints); //front recessed hole
                        
                         rotate([90,0,0]) 
                        translate([boxDepthHalf - (interiorOffset/2 ) - frontHoleOffset[i] , holeOffset + frontHoleHeight[i], ((width / 2) - (wallThickness / 2)   ) ])
                        cylinder(h = wallThickness * 2, r = frontHoleSize[i], center = true, $fn = circleRadiusPoints); //front round hole
                        
                        rotate([90,0,0]) 
                        translate([boxDepthHalf - (interiorOffset/2 ) - frontHoleOffset[i], holeOffset + frontHoleHeight[i] , ((width / 2) - (wallThickness - frontHoleRecess[i][1]/2 ) ) ])
                        cylinder(h = (frontHoleRecess[i][1]) + 0.01, r = frontHoleSize[i] + (frontHoleRecess[i][0]/2) , center = true, $fn = circleRadiusPoints); //rear recessed hole
                         
                     }else if (frontHoleType[i]=="frsquare"){
                        echo("This is a front recessed square with offset=", frontHoleOffset[i], " x=", frontHoleSize[i][0], " y=", frontHoleSize[i][1]);
                        
                        rotate([90,0,0]) 
                        translate([boxDepthHalf - (interiorOffset/2 ) - frontHoleOffset[i], holeOffset + frontHoleHeight[i] , ((width / 2) - (frontHoleRecess[i][1]/2)  ) ])
                        cube([frontHoleSize[i][0] + (frontHoleRecess[i][0]/2) ,frontHoleSize[i][1] + (frontHoleRecess[i][0]/2), frontHoleRecess[i][1] + 0.01 ], center=true); //front recessed square
                         
                        rotate([90, 0,0]) 
                        translate([boxDepthHalf - (interiorOffset/2 ) - frontHoleOffset[i], holeOffset + frontHoleHeight[i], ((width / 2) - (wallThickness / 2))])
                         cube([frontHoleSize[i][0],frontHoleSize[i][1], wallThickness * 2], center=true); //speaker wire hole
                     }else if (frontHoleType[i]=="rrsquare"){
                        echo("This is a back recessed square with offset=", frontHoleOffset[i], " x=", frontHoleSize[i][0], " y=", frontHoleSize[i][1]);
                         
                         
                         
                        rotate([90, 0,0]) 
                        translate([boxDepthHalf - (interiorOffset/2 ) - frontHoleOffset[i], holeOffset + frontHoleHeight[i], ((width / 2) - (wallThickness / 2))])
                         cube([frontHoleSize[i][0],frontHoleSize[i][1], wallThickness * 2], center=true); //speaker wire hole
                         
                                                 
                        rotate([90,0,0]) 
                        translate([boxDepthHalf - (interiorOffset/2 ) - frontHoleOffset[i], holeOffset + frontHoleHeight[i] , ((width / 2) - (wallThickness - frontHoleRecess[i][1]/2 ) ) ])
                        cube([frontHoleSize[i][0] + (frontHoleRecess[i][0]/2) ,frontHoleSize[i][1] + (frontHoleRecess[i][0]/2), frontHoleRecess[i][1] + 0.01 ], center=true); // back recessed hole
                          
                     }else if (frontHoleType[i]=="brsquare"){
                        echo("This is a both sides recessed square with offset=", frontHoleOffset[i], " x=", frontHoleSize[i][0], " y=", frontHoleSize[i][1]);
                         
                         rotate([90,0,0]) 
                        translate([boxDepthHalf - (interiorOffset/2 ) - frontHoleOffset[i], holeOffset + frontHoleHeight[i] , ((width / 2) - (frontHoleRecess[i][1]/2)  ) ])
                        cube([frontHoleSize[i][0] + (frontHoleRecess[i][0]/2) ,frontHoleSize[i][1] + (frontHoleRecess[i][0]/2), frontHoleRecess[i][1] + 0.01 ], center=true); //front recessed square
                         
                        rotate([90, 0,0]) 
                        translate([boxDepthHalf - (interiorOffset/2 ) - frontHoleOffset[i], holeOffset + frontHoleHeight[i], ((width / 2) - (wallThickness / 2))])
                         cube([frontHoleSize[i][0],frontHoleSize[i][1], wallThickness * 2], center=true); //speaker wire hole
                         
                         rotate([90,0,0]) 
                        translate([boxDepthHalf - (interiorOffset/2 ) - frontHoleOffset[i], holeOffset + frontHoleHeight[i] , ((width / 2) - (wallThickness - frontHoleRecess[i][1]/2 ) ) ])
                        cube([frontHoleSize[i][0] + (frontHoleRecess[i][0]/2) ,frontHoleSize[i][1] + (frontHoleRecess[i][0]/2), frontHoleRecess[i][1] + 0.01 ], center=true); // back recessed hole
                     }

                }
                if (enableWords==1){
                    rotate([90,0,0]) 
                        translate([-boxWidthHalf - (interiorOffset/2 ), wordsHeight, ((width / 2) - (textSize /2 )) ]) 
                        scale([textSize,textSize,textSize]) 
                        drawtext(wordsToPrint);
                }
        }
        
        
        difference() {
            translate([standFrontLeftPosX, standFrontLeftPosY, wallThickness  ]) cylinder(h = standHeight + wallThickness, r = standPostDiameter, center = true, $fn = standPostSides);
            
            translate([standFrontLeftPosX, standFrontLeftPosY, wallThickness  ]) cylinder(h = standHeight + wallThickness + 0.01, r = standScrewHole, center = true, $fn = 30);
            
        }
        
        difference() {
            translate([standFrontRightPosX, standFrontRightPosY,wallThickness  ]) cylinder(h = standHeight + wallThickness, r = standPostDiameter, center = true, $fn = standPostSides);
            
            translate([standFrontRightPosX, standFrontRightPosY,wallThickness ]) cylinder(h = standHeight + wallThickness + 0.01, r = standScrewHole, center = true, $fn = 30);
            
        }
        difference() {
            translate([standBackLeftPosX, standBackLeftPosY,wallThickness  ]) cylinder(h = standHeight + wallThickness, r = standPostDiameter, center = true, $fn = standPostSides);
            
            translate([standBackLeftPosX, standBackLeftPosY,wallThickness ]) cylinder(h = standHeight + wallThickness + 0.01, r = standScrewHole, center = true, $fn = 30);
            
        }
        
        difference() {
            translate([standBackRightPosX, standBackRightPosY,wallThickness  ]) cylinder(h = standHeight + wallThickness, r = standPostDiameter, center = true, $fn = standPostSides);
            
            translate([standBackRightPosX, standBackRightPosY,wallThickness  ]) cylinder(h = standHeight + wallThickness + 0.01, r = standScrewHole, center = true, $fn = 30);
            
        }
    }
    

};

module drawtext(text) {
	//Characters
	chars = " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}";

	//Chracter table defining 5x7 characters
	//Adapted from: http://www.geocities.com/dinceraydin/djlcdsim/chartable.js
	char_table = [ [ 0, 0, 0, 0, 0, 0, 0],
                  [ 4, 0, 4, 4, 4, 4, 4],
                  [ 0, 0, 0, 0,10,10,10],
                  [10,10,31,10,31,10,10],
                  [ 4,30, 5,14,20,15, 4],
                  [ 3,19, 8, 4, 2,25,24],
                  [13,18,21, 8,20,18,12],
                  [ 0, 0, 0, 0, 8, 4,12],
                  [ 2, 4, 8, 8, 8, 4, 2],
                  [ 8, 4, 2, 2, 2, 4, 8],
                  [ 0, 4,21,14,21, 4, 0],
                  [ 0, 4, 4,31, 4, 4, 0],
                  [ 8, 4,12, 0, 0, 0, 0],
                  [ 0, 0, 0,31, 0, 0, 0],
                  [12,12, 0, 0, 0, 0, 0],
                  [ 0,16, 8, 4, 2, 1, 0],
                  [14,17,25,21,19,17,14],
                  [14, 4, 4, 4, 4,12, 4],
                  [31, 8, 4, 2, 1,17,14],
                  [14,17, 1, 2, 4, 2,31],
                  [ 2, 2,31,18,10, 6, 2],
                  [14,17, 1, 1,30,16,31],
                  [14,17,17,30,16, 8, 6],
                  [ 8, 8, 8, 4, 2, 1,31],
                  [14,17,17,14,17,17,14],
                  [12, 2, 1,15,17,17,14],
                  [ 0,12,12, 0,12,12, 0],
                  [ 8, 4,12, 0,12,12, 0],
                  [ 2, 4, 8,16, 8, 4, 2],
                  [ 0, 0,31, 0,31, 0, 0],
                  [16, 8, 4, 2, 4, 8,16],
                  [ 4, 0, 4, 2, 1,17,14],
                  [14,21,21,13, 1,17,14],
                  [17,17,31,17,17,17,14],
                  [30,17,17,30,17,17,30],
                  [14,17,16,16,16,17,14],
                  [30,17,17,17,17,17,30],
                  [31,16,16,30,16,16,31],
                  [16,16,16,30,16,16,31],
                  [15,17,17,23,16,17,14],
                  [17,17,17,31,17,17,17],
                  [14, 4, 4, 4, 4, 4,14],
                  [12,18, 2, 2, 2, 2, 7],
                  [17,18,20,24,20,18,17],
                  [31,16,16,16,16,16,16],
                  [17,17,17,21,21,27,17],
                  [17,17,19,21,25,17,17],
                  [14,17,17,17,17,17,14],
                  [16,16,16,30,17,17,30],
                  [13,18,21,17,17,17,14],
                  [17,18,20,30,17,17,30],
                  [30, 1, 1,14,16,16,15],
                  [ 4, 4, 4, 4, 4, 4,31],
                  [14,17,17,17,17,17,17],
                  [ 4,10,17,17,17,17,17],
                  [10,21,21,21,17,17,17],
                  [17,17,10, 4,10,17,17],
                  [ 4, 4, 4,10,17,17,17],
                  [31,16, 8, 4, 2, 1,31],
                  [14, 8, 8, 8, 8, 8,14],
                  [ 0, 1, 2, 4, 8,16, 0],
                  [14, 2, 2, 2, 2, 2,14],
                  [ 0, 0, 0, 0,17,10, 4],
                  [31, 0, 0, 0, 0, 0, 0],
                  [ 0, 0, 0, 0, 2, 4, 8],
                  [15,17,15, 1,14, 0, 0],
                  [30,17,17,25,22,16,16],
                  [14,17,16,16,14, 0, 0],
                  [15,17,17,19,13, 1, 1],
                  [14,16,31,17,14, 0, 0],
                  [ 8, 8, 8,28, 8, 9, 6],
                  [14, 1,15,17,15, 0, 0],
                  [17,17,17,25,22,16,16],
                  [14, 4, 4, 4,12, 0, 4],
                  [12,18, 2, 2, 2, 6, 2],
                  [18,20,24,20,18,16,16],
                  [14, 4, 4, 4, 4, 4,12],
                  [17,17,21,21,26, 0, 0],
                  [17,17,17,25,22, 0, 0],
                  [14,17,17,17,14, 0, 0],
                  [16,16,30,17,30, 0, 0],
                  [ 1, 1,15,19,13, 0, 0],
                  [16,16,16,25,22, 0, 0],
                  [30, 1,14,16,15, 0, 0],
                  [ 6, 9, 8, 8,28, 8, 8],
                  [13,19,17,17,17, 0, 0],
                  [ 4,10,17,17,17, 0, 0],
                  [10,21,21,17,17, 0, 0],
                  [17,10, 4,10,17, 0, 0],
                  [14, 1,15,17,17, 0, 0],
                  [31, 8, 4, 2,31, 0, 0],
                  [ 2, 4, 4, 8, 4, 4, 2],
                  [ 4, 4, 4, 4, 4, 4, 4],
                  [ 8, 4, 4, 2, 4, 4, 8] ];

	//Binary decode table
	dec_table = [ "00000", "00001", "00010", "00011", "00100", "00101",
  	            "00110", "00111", "01000", "01001", "01010", "01011",
  	            "01100", "01101", "01110", "01111", "10000", "10001",
  	            "10010", "10011", "10100", "10101", "10110", "10111",
	            "11000", "11001", "11010", "11011", "11100", "11101",
	            "11110", "11111" ];

	//Process string one character at a time
	for(itext = [0:len(text)-1]) {
		//Convert character to index
		assign(ichar = search(text[itext],chars,1)[0]) {
			//Decode character - rows
			for(irow = [0:6]) {
				assign(val = dec_table[char_table[ichar][irow]]) {
					//Decode character - cols
					for(icol = [0:4]) {
						assign(bit = search(val[icol],"01",1)[0]) {
							if(bit) {
								//Output cube
								translate([icol + (6*itext), irow, 0])
									cube([1.0001,1.0001,1]);
							}
						}
					}
				}
			}
		}
	}
}


Rail(motherboardDepth + interiorOffset  + (wallThickness* 2), motherboardWidth + interiorOffset + (wallThickness* 2), wallThickness);

