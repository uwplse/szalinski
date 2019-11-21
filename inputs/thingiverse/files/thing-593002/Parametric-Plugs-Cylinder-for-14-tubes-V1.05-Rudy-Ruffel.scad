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
// (For the exterior form. just for cyclinder Width=diameter) 
Width        = 20;
// (Height of the plug part)
Height		  = 50;

/* [Plugs] */
//(If you have multi-plug, chose number of plug )
NumberOfPlug = 14; // [2,3,4,5,6,7,8,9,10,11,12,13,14]
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
//////// ninth angle
//(if NumberOfPlug = 9.The color for the Seventh plug is White)
NinthAngleVertical = 310;
//(if NumberOfPlug = 9. Only for the cylinder, not use with the rectangle/square.)
NinthAngleHorizontal =0;
//////// tenth angle
//(if NumberOfPlug = 10.The color for the Seventh plug is DarkKhaki)
TenthAngleVertical = 45;
//(if NumberOfPlug = 10. Only for the cylinder, not use with the rectangle/square.)
TenthAngleHorizontal = 0;
//////// eleventh angle
//(if NumberOfPlug = 11.The color for the Seventh plug is RosyBrown)
EleventhAngleVertical = 45;
//(if NumberOfPlug = 11. Only for the cylinder, not use with the rectangle/square.)
EleventhAngleHorizontal = 90;
//////// twelfth angle
//(if NumberOfPlug = 12.The color for the Seventh plug is Gray)
TwelfthAngleVertical = -45;
//(if NumberOfPlug = 12. Only for the cylinder, not use with the rectangle/square.)
TwelfthAngleHorizontal = 90;
//////// thirteenth angle
//(if NumberOfPlug = 13.The color for the Seventh plug is SpringGreen)
ThirteenthAngleVertical = 135;
//(if NumberOfPlug = 13. Only for the cylinder, not use with the rectangle/square.)
ThirteenthAngleHorizontal = 90;
//////// fourteenth angle
//(if NumberOfPlug = 14.The color for the Seventh plug is Brown)
FourteenthAngleVertical = -135;
//(if NumberOfPlug = 14. Only for the cylinder, not use with the rectangle/square.)
FourteenthAngleHorizontal = 90;


/* [Settings] */
//(Thickness Wall the dimention is in mm)
ThicknessWall = 5;
// (resolution of cylinder)
ResolutionCylinder = 100;//[20:Draft,50:Medium,100:Fine, 200:Very fine]

//  simplification des variables
W    = Width;
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
NAV   = NinthAngleVertical;
NAH   = NinthAngleHorizontal;
TEAV  = TenthAngleVertical;
TEAH  = TenthAngleHorizontal;
EAV   = EleventhAngleVertical;
EAH   = EleventhAngleHorizontal;
TWAV  = TwelfthAngleVertical;
TWAH  = TwelfthAngleHorizontal;
THIAV = ThirteenthAngleVertical;
THIAH = ThirteenthAngleHorizontal;
FOUAV = FourteenthAngleVertical;
FOUAH = FourteenthAngleHorizontal;

RC  = ResolutionCylinder;
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
                                    if(NumberOfPlug >= 9){
                                    translate([0,0,0]) rotate([NAV,0,NAH]) color("White",1) cylinder(H+W/2,W/2+TH,W/2+TH,$fn=RC);
                                    }
                                        if(NumberOfPlug >= 10){
                                        translate([0,0,0]) rotate([TEAV,0,TEAH]) color("DarkKhaki",1) cylinder(H+W/2,W/2+TH,W/2+TH,$fn=RC);
                                        }
                                            if(NumberOfPlug >= 11){
                                            translate([0,0,0]) rotate([EAV,0,EAH]) color("RosyBrown",1) cylinder(H+W/2,W/2+TH,W/2+TH,$fn=RC);
                                            }
                                                if(NumberOfPlug >= 12){
                                                translate([0,0,0]) rotate([TWAV,0,TWAH]) color("Gray",1) cylinder(H+W/2,W/2+TH,W/2+TH,$fn=RC);
                                                }
                                                    if(NumberOfPlug >= 13){
                                                    translate([0,0,0]) rotate([THIAV,0,THIAH]) color("SpringGreen",1) cylinder(H+W/2,W/2+TH,W/2+TH,$fn=RC);
                                                    }
                                                        if(NumberOfPlug >= 14){
                                                        translate([0,0,0]) rotate([FOUAV,0,FOUAH]) color("Brown",1) cylinder(H+W/2,W/2+TH,W/2+TH,$fn=RC);
                                                        }   
				}
			}
	
		}
	}	    

module Cut(){ 
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
                                     if(NumberOfPlug >= 9){
                                    translate([0,0,0]) rotate([NAV,0,NAH]) color("White",1) cylinder(H+W/2+1,W/2,W/2,$fn=RC);
                                    }
                                        if(NumberOfPlug >= 10){
                                        translate([0,0,0]) rotate([TEAV,0,TEAH]) color("DarkKhaki",1) cylinder(H+W/2+1,W/2,W/2,$fn=RC);
                                        }
                                            if(NumberOfPlug >= 11){
                                            translate([0,0,0]) rotate([EAV,0,EAH]) color("RosyBrown",1) cylinder(H+W/2+1,W/2,W/2,$fn=RC);
                                            }
                                                if(NumberOfPlug >= 12){
                                                translate([0,0,0]) rotate([TWAV,0,TWAH]) color("Gray",1) cylinder(H+W/2+1,W/2,W/2,$fn=RC);
                                                }
                                                    if(NumberOfPlug >= 13){
                                                    translate([0,0,0]) rotate([THIAV,0,THIAH]) color("SpringGreen",1) cylinder(H+W/2+1,W/2,W/2,$fn=RC);
                                                    }
                                                        if(NumberOfPlug >= 14){
                                                        translate([0,0,0]) rotate([FOUAV,0,FOUAH]) color("Brown",1) cylinder(H+W/2+1,W/2,W/2,$fn=RC);
                                                        }                                                   
				}
			}
		}








