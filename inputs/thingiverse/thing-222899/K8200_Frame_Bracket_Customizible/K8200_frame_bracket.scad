//	Customizible Frame Bracket For Velleman K8200 3D -Printer
//	for questions and comments go to http://www.thingiverse.com/donboy/message
// use M5 Screw with nut to fix bracket on frame

	include <utils/build_plate.scad>

//CUSTOMIZER VARIABLES

//	of bracket:
Length = 80;	//	[11:150]

//	of bracket base:
Thickness = 4;	//	[1:25]

// of bracket base:
Width=20;		//	[16:80]

// - max. fixing holes (if possible concerning length)
Holes = 2;	//	[1,2,3]

//CUSTOMIZER VARIABLES END


//calc hight of difference holes
$cube_z_diff = Thickness + 3.2;

//calc max no of holes
$holes = ((Length/11) < Holes) ? floor(Length/11) : Holes;//doesn't matter if 0
echo($holes);

build_plate(1,100,100);

//	build bracket
difference(){
	union() {
		translate([0,0,Thickness/2]) 
		cube([Length, Width, Thickness], center=true);
		translate([0,0,Thickness+0.6]) 
		cube([Length, 16, 1.2], center=true);
	}

	//calculate hole postion(s)
	translate([0,0,$cube_z_diff/2 -1]) 
	if($holes != 2){

		//centric hole
		cylinder(r=2.7, h=$cube_z_diff, center = true);

		if($holes == 3){
			translate([-Length/3,0,0]) 
			cylinder(r=2.7, h=$cube_z_diff, center = true);
			translate([Length/3,0,0])
			cylinder(r=2.7, h=$cube_z_diff, center = true); 
		}
	} else {
		translate([-Length/4,0,0]) 
		cylinder(r=2.7, h=$cube_z_diff, center = true);
		translate([Length/4,0,0])
		cylinder(r=2.7, h=$cube_z_diff, center = true); 
	} 
}
