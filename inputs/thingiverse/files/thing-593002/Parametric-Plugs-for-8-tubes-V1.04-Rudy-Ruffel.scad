// ************* Credits part *************
// "Parametric Plugs" 
// Programmed by Rudy RUFFEL - Decembre 2014
// Optimized for Customizer makerbot
//
//
//********************** License ******************
//**            "Parametric Plugs"               **
//**                  by rr2s                    **
//**  is licensed under the Creative Commons     **
//** - Attribution - Non-Commercial license.     **
//*************************************************
//
//
// ************* Declaration part *************
/* [Dimensions] */
// (For the exterior form. if cyclinder = false this a rectangle/square. For the cylinder Width=diameter).
cylinder = "true";// [true,false]
// (Width of the plug part or if cylinder it's diametere) 
Width        = 20;
// (Length of the plug part if cylinder use same of Width)
Length       = 20;
// (Height of the plug part)
Height		  = 50;

/* [Plugs] */
//(If you have multi-plug, chose number of plug )
NumberOfPlug = 8; // [2,3,4,5,6,7,8]
//*******************************
//The plug"0" is normalement fix but you can change. The color for the plug"0" is Red
Plug_0_Vertical = 0;
//(Only for the cylinder, not use with the rectangle/square. The first angle Horisontal is 0°.) 
Plug_0_Horizontal = 0;

//(The color for the first plug is Blue)
FristAngleVertical = 90;
//(Only for the cylinder, not use with the rectangle/square. The first angle Horisontal is 0°.) 
FristAngleHorizontal = 0;
//////// Second angle
//(if NumberOfPlug >= 3.The color for the Second plug is Green)
SecondAngleVertical = 90;
//(if NumberOfPlug >= 3. Only for the cylinder, not use with the rectangle/square.)
SecondAngleHorizontal=90;
//////// third angle
//(if NumberOfPlug >= 4.The color for the Third plug is Balck)
ThirdAngleVertical = 90;
//(if NumberOfPlug >= 4. Only for the cylinder, not use with the rectangle/square.)
ThirdAngleHorizontal=180;
//////// fourth angle
//(if NumberOfPlug >= 5. The base for first angle vertical is 90°.The color for the Fourth plug is Yellow)
FourthAngleVertical = 90;
//(if NumberOfPlug >= 5. Only for the cylinder, not use with the rectangle/square.)
FourthAngleHorizontal=270;
//////// fifth angle
//(if NumberOfPlug = 6.The color for the Fifth plug is Pink)
FifthAngleVertical = 180;
//(if NumberOfPlug = 6. Only for the cylinder, not use with the rectangle/square.)
FifthAngleHorizontal = 0;
//////// Sixth angle
//(if NumberOfPlug = 7.The color for the Sixth plug is Magenta)
SixthAngleVertical = 220;
//(if NumberOfPlug = 7. Only for the cylinder, not use with the rectangle/square.)
SixthAngleHorizontal = 0;
//////// Seventh angle
//(if NumberOfPlug = 8.The color for the Seventh plug is Aqua)
SeventhAngleVertical = 140;
//(if NumberOfPlug = 8. Only for the cylinder, not use with the rectangle/square.)
SeventhAngleHorizontal = 0;

/* [Settings] */
//(Thickness Wall the dimention is in mm)
ThicknessWall = 5;
// (resolution of cylinder)
ResolutionCylinder = 100;//[20:Draft,50:Medium,100:Fine, 200:Very fine]

//  simplification des variables
W    = Width;
L    = Length;
H    = Height;
TH   = ThicknessWall;
FAV  = FristAngleVertical;
FAH  = FristAngleHorizontal;
NOP  = NumberOfPlug-3;
SAV  = SecondAngleVertical;
SAH  = SecondAngleHorizontal;
TAV  = ThirdAngleVertical;
TAH  = ThirdAngleHorizontal;
FOAV = FourthAngleVertical;
FOAH = FourthAngleHorizontal;
FIAV = FifthAngleVertical;
FIAH = FifthAngleHorizontal;
SIAV = SixthAngleVertical;
SIAH = SixthAngleHorizontal;
SEAV = SeventhAngleVertical;
SEAH = SeventhAngleHorizontal;
RC   = ResolutionCylinder;
PV  = Plug_0_Vertical;
PH  = Plug_0_Horizontal;


