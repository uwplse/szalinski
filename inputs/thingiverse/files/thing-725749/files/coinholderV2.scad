/*=========================================
Program Name :	Euro Coin Holder
Base Language:		English
Created by   :	Esmarra
Creation Date:	22/01/2015
Rework date entries:
	31/01/2015
	10/03/2015 Fixed trigonometry issue, added extra pillars
	16/03/2015 Upgraded Design to Makerbot Customizer
	20/03/2015 Patched Pillar Radius / some pillars not displaying / box_d issue
	22/03/2015 Started Developing Numbers With next 2015 text() function 
	15/07/2015 Implemented Semi-Modular Coin Selection ( example: Print 1Euro,50Cent,20Cent only )
	13/09/2017 Added Orientation in Display Numbers feature ( Dumb way to do it, but it will do ) <-- Readress if needed
	
Program Objectives:
Observations:
	In pillars() trigonometry rules are inverted due to the angle being 180 - angle
Special Thanks:
=========================================*/

// preview[view:south west, tilt:top diagonal]

// How thick should the outside box be?
box_d = 20 ;
// Printed at 20

// How High should the outside box be?
box_h = 50 ;
// Printed at 50

// Select the Row for the Starting Coin ( 1 = 2Euro)
starting_row = 1 ; // [1:8]
// Goes from 1 - 8 (2Euro to 1Cent)

// Select the Row for the End Coin ( 3 = 50cent )
end_row = 8 ; // [1:8]


// Goes from 0 - 8 (2Euro to 1Cent) Number of rows = number of coins slot Printed at 3 + 3

// Inclination
angle = 70 ;
// Printed at 50 --> best results at 60

// Space Between Coins
wall = 3 ;
// Printed at 3

// Pillar Radius
pillar_r = 5 ;
// Printed at 5

// Pillar Distance from Edge
pillar_distance = 3 ; 
// Distance of pillar to the edge ( x axis only! )

//Printer threshold ( + if coins don't fit )
thr = 1 ;
// Printed at 1

// Preview Mode, Set to OFF when finished Customizing your part
Preview = 1 ; // [0:OFF,1:ON]

// Number's Size
car_size = 10  ;
// ideal 10 ?

// Display Number on Bottom
Display = 1 ; // [0:OFF,1:ON]

// Display Number Orientation
Orientation= 90 ; // [0:Down,90:UP]

/* [Hidden] */

Print = 1 - Preview ;

Debug = 0 ;

// ====	Euro Coins  parameters	====

d_2 = 25.75 + thr ;	 // 2 Euro
d_1 = 23.25 + thr ;	 // 1 Euro
d_05 = 24.25 + thr ;	 // 50 cents
d_02 = 22.25 + thr ;	 //20 cents
d_01 = 19.75 + thr ;	 // 10 cents
d_005 = 21.25 + thr ;	 // 5 cents
d_002 = 18.75 + thr ;	// 2 cents
d_001 = 16.25 + thr ;	// 1 cent


$fn=120;


module full(){										// Creates coin box, acording to rows parameter

	if(starting_row <=1 && end_row>=1){
		difference(){
			cube([box_d,d_2 + 2*wall,box_h]);
			hull(){
				translate([d_2/2 + wall,d_2/2 +wall,wall])cylinder(box_h - wall+.1, d_2/2, d_2/2  ); // 2 Euro
				translate([box_d + wall,d_2/2 +wall,wall])cylinder(box_h - wall, d_2/2, d_2/2  ); // 2 Euro
			}
		}
	}
	if(starting_row <=2 && end_row>=2){
		difference(){
			translate([0,d_2 + wall,0])cube([box_d,d_1+ 2*wall,box_h]);
			hull(){
				translate([d_1/2 + wall,d_1/2 + d_2 + 2 * wall,wall])cylinder(box_h - wall+.1, d_1/2, d_1/2  ); //1 Euro
				translate([box_d + wall,d_1/2 + d_2 + 2 * wall,wall])cylinder(box_h - wall, d_1/2, d_1/2  ); //1 Euro
			}
		}
	}
	
