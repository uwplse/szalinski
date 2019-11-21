//How thick the backing for the display is
backingThickness=6.25;
//How tall the backing is
backingHeight=140;
//How wide the backing is, should be the same width as the plexiglass
backingWidth=298;
//How thick the Plexiglass you are working with is
plexiThickness=2.25;
//How tall the Plexiglass is
plexiHeight=151.5;
plexiWidth=backingWidth;
// Hole creation offset for bolt holes and such
holeCreationOffset=0.05;
//The size of the text on the object
textSize=.75;//[.5,.75,1]
//The text to display on the fliplock
locktext="AKA Kelly's Mod";
//How wide the faceplate is
facePlateWidth=120;
//How thick the base is
baseThickness=10;
//How tall the base is
baseHeight=20;
//The base offset size, this will affect the shouldered areas
baseOffset=8;
//How large the holes are, make it smaller then the screw radius to ensure self threading
boltHolesRadius=1.3;
//How long the hole for the bolts are
boltHoleLength=20;
//Howe large the bolthead is in height
screwHeadHeight=2.5;
//The radius of the bolthead
screwHeadRadius=2.8;
fakePlexi=true; //[true:false]
fakeBacking=true; //[true:false]
enableBracket=true; //[true:false]
enableBase=true; //[true:false]
enableBaseLeftSide=true; //[true:false]
enableBaseRightSide=true; //[true:false]
enableTop=true; //[true:false]
enableText=true; //[true:false]
enableScrewHoles=true; //[true:false]
enableFacePlate=true; //[true:false]
enableTopPlate=true; //[true:false]

 
module cylinder_outer(height,radius,fn){
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn);}
   
module cylinder_mid(height,radius,fn){
   fudge = (1+1/cos(180/fn))/2;
   cylinder(h=height,r=radius*fudge,$fn=fn);}
   
module holder(){
    stringlen=len(locktext);
    testlength=stringlen *textSize;
    //How wide the base is
    baseWidth=(backingWidth/2) + 10;
    overallThickness=backingThickness + plexiThickness;
    bracketThickness=((baseWidth * 2) - backingWidth) /2;
    bracketHeight=baseHeight;
    bracketWidth=(baseThickness * 3) + backingHeight;
    bracketOffset=bracketThickness/2;

        if (enableText){
             translate([testlength * 3 , baseWidth/2 - (baseThickness ) , baseThickness * 2 - (baseOffset/2) + (textSize )]) rotate(a=[-45,0,180])  scale([textSize,textSize,textSize]) drawtext(locktext);
        }
    
    
        if (enableTopPlate){
            difference(){
                translate([0, -bracketWidth/2 - (plexiThickness/2), 0]) cube([facePlateWidth, plexiThickness, baseHeight + baseOffset], center=true);
                translate([-(facePlateWidth / 3 ), -bracketWidth/2 + (boltHoleLength), -(baseHeight ) * .33]) rotate(a=[90,0,0]) cylinder_outer(boltHoleLength* 3 + holeCreationOffset,boltHolesRadius,6);
                translate([(facePlateWidth / 3 ), -bracketWidth/2 + (boltHoleLength), (baseHeight )  * .33]) rotate(a=[90,0,0]) cylinder_outer(boltHoleLength* 3 + holeCreationOffset,boltHolesRadius,6);

                translate([(facePlateWidth / 3 ), -bracketWidth/2 + (boltHoleLength), -(baseHeight ) * .33]) rotate(a=[90,0,0]) cylinder_outer(boltHoleLength* 3 + holeCreationOffset,boltHolesRadius,6);
                translate([-(facePlateWidth / 3 ), -bracketWidth/2 + (boltHoleLength), (baseHeight )  * .33]) rotate(a=[90,0,0]) cylinder_outer(boltHoleLength* 3 + holeCreationOffset,boltHolesRadius,6);
            }
    
        }
    

