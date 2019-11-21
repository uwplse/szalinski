
//CUSTOMIZER VARIABLES
/* [Basic] */
//Table thickness
Table_Thickness=28;//[10:100]
//Length
Length=30;//[20:50]
//Clip thickness
Clip_Thickness=3;//[3:6]
//Clip width
Clip_Width=15;//[10:30]
//Max cable diameter
Cable_Diameter=10;//[3:20]
//CUSTOMIZER VARIABLES END

$fs=0.2;
cube ([Clip_Thickness,Length,Clip_Width]);
translate ([Table_Thickness+Clip_Thickness+1,0,0]) cube ([Clip_Thickness,Length,Clip_Width]);
cube ([Table_Thickness+Clip_Thickness*3+Cable_Diameter,Clip_Thickness,Clip_Width]);
translate ([Clip_Thickness-0.3,Length-1,0]) cylinder(h=Clip_Width,r=1);
translate ([Table_Thickness+Clip_Thickness+1.3,Length-1,0]) cylinder(h=Clip_Width,r=1);
translate ([Table_Thickness+Clip_Thickness*3+Cable_Diameter,Length-Clip_Thickness/2,0]) cylinder(h=Clip_Width,r=Clip_Thickness/2);
translate ([Table_Thickness+Clip_Thickness*3+Cable_Diameter,Length/2,0]) difference () {
	cylinder(h=Clip_Width,r=Length/2);
	translate ([0,0,-0.5])cylinder(h=Clip_Width+1,r=Length/2-Clip_Thickness);
	translate ([-Length/2,-Length/2,-0.5]) cube([Length/2,Length,Clip_Width+1]);
}