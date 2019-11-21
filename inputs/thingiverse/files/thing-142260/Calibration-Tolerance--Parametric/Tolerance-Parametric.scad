//-----------Setup-----------//

//The total print height.
cubeHeight =3;

//The side of the squares.
cubeSide =8;

//The tolrance you want to test (distance between cubes).
tolerance =0.7;

//The second tolrance you want to test.
tolerance2 =0.5;

//-------End of setup-------//

//Disable $fn and $fa
$fn=0;
$fa=0.01;

//Use only $fs
//fine
$fs=0.25;

translate = cubeSide + tolerance;
translate2 = cubeSide + tolerance2;

markerTranslate = cubeSide + cubeSide/2 + tolerance2;

cube([cubeSide, cubeSide, cubeHeight]);

	translate([0, translate2, 0])
	{
		cube([cubeSide, cubeSide, cubeHeight]);
	}
	
	translate([translate2, 0, 0])
	{
		cube([cubeSide, cubeSide, cubeHeight]);
	}

	translate([translate*-1, 0, 0])
	{
		cube([cubeSide, cubeSide, cubeHeight]);
	}
	
	translate([0, translate*-1, 0])
	{
		cube([cubeSide, cubeSide, cubeHeight]);
	}

	translate([markerTranslate, markerTranslate, 0])
	{
		cylinder(2, cubeSide/2-1, cubeSide/2-1);
	}

