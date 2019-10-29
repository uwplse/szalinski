//Square Rod or Tubing Bracket
//Designed by Bryscus: Bryce B.

//Number of Holes
Num_Holes=1; //[1:2]

//Extension Distance
ED=20;

//Tubing Width
TW=19.5;

//Tubing Slot Wall Thickness
WT=5;

//Screw Hole Radius
SHR=2.4;

//(1 Hole) Screw Head Size (radius)
SHS=3.5;

//(1 Hole) Screw Head Depth
SHD=2.5;

//(2 Holes) Screw Bracket Oversizing
SBO=0;

//(2 Holes) Screw Bracket Tab Length
TL=20;

//(2 Holes) Screw Distance
SD=9;

//Mount Thickness
MT=4;

//(2 Holes) Screw Bracket Fillet Radius
FR=5;

if(Num_Holes == 1)
{
rotate([0,0,180])
difference(){
translate([0,0,ED/2+MT/2])
	cube([TW+(WT*2), TW+WT, ED+MT],center=true);
translate([0,MT/2,MT/2])
	cylinder(h=MT+5, r=SHR,$fn=50,center=true); // screw hole
translate([0,MT/2,MT-SHD])
	cylinder(h=SHD+1, r=SHS,$fn=50); // screw head hole
translate([0,WT,(ED+5)/2+MT])
	cube([TW,TW+WT,ED+5],center=true);
}
}

if(Num_Holes == 2)
{
rotate([0,0,180])
difference(){
union(){
	translate([-(TW+(WT*2)+SBO*2-FR*2)/2,-(TW+WT*2+(TL-FR)*2)/2,0]) 
	minkowski(){
		cube([TW+(WT*2)+SBO*2-FR*2,TW+WT*2+(TL-FR)*2,MT/2]); // Screw Bracket
		cylinder(r=FR, h=MT/2,$fn=50);
	}
	translate([0,0,ED/2+MT])
		cube([TW+(WT*2), TW+WT*2, ED],center=true); //Tube Holder Outside
}
translate([0,TL/2+WT+TW/2,MT/2])  //TW+SD
	cylinder(h=MT+5, r=SHR,$fn=50,center=true); //screw hole
translate([0,-(TL/2+WT+TW/2),MT/2])  //-(TL/2+TW/4+WT/2)
	cylinder(h=MT+5, r=SHR,$fn=50,center=true); // screw hole
translate([0,WT,(ED+5)/2+MT])
	cube([TW,TW+WT*2,ED+5],center=true); //tubing opening
}
}