	if(starting_row <=3 && end_row>=3){
		difference(){
			translate([0,d_2 + 2*wall +d_1,0])cube([box_d,d_05+ 2*wall,box_h]);
			hull(){
				translate([d_05/2 + wall,d_05/2 +d_2+d_1+ 3*wall,wall])cylinder(box_h - wall+.1, d_05/2, d_05/2  ); // 50 cents
				translate([box_d + wall,d_05/2 +d_2+d_1+ 3*wall,wall])cylinder(box_h - wall+.1, d_05/2, d_05/2  ); // 50 cents
			}
		}
	}
	
	if(starting_row <=4 && end_row>=4){
		difference(){
			translate([0,d_2 + 3*wall +d_1+d_05,0])cube([box_d,d_02+ 2*wall,box_h]);
			hull(){
				translate([d_02/2 + wall,d_02/2 +d_2+d_1+ d_05+ 4* wall,wall])cylinder(box_h - wall+.1, d_02/2, d_02/2  ); // 20 cents
				translate([box_d + wall,d_02/2 +d_2+d_1+ d_05+ 4* wall,wall])cylinder(box_h - wall+.1, d_02/2, d_02/2  ); // 20 cents
			}
		}
	}
	
	if(starting_row <=5 && end_row>=5){
		difference(){
			translate([0,d_2 + 4*wall +d_1+d_05+d_02,0])cube([box_d,d_01+ 2*wall,box_h]);
			hull(){
				translate([d_01/2 + wall,d_01/2 +d_2+d_1+ d_05 +d_02+ 5* wall,wall])cylinder(box_h - wall+.1, d_01/2, d_01/2  ); // 10 cents
				translate([box_d + wall,d_01/2 +d_2+d_1+ d_05 +d_02+ 5* wall,wall])cylinder(box_h - wall+.1, d_01/2, d_01/2  ); // 10 cents
			}
		}
	}
	
	
	if(starting_row <=6 && end_row>=6){
		difference(){
			translate([0,d_2 + 5*wall +d_1+d_05+d_02+d_01,0])cube([box_d,d_005+ 2*wall,box_h]);
			hull(){
				translate([d_005/2 + wall,d_005/2 +d_2+d_1+ d_05 +d_02 + d_01 + 6* wall,wall])cylinder(box_h - wall+.1, d_005/2, d_005/2  ); // 5 cents
				translate([box_d + wall,d_005/2 +d_2+d_1+ d_05 +d_02 + d_01 + 6* wall,wall])cylinder(box_h - wall+.1, d_005/2, d_005/2  ); // 5 cents
			}
		}
	}
	
	if(starting_row <=7 && end_row>=7){
		difference(){
			translate([0,d_2 + 6*wall +d_1+d_05+d_02+d_01+d_005,0])cube([box_d,d_002+ 2*wall,box_h]);
			hull(){
				translate([d_002/2 + wall,d_002/2 +d_2+d_1+ d_05 +d_02 +d_01 + d_005+ 7* wall,wall])cylinder(box_h - wall+.1, d_002/2, d_002/2  ); // 2 cents
				translate([box_d + wall,d_002/2 +d_2+d_1+ d_05 +d_02 +d_01 + d_005+ 7* wall,wall])cylinder(box_h - wall+.1, d_002/2, d_002/2  ); // 2 cents
			}
		}
	}
	
	if(starting_row <=8 && end_row>=8){
		difference(){
			translate([0,d_2 + 7*wall +d_1+d_05+d_02+d_01+d_005+d_002,0])cube([box_d,d_001+ 2*wall,box_h]);
			hull(){
				translate([d_001/2 + wall,d_001/2 +d_2+d_1+ d_05 +d_02 +d_01 + d_005 +d_002 + 8* wall,wall])cylinder(box_h - wall+.1, d_001/2, d_001/2  ); // 1 cent
				translate([box_d ,d_001/2 +d_2+d_1+ d_05 +d_02 +d_01 + d_005 +d_002 + 8* wall,wall])cylinder(box_h - wall+.1, d_001/2, d_001/2  ); // 1 cent
			}
		}
	}
	
}

