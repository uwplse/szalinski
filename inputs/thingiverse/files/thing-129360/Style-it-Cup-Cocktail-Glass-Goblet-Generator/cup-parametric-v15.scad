///////////////////////////////////////////////////////////////////////////
// Cup, goblet, cocktail glass  V1.5
//
// Copyright (C) 2013 Author: Lochner, Juergen
// Email: aabblapo@googlemail.com
// www.thingiverse.com/Ablapo
//
// Attribution-NonCommercial 3.0 Unported (CC BY-NC 3.0)
// http://creativecommons.org/licenses/by-nc/3.0/
//
// You are free: 
// 1. to Share - to copy, distribute and transmit the work
// 2. to Remix - to adapt the work
//
// Under the following conditions:
// 1. Attribution - You must attribute "Cup, goblet, cocktail glass" to Ablapo with link.
// 2. Noncommercial - You may not use this work for commercial purposes without the author's permission. 
///////////////////////////////////////////////////////////////////////////
// Attribution to HarlanDMii (http://www.thingiverse.com/HarlanDMii) for his write.scad (CC-BY-3.0) software
// Link to write.scad: http://www.thingiverse.com/thing:16193
// 

// Set your parameters:

/* Shape */

// Radius of the top bowl:
tr=8;		//	[1:100]

// Ratio of the stem:
mrp=10; // [5:100]

// Ratio of the base:
brp=80; // [5:120]

// Bottom cylinder height:
h0=0.5; // [0,0.3,0.5,0.7,1]

// Bottom cone height:
h1=5;	// [0:100]

// Stem cylinder height:
h2=6;	// [0:100]

// Lower curved bowl height:
h3=22;	// [0:100]

// Upper cylinder bowl height:
h4=2;	// [0:100]

// Cup's top edge height:
h5=0.5;	// [0:10]

// Upper part curve parameter:
kurve= 45 ; // [1:280]

// Bottom part curve parameter:
po=4;		//	[1:8]

// Wall thickness:
wall=0.6;	

// Edges per layer:
details=120;	//	[3:200]

/* Text */

// Custom text:
ctext="Happy Birthday!   Happy Birthday!   Happy Birthday!   Happy Birthday!";

// Text font:
textfont = "write/orbitron.dxf";//["write/Letters.dxf":Standard,"write/BlackRose.dxf":BlackRose,"write/orbitron.dxf":Orbitron,"write/knewave.dxf":Knewave,"write/braille.dxf":Braille]

// Text mode:
textmode = 2; // [1:Cut,2:Add]

// Text orientation:
textrota = 0; // [90:Up_Down,0:Left_Right]

// Text size scaler:
textscale=50 ; // [1:100]

b=tr*mrp/100;   // Stiel radius
br=tr*brp/100; 	// Base radius
$fn=details;

include <write/Write.scad>
//use <write.scad>
// usage:
//translate([0,0, h2+h3 ])  writecylinder(ctext,[0,0,0],tr-0.2,h4,t=wall,h=h4,rotate= 0, font=textfont);

manif=1.001*1;			// Overlapping segments for beeing manifold
mancu=0.0004*1;		// clears preview by overlaping cut segments

glass();
//htext=3*1;		// rectagle base , not used

module glass(){
	//	translate([0,0, -h1-h0-htext])  cylinder(h=htext,r=br/sin(45),center=false,$fn=4); // square base not used
	// h0: Sockel
		translate([0,0, -h1-h0 ])rotate([0,0,360/details/2*(details%2)]) cylinder(h=h0,r=br,center=false);

	// h1: Ständer
		mirror([0,0,1])	power(b,br ,h1, po );

	// h2:	Stiel
	   rotate([0,0,360/details/2*(details%2)]) cylinder(h=h2,r=b,center=false);
	
	// h3: unterer Korpus
		translate([0,0, h2 ])  
			difference(){
					sinus(b,tr,h3,kurve);
				translate([0,0,0.004])	sinus(b-wall,tr-wall,h3,kurve);
			}

	// h4: gerader Anteil, oberer Korpus
		translate([0,0, h2+h3 ])rotate([0,0,360/details/2*(details%2)])  
		difference(){
			union(){
				cylinder(h=h4,r=tr,center=false);
				if (textmode==2)  writecylinder(ctext,[0,0,0],tr-0.2,h4,t=wall,h=h4*textscale/100,rotate= textrota, font=textfont);
			}
			translate([0,0,-0.1])cylinder(h=h4+0.2,r=tr-wall,center=false);
			if (textmode==1)  writecylinder(ctext,[0,0,0],tr-0.0,h4,t=wall,h=h4*textscale/100,rotate= textrota, font=textfont);
		}

	// h5: obere Kante
		translate([0,0, h2+h3+h4 ]) rotate([0,0,360/details/2*(details%2)]) 
		difference(){
			cylinder(h=h5,r1=tr,r2=tr*0.97, center=false);
			translate([0,0,-0.002])cylinder(h=h5+0.004,r1=tr-wall,r2=(tr-wall)*1.2-wall,center=false);
		}

}


module power  (b=1, t=5, h=5, p=2){
	lay=100;
	slice=h/lay;					// height of each slice

	// Sorry for that long repeating code - I have found no other smooth solution!

 	rotate_extrude(convexity = 10)
	polygon(points=[
		[0,0],
			[b + (t-b)* pow(0/lay , p),0*slice],
			[b + (t-b)* pow(1/lay , p),1*slice],
			[b + (t-b)* pow(2/lay , p),2*slice],
			[b + (t-b)* pow(3/lay , p),3*slice],
			[b + (t-b)* pow(4/lay , p),4*slice],
			[b + (t-b)* pow(5/lay , p),5*slice], 
			[b + (t-b)* pow(6/lay , p),6*slice],
			[b + (t-b)* pow(7/lay , p),7*slice], 
			[b + (t-b)* pow(8/lay , p),8*slice],
			[b + (t-b)* pow(9/lay , p),9*slice],
			[b + (t-b)* pow(10/lay , p),10*slice],
			[b + (t-b)* pow(11/lay , p),11*slice],
			[b + (t-b)* pow(12/lay , p),12*slice],
			[b + (t-b)* pow(13/lay , p),13*slice],
			[b + (t-b)* pow(14/lay , p),14*slice],
			[b + (t-b)* pow(15/lay , p),15*slice], 
			[b + (t-b)* pow(16/lay , p),16*slice],
			[b + (t-b)* pow(17/lay , p),17*slice], 
			[b + (t-b)* pow(18/lay , p),18*slice],
			[b + (t-b)* pow(19/lay , p),19*slice],
			[b + (t-b)* pow(20/lay , p),20*slice],
			[b + (t-b)* pow(21/lay , p),21*slice],
			[b + (t-b)* pow(22/lay , p),22*slice],
			[b + (t-b)* pow(23/lay , p),23*slice],
			[b + (t-b)* pow(24/lay , p),24*slice],
			[b + (t-b)* pow(25/lay , p),25*slice], 
			[b + (t-b)* pow(26/lay , p),26*slice],
			[b + (t-b)* pow(27/lay , p),27*slice], 
			[b + (t-b)* pow(28/lay , p),28*slice],
			[b + (t-b)* pow(29/lay , p),29*slice],
			[b + (t-b)* pow(30/lay , p),30*slice],
			[b + (t-b)* pow(31/lay , p),31*slice],
			[b + (t-b)* pow(32/lay , p),32*slice],
			[b + (t-b)* pow(33/lay , p),33*slice],
			[b + (t-b)* pow(34/lay , p),34*slice],
			[b + (t-b)* pow(35/lay , p),35*slice], 
			[b + (t-b)* pow(36/lay , p),36*slice],
			[b + (t-b)* pow(37/lay , p),37*slice], 
			[b + (t-b)* pow(38/lay , p),38*slice],
			[b + (t-b)* pow(39/lay , p),39*slice],
			[b + (t-b)* pow(40/lay , p),40*slice],
			[b + (t-b)* pow(41/lay , p),41*slice],
			[b + (t-b)* pow(42/lay , p),42*slice],
			[b + (t-b)* pow(43/lay , p),43*slice],
			[b + (t-b)* pow(44/lay , p),44*slice],
			[b + (t-b)* pow(45/lay , p),45*slice], 
			[b + (t-b)* pow(46/lay , p),46*slice],
			[b + (t-b)* pow(47/lay , p),47*slice], 
			[b + (t-b)* pow(48/lay , p),48*slice],
			[b + (t-b)* pow(49/lay , p),49*slice],
			[b + (t-b)* pow(50/lay , p),50*slice],
			[b + (t-b)* pow(51/lay , p),51*slice],
			[b + (t-b)* pow(52/lay , p),52*slice],
			[b + (t-b)* pow(53/lay , p),53*slice],
			[b + (t-b)* pow(54/lay , p),54*slice],
			[b + (t-b)* pow(55/lay , p),55*slice], 
			[b + (t-b)* pow(56/lay , p),56*slice],
			[b + (t-b)* pow(57/lay , p),57*slice], 
			[b + (t-b)* pow(58/lay , p),58*slice],
			[b + (t-b)* pow(59/lay , p),59*slice],
			[b + (t-b)* pow(60/lay , p),60*slice],
			[b + (t-b)* pow(61/lay , p),61*slice],
			[b + (t-b)* pow(62/lay , p),62*slice],
			[b + (t-b)* pow(63/lay , p),63*slice],
			[b + (t-b)* pow(64/lay , p),64*slice],
			[b + (t-b)* pow(65/lay , p),65*slice], 
			[b + (t-b)* pow(66/lay , p),66*slice],
			[b + (t-b)* pow(67/lay , p),67*slice], 
			[b + (t-b)* pow(68/lay , p),68*slice],
			[b + (t-b)* pow(69/lay , p),69*slice],
			[b + (t-b)* pow(70/lay , p),70*slice],
			[b + (t-b)* pow(71/lay , p),71*slice],
			[b + (t-b)* pow(72/lay , p),72*slice],
			[b + (t-b)* pow(73/lay , p),73*slice],
			[b + (t-b)* pow(74/lay , p),74*slice],
			[b + (t-b)* pow(75/lay , p),75*slice], 
			[b + (t-b)* pow(76/lay , p),76*slice],
			[b + (t-b)* pow(77/lay , p),77*slice], 
			[b + (t-b)* pow(78/lay , p),78*slice],
			[b + (t-b)* pow(79/lay , p),79*slice],
			[b + (t-b)* pow(80/lay , p),80*slice],
			[b + (t-b)* pow(81/lay , p),81*slice],
			[b + (t-b)* pow(82/lay , p),82*slice],
			[b + (t-b)* pow(83/lay , p),83*slice],
			[b + (t-b)* pow(84/lay , p),84*slice],
			[b + (t-b)* pow(85/lay , p),85*slice], 
			[b + (t-b)* pow(86/lay , p),86*slice],
			[b + (t-b)* pow(87/lay , p),87*slice], 
			[b + (t-b)* pow(88/lay , p),88*slice],
			[b + (t-b)* pow(89/lay , p),89*slice],
			[b + (t-b)* pow(90/lay , p),90*slice],
			[b + (t-b)* pow(91/lay , p),91*slice],
			[b + (t-b)* pow(92/lay , p),92*slice],
			[b + (t-b)* pow(93/lay , p),93*slice],
			[b + (t-b)* pow(94/lay , p),94*slice],
			[b + (t-b)* pow(95/lay , p),95*slice], 
			[b + (t-b)* pow(96/lay , p),96*slice],
			[b + (t-b)* pow(97/lay , p),97*slice], 
			[b + (t-b)* pow(98/lay , p),98*slice],
			[b + (t-b)* pow(99/lay , p),99*slice],
			[b + (t-b)* pow(100/lay , p),100*slice],
		[0,100*slice],
		], paths=[[0,1,2,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102]]);
}




module sinus (b=4, t=1, h=5, k=180){
	lay=100;
	slice = h/lay;				// height of each slice
	c = -cos(k);  					// (cos(k)+c)*a=0
	a = (b-t)/(1+c); 				// (cos(0)+c)*a=b-t

	// Sorry for that long repeating code - I have found no other smooth solution!

	rotate_extrude(convexity = 10)
	polygon(points=[
		[0,0],
			[t + a*(cos( 0 /lay  *k)+ c),0*slice],
			[t + a*(cos( 1 /lay  *k)+ c),1*slice],
			[t + a*(cos( 2 /lay  *k)+ c),2*slice],
			[t + a*(cos( 3 /lay  *k)+ c),3*slice],
			[t + a*(cos( 4 /lay  *k)+ c),4*slice],
			[t + a*(cos( 5 /lay  *k)+ c),5*slice], 
			[t + a*(cos( 6 /lay  *k)+ c),6*slice],
			[t + a*(cos( 7 /lay  *k)+ c),7*slice], 
			[t + a*(cos( 8 /lay  *k)+ c),8*slice],
			[t + a*(cos( 9 /lay  *k)+ c),9*slice],
			[t + a*(cos( 10 /lay  *k)+ c),10*slice],
			[t + a*(cos( 11 /lay  *k)+ c),11*slice],
			[t + a*(cos( 12 /lay  *k)+ c),12*slice],
			[t + a*(cos( 13 /lay  *k)+ c),13*slice],
			[t + a*(cos( 14 /lay  *k)+ c),14*slice],
			[t + a*(cos( 15 /lay  *k)+ c),15*slice], 
			[t + a*(cos( 16 /lay  *k)+ c),16*slice],
			[t + a*(cos( 17 /lay  *k)+ c),17*slice], 
			[t + a*(cos( 18 /lay  *k)+ c),18*slice],
			[t + a*(cos( 19 /lay  *k)+ c),19*slice],
			[t + a*(cos( 20 /lay  *k)+ c),20*slice],
			[t + a*(cos( 21 /lay  *k)+ c),21*slice],
			[t + a*(cos( 22 /lay  *k)+ c),22*slice],
			[t + a*(cos( 23 /lay  *k)+ c),23*slice],
			[t + a*(cos( 24 /lay  *k)+ c),24*slice],
			[t + a*(cos( 25 /lay  *k)+ c),25*slice], 
			[t + a*(cos( 26 /lay  *k)+ c),26*slice],
			[t + a*(cos( 27 /lay  *k)+ c),27*slice], 
			[t + a*(cos( 28 /lay  *k)+ c),28*slice],
			[t + a*(cos( 29 /lay  *k)+ c),29*slice],
			[t + a*(cos( 30 /lay  *k)+ c),30*slice],
			[t + a*(cos( 31 /lay  *k)+ c),31*slice],
			[t + a*(cos( 32 /lay  *k)+ c),32*slice],
			[t + a*(cos( 33 /lay  *k)+ c),33*slice],
			[t + a*(cos( 34 /lay  *k)+ c),34*slice],
			[t + a*(cos( 35 /lay  *k)+ c),35*slice], 
			[t + a*(cos( 36 /lay  *k)+ c),36*slice],
			[t + a*(cos( 37 /lay  *k)+ c),37*slice], 
			[t + a*(cos( 38 /lay  *k)+ c),38*slice],
			[t + a*(cos( 39 /lay  *k)+ c),39*slice],
			[t + a*(cos( 40 /lay  *k)+ c),40*slice],
			[t + a*(cos( 41 /lay  *k)+ c),41*slice],
			[t + a*(cos( 42 /lay  *k)+ c),42*slice],
			[t + a*(cos( 43 /lay  *k)+ c),43*slice],
			[t + a*(cos( 44 /lay  *k)+ c),44*slice],
			[t + a*(cos( 45 /lay  *k)+ c),45*slice], 
			[t + a*(cos( 46 /lay  *k)+ c),46*slice],
			[t + a*(cos( 47 /lay  *k)+ c),47*slice], 
			[t + a*(cos( 48 /lay  *k)+ c),48*slice],
			[t + a*(cos( 49 /lay  *k)+ c),49*slice],
			[t + a*(cos( 50 /lay  *k)+ c),50*slice],
			[t + a*(cos( 51 /lay  *k)+ c),51*slice],
			[t + a*(cos( 52 /lay  *k)+ c),52*slice],
			[t + a*(cos( 53 /lay  *k)+ c),53*slice],
			[t + a*(cos( 54 /lay  *k)+ c),54*slice],
			[t + a*(cos( 55 /lay  *k)+ c),55*slice], 
			[t + a*(cos( 56 /lay  *k)+ c),56*slice],
			[t + a*(cos( 57 /lay  *k)+ c),57*slice], 
			[t + a*(cos( 58 /lay  *k)+ c),58*slice],
			[t + a*(cos( 59 /lay  *k)+ c),59*slice],
			[t + a*(cos( 60 /lay  *k)+ c),60*slice],
			[t + a*(cos( 61 /lay  *k)+ c),61*slice],
			[t + a*(cos( 62 /lay  *k)+ c),62*slice],
			[t + a*(cos( 63 /lay  *k)+ c),63*slice],
			[t + a*(cos( 64 /lay  *k)+ c),64*slice],
			[t + a*(cos( 65 /lay  *k)+ c),65*slice], 
			[t + a*(cos( 66 /lay  *k)+ c),66*slice],
			[t + a*(cos( 67 /lay  *k)+ c),67*slice], 
			[t + a*(cos( 68 /lay  *k)+ c),68*slice],
			[t + a*(cos( 69 /lay  *k)+ c),69*slice],
			[t + a*(cos( 70 /lay  *k)+ c),70*slice],
			[t + a*(cos( 71 /lay  *k)+ c),71*slice],
			[t + a*(cos( 72 /lay  *k)+ c),72*slice],
			[t + a*(cos( 73 /lay  *k)+ c),73*slice],
			[t + a*(cos( 74 /lay  *k)+ c),74*slice],
			[t + a*(cos( 75 /lay  *k)+ c),75*slice], 
			[t + a*(cos( 76 /lay  *k)+ c),76*slice],
			[t + a*(cos( 77 /lay  *k)+ c),77*slice], 
			[t + a*(cos( 78 /lay  *k)+ c),78*slice],
			[t + a*(cos( 79 /lay  *k)+ c),79*slice],
			[t + a*(cos( 80 /lay  *k)+ c),80*slice],
			[t + a*(cos( 81 /lay  *k)+ c),81*slice],
			[t + a*(cos( 82 /lay  *k)+ c),82*slice],
			[t + a*(cos( 83 /lay  *k)+ c),83*slice],
			[t + a*(cos( 84 /lay  *k)+ c),84*slice],
			[t + a*(cos( 85 /lay  *k)+ c),85*slice], 
			[t + a*(cos( 86 /lay  *k)+ c),86*slice],
			[t + a*(cos( 87 /lay  *k)+ c),87*slice], 
			[t + a*(cos( 88 /lay  *k)+ c),88*slice],
			[t + a*(cos( 89 /lay  *k)+ c),89*slice],
			[t + a*(cos( 90 /lay  *k)+ c),90*slice],
			[t + a*(cos( 91 /lay  *k)+ c),91*slice],
			[t + a*(cos( 92 /lay  *k)+ c),92*slice],
			[t + a*(cos( 93 /lay  *k)+ c),93*slice],
			[t + a*(cos( 94 /lay  *k)+ c),94*slice],
			[t + a*(cos( 95 /lay  *k)+ c),95*slice], 
			[t + a*(cos( 96 /lay  *k)+ c),96*slice],
			[t + a*(cos( 97 /lay  *k)+ c),97*slice], 
			[t + a*(cos( 98 /lay  *k)+ c),98*slice],
			[t + a*(cos( 99 /lay  *k)+ c),99*slice],
			[t + a*(cos( 100 /lay  *k)+ c),100*slice],
		[0,100*slice],
		], paths=[[0,1,2,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102]]);
}



