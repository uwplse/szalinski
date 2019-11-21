$fn=20;
include <MCAD/boxes.scad>;
include <MCAD/teardrop.scad>;

//CUSTOMIZER VARIABLES

//	Parameters
//	Height of the clip
Height= 8; 		//	[6:50]
// width of the slot
Distance_Slot=4.8; 	//	[3:10]
// hole for tie rip Diameter
dHole= 3.5; 		//	[3:10]
// width of extrusion beam
width= 18; 		//	[13:40]
// depth outside
deep=7;
// thickness of wall (1/10 of mm)
wall=15;		// 	[5:50]
//CUSTOMIZER VARIABLES END


module Hook(h=5){
	linear_extrude(height=h)
		polygon([[0,0],[-2.5,0.2],[-2.5,1],[-5,-1],[0,-1],[0,0]]);
	}


wall2= wall / 10;
echo("Size inside:", deep - wall2,"x", width-2*wall2, "mm");
	
translate([0, Distance_Slot/2, 0]) 	rotate([0,0,0])	  Hook(h=Height);
translate([0,-Distance_Slot/2, Height]) rotate([180,0,0]) Hook(h=Height);

difference(){
	translate([deep/2, 0, Height/2]) 
		roundedBox([deep,width,Height], 1, true);
	translate([(deep)/2+wall2+0.01, 0, Height/2]) 
		roundedBox([deep,width-2*wall2,Height+1], 3, true);	
	
translate([dHole/2+wall2, 0, Height/2])
rotate([0,0,90])		
//	cylinder(d=dHole, h=width+1, center=true);
	teardrop(dHole/2, width+1, 90);
}