module pillar(radius){							// Putts Pillars in Coin's Module

	// Small issue due to angle being "180 - angle"  		Sin is Cos and Cos is Sin ( Opposite of normal trig rules )
	
	dif = (end_row - starting_row)+1 ;
	
	if(starting_row <=1 && end_row>=1){
			difference(){ //2
				translate([ - box_h*sin(angle) + radius + pillar_distance ,d_2/2 + wall,0]) cylinder(box_h*cos(angle),radius,radius); 
				rotate([0,-angle + 2 ,0])cube([box_d,d_2 + 2*wall,box_h]);
			}
	}
	
	if(starting_row <=2 && end_row>=2){
		if(dif<3 || starting_row==2 ||end_row ==2){
			difference(){
				translate([ - box_h*sin(angle) + radius + pillar_distance ,d_2 +d_1/2 + 2*wall,0]) cylinder(box_h*cos(angle),radius,radius); 
				translate([0,d_2 + wall,0])rotate([0,-angle + 2 ,0])cube([box_d,d_1 + 2*wall,box_h]);
			}
		}
	}
	
	if(starting_row <=3 && end_row>=3){
		if(dif<3 || starting_row==3 || end_row ==3){
			difference(){
				translate([ - box_h*sin(angle) + radius + pillar_distance ,d_2 + d_1 + d_05/2 + 3*wall,0]) cylinder(box_h*cos(angle),radius,radius);  
				translate([0,d_2 + 2*wall +d_1,0])rotate([0,-angle + 2 ,0])cube([box_d,d_05 + 2* wall,box_h]);
			}
		}
	}
	
	if(starting_row <=4 && end_row>=4){
		if(dif<3 || starting_row==4 || end_row ==4){
			difference(){
				translate([ - box_h*sin(angle) + radius + pillar_distance ,d_2 +d_1 +d_05 + d_02/2 + 4*wall ,0]) cylinder(box_h*cos(angle),radius,radius);  
				translate([0,d_2 + 3*wall +d_1+d_05,0])rotate([0,-angle + 2 ,0])cube([box_d,d_02+ 2*wall,box_h]);
			}
		}
	}
	
	if(starting_row <=5 && end_row>=5){
		if(dif<3 || starting_row==5|| end_row ==5){
			difference(){
				translate([ - box_h*sin(angle) + radius + pillar_distance ,d_2 +d_1 +d_05 + d_02 + d_01/2 + 5*wall ,0]) cylinder(box_h*cos(angle),radius,radius);  
				translate([0,d_2 + 4*wall +d_1+d_05+d_02,0])rotate([0,-angle + 2 ,0])cube([box_d,d_01+ 2*wall,box_h]);
			}
		}
	}
	
	if(starting_row <=6 && end_row>=6){
		if(dif<3 || starting_row==6|| end_row ==6){
			difference(){
				translate([ - box_h*sin(angle)+ radius + pillar_distance,d_2+d_1 + d_05 +d_02 + d_01 + d_005/2 + 6* wall ,0]) cylinder(box_h*cos(angle),radius,radius);  
				translate([0,d_2 + 5*wall +d_1+d_05+d_02+d_01,0])rotate([0,-angle + 2 ,0])cube([box_d,d_005+ 2*wall,box_h]);
			}
		}
	}
	
	if(starting_row <=7 && end_row>=7){
		if(dif<3 || starting_row==7|| end_row ==7){
			difference(){
				translate([ - box_h*sin(angle)+ radius + pillar_distance,d_2+d_1 + d_05 +d_02 + d_01 + d_005 + d_002/2 + 7* wall ,0]) cylinder(box_h*cos(angle),radius,radius);  
				translate([0,d_2 + 6*wall +d_1+d_05+d_02+d_01+d_005,0])rotate([0,-angle + 2 ,0])cube([box_d,d_002+ 2*wall,box_h]);
			}
		}
	}
	
