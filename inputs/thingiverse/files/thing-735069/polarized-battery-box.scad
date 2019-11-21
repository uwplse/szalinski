/* Created by Heindal at Thingiverse and inspired by the design by flummer

User Variables - Change to fit your battery
 */
// Number of batteries
Cell_Count = 2; // [1:6]

// Battery Size
Battery_Size = 0; // [0:AA, 1:16340 lithium, 2:18650 lithium]

// Distance between mounting holes
Mount_Hole_X_Spacing = 40; // [30:60]

/* [Hidden] */
// for the customizer - please edit here for custom values
// Overall length including positive button
Length_Options = [50,37.4,71];
Battery_Length = Length_Options[Battery_Size]; // [37.4:xx340 lithium, 50:AA, 71:xx650 lithium]

// Diameter of the body of the battery plus 1mm for clearance
Dia_Options = [15,17,19];
Battery_Dia = Dia_Options[Battery_Size];// [15:AA, 17:16xxx lithium, 19:18xxx lithium] 

// Diameter of the positive side button at the base
Button_Dia = 8; // [8:AA and 18650 and 16340, 17:26650]

// Height of the button - 0.8 works for most everything
Button_Height = 0.8; 

/*
Fixed and Calculated Dimensions - alter at your own risk
*/
//clip dimensions for Keystone 1107-1 
Clip_Width = 7; //overall width of clip
Clip_Below_Center = 10; //distance inserted part of clip extends below center of the battery
Clip_Above_Center = 5;
Clip_Compressed = 3;
Clip_Uncompressed = 4-0.5;
Tab_Width = 4;
// Dimensions of holder 
Mid_Height = Battery_Dia/2+2;
Mid_End_Height = Mid_Height + Clip_Above_Center;
End_Height = Mid_Height + Battery_Dia/2;


module battery_box(cells)
{	
union () 
	{
				// polarizing tabs for positive terminal
	for (i=[0:(cells-1)])
		{
		if (i%2 == 0) { // is even
			translate([Battery_Length/2+Clip_Compressed-(Clip_Uncompressed+Button_Height)/2, -(cells-1)*Battery_Dia/2+i*Battery_Dia+(Button_Dia+Battery_Dia)/4, Mid_End_Height/2])
				cube(size=[(Clip_Uncompressed+Button_Height), (Battery_Dia-Button_Dia)/2, Mid_End_Height], center=true);
			translate([Battery_Length/2+Clip_Compressed-(Clip_Uncompressed+Button_Height)/2, -(cells-1)*Battery_Dia/2+i*Battery_Dia-(Button_Dia+Battery_Dia)/4, Mid_End_Height/2])
				cube(size=[(Clip_Uncompressed+Button_Height), (Battery_Dia-Button_Dia)/2, Mid_End_Height], center=true);
		}
		else { // if odd flip to the other side of the holder
			translate([-Battery_Length/2-Clip_Compressed+(Clip_Uncompressed+Button_Height)/2, -(cells-1)*Battery_Dia/2+i*Battery_Dia+(Button_Dia+Battery_Dia)/4, Mid_End_Height/2])
				cube(size=[(Clip_Uncompressed+Button_Height), (Battery_Dia-Button_Dia)/2, Mid_End_Height], center=true);
			translate([-Battery_Length/2-Clip_Compressed+(Clip_Uncompressed+Button_Height)/2, -(cells-1)*Battery_Dia/2+i*Battery_Dia-(Button_Dia+Battery_Dia)/4, Mid_End_Height/2])
				cube(size=[(Clip_Uncompressed+Button_Height), (Battery_Dia-Button_Dia)/2, Mid_End_Height], center=true);
		}
		}

