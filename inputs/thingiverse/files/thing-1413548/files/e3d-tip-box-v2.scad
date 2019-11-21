//How thick the walls are
boxWallThickness=3; //[2:5]
//How thick the lid is, 2 is a good value, 3 is too thick and 1 is down right not enough, 4 is right out unless you plan on breaking one side and inserting it that way. 
boxLidThickness=2; //[1:4]
//How tall the inside box is
boxInteriorHeight=18;//[15:200]
//How wide the laser cut tray is
boxInteriorWidth=80.25;//[60:400]
//How deep the box is
boxInteriorDepth=35; //[25:200]
//Box interior block
BoxInterorBlockWidth=2;//[1:10]
//The roundness of the corners 
partChamferRadius=1; //[1:3]
// If the box is one unit or the lid is next to the box
enableoffset=1; //[0:1]
// If the words on the lid are enabled or not
enablelidwords=1; //[0:1]
// If the words on the box are enabled or not
enableboxwords=1; //[0:1]
//Words to print on the side and top of the box
wordsToPrint="E3D Tips";
//Size of the box letters X Dimension (how wide the letters are)
BoxTextXSize=1.5; //[1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0,5.5,6.0,6.5,7.0]
//Size of the box letters Y Dimension (how far the letters are raised from the surface)
BoxTextYSize=1.5; //[1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0,5.5,6.0,6.5,7.0]
//Size of the box letters Z Dimension (how tall the letters are)
BoxTextZSize=1.5; //[1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0,5.5,6.0,6.5,7.0]
//Size of the box letters X Dimension (how wide the letters are)
LidTextXSize=1.5; //[1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0,5.5,6.0,6.5,7.0]
//Size of the box letters Y Dimension (how far the letters are raised from the surface)
LidTextYSize=1.5; //[1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0,5.5,6.0,6.5,7.0]
//Size of the box letters Z Dimension (how tall the letters are)
LidTextZSize=1.5; //[1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0,5.5,6.0,6.5,7.0]
// Left to right offset for the text used to center it on the object
LidTextXOffset=0; //[-500:500]
// Up/Down offset for the text used to center it on the object
LidTextYOffset=0; //[-500:500]
// Left to right offset for the text used to center it on the object
BoxTextXOffset=0; //[-500:500]
// Up/Down offset for the text used to center it on the object
BoxTextYOffset=0; //[-500:500]
//How tall the rail height is
boxInteriorRailHeight=4.5; //[0.5,1,1.5,2,2.5,3,3.5,4,4.5,5,5.5,6,6.5,7,7.5,8,8.5,9,9.5,10,10.5,11,11.5,12,12.5,13,13.5,14,14.5,15,15.5,16,16.5,17,17.5,18,18.5,19,19.5,20,20.5,21,21.5,22,22.5,23,23.5,24,24.5,25,25.5,26,26.5,27,27.5,28,28.5,29,29.5,30,30.5,31,31.5,32,32.5,33,33.5,34,34.5,35,35.5,36,36.5,37,37.5,38,38.5,39,39.5,40,40.5,41,41.5,42,42.5,43,43.5,44,44.5,45,45.5,46,46.5,47,47.5,48,48.5,49,49.5,50,50.5,51,51.5,52,52.5,53,53.5,54,54.5,55,55.5,56,56.5,57,57.5,58,58.5,59,59.5,60,60.5,61,61.5,62,62.5,63,63.5,64,64.5,65,65.5,66,66.5,67,67.5,68,68.5,69,69.5,70,70.5,71,71.5,72,72.5,73,73.5,74,74.5,75,75.5,76,76.5,77,77.5,78,78.5,79,79.5,80,80.5,81,81.5,82,82.5,83,83.5,84,84.5,85,85.5,86,86.5,87,87.5,88,88.5,89,89.5,90,90.5,91,91.5,92,92.5,93,93.5,94,94.5,95,95.5,96,96.5,97,97.5,98,98.5,99,99.5,100,100.5,101,101.5,102,102.5,103,103.5,104,104.5,105,105.5,106,106.5,107,107.5,108,108.5,109,109.5,110,110.5,111,111.5,112,112.5,113,113.5,114,114.5,115,115.5,116,116.5,117,117.5,118,118.5,119,119.5,120,120.5,121,121.5,122,122.5,123,123.5,124,124.5,125,125.5,126,126.5,127,127.5,128,128.5,129,129.5,130,130.5,131,131.5,132,132.5,133,133.5,134,134.5,135,135.5,136,136.5,137,137.5,138,138.5,139,139.5,140,140.5,141,141.5,142,142.5,143,143.5,144,144.5,145,145.5,146,146.5,147,147.5,148,148.5,149,149.5,150,150.5,151,151.5,152,152.5,153,153.5,154,154.5,155,155.5,156,156.5,157,157.5,158,158.5,159,159.5,160,160.5,161,161.5,162,162.5,163,163.5,164,164.5,165,165.5,166,166.5,167,167.5,168,168.5,169,169.5,170,170.5,171,171.5,172,172.5,173,173.5,174,174.5,175,175.5,176,176.5,177,177.5,178,178.5,179,179.5,180,180.5,181,181.5,182,182.5,183,183.5,184,184.5,185,185.5,186,186.5,187,187.5,188,188.5,189,189.5,190,190.5,191,191.5,192,192.5,193,193.5,194,194.5,195,195.5,196,196.5,197,197.5,198,198.5,199,199.5,200]

//  ####### DO NOT CHANGE #######
echo(boxInteriorRailHeight);
boxInteriorWidthCombined=boxInteriorWidth+ (boxWallThickness*2);
boxInteriorDepthCombined=boxInteriorDepth + (boxWallThickness*2);
boxInteriorHeightCombined=boxInteriorHeight + (boxWallThickness);

//############## FUNCTIONS DO NOT CHANGE ##############

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

module cylinder_outer(height,radius,fn){
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn, center = true);
}
   
   
module createMeniscus(h,radius) {// This module creates the shape that needs to be substracted from a cube to make its corners rounded.
    difference(){        //This shape is basicly the difference between a quarter of cylinder and a cube
       translate([radius/2+0.1,radius/2+0.1,0]){
          cube([radius+0.2,radius+0.1,h+0.2],center=true);         // All that 0.x numbers are to avoid "ghost boundaries" when substracting
       }
       cylinder(h=h+0.2,r=radius,$fn = 90,center=true);
    }
}

module roundCornersCube(x,y,z,r){  // Now we just substract the shape we have created in the four corners
    difference(){
       cube([x,y,z], center=true);

    translate([x/2-r,y/2-r]){  // We move to the first corner (x,y)
          rotate(0){  
             createMeniscus(z,r); // And substract the meniscus
          }
       }
       translate([-x/2+r,y/2-r]){ // To the second corner (-x,y)
          rotate(90){
             createMeniscus(z,r); // But this time we have to rotate the meniscus 90 deg
          }
       }
          translate([-x/2+r,-y/2+r]){ // ... 
          rotate(180){
             createMeniscus(z,r);
          }
       }
          translate([x/2-r,-y/2+r]){
          rotate(270){
             createMeniscus(z,r);
          }
       }
    }
}

module miniround(x,y,z, diameter)
{
    $fn=50;
    fn=$fn;
    fudge = 1/cos(180/fn);
    radius=(diameter/2)*fudge;
    x = x-radius;
    y = y-radius;
    minkowski()
    {
        roundCornersCube(x,y,z,partCornerRadius);
        //cube(size=[x,y,z], center = true);
        //cylinder(r=diameter,$fn=12);
        // Using a sphere is possible, but will kill performance
        sphere(r=radius);
    }
}

module miniround2(x,y,z, diameter)
{
    $fn=50;
    fn=$fn;
    fudge = 1/cos(180/fn);
    radius=(diameter/2)*fudge;
    x = x-radius;
    y = y-radius;
    minkowski()
    {
        //roundCornersCube(x,y,z,partCornerRadius);
        cube(size=[x,y,z], center = true);
        //cylinder(r=diameter,$fn=12);
        // Using a sphere is possible, but will kill performance
        sphere(r=radius);
    }
}
//############## FUNCTIONS DO NOT CHANGE ##############
//  ####### DO NOT CHANGE #######

module e3dBox(){
    union(){
    difference(){
        roundCornersCube(boxInteriorWidthCombined,boxInteriorDepthCombined,boxInteriorHeightCombined,partChamferRadius);
        translate([0,0,boxWallThickness + 2]) roundCornersCube(boxInteriorWidth,boxInteriorDepth,boxInteriorHeight,partChamferRadius);
        translate([0,boxInteriorDepth/2,boxInteriorHeightCombined/2 - boxLidThickness])cube([boxInteriorWidth,boxInteriorDepth + (boxLidThickness*4),boxLidThickness * 3 + 0.01],center=true); // rear cutout 
        translate([0,-boxInteriorDepth/2,boxInteriorHeightCombined/2])cube([boxInteriorWidth,boxInteriorDepth + (boxLidThickness*3),boxLidThickness * 2 ],center=true); // front cutout
        translate([0,boxInteriorDepth/2 - 1,boxInteriorHeightCombined/2 - boxWallThickness]) rotate([0,90,0]) cylinder_outer(boxInteriorWidthCombined * 1.5,boxLidThickness/2 + .25,360); // hole for hinge
translate([0,boxInteriorDepth/2 - 1,boxInteriorHeightCombined/2 - boxWallThickness]) rotate([0,90,0]) cylinder_outer(boxInteriorWidth,boxLidThickness,360); // hole for hinge
translate([0,boxInteriorDepth/2 - 1 + boxLidThickness,boxInteriorHeightCombined/2 - boxWallThickness + boxLidThickness ]) cube([boxInteriorWidth,boxLidThickness + .25,boxInteriorHeightCombined/4],center=true); // hole for hinge 2
    }
    
    //interior blocks
    translate([boxInteriorWidthCombined/2 - BoxInterorBlockWidth/2 - boxWallThickness,0,-boxInteriorHeight/2 + boxInteriorRailHeight + boxWallThickness/2])cube([BoxInterorBlockWidth,boxInteriorDepth,boxInteriorRailHeight],center=true);
    translate([-boxInteriorWidthCombined/2 + BoxInterorBlockWidth/2 +  boxWallThickness,0,-boxInteriorHeight/2 + boxInteriorRailHeight + boxWallThickness/2])cube([BoxInterorBlockWidth,boxInteriorDepth,boxInteriorRailHeight],center=true);
    if (enableboxwords==1){
    translate([-boxInteriorWidthCombined/2 + 7 + BoxTextXOffset,-boxInteriorDepthCombined/2 + .5,-boxInteriorHeightCombined/2 + 2 + BoxTextYOffset]) scale([BoxTextXSize,BoxTextYSize,BoxTextZSize]) rotate ([90,0,0]) drawtext(wordsToPrint);
    }
    }
    if (enableoffset==1){
    
    translate([0,boxInteriorDepth * 1.5,-boxInteriorHeight + boxWallThickness/2 ])union(){
        
        
            translate([0,0,boxInteriorHeightCombined/2 - boxWallThickness]) roundCornersCube(boxInteriorWidth - 0.5,boxInteriorDepthCombined,boxLidThickness + 0.01,partChamferRadius);
        translate([0,boxInteriorDepth/2 + boxWallThickness/2,boxInteriorHeightCombined/2 - boxWallThickness]) rotate([0,90,0]) cylinder_outer(boxInteriorWidthCombined ,boxLidThickness/2,360);  
     if (enablelidwords==1){   
        translate([-boxInteriorWidthCombined/2 + 7 + LidTextXOffset,-5  + LidTextYOffset,boxInteriorHeightCombined/2-boxWallThickness/2 ]) scale([LidTextXSize,LidTextYSize,LidTextZSize]) drawtext(wordsToPrint);
     }
        }
    
        } else {
            union(){
        
        
            translate([0,0,boxInteriorHeightCombined/2 - boxWallThickness]) roundCornersCube(boxInteriorWidth - 0.5,boxInteriorDepthCombined,boxLidThickness + 0.01,partChamferRadius);
        translate([0,boxInteriorDepth/2,boxInteriorHeightCombined/2 - boxWallThickness]) rotate([0,90,0]) cylinder_outer(boxInteriorWidthCombined ,boxLidThickness/2,360);     
                if (enablelidwords==1){
                    translate([-boxInteriorWidthCombined/2 + 7 + LidTextXOffset,-5  + LidTextYOffset,boxInteriorHeightCombined/2-boxWallThickness/2 ]) scale([LidTextSize,LidTextSize,LidTextSize]) drawtext(wordsToPrint);
                }
                }
            }
    
};

e3dBox();