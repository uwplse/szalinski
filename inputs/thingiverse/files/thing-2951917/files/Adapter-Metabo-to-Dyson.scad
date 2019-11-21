/*
This file contains the parameterized code to make a coupling between a Metabo table saw (TS 254) and a Dyson CD39 vacuum tube.
	All parameters can be changed, but these fit the Dyson tube and Metabo adapter perfect. 
I made the adapter for the Metabo part a little bit bigger so it would fit the Metabo part very easy and would not damage the adapter.
*/
/*********************************************************************************************************************
												Parameters
*********************************************************************************************************************/
// General
$fn = 100;
Thickness = 3;

// Dyson
DiaTubeOuter = 34;
DiaTubeInner = 28.4;

// Funnel
DiaFunnelIn = 39;
DiaFunnelOut = DiaFunnelIn + Thickness;
FunnelHeight = 25;

/*********************************************************************************************************************
												Functions
*********************************************************************************************************************/
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

/*********************************************************************************************************************
												Code
*********************************************************************************************************************/
union(){
	DysonMouthpiece();
	// Funnel
	translate([0,0,-FunnelHeight/4])difference(){
		cylinder(d2=DiaTubeOuter, d1=DiaFunnelOut, h=FunnelHeight/2, center=true);
		cylinder(d2=DiaTubeInner, d1=DiaFunnelOut-Thickness, h=FunnelHeight/1.99, center=true);
	}
	// Adapter
	translate([0,0,-FunnelHeight])difference(){	
		cylinder(d=DiaFunnelOut, h=FunnelHeight, center=true);
		cylinder(d=DiaFunnelIn, h=FunnelHeight*3, center=true);
	}
}
