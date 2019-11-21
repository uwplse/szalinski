use <utils/build_plate.scad>

// preview[view:south, tilt:top]

//Size of space
end = 20; //[10,20,30,40,50,60]

//What incrament to put lines at (Smaller for greater detail)
step = 1; //[1,2,5]

//Radius of lines
decimalRadius = 1; //[1:5]

//Choose random display with above selections ("Random Pick" works when all Draw's below are set to "Don't Draw") (If set to "I'll Pick" ignore Error and choose which lines to draw below)
isRand = 1; //[1:Random Pick,0:I'll Pick]

//Draw the lines at the bottom left of quadrant I
draw_bld = 0;	//[1:Draw Bottom Left Lines,0:Don't Draw]
//Which quadrants to draw the lines at
BLD = 26;	//[3:Quadrant I, 5:Quadrant II, 7:Quadrant III, 11:QuadrantIV, 8:Quadrants I & II, 10:Quadrants I & III, 12:Quadrants II & III, 14:Quadrants I & IV, 16:Quadrants II & IV, 18:Quadrants III & IV, 15:Quadrants I & II & III, 19:Quadrants I & II & IV, 21:Quadrants I & III & IV, 23:Quadrants II & III & IV, 26:All Quadrants]]

//Draw the lines at the bottom right of quadrant I
draw_brd = 0;	//[1:Draw Bottom Right Lines,0:Don't Draw]
//Which quadrants to draw the lines at
BRD = 26;	//[3:Quadrant I, 5:Quadrant II, 7:Quadrant III, 11:QuadrantIV, 8:Quadrants I & II, 10:Quadrants I & III, 12:Quadrants II & III, 14:Quadrants I & IV, 16:Quadrants II & IV, 18:Quadrants III & IV, 15:Quadrants I & II & III, 19:Quadrants I & II & IV, 21:Quadrants I & III & IV, 23:Quadrants II & III & IV, 26:All Quadrants]]

//Draw the lines at the top right of quadrant I
draw_trd = 0;	//[1:Draw Top Right Lines,0:Don't Draw]
//Which quadrants to draw the lines at
TRD = 26;	//[3:Quadrant I, 5:Quadrant II, 7:Quadrant III, 11:QuadrantIV, 8:Quadrants I & II, 10:Quadrants I & III, 12:Quadrants II & III, 14:Quadrants I & IV, 16:Quadrants II & IV, 18:Quadrants III & IV, 15:Quadrants I & II & III, 19:Quadrants I & II & IV, 21:Quadrants I & III & IV, 23:Quadrants II & III & IV, 26:All Quadrants]]

//Draw the lines at the top left of quadrant I
draw_tld = 0;	//[1:Draw Top Left Lines,0:Don't Draw]
//Which quadrants to draw the lines at
TLD = 26;	//[3:Quadrant I, 5:Quadrant II, 7:Quadrant III, 11:QuadrantIV, 8:Quadrants I & II, 10:Quadrants I & III, 12:Quadrants II & III, 14:Quadrants I & IV, 16:Quadrants II & IV, 18:Quadrants III & IV, 15:Quadrants I & II & III, 19:Quadrants I & II & IV, 21:Quadrants I & III & IV, 23:Quadrants II & III & IV, 26:All Quadrants]]

//Draw a box around lines (Recommended if placing a ring)
isBox = 0;	//[1:Draw Box,0:Don't Draw]

//Place a ring on lines so it can be worn
isRing = 0; //[1:Draw Ring,0:Don't Draw]
//Size of ring
ringSize = 2; //[1:5]
//Position of ring
ringPos = 2;	//[1:Top Left,2:Top Mid,3:Top Right,4:Mid Right,5:Bottom Right,6:Bottom Mid,7:Bottom Left,8:Mid Left]

//Display only, does not contribute to final object
buildPlateType = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic]

if(isRing == 1)
	isWearable(ringPos);

if(isBox == 1)
	drawBox();

if(draw_bld == 1)
	allQuadrants(BLD){smallBoxBottomLeftDraw();}

