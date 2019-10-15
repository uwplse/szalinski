/*
jab - has fix to prevent occlusion when 2nd gear has even tooth count
*/


use <MCAD/involute_gears.scad>

// dummy arg to workaround customizer bug where first arg changes do not show in preview window
ignore_this=0;

// Which one would you like to see?
part = 0; // [0:Both Gears, 1:1st Gear Only, 2:2nd Gear Only]

// The number of teeth in the 1st gear
gear1_teeth = 12;

// The number of teeth in the 2nd gear 
gear2_teeth = 36;

// The desired angle between the input and output shafts, Use .001 for virtually flat gears. 
axis_angle = 45;  

// Controls the relative gear thickness and relative circumference.  Use lower values for thicker gears.
outside_circular_pitch =  1000;  

// size of the center holes.  Use 0 for no center holes.
bore_diameter = 0; 

// Controls tooth shape. Lower value for more aggressive engagement, higher for stronger teeth.
pressure_angle = 20;  //[14.5,20,25,30] 

// ///which_gear_to_generate = 0; //[0:Both,1:1st only,2:2nd only]


bevel_gear_pair_v2( gear1_teeth = gear1_teeth
		, gear2_teeth = gear2_teeth
		, axis_angle = axis_angle
		, outside_circular_pitch = outside_circular_pitch
		, bore_diameter = bore_diameter
		, pressure_angle = pressure_angle
		, part = part
);

module bevel_gear_pair_v2( gear1_teeth = 41,
	gear2_teeth = 7,
	axis_angle = 90,
	outside_circular_pitch=1000
	, bore_diameter = 0
	, pressure_angle = 30
	, part = 0	// jab
	)

{
	outside_pitch_radius1 = gear1_teeth * outside_circular_pitch / 360;
	outside_pitch_radius2 = gear2_teeth * outside_circular_pitch / 360;

	pitch_apex1=outside_pitch_radius2 * sin (axis_angle) +
		(outside_pitch_radius2 * cos (axis_angle) + outside_pitch_radius1) / tan (axis_angle);

	cone_distance = sqrt (pow (pitch_apex1, 2) + pow (outside_pitch_radius1, 2));
	pitch_apex2 = sqrt (pow (cone_distance, 2) - pow (outside_pitch_radius2, 2));

	//echo ("cone_distance", cone_distance);

	pitch_angle1 = asin (outside_pitch_radius1 / cone_distance);
	pitch_angle2 = asin (outside_pitch_radius2 / cone_distance);

	//echo ("pitch_angle1, pitch_angle2", pitch_angle1, pitch_angle2);
	//echo ("pitch_angle1 + pitch_angle2", pitch_angle1 + pitch_angle2);

    fix_occlude = gear2_teeth % 2 ? 0 : 180.0 / gear1_teeth;
    //echo ("fix_occlude", fix_occlude);

	rotate([0,0,90])
	translate ([0,0,pitch_apex1+20])
	{
		translate([0,0,-pitch_apex1])
        rotate([0,0,-fix_occlude])

		if (part != 2)  // jab
		{
		bevel_gear (
			number_of_teeth=gear1_teeth,
			cone_distance=cone_distance,
			pressure_angle=pressure_angle,
			outside_circular_pitch=outside_circular_pitch
			, bore_diameter=bore_diameter  // jab
			);
		}
        //rotate([0,0,fix_occlude])  not needed, causes 
		rotate([0,-(pitch_angle1+pitch_angle2),0])
		translate([0,0,-pitch_apex2])

		if (part != 1) // jab
		{
		bevel_gear (
			number_of_teeth=gear2_teeth,
			cone_distance=cone_distance,
			pressure_angle=pressure_angle,
			outside_circular_pitch=outside_circular_pitch
			, bore_diameter=bore_diameter  // jab
);
		}
	}

}


//translate([0,0,-.5]){
//	if(00_build_plate == 0){
//		%cube([285,153,1],center = true);
//	}
//	if(00_build_plate == 1){
//		%cube([225,145,1],center = true);
//	}
//	if(00_build_plate == 3){
//		%cube([120,120,1],center = true);
//	}
//
//}