// ************* Execute Part *************
difference(){
Base();
Cut();
};

// ************* Module grouping : base and cut  *************

module Base(){   
	union() {
		if(cylinder =="false"){
		rotate([FAV,0,0])  translate([0,0,(H+W/2)/2]) color("Blue",1) cube([W+TH*2,L+TH*2,H+W/2],center = true);
 		rotate([PV,0,0])  translate([0,0,(H+W/2)/2]) color("Red",1) cube([W+TH*2,L+TH*2,H+W/2],center = true);
		cube([W+TH*2,L+TH*2,L+TH*2],center = true);
		if(NumberOfPlug > 0){
				if(NumberOfPlug >= 3){
				 rotate([SAV,0,90])  translate([0,0,(H+W/2)/2]) color("Green",1)  cube([W+TH*2,L+TH*2,H+W/2],center = true);
					if(NumberOfPlug >= 4){
				 	rotate([TAV,0,180])  translate([0,0,(H+W/2)/2]) color("Black",1) cube([W+TH*2,L+TH*2,H+W/2],center = true);
					}
						if(NumberOfPlug >= 5){
				 		rotate([FOAV,0,270])  translate([0,0,(H+W/2)/2]) color("Yellow",1) cube([W+TH*2,L+TH*2,H+W/2],center = true);
						}
							if(NumberOfPlug >= 6){
				 			rotate([FIAV,0,0])  translate([0,0,(H+W/2)/2]) color("DeepPink",1) cube([W+TH*2,L+TH*2,H+W/2],center = true);
							}
                                if(NumberOfPlug >= 7){
                                rotate([SIAV,0,0])  translate([0,0,(H+W/2)/2]) color("Magenta",1) cube([W+TH*2,L+TH*2,H+W/2],center = true);
                                }
                                    if(NumberOfPlug >= 8){
                                    rotate([SEAV,0,0])  translate([0,0,(H+W/2)/2]) color("Aqua",1) cube([W+TH*2,L+TH*2,H+W/2],center = true);
                                    }                                
				}
			}
		}
		else{
		translate([0,0,0]) rotate([FAV,0,FAH]) color("Blue",1) cylinder(H+W/2,W/2+TH,W/2+TH,$fn=RC);
		translate([0,0,0]) rotate([PV,0,PH]) color("Red",1)cylinder(H+W/2,W/2+TH,W/2+TH,$fn=RC);
		sphere(W/2+TH,$fn=RC);
			if(NumberOfPlug > 0){
				if(NumberOfPlug >= 3){
				 translate([0,0,0]) rotate([SAV,0,SAH]) color("Green",1) cylinder(H+W/2,W/2+TH,W/2+TH,$fn=RC);
					if(NumberOfPlug >= 4){
				 	translate([0,0,0]) rotate([TAV,0,TAH]) color("Black",1) cylinder(H+W/2,W/2+TH,W/2+TH,$fn=RC);
					}
						if(NumberOfPlug >= 5){
				 		translate([0,0,0]) rotate([FOAV,0,FOAH]) color("Yellow",1) cylinder(H+W/2,W/2+TH,W/2+TH,$fn=RC);
						}
							if(NumberOfPlug >= 6){
				 			translate([0,0,0]) rotate([FIAV,0,FIAH]) color("DeepPink",1) cylinder(H+W/2,W/2+TH,W/2+TH,$fn=RC);
							}
                                if(NumberOfPlug >= 7){
                                translate([0,0,0]) rotate([SIAV,0,SIAH]) color("Magenta",1) cylinder(H+W/2,W/2+TH,W/2+TH,$fn=RC);
                                }
                                    if(NumberOfPlug >= 8){
                                    translate([0,0,0]) rotate([SEAV,0,SEAH]) color("Aqua",1) cylinder(H+W/2,W/2+TH,W/2+TH,$fn=RC);
                                    } 
				}
			}
	
		}
	}	    
}





