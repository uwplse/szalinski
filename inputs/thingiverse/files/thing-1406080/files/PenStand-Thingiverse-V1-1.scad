// Customizable Pen Stand v1.0 by EKOBEAN


//Menu Area Cor Customizer
//	Resolution 
Resolution = 0;	//	[20:100]
//	Height of the Stand
Height = 100;	//	[40:220]
//	Radius of the Stand
Radius = 40;	//	[40:110]
//	Base Thickness !
Base_Thickness = 5;	//	[2:10]
//	Spiral Cross Section Thickness
Spiral_Thickness = 1;	//	[1:10]
//	Number of Spirals
Spiral_Number = 70;	//	[20:200]
//	Twist of the first spiral
Spiral1_Slope = 20;	//	[0:100]
//	Twist of the second spiral
Spiral2_Slope = 20;	//	[0:100]

//Script for the Pen Stand !
$fn=(Resolution);

translate ([0,0,Base_Thickness/2])
cylinder(r=Radius,h=Base_Thickness, center=true );
translate ([0,0,Base_Thickness/2])
rotate_extrude(){
translate ([Radius,0,0])
circle(r=Base_Thickness/2, center=true);}
translate ([0,0,Height])
rotate_extrude(){
translate ([Radius,0,0])
circle(r=Base_Thickness/2, center=true);}
translate ([0,0,Height/95])
for(r=[0:(360/Spiral_Number):360]){
rotate ([0,0,r])
linear_extrude (height=Height,twist=Spiral1_Slope)
translate ([Radius,0,0])
circle(Spiral_Thickness);}
translate ([0,0,Height/95])
for(r=[0:(360/Spiral_Number):360]){
rotate ([0,0,r])
linear_extrude (height=Height,twist=-Spiral2_Slope)
translate ([Radius,0,0])
circle(Spiral_Thickness);}