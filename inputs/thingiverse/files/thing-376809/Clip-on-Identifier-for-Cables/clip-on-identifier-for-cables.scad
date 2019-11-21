//Square Rod or Tubing Bracket
//Designed by Bryscus: Bryce B.

//Marker Height
MH=1.5;

//Cable Radius
CD=4;

//Wall thickness
WT=1;

//Opening (in degrees)
OD=60; //[10:160]

SLICE_SIZE=3.14*(CD)*2/360;

difference(){
	translate([0,0,MH/2])
		cylinder(h=MH, r=CD/2+WT,$fn=60,center=true); // screw hole
	translate([0,0,MH/2])
		cylinder(h=MH+1, r=CD/2,$fn=60,center=true); // screw hole
	for ( i = [1 : OD-1] )
	{
   	rotate(i, [0, 0, 1])
   	translate([(CD+1)/2, 0, (MH)/2])
   	cube([CD+1,SLICE_SIZE,MH+1], center=true);
	}
}