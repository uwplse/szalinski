/*
* Parametric Divider Box
*
*   Author: Bryan Smith - bryan.smith.dev@gmail.com
*   Created Date: 8/24/16
*   Updated Date: 9/10/16
*   Version: 1.3
*
*
*  Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License
*       (https://creativecommons.org/licenses/by-nc-sa/3.0/legalcode)
*/

///////////////////////////////////////////////////////////////////
//Customize the box. Sizes are in millimeters
///////////////////////////////////////////////////////////////////

//Do you want a lid to be generated?
generateLid=1; //[1:true,0:false]

//Do you want the box to be generated?
generateBox=1; //[1:true,0:false]

//What is the height of the item to be placed in the holes in mm?
itemHeight=65;

//What is the size of each hole in mm?
holeSize=7.0;

//Adds to the hole size so you can get items back out of the holes. Don't want it too tight. Can help account for shrinking too. I recomend around 0.7mm)
holeTolerence=0.7;

//Adds spacing to the width fit of the lid to help account for shrinking, printer accuracy, and different materials. (My printer FlashForge Creator Pro can use a tolerence of 0 for flexible material like TPU, but needs to add some space for rigid materials like ABS so that the lid will actually go down on the box.)
lidWidthTolerence=0.3;

//Adds spacing to the length fit of the lid to help account for shrinking, printer accuracy, and different materials. (My printer FlashForge Creator Pro can use a tolerence of 0 for flexible material like TPU, but needs to add some space for rigid materials like ABS so that the lid will actually go down on the box.)
lidLengthTolerence=0.3;

//How many rows of holes?
rows=3;

//How many columns of holes?
columns=9;

//The thickness of the outside lid walls.
lidWallWidth=1.6; 

//The thickness of the outside box walls.
wallWidth=1.6; 

//The thickness of the dividers.
dividerWidth=2;                 

//Box height as compared to item height. Allows the items to stick up higher than the box to help ease getting them out.
boxHeightPercentage=0.75; //[0.05:0.01:1.0]

//Divider height as compared to box height. This allows inset dividers to save material.
dividerHeightPercentage=0.75; //[0:0.01:1.0]

///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////

//Calculated Box Sizes. Do not change.
boxWidth=max(((dividerWidth*(columns-1))+(((holeSize+holeTolerence))*columns)+(wallWidth*2)),1);
boxLength=max(((dividerWidth*(rows-1))+(((holeSize+holeTolerence))*rows)+(wallWidth*2)),1);
boxFloorThickness=max(wallWidth,0.1);
boxHeight=max(itemHeight*boxHeightPercentage,1);
dividerHeight=min(boxHeight*dividerHeightPercentage,boxHeight);
lidHeight=(itemHeight-boxHeight)+20;
lidWidth=boxWidth+lidWidthTolerence+(lidWallWidth*2);
lidLength=boxLength+lidLengthTolerence+(lidWallWidth*2);

//Calculate the hole offsets
function holes(x) = ((holeSize+holeTolerence) * x)+(dividerWidth*x);

///////////////////////////////////////////////////////////////////
//Box
///////////////////////////////////////////////////////////////////
if (generateBox)
    difference(){
        difference(){
            cube([boxWidth,boxLength,boxHeight],false);
                for (r = [ 0 : 1 : rows-1 ])
                    for (c = [ 0 : 1 : columns-1 ])
                        translate([holes(c)+wallWidth, holes(r)+wallWidth, boxFloorThickness]) 
                        cube([(holeSize+holeTolerence),(holeSize+holeTolerence),itemHeight], center = false);
        }
        translate([wallWidth,wallWidth,min(dividerHeight,boxHeight+boxFloorThickness)]) 
        cube([boxWidth-(wallWidth*2),boxLength-(wallWidth*2),boxHeight*2],false);
    }

///////////////////////////////////////////////////////////////////
//Lid
///////////////////////////////////////////////////////////////////
if (generateLid)
    difference(){
        translate([-lidWallWidth+(boxWidth)+10,-lidWallWidth,0])
        cube([lidWidth,lidLength,lidHeight],false);

        translate([(boxWidth)+10,0,0])translate([0,0,lidWallWidth]) 
        cube([boxWidth+ lidLengthTolerence,boxLength+lidWidthTolerence,itemHeight*2],false);
    }