	if(starting_row <=8 && end_row>=8){		
			difference(){
				translate([ - box_h*sin(angle)+ radius + pillar_distance,d_2+d_1 + d_05 +d_02 + d_01 + d_005 + d_002 + d_001/2 + 8* wall ,0]) cylinder(box_h*cos(angle),radius,radius);  
				translate([0,d_2 + 7*wall +d_1+d_05+d_02+d_01+d_005+d_002,0])rotate([0,-angle + 2 ,0])cube([box_d,d_001+ 2*wall,box_h]);
			}
	}

}

// ignore this variable!
pillar_hole = .2 ;

module final(){										// Preforms pillar hole in full()
	difference(){
		rotate([0,-angle,0])full();
		scale([1,1,1])pillar(pillar_r + pillar_hole);	
	}
}

if ( Print == 1 ){
	difference(){
		rotate([0,angle,0])final();
		if( Display == 1){
			display_number();
		}
	}
	
	translate([ + (box_h*sin(angle) - 2*pillar_r ) -pillar_distance*2 ,0,0])pillar(pillar_r);
}

if( Preview == 1 ){
	difference(){
		final();
		if( Display == 1 ){
			rotate([0,-angle,0])display_number();
		}
	}
	pillar(pillar_r);
}



// In Development

module display_number(){
	// Dumb implementation ...		 X.X
	//                                  	 ___
	if(Orientation== 0){
		translate([box_d/1.7 + wall + car_size/5 ,d_2/2 + wall -car_size/2.15 ,wall - 1])rotate([0,0,90])color("white")linear_extrude(2)text("2", font = "Liberation Mono",size = car_size);
		translate([box_d/1.7 + wall + car_size/5 ,d_2 + d_1/2 + 2*wall -car_size/2.15 ,wall - 1])rotate([0,0,90])color("white")linear_extrude(2)text("1", font = "Liberation Mono",size = car_size);
		translate([box_d/1.7 + wall + car_size/5 ,d_2+d_1+ d_05/2 + 3*wall - 2*car_size/2.4,wall - 1])rotate([0,0,90])color("white")linear_extrude(2)text("50", font = "Liberation Mono",size = car_size);
		translate([box_d/1.7 + wall + car_size/5 ,d_2 + d_1 + d_05 + d_02/2 + 4*wall - 2*car_size/2.4 ,wall - 1])rotate([0,0,90])color("white")linear_extrude(2)text("20", font = "Liberation Mono",size = car_size);
		translate([box_d/1.7 + wall + car_size/5 ,d_2 + d_1 + d_05 + d_02 + d_01/2 + 5*wall -2*car_size/2.4 ,wall - 1])rotate([0,0,90])color("white")linear_extrude(2)text("10", font = "Liberation Mono",size = car_size);
		translate([box_d/1.7 + wall + car_size/5 ,d_2 + d_1 + d_05 + d_02 + d_01 + d_005/2  + 6*wall - car_size/2.15 ,wall - 1])rotate([0,0,90])color("white")linear_extrude(2)text("5", font = "Liberation Mono",size = car_size);
		translate([box_d/1.7 +wall + car_size/5,d_2 + d_1 + d_05 + d_02 + d_01 + d_005 + d_002/2 + 7*wall - car_size/2.15,wall - 1])rotate([0,0,90])color("white")linear_extrude(2)text("2", font = "Liberation Mono",size = car_size);
		translate([box_d/1.7 + wall + car_size/5 ,d_2 + d_1 + d_05 + d_02 + d_01 + d_005 + d_002 + d_001/2 + 8*wall - car_size/2.15 ,wall - 1])rotate([0,0,90])color("white")linear_extrude(2)text("1", font = "Liberation Mono",size = car_size);
	}
	