if(draw_brd == 1)
	allQuadrants(BRD){smallBoxBottomRightDraw();}

if(draw_trd == 1)
	allQuadrants(TRD){smallBoxTopRightDrawing();}

if(draw_tld == 1)
	allQuadrants(TLD){smallBoxTopLeftDraw();}

if(isRand ==1)
	randomCrazyness();

start = step;
radius = decimalRadius/10;  //getting a decimal radius

function findC(a,b) = sqrt((pow(a,2) + pow(b,2)));  //a^2 + b^2 = c^2... findC
function findDeg(a,o) = atan(a/o);  //find the arc tangent (for degrees) of an angle

module randomCrazyness(){
	//Method to my madness -> Quadrant I = 3, Quadrant II = 5, Quadrant III = 7, Quadrant IV = 11
	//The rest are just variations of the sum of the above.  ie. Quadrants I+II = 3+5 = 8

	arrayOfQuadrants = [0, 3, 5, 7, 8, 10, 11, 12, 14, 15, 16, 18, 19, 21, 23, 26];
	randomVector = rands(0, 16, 5);  //first random number is junk (possibly off of hours)

	for(x=[1:4]){  //cycle through last 4 numbers
		if(x == 1){
			allQuadrants(arrayOfQuadrants[randomVector[x]]){smallBoxBottomLeftDraw();}
		}else if(x == 2){
			allQuadrants(arrayOfQuadrants[randomVector[x]]){smallBoxBottomRightDraw();}
		}else if(x == 3){
			allQuadrants(arrayOfQuadrants[randomVector[x]]){smallBoxTopRightDrawing();}
		}else if(x == 4){
			allQuadrants(arrayOfQuadrants[randomVector[x]]){smallBoxTopLeftDraw();}
		}
	}

	if(floor(randomVector[1]) <= 8){  //don't think it matters but just to make it nicer floor the double
		isWearable(floor(randomVector[1]));
		drawBox();
	}
}

module isWearable(whereToo){
	cornerMove = ringSize - .5;
	move = ringSize;

	if(whereToo == 1){
		translate([-end - cornerMove,end + cornerMove,0]) wearableRing();
	}else if(whereToo == 2){
		translate([0,end + move,0]) wearableRing();
	}else if(whereToo == 3){
		translate([end + cornerMove,end + cornerMove,0]) wearableRing();
	}else if(whereToo == 4){
		translate([end + move,0,0]) wearableRing();
	}else if(whereToo == 5){
		translate([end + cornerMove,-end - cornerMove,0]) wearableRing();
	}else if(whereToo == 6){
		translate([0,-end - move,0]) wearableRing();
	}else if(whereToo == 7){
		translate([-end - cornerMove,-end - cornerMove,0]) wearableRing();
	}else if(whereToo == 8){
		translate([-end - move,0,0]) wearableRing();
	}
}

module wearableRing(){
	rotate_extrude(convexity = 10) translate([ringSize, 0, 0])
			circle(r = 1);
}

module drawCorner(corner){
	//module to draw lines that cover each corner

	if(corner == 1){
		translate([end/2,end,0]) rotate(a=[0,90,0])
			cylinder(h = end,r = radius,center = true);
		translate([0,end/2,0]) rotate(a=[90,0,0])
			cylinder(h = end,r = radius,center = true);
	}else if(corner == 2){
		translate([end/2,end,0]) rotate(a=[0,90,0])
			cylinder(h = end,r = radius,center = true);
		translate([end,end/2,0]) rotate(a=[90,0,0])
			cylinder(h = end,r = radius,center = true);
	}else if(corner == 3){
		translate([end/2,0,0]) rotate(a=[0,90,0])
			cylinder(h = end,r = radius,center = true);
		translate([end,end/2,0]) rotate(a=[90,0,0])
			cylinder(h = end,r = radius,center = true);
	}else if(corner == 4){
		translate([end/2,0,0]) rotate(a=[0,90,0])
			cylinder(h = end,r = radius,center = true);
		translate([0,end/2,0]) rotate(a=[90,0,0])
			cylinder(h = end,r = radius,center = true);
	}
}

