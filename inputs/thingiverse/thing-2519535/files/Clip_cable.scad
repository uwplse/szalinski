//CUSTOMIZER VARIABLES
/* [Basic] */
//Table thickness (in mm)
Table_Thickness=20;//[5:100]
//Length (in mm)
Length=20;//[5:50]
//Clip thickness (in mm)
Clip_Thickness=2;//[1:6]
//Clip width (in mm)
Clip_Width=5;//[5:30]
//Max cable diameter (in mm)
Cable_Diameter=26;//[3:50]
// Smoothness
$fn = 50; //[30:100]


cube ([Clip_Thickness, Length + Clip_Thickness, Clip_Width]);

translate ([Table_Thickness+ Clip_Thickness + 1, 0, 0])
	cube ([Clip_Thickness, Length + Clip_Thickness, Clip_Width]);

cube ([Table_Thickness+ (Clip_Thickness * 3) + (Cable_Diameter / 2), Clip_Thickness, Clip_Width]);

translate ([Clip_Thickness - 0.3, (Length - 1) + Clip_Thickness, 0])
	cylinder(h = Clip_Width, r = 1);

translate ([Table_Thickness+ Clip_Thickness + 1.3, (Length - 1) + Clip_Thickness, 0])
	cylinder(h = Clip_Width, r = 1);

translate ([Table_Thickness+ (Clip_Thickness * 3) + (Cable_Diameter / 2), Cable_Diameter + (Clip_Thickness * 1.5), 0])
	cylinder(h = Clip_Width, r = (Clip_Thickness / 2));

translate ([Table_Thickness+ (Clip_Thickness * 3) + (Cable_Diameter / 2), (Cable_Diameter / 2) + Clip_Thickness, 0])
	difference ()
	{
		cylinder(h = Clip_Width, r = (Cable_Diameter / 2) + Clip_Thickness);

		translate ([0, 0, -0.5])
			cylinder(h = Clip_Width + 1, r = (Cable_Diameter / 2));

		translate ([((-Cable_Diameter) / 2) - Clip_Thickness, ((-Cable_Diameter) / 2), (-0.5)])
			cube([(Cable_Diameter / 2) + Clip_Thickness, Cable_Diameter + Clip_Thickness, Clip_Width + 1]);
	}