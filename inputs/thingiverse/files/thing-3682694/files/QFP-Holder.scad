/*
Parametric holder for QFP chips to protect the pins in transport
*/

//X size of individual chip leg end to end
SizeX = 9; 		//[3:100]
//Y size of individual chip leg end to end
SizeY = 9; 		//[3:100]
//Z height of individual chip
SizeZ = 1.2; 	//[0.2:0.1:20]
//Length of legs from package
LengthLeg = 1;	//[0.4:0.1:3]
//Foot height under plastik package to make the legs not touch the ground
HeightFoot = 1;	//[0:0.1:10]
//Tolerance distance for basically everything
Tolerance = 0.5;//[0:0.1:3]
//Number of horizontal chips
NumHor = 3;		//[1:100]
//Number of vertical chips
NumVer = 10;		//[1:100]
//Wall thiccness
SizeWall = 1.2;	//[0.4:0.1:3]

//Fixed Resolution
$fa=5+0;
$fs=0.5+0;

//Actual code rendering and translating the individual holders for the number of set holders
for(j = [0 : NumVer-1]){
	for(i = [0 : NumHor-1]){
		translate([(SizeX+SizeWall+Tolerance*2)*i, (SizeY+SizeWall+Tolerance*2)*j, 0]) holder();
	}
}


//Modules
module holder() {
	//ground plate from 0 down
	translate([0,0,-SizeWall/2])
		cube([(SizeX+SizeWall*2+Tolerance*2) , (SizeY+SizeWall*2+Tolerance*2) , SizeWall], true);
	
	//foot from 0 up
	translate([0,0,HeightFoot/2])
		cube([(SizeX-LengthLeg*2-Tolerance*2) , (SizeX-LengthLeg*2-Tolerance*2) , (HeightFoot)] , true);
	
	//Walls from 0 up
	translate ([0,0,(SizeZ++HeightFoot+Tolerance)/2])
		difference() {
				cube([(SizeX+SizeWall*2+Tolerance*2) , (SizeY+SizeWall*2+Tolerance*2) , (SizeZ+HeightFoot+Tolerance)], true);
				cube([(SizeX+Tolerance*2) , (SizeY+Tolerance*2) , (SizeZ+HeightFoot+Tolerance+1)], true);
		}
}