	difference()
	{
		union()
		{	// body of battery holder
			translate([0, 0, Mid_Height/2])
				cube(size=[Battery_Length+2*(Clip_Compressed-1.5+4), Battery_Dia*cells+2, Mid_Height], center=true);
	
			translate([Battery_Length/2+(Clip_Compressed-1.5)+2+2/2, 0, End_Height/2])
				cube(size=[2, Battery_Dia*cells+2, End_Height], center=true);

			translate([-(Battery_Length/2+(Clip_Compressed-1.5)+2+2/2), 0, End_Height/2])
				cube(size=[2, Battery_Dia*cells+2, End_Height], center=true);

			translate([-(Battery_Length/2+(Clip_Compressed-1.5)+2/2), 0, Mid_End_Height/2])
				cube(size=[2, Battery_Dia*cells+2, Mid_End_Height], center=true);

			translate([(Battery_Length/2+(Clip_Compressed-1.5)+2/2), 0, Mid_End_Height/2])
				cube(size=[2, Battery_Dia*cells+2, Mid_End_Height], center=true);
			
			// mounting flanges	
			translate([Mount_Hole_X_Spacing/2, cells*Battery_Dia/2+4/2, 3/2])
				cube(size=[7, 4, 3], center=true);

			translate([Mount_Hole_X_Spacing/2, cells*Battery_Dia/2+4, 3/2])
				cylinder(r=7/2, h=3, center=true, $fn = 60);

			translate([-Mount_Hole_X_Spacing/2, cells*Battery_Dia/2+4/2, 3/2])
				cube(size=[7, 4, 3], center=true);

			translate([-Mount_Hole_X_Spacing/2, cells*Battery_Dia/2+4, 3/2])
				cylinder(r=7/2, h=3, center=true, $fn = 60);

			translate([Mount_Hole_X_Spacing/2, -(cells*Battery_Dia/2+4/2), 3/2])
				cube(size=[7, 4, 3], center=true);

			translate([Mount_Hole_X_Spacing/2, -(cells*Battery_Dia/2+4), 3/2])
				cylinder(r=7/2, h=3, center=true, $fn = 60);

			translate([-Mount_Hole_X_Spacing/2, -(cells*Battery_Dia/2+4/2), 3/2])
				cube(size=[7, 4, 3], center=true);

			translate([-Mount_Hole_X_Spacing/2, -(cells*Battery_Dia/2+4), 3/2])
				cylinder(r=7/2, h=3, center=true, $fn = 60);
		}
		
		for (i=[0:cells-1])
		{
			// battery cradle
			translate([0, -cells*Battery_Dia/2+Battery_Dia/2+Battery_Dia*i, Mid_Height])
			rotate(90, [0, 1, 0])
				cylinder(r=Battery_Dia/2-0.01, h=Battery_Length+2*(Clip_Compressed-1.5), center=true, $fn = 100);
			
			// spring cut-out
			translate([Battery_Length/2+Clip_Compressed, -cells*Battery_Dia/2+Battery_Dia/2+Battery_Dia*i, Mid_End_Height/2])
				cube(size=[1, Clip_Width, 30], center=true);

			translate([Battery_Length/2+Clip_Compressed+10/2, -cells*Battery_Dia/2+Battery_Dia/2+Battery_Dia*i, Mid_Height+30/2])
				cube(size=[10, Tab_Width, 30], center=true);

			translate([-(Battery_Length/2+Clip_Compressed), -cells*Battery_Dia/2+Battery_Dia/2+Battery_Dia*i, Mid_Height])
				cube(size=[1, Clip_Width, 30], center=true);

			translate([-(Battery_Length/2+Clip_Compressed+10/2), -cells*Battery_Dia/2+Battery_Dia/2+Battery_Dia*i, Mid_Height+30/2])
				cube(size=[10, Tab_Width, 30], center=true);
		if (i%2 == 0 ) { // is even
	// polarity marking (+)
			translate([2*Battery_Length/5, -cells*Battery_Dia/2+Battery_Dia/2+Battery_Dia*i, Mid_Height-Battery_Dia/2+1.25])
				cube(size=[6, 2, 4], center=true);

			translate([2*Battery_Length/5, -cells*Battery_Dia/2+Battery_Dia/2+Battery_Dia*i, Mid_Height-Battery_Dia/2+1.25])
				cube(size=[2, 6, 4], center=true);

			// polarity marking (-)
			translate([-2*Battery_Length/5, -cells*Battery_Dia/2+Battery_Dia/2+Battery_Dia*i, Mid_Height-Battery_Dia/2+1.25])
				cube(size=[6, 2, 4], center=true);
		}
		else { // if odd switch to opposite side
	// polarity marking (+)
			translate([-2*Battery_Length/5, -cells*Battery_Dia/2+Battery_Dia/2+Battery_Dia*i, Mid_Height-Battery_Dia/2+1.25])
				cube(size=[6, 2, 4], center=true);

			translate([-2*Battery_Length/5, -cells*Battery_Dia/2+Battery_Dia/2+Battery_Dia*i, Mid_Height-Battery_Dia/2+1.25])
				cube(size=[2, 6, 4], center=true);

			// polarity marking (-)
			translate([2*Battery_Length/5, -cells*Battery_Dia/2+Battery_Dia/2+Battery_Dia*i, Mid_Height-Battery_Dia/2+1.25])
				cube(size=[6, 2, 4], center=true);
		}

		}
		
		// mounting holes
		translate([Mount_Hole_X_Spacing/2, cells*Battery_Dia/2+4, 3/2])
			cylinder(r=3.3/2, h=4, center=true, $fn = 30);

		translate([-Mount_Hole_X_Spacing/2, cells*Battery_Dia/2+4, 3/2])
			cylinder(r=3.3/2, h=4, center=true, $fn = 30);

		translate([Mount_Hole_X_Spacing/2, -(cells*Battery_Dia/2+4), 3/2])
			cylinder(r=3.3/2, h=4, center=true, $fn = 30);

		translate([-Mount_Hole_X_Spacing/2, -(cells*Battery_Dia/2+4), 3/2])
			cylinder(r=3.3/2, h=4, center=true, $fn = 30);

		// cutout to ease battery removal
		translate([0, 0, End_Height/2+Mid_Height/2])
		rotate(90, [1, 0, 0])
			cylinder(r=End_Height/2, h=cells*Battery_Dia+5, center=true, $fn = 100);

		}
	}
}

battery_box(Cell_Count);