// Customizable Belt Loop v1.0 by EKOBEAN


//Menu Area Cor Customizer
//Inside Width
Hole_Width = 5; // [3:15]
//Inside Length
Hole_Lenght = 41; // [15:60]
//Width
Width = 12; // [5:35]
//Loop Thickness
Thickness = 2; // [2:6]

//Script for Belt Loop !
difference() { 
 linear_extrude(height = Width)
 square([Hole_Width+Thickness,Hole_Lenght+Thickness], center=true); //outside
 linear_extrude(height = Width)
 square([Hole_Width,Hole_Lenght], center=true); //hole
}