module drawBox(){
	//outside box

	difference(){
		cube([end*2,end*2,1], center = true);
		cube([end*2-1,end*2-1,5], center = true);
	}
}

module smallBoxTopLeftDraw(){
	//Line fun!  Work backwards, draw a cylinder of h = to our triangles "C",
	//then rotate it tangent degrees, then drop it down on the xy plane,
	//finnaly move each iteration across the coordinate system.

	for(x = [end:step:start]){
		translate([x, end, 0]) rotate([0,90,0]) rotate([findDeg(x,(end+step)-x)+90,0,0])
			cylinder(h = findC(x, (end+step)-x), r = radius, center = false);
	}
	drawCorner(1);
}

module smallBoxBottomLeftDraw(){
	for(x = [end:step:start]){
		translate([0, x, 0]) rotate([0,90,0]) rotate([findDeg(x,(end+step)-x),0,0])
			cylinder(h = findC(x, (end+step)-x), r = radius, center = false);
	}
	drawCorner(4);
}

module smallBoxBottomRightDraw(){
	for(x = [end:step:start]){
		translate([end, x, 0]) rotate([0,-90,0]) rotate([findDeg(x,(end+step)-x),0,0])
			cylinder(h = findC(x, (end+step)-x), r = radius, center = false);
	}
	drawCorner(3);
}

module smallBoxTopRightDrawing(){
	for(x = [start:step:end]){
		translate([end, x, 0]) rotate([0,90,0]) rotate([findDeg(end-x,x)+180,0,0])
			cylinder(h = findC((end - x), x), r = radius, center = false);
	}
	drawCorner(2);
}

module rotateFourFive(){
	//not in use, 45degree rotate module
	for (y = [0 : $children-1])
		rotate([0,0,45]) child(y);
}

module allQuadrants(whichQuadrant){
	//easy 360 rotations to any of the four quadrants depending on where the user wants them
	for (y = [0 : $children-1]){
		if(whichQuadrant == 26){
			child(y);
			rotate([0,0,90]) child(y);
			rotate([0,0,180]) child(y);
			rotate([0,0,270]) child(y);
		}else if(whichQuadrant >= 15 && whichQuadrant%2 != 0){
			if(whichQuadrant == 15){
				child(y);
				rotate([0,0,90]) child(y);
				rotate([0,0,180]) child(y);
			}else if(whichQuadrant == 19){
				child(y);
				rotate([0,0,90]) child(y);
				rotate([0,0,270]) child(y);
			}else if(whichQuadrant == 21){
				child(y);
				rotate([0,0,180]) child(y);
				rotate([0,0,270]) child(y);
			}else if(whichQuadrant == 23){
				rotate([0,0,90]) child(y);
				rotate([0,0,180]) child(y);
				rotate([0,0,270]) child(y);
			}
		}else if(whichQuadrant >= 8 && whichQuadrant != 11){
			if(whichQuadrant == 8){
				child(y);
				rotate([0,0,90]) child(y);
			}else if(whichQuadrant == 10){
				child(y);
				rotate([0,0,180]) child(y);
			}else if(whichQuadrant == 12){
				rotate([0,0,90]) child(y);
				rotate([0,0,180]) child(y);
			}else if(whichQuadrant == 14){
				child(y);
				rotate([0,0,270]) child(y);
			}else if(whichQuadrant == 16){
				rotate([0,0,90]) child(y);
				rotate([0,0,270]) child(y);
			}else if(whichQuadrant == 18){
				rotate([0,0,180]) child(y);
				rotate([0,0,270]) child(y);
			}
		}else	if(whichQuadrant == 3)
			child(y);
		else if(whichQuadrant == 5)
			rotate([0,0,90]) child(y);
		else if(whichQuadrant == 7)
			rotate([0,0,180]) child(y);
		else if(whichQuadrant == 11)
			rotate([0,0,270]) child(y);
	}
}

build_plate(buildPlateType, buildPlateX, buildPlateY);