//Number of horizontal pegs
NumHorizontal = 10; 	//[1:30]
//Number of vertical pegs
NumVertical = 2;		//[1:30]
//Distance between pegs
Distance = 13;			//[13:30]
ScrewHoleDia = 4;		//[1:0.1:6]
//Height of the ground plate
Thiccness = 2;			//[1:0.1:5]
//Height of the pegs
WallHeight = 15;		//[5:0.1:20]
//Should the screw holes be chamfered?
ChamferHoles = "Yes";	//[Yes, No]

//Inner diameter of the small wall, smaller is tighter
SmallWallInner = 4.4;	//[3.5:0.1:5.5] 
//Outer diameter of the small wall, bigger is thighter
SmallWallOuter = 5.8;	//[5.0:0.1:7.0]
//Inner diameter of the big wall, smaller is tighter
BigWallInner = 9.2;		//[8.5:0.1:10.0]
//Outer diameter of the big wall, is just for stability
BigWallOuter = 10.5;	//[10.5:0.1:13.0]

/*MyValues
	
SmallWallInner = 4.4+0;	
SmallWallOuter = 5.8+0;	
BigWallInner = 9.2+0;	
BigWallOuter = 10.5+0;		
*/

//Fixed Resolution
$fa=5+0;
$fs=0.5+0;
//Fixed Variables
Framelength = 20+0;	

//Draw the Pegs depending on selected number of vertical/horizontal Num variables
//The for loop uses i and j as multipliers in the translation while drawing the pegs
for(j = [0 : NumVertical-1]){
	for(i = [0 : NumHorizontal-1]){
		translate([Distance*i, Distance*j, 0]) peg();
	}
}

//Plate with Screwholes
difference(){
	//Plate
	translate([-(Distance+Framelength)/2, -(Distance/2), -Thiccness])
		cube([Distance*NumHorizontal+Framelength, Distance*NumVertical, Thiccness]);
	
	
	//Screwholes
	//If more than one vertical peg is drawn we put a screwhole in each corner
	if (NumVertical > 1){
		translate([(-(Distance+Framelength)/2)+Framelength/3,
			-(Distance/2)+Framelength/3,
			-Thiccness-0.1])
				drill();
		translate([(-(Distance+Framelength)/2)+Framelength/3,
			(Distance*(NumVertical-1)+Distance*0.5)-Framelength/3,
			-Thiccness-0.1])
				drill();
		translate([(Distance*(NumHorizontal-1)+(Distance+Framelength)/2)-Framelength/3,
			-(Distance/2)+Framelength/3,
			-Thiccness-0.1])
				drill();
		translate([(Distance*(NumHorizontal-1)+(Distance+Framelength)/2)-Framelength/3,
			(Distance*(NumVertical-1)+Distance*0.5)-Framelength/3,
			-Thiccness-0.1])
				drill();
	//if only one vertical peg is drawn we only need a single screwhole on each side
	} else {
		translate([(-(Distance+Framelength)/2)+Framelength/3,
			0,
			-Thiccness-0.1])
				drill();
		translate([(Distance*(NumHorizontal-1)+(Distance+Framelength)/2)-Framelength/3,
			0,
			-Thiccness-0.1])
				drill();
			}
		}
//Modules
module peg() {
	//Inner Wall
	difference(){
		cylinder(h=WallHeight, d=SmallWallOuter);
		cylinder(h=100, d=SmallWallInner, center=true);
	}
	//Outer Wall
	difference(){
		cylinder(h=WallHeight, d=BigWallOuter);
		cylinder(h=100, d=BigWallInner, center=true);
	}
}

module drill(){
	if(ChamferHoles == "Yes"){
	cylinder(h=Thiccness+0.2, d1=ScrewHoleDia, d2=(ScrewHoleDia+2*tan(45)*Thiccness+0.2));
	} else {
		cylinder(h=Thiccness+0.2, d=ScrewHoleDia);
	}
}