        if (enableFacePlate){
            difference(){
                translate([0, baseWidth/2, baseThickness * 2]) rotate(a=[-45,0,0])cube([facePlateWidth, baseThickness, 60], center=true);
                translate([0, 0, -50 ]) cube([plexiWidth, plexiHeight, 100], center=true);
                translate([0, 45, 0 ]) cube([plexiWidth, 40, 40], center=true);
                translate([0, bracketWidth/2.25, 40 ]) rotate(a=[60,0,0]) cube([plexiWidth, 40, 80], center=true);
                hull(){
                    translate([0, (backingHeight/2) + (baseThickness/3) , 0 ]) cube([baseWidth ,baseThickness , baseHeight], center=true);
                    translate([0, (backingHeight/2) + (baseThickness) , 0 ]) cube([baseWidth + baseOffset ,baseThickness , baseHeight + baseOffset], center=true);
                    }
    translate([-(facePlateWidth / 3 ), baseWidth/2 + baseThickness , -baseThickness/2  ]) rotate(a=[45,0,0]) cylinder_outer(boltHoleLength * 3 + holeCreationOffset,boltHolesRadius,6);
    translate([(facePlateWidth / 3 ), baseWidth/2 + baseThickness , -baseThickness/2 ]) rotate(a=[45,0,0]) cylinder_outer(boltHoleLength* 3 + holeCreationOffset,boltHolesRadius,6);
            }
        }
        
        if (fakeBacking){
            color([1,1,0]) translate([0, 0, -backingThickness - holeCreationOffset + (plexiThickness) - .25]) cube([backingWidth, backingHeight, backingThickness], center=true);
            
            }
        if (fakePlexi){
            color([1,0,1]) translate([0, 0, 0 ]) cube([plexiWidth, plexiHeight, plexiThickness], center=true);
            }