module Cut(){ 
		if(cylinder =="false"){
			// Cut for the plug
			rotate([FAV,0,0])  translate([0,0,(H+W/2)/2]) color("Blue",1) cube([W,L,H+W/2+1],center = true);
 			rotate([PV,0,0])  translate([0,0,(H+W/2)/2]) color("Red",1) cube([W,L,H+W/2+1],center = true);

			if(NumberOfPlug == 2){
				//////// cut for simple angle  //////////////
				//cut Bottom
	  			rotate([FAV,0,0])  translate([0,-L+-TH,(H+W/2)/2]) cube([(W+TH)*2,L+-TH,(H+W/2+TH)*2],center = true);
				//cut Right
	  			rotate([FAV,0,0])  translate([W*2,0,(H+W/2)/2+-W/2]) cube([W+TH*2,L+TH*2,H*2],center = true);
				//cut Left
	  			rotate([FAV,0,0])  translate([-W+-TH*2,0,(H+W/2)/2+-W/2]) cube([W+TH*2,L+TH*2,H*2],center = true);
			}
			if(NumberOfPlug > 0){
					if(NumberOfPlug >= 3){
				 		rotate([SAV,0,90])  translate([0,0,(H+W/2)/2]) color("Green",1) cube([W,L,H+W/2+1],center = true);
						if(NumberOfPlug >= 4){
				 			rotate([TAV,0,180])  translate([0,0,(H+W/2)/2]) color("Black",1) cube([W,L,H+W/2+1],center = true);
						}
							if(NumberOfPlug >= 5){
				 				rotate([FOAV,0,270])  translate([0,0,(H+W/2)/2]) color("Yellow",1) cube([W,L,H+W/2+1],center = true);
							}
								if(NumberOfPlug >= 6){
				 				rotate([FIAV,0,0])  translate([0,0,(H+W/2)/2]) color("DeepPink",1)  cube([W,L,H+W/2+1],center = true);
                                                                                                  //cube([W+TH*2,L+TH*2,H+W/2]
								}
                                    if(NumberOfPlug >= 7){
                                    rotate([SIAV,0,0])  translate([0,0,(H+W/2)/2]) color("Magenta",1) cube([W,L,H+W/2+1],center = true);
                                    }
                                        if(NumberOfPlug >= 8){
                                        rotate([SEAV,0,0])  translate([0,0,(H+W/2)/2]) color("Aqua",1) cube([W,L,H+W/2+1],center = true);
                                        }        
					}
			}
		}
		else{
		translate([0,0,0]) rotate([FAV,0,FAH]) color("Blue",1) cylinder(H+W/2+1,W/2,W/2,$fn=RC);
		translate([0,0,0]) rotate([PV,0,PH]) color("Red",1)cylinder(H+W/2+1,W/2,W/2,$fn=RC);
			if(NumberOfPlug > 0){
				if(NumberOfPlug >= 3){
				 translate([0,0,0]) rotate([SAV,0,SAH]) color("Green",1) cylinder(H+W/2+1,W/2,W/2,$fn=RC);
					if(NumberOfPlug >= 4){
				 	translate([0,0,0]) rotate([TAV,0,TAH]) color("Black",1) cylinder(H+W/2+1,W/2,W/2,$fn=RC);
					}
						if(NumberOfPlug >= 5){
				 		translate([0,0,0]) rotate([FOAV,0,FOAH]) color("Yellow",1) cylinder(H+W/2+1,W/2,W/2,$fn=RC);
						}
							if(NumberOfPlug >= 6){
				 			translate([0,0,0]) rotate([FIAV,0,FIAH]) color("DeepPink",1) cylinder(H+W/2+1,W/2,W/2,$fn=RC);							}
                                if(NumberOfPlug >= 7){
                                translate([0,0,0]) rotate([SIAV,0,SIAH]) color("Magenta",1) cylinder(H+W/2+1,W/2,W/2,$fn=RC);
                                }
                                    if(NumberOfPlug >= 8){
                                    translate([0,0,0]) rotate([SEAV,0,SEAH]) color("Aqua",1) cylinder(H+W/2+1,W/2,W/2,$fn=RC);
                                    } 
				}
			}
		}
  }