	if(Orientation==90){
		translate([box_d/1.7 + wall - car_size/1.4 ,d_2/2 + wall +car_size/2.15 ,wall - 1])rotate([0,0,270])color("white")linear_extrude(2)text("2", font = "Liberation Mono",size = car_size);
		translate([box_d/1.7 + wall - car_size/1.4  ,d_2 + d_1/2 + 2*wall +car_size/2.15 ,wall - 1])rotate([0,0,270])color("white")linear_extrude(2)text("1", font = "Liberation Mono",size = car_size);
		translate([box_d/1.7 + wall - car_size/1.4  ,d_2+d_1+ d_05/2 + 3*wall + 2*car_size/2.4,wall - 1])rotate([0,0,270])color("white")linear_extrude(2)text("50", font = "Liberation Mono",size = car_size);
		translate([box_d/1.7 + wall - car_size/1.4  ,d_2 + d_1 + d_05 + d_02/2 + 4*wall + 2*car_size/2.4 ,wall - 1])rotate([0,0,270])color("white")linear_extrude(2)text("20", font = "Liberation Mono",size = car_size);
		translate([box_d/1.7 + wall - car_size/1.4  ,d_2 + d_1 + d_05 + d_02 + d_01/2 + 5*wall + 2*car_size/2.4 ,wall - 1])rotate([0,0,270])color("white")linear_extrude(2)text("10", font = "Liberation Mono",size = car_size);
		translate([box_d/1.7 + wall - car_size/1.4  ,d_2 + d_1 + d_05 + d_02 + d_01 + d_005/2  + 6*wall + car_size/2.15 ,wall - 1])rotate([0,0,270])color("white")linear_extrude(2)text("5", font = "Liberation Mono",size = car_size);
		translate([box_d/1.7 +wall - car_size/1.4 ,d_2 + d_1 + d_05 + d_02 + d_01 + d_005 + d_002/2 + 7*wall + car_size/2.15,wall - 1])rotate([0,0,270])color("white")linear_extrude(2)text("2", font = "Liberation Mono",size = car_size);
		translate([box_d/1.7 + wall - car_size/1.4  ,d_2 + d_1 + d_05 + d_02 + d_01 + d_005 + d_002 + d_001/2 + 8*wall + car_size/2.15 ,wall - 1])rotate([0,0,270])color("white")linear_extrude(2)text("1", font = "Liberation Mono",size = car_size);
	}

}

if( Debug == 1){
	rotate([0,-angle,0])translate([d_2/2 + wall,d_2/2 + wall,wall])cylinder(box_h - wall+.1, .5, .5); 																								// 2 Euro
	rotate([0,-angle,0])translate([d_1/2 + wall,d_2+d_1/2+ 2*wall,wall])cylinder(box_h - wall+.1, .5, .5); 																					// 1 Euro
	rotate([0,-angle,0])translate([d_05/2 + wall,d_2+d_1+ d_05/2 + 3*wall,wall])cylinder(box_h - wall+.1, .5, .5); 																		// 50 Cents
	rotate([0,-angle,0])translate([d_02/2 + wall,d_2+d_1+ d_05 + d_02/2 + 4*wall,wall])cylinder(box_h - wall+.1, .5, .5); 															// 20 Cents
	rotate([0,-angle,0])translate([d_01/2 + wall,d_2+d_1+ d_05 + d_02 + d_01/2 + 5*wall,wall])cylinder(box_h - wall+.1, .5, .5); 												// 10 Cents
	rotate([0,-angle,0])translate([d_005/2 + wall,d_2+d_1+ d_05 + d_02 + d_01 +d_005/2 + 6*wall,wall])cylinder(box_h - wall+.1, .5, .5); 									// 5 Cents
	rotate([0,-angle,0])translate([d_002/2 + wall,d_2+d_1+ d_05 + d_02 + d_01 + d_005 + d_002/2 + 7*wall,wall])cylinder(box_h - wall+.1, .5, .5); 					// 2 Cents
	rotate([0,-angle,0])translate([d_001/2 + wall,d_2+d_1+ d_05 + d_02 + d_01 + d_005 + d_002 + d_001/2 + 8*wall,wall])cylinder(box_h - wall+.1, .5, .5); 		// 1 Cent
}


//Debug
/* echo(box_h*cos(angle));
a=box_h*cos(angle);
b=box_h*sin(angle);
color("white")translate([-b,0,0])cube([1,1,a]);
color("blue")cylinder(box_h*cos(angle),radius,radius); */