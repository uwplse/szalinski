/*
This file contains the Dyson mouthpiece. I've made it like a function so it can easily be used inside other projects. 
*/
module DysonMouthpiece(){
	DiaTubeOuter = 34;
	DiaTubeInner = 28.4;
	Dia = 30.7;
	HeightShaft = 10;
	HeightInner = 4.45;
	HeightTapper = 2.75;
	HeightTotal = 50;
    HeightShaft2 = HeightTotal - HeightShaft - HeightInner - HeightTapper;
	$fn = 100;

	difference(){
		union(){
			translate([0,0,(HeightShaft/2+HeightInner+HeightTapper+HeightShaft2)])cylinder(d=DiaTubeOuter, h=HeightShaft, center=true);
			color("red")translate([0,0,(HeightShaft2+HeightTapper+HeightInner/2)])cylinder(d=Dia, h=HeightInner, center=true);
			color("green")translate([0,0,(HeightTapper/2+HeightShaft2)])cylinder(d2=Dia+.1, d1=DiaTubeOuter, h=HeightTapper, center=true);
			color("purple")translate([0,0,HeightShaft2/2])cylinder(d=DiaTubeOuter, h=HeightShaft2, center=true);
		}
		cylinder(d=DiaTubeInner, h=150, center=true);
	}
}

DysonMouthpiece();