        if (enableBracket){
            difference(){
            hull() union() {
            translate([-baseWidth - bracketOffset , 0, 0]) cube([ bracketThickness, bracketWidth, bracketHeight], center=true);
            translate([-baseWidth - (bracketThickness /2) - bracketOffset, 0, 0]) cube([ bracketThickness, bracketWidth, bracketHeight + baseOffset], center=true);
            }
            hull() {
            translate([-baseWidth/2, (backingHeight/2) + (baseThickness/2) , 0 ]) cube([baseWidth ,baseThickness , baseHeight], center=true);
            translate([baseWidth/2, (backingHeight/2) + (baseThickness/2), 0 ]) cube([baseWidth ,baseThickness , baseHeight], center=true);
            translate([-baseWidth/2, (backingHeight/2) + (baseThickness) , 0 ]) cube([baseWidth + baseOffset ,baseThickness , baseHeight + baseOffset], center=true);
            translate([baseWidth/2, (backingHeight/2) + (baseThickness), 0 ]) cube([baseWidth + baseOffset ,baseThickness , baseHeight + baseOffset], center=true);

                }
                
            hull() {
            translate([baseWidth/2, -(backingHeight/2) - (baseThickness/2) , 0 ]) cube([baseWidth ,baseThickness , baseHeight], center=true);
            translate([-baseWidth/2, -(backingHeight/2) - (baseThickness/2), 0 ]) cube([baseWidth ,baseThickness , baseHeight], center=true);
            translate([baseWidth/2, -(backingHeight/2) - (baseThickness) , 0 ]) cube([baseWidth + baseOffset ,baseThickness , baseHeight + baseOffset], center=true);
            translate([-baseWidth/2, -(backingHeight/2) - (baseThickness), 0 ]) cube([baseWidth + baseOffset ,baseThickness , baseHeight + baseOffset], center=true);
            
                }
                
            rotate(a=[0,90,0]) translate([(baseHeight / 3), baseWidth/2, -baseWidth - boltHoleLength ]) cylinder_outer(boltHoleLength + holeCreationOffset,boltHolesRadius,6);
            rotate(a=[0,90,0]) translate([-(baseHeight / 3), baseWidth/2, -baseWidth - boltHoleLength ]) cylinder_outer(boltHoleLength + holeCreationOffset,boltHolesRadius,6);
            rotate(a=[0,90,0]) translate([(baseHeight / 3), -baseWidth/2, -baseWidth - boltHoleLength ]) cylinder_outer(boltHoleLength + holeCreationOffset,boltHolesRadius,6);
            rotate(a=[0,90,0]) translate([-(baseHeight / 3), -baseWidth/2, -baseWidth - boltHoleLength ]) cylinder_outer(boltHoleLength + holeCreationOffset,boltHolesRadius,6);
        }
        difference(){
                hull() union() {
            translate([baseWidth + bracketOffset, 0, 0]) cube([ bracketThickness, bracketWidth, bracketHeight], center=true);
            translate([baseWidth  + (bracketThickness /2) + bracketOffset, 0, 0]) cube([ bracketThickness, bracketWidth, bracketHeight + baseOffset], center=true);
                }
                hull() union() {
            translate([-baseWidth/2, (backingHeight/2) + (baseThickness/2) , 0 ]) cube([baseWidth ,baseThickness , baseHeight], center=true);
            translate([baseWidth/2, (backingHeight/2) + (baseThickness/2), 0 ]) cube([baseWidth ,baseThickness , baseHeight], center=true);
            translate([-baseWidth/2, (backingHeight/2) + (baseThickness) , 0 ]) cube([baseWidth + baseOffset ,baseThickness , baseHeight + baseOffset], center=true);
            translate([baseWidth/2, (backingHeight/2) + (baseThickness), 0 ]) cube([baseWidth + baseOffset ,baseThickness , baseHeight + baseOffset], center=true);
                                            
                }
                
                hull() union() {
            translate([baseWidth/2, -(backingHeight/2) - (baseThickness/2) , 0 ]) cube([baseWidth ,baseThickness , baseHeight], center=true);
            translate([-baseWidth/2, -(backingHeight/2) - (baseThickness/2), 0 ]) cube([baseWidth ,baseThickness , baseHeight], center=true);
            translate([baseWidth/2, -(backingHeight/2) - (baseThickness) , 0 ]) cube([baseWidth + baseOffset ,baseThickness , baseHeight + baseOffset], center=true);
            translate([-baseWidth/2, -(backingHeight/2) - (baseThickness), 0 ]) cube([baseWidth + baseOffset ,baseThickness , baseHeight + baseOffset], center=true);
            
                }
                
                rotate(a=[0,90,0]) translate([(baseHeight / 3), baseWidth/2, baseWidth ]) cylinder_outer(boltHoleLength + holeCreationOffset,boltHolesRadius,6);
                rotate(a=[0,90,0]) translate([-(baseHeight / 3), baseWidth/2, baseWidth ]) cylinder_outer(boltHoleLength + holeCreationOffset,boltHolesRadius,6);
                rotate(a=[0,90,0]) translate([(baseHeight / 3), -baseWidth/2, baseWidth ]) cylinder_outer(boltHoleLength + holeCreationOffset,boltHolesRadius,6);
                rotate(a=[0,90,0]) translate([-(baseHeight / 3), -baseWidth/2, baseWidth ]) cylinder_outer(boltHoleLength + holeCreationOffset,boltHolesRadius,6);
            }
        }   
        if (enableBase){
            
            difference(){
            hull() union() {
                if (enableBaseLeftSide){
            translate([-baseWidth/2, (backingHeight/2) + (baseThickness/3) , 0 ]) cube([baseWidth ,baseThickness , baseHeight], center=true);
                                translate([-baseWidth/2, (backingHeight/2) + (baseThickness) , 0 ]) cube([baseWidth + baseOffset ,baseThickness , baseHeight + baseOffset], center=true);
                    
                        

                }
                if (enableBaseRightSide){

            translate([baseWidth/2, (backingHeight/2) + (baseThickness), 0 ]) cube([baseWidth + baseOffset ,baseThickness , baseHeight + baseOffset], center=true);
                                translate([baseWidth/2, (backingHeight/2) + (baseThickness/3), 0 ]) cube([baseWidth ,baseThickness , baseHeight], center=true);

                }
                }
               cube([plexiWidth, plexiHeight, plexiThickness + holeCreationOffset], center=true); 
               translate([0, 0, -backingThickness  + (plexiThickness) - .25]) cube([backingWidth, backingHeight, backingThickness + holeCreationOffset], center=true);
            
                rotate(a=[0,90,0]) translate([(baseHeight / 3), baseWidth/2, baseWidth - (baseThickness * 1.5)]) cylinder_outer(boltHoleLength + holeCreationOffset,boltHolesRadius,6);
                rotate(a=[0,90,0]) translate([-(baseHeight / 3), baseWidth/2, baseWidth - (baseThickness * 1.5) ]) cylinder_outer(boltHoleLength + holeCreationOffset,boltHolesRadius,6);


                rotate(a=[0,90,0]) translate([(baseHeight / 3), baseWidth/2, -baseWidth - (boltHoleLength/4) ]) cylinder_outer(boltHoleLength + holeCreationOffset,boltHolesRadius,6);
                rotate(a=[0,90,0]) translate([-(baseHeight / 3), baseWidth/2, -baseWidth - (boltHoleLength/4) ]) cylinder_outer(boltHoleLength + holeCreationOffset,boltHolesRadius,6);

                translate([-(facePlateWidth / 3 ), baseWidth/2 + baseThickness , -baseThickness/2  ]) rotate(a=[45,0,0]) cylinder_outer(boltHoleLength * 3 + holeCreationOffset,boltHolesRadius,6);
                translate([(facePlateWidth / 3 ), baseWidth/2 + baseThickness , -baseThickness/2 ]) rotate(a=[45,0,0]) cylinder_outer(boltHoleLength* 3 + holeCreationOffset,boltHolesRadius,6);

                
                }
            } 
          
        if (enableTop){
            difference(){
            hull() union() {
                if (enableBaseRightSide){
            translate([baseWidth/2, -(backingHeight/2) - (baseThickness/3) , 0 ]) cube([baseWidth ,baseThickness , baseHeight], center=true);
                        translate([baseWidth/2, -(backingHeight/2) - (baseThickness) , 0 ]) cube([baseWidth + baseOffset ,baseThickness , baseHeight + baseOffset], center=true);
                    }
            if (enableBaseLeftSide){

            translate([-baseWidth/2, -(backingHeight/2) - (baseThickness), 0 ]) cube([baseWidth + baseOffset ,baseThickness , baseHeight + baseOffset], center=true);
                translate([-baseWidth/2, -(backingHeight/2) - (baseThickness/3), 0 ]) cube([baseWidth ,baseThickness , baseHeight], center=true);
            }
            
                }
                cube([plexiWidth, plexiHeight, plexiThickness + holeCreationOffset], center=true); 
                translate([0, 0, -backingThickness  + (plexiThickness) - .25]) cube([backingWidth, backingHeight, backingThickness + holeCreationOffset], center=true);

                rotate(a=[0,90,0]) translate([(baseHeight / 3), -baseWidth/2, baseWidth - (baseThickness * 1.5) ]) cylinder_outer(boltHoleLength + holeCreationOffset,boltHolesRadius,6);
                rotate(a=[0,90,0]) translate([-(baseHeight / 3), -baseWidth/2, baseWidth - (baseThickness * 1.5) ]) cylinder_outer(boltHoleLength + holeCreationOffset,boltHolesRadius,6);
                rotate(a=[0,90,0]) translate([(baseHeight / 3), -baseWidth/2, -baseWidth - (boltHoleLength/4) ]) cylinder_outer(boltHoleLength + holeCreationOffset,boltHolesRadius,6);
                rotate(a=[0,90,0]) translate([-(baseHeight / 3), -baseWidth/2, -baseWidth - (boltHoleLength/4) ]) cylinder_outer(boltHoleLength + holeCreationOffset,boltHolesRadius,6);
                
                    translate([(facePlateWidth / 3 ), -bracketWidth/2 + (boltHoleLength), (baseHeight )  * .33]) rotate(a=[90,0,0]) cylinder_outer(boltHoleLength* 3 + holeCreationOffset,boltHolesRadius,6);
    
    translate([(facePlateWidth / 3 ), -bracketWidth/2 + (boltHoleLength), -(baseHeight ) * .33]) rotate(a=[90,0,0]) cylinder_outer(boltHoleLength* 3 + holeCreationOffset,boltHolesRadius,6);
                
                    translate([-(facePlateWidth / 3 ), -bracketWidth/2 + (boltHoleLength), -(baseHeight ) * .33]) rotate(a=[90,0,0]) cylinder_outer(boltHoleLength* 3 + holeCreationOffset,boltHolesRadius,6);

    translate([-(facePlateWidth / 3 ), -bracketWidth/2 + (boltHoleLength), (baseHeight )  * .33]) rotate(a=[90,0,0]) cylinder_outer(boltHoleLength* 3 + holeCreationOffset,boltHolesRadius,6);
                
                }
            }   
            
        
}



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


holder();