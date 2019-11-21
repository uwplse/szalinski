//
// ************* Credits part *************
//            "Mini-sandwich Maker Twist" 
// Programmed by Rudy RUFFEL - Decembre 2014
// Optimized for Customizer makerbot
//
//********************** License ******************
//**        "Mini-sandwich_Maker-Twist" by rr2s        **
//**  is licensed under the Creative Commons     **
//** - Attribution - Non-Commercial license.     **
//*************************************************
//
// Buld plate selector

//
//
// ************* Declaration part *************
/* [Global] */

/* [Part] */
// (If you want part by part of mini-sandwich maker, or if you want to have mini-sandwich maker complete on your Bed. If you want part by part choose PartOfObject )
PartByPart = "no"; // [yes,no]
// (What type of Mini-sandwich Twist you want.)
Type = "Square"; // [Square:Square,Hex:Hex,Octagonal:Octagonal,Rectangle:Rectangle,RectangleBevel:Rectangle/Square Bevel,Oval:Oval,Heart:Heart]
// (Select the part you want to see. If you change the settings select all the parts with the same setting.)
PartOfObject = "Base";// [Base:Base,Pusher:Pusher,Axispusher:Axis pusher,Cap:Cap]

/* [build_plate] */
///////************************************************   Build - plate ****************************
// for use build_plate.scad you can see :
										// http://www.thingiverse.com/thing:44094/#files
use <utils/build_plate.scad>
//set your build plate
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//if set to "manual" set the  build plate x dimension
build_plate_manual_x = 100; //[100:400]

//if set to "manual" set the  build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);
///////************************************************   Build - plate ****************************

/* [Settings] */
// (Height of your Mini-sandwich Twist in mm)
Height = 40;
// (The width of your Mini-sandwich Twist in mm. if it's a circle or oval this is the diameter.if it's Heart this is a size)
Width = 30; 
// (The length of your Mini-sandwich Twist in mm. If it's Oval Length)
Length = 25;
// (The Twist)
Twist = 100;
// Resolution Bevel if you have choose Rectangle/Square Bevel
RectangleBevelResoltuion = 50;

/* [Hidden] */
	// ************* private variable *************
   // No change this variable. The code needs to be improved to use these variable.
	TP  = 5;//ThicknessPusher
	H   = Height+TP;
	W   = Width;
	L   = Length;
	TH  = 2 ; //ThicknessWall 
	// other
	HAP = H+10;  //Height Axis Of Piston
	WAP = W/3.5; //Width Axis Of Piston or diametre if cinylinder or oval
	LAP = L/3.5; //Length Axis Of Piston
	RSB = RectangleBevelResoltuion;
	AxisOfpistonExtension= Twist*(HAP+TH-H+TH)/H+TH; // extension pistion for axis piston follow twist Base

// ************* Executable part *************
		Type_Part();
/////////////////////////**********************

// ************* Module part Piston *************
// Axis Piston Print
module AxisOfPistonCylinder(){
	difference(){
		//Base Cap
		union() {
			//base axis of piston
			difference(){
				translate([0,0,0])linear_extrude(H+TH,center=false,twist =Twist,$fn=1000)
				circle(WAP/2, WAP/2,$fn=4);
				translate([0,0,-WAP+1]) cube(WAP*2,center = true);
			}
			// axis of pistion extension
			rotate([0,0,-Twist ]) translate([0,0,H+TH-0.01]) 
			linear_extrude(HAP+TH-(H+TH),center=false,twist =AxisOfpistonExtension,$fn=1000)
			circle(WAP/2, WAP/2,$fn=4);
		}
		// Cylinder for indicate the top of the Axis Pusher
		translate([0,0,HAP+TH]) cylinder(0.5,WAP/2/10 , center=true,$fn=100);
	}

}

// Axis Piston Cut Base
module AxisOfPistonCylinderCutBase(){
		union() {
			//base axis of piston
			translate([0,0,0])linear_extrude(H+TH,center=false,twist =Twist,$fn=1000)
			circle(WAP/2+0.2, WAP/2+0.2,$fn=4);
			// axis of pistion extension
			rotate([0,0,-Twist ]) translate([0,0,H+TH-0.01]) 
			linear_extrude(HAP+TH-(H+TH),center=false,twist =AxisOfpistonExtension,$fn=1000)
			circle(WAP/2+0.2, WAP/2+0.2,$fn=4);
		}
}
	

// Cap of the piston Sphere
module CapPistionSphere(){
		translate([0,0,HAP+TH-W/3]) difference(){
				sphere(W/2,$fn=150);
				translate([0,0,-W/2]) cube(W,center=true);
				translate([0,W/2.2,W/2.2]) rotate([45,180, 0]) difference(){
								sphere(W/3,$fn=150);
								translate([0,0,-W/2]) cube(W,center=true);
								}
				translate([0,-W/2.2,W/2.2]) rotate([-45,180, 0]) difference(){
								sphere(W/3,$fn=150);
								translate([0,0,-W/2]) cube(W,center=true);
								}
		}
}

// ************* Module part For Square *************
module BaseSquare(){
	linear_extrude(height=H+TH,center=false,twist =Twist,$fn=1000) circle(r = W/2+TH*2,$fn=4);
}

module PusherSquare(){
	difference(){
		// Pusher
		translate([0,0,0]) linear_extrude(height=H+1,center=false,twist=Twist,$fn=1000)
		circle(r = W/2-(W/2/10),$fn=4);
		// cube cute Pusher
		translate([0,0,TP]) cylinder(H, W*2, W*2,$fn=4);
	}
} 

module CutSquare(){
	translate([0,0,-1]) linear_extrude(height=H+1,center=false,twist=Twist,$fn=1000) circle(r = W/2,$fn=4);
}

module CutSquareAngle(){
	difference(){
		translate([0,0,-1]) linear_extrude(height=H+TH+2,center=false,twist=Twist,$fn=1000) circle(r = W/2+TH*3,$fn=4);
		translate([0,0,0])  linear_extrude(height=H+TH,scale=1.5,center=false,twist=Twist,$fn=1000) circle(r = W/2+TH/2,$fn=4);
	}
}

// ************* Module part For Hex *************
module BaseHex(){
	linear_extrude(height=H+TH,center=false,twist=Twist,$fn=1000) circle(r = W/2+TH*2,$fn=6);
}

module PusherHex(){
	difference(){
		// Pusher
		translate([0,0,0]) linear_extrude(height=H+1,center=false,twist=Twist,$fn=1000) circle(r = W/2-(W/2/10),$fn=6);
		// cube cute Pusher
		translate([0,0,TP]) cylinder(H, W*2, W*2,$fn=4);
	}
} 

module CutHex(){
	translate([0,0,-1]) linear_extrude(height=H+1,center=false,twist=Twist,$fn=1000) circle(r = W/2,$fn=6);
}

module CutHexAngle(){
	difference(){
		translate([0,0,-1])linear_extrude(height=H+TH+2,center=false,twist=Twist,$fn=1000) circle(r = W/2+TH*3,$fn=6);
		translate([0,0,0]) linear_extrude(height=H+TH,scale=1.5,center=false,twist=Twist,$fn=1000) circle(r = W/2+TH/2,$fn=6);
	}
}

// ************* Module part For Octagonal *************
module BaseOctagonal(){
	linear_extrude(height=H+TH,center=false,twist=Twist,$fn=1000) circle(r = W/2+TH*2,$fn=8);
}

module PusherOctagonal(){
	difference(){
		// Pusher
		translate([0,0,0]) linear_extrude(height=H+1,center=false,twist=Twist,$fn=1000) circle(r = W/2-0.5,$fn=8);
		// cube cute Pusher
		translate([0,0,TP]) cylinder(H, W*2, W*2,$fn=8);
	}
}

module CutOctagonal(){
	translate([0,0,-1]) linear_extrude(height=H+1,center=false,twist=Twist,$fn=1000) circle(r = W/2,$fn=8);
}

module CutOctagonalAngle(){
	difference(){
		translate([0,0,-1]) linear_extrude(height=H+TH+2,center=false,twist= Twist,$fn=1000) circle(r = W/2+TH*3,$fn=8);
		translate([0,0,0]) linear_extrude(height=H+TH,scale=1.5,center=false,twist=Twist,$fn=1000) circle(r = W/2+TH/2,$fn=8);
	}
}

// ************* Module part For Rectangle *************
module BaseRectangle(){
	linear_extrude(height = H+TH,center = false, twist = Twist,$fn=1000) square([W+TH*2,L+TH*2],center=true);
}

module PusherRectangle(){
	difference(){
		// Pusher
		translate([0,0,0]) linear_extrude(height = H+1,center = false, twist = Twist,$fn=1000) square([W-1,L-1],center=true);
		// cube cute Pusher
		translate([0,0,TP]) cylinder(H, W*2, W*2,$fn=8);
	}
}

module CutRectangle(){
	translate([0,0,-1]) linear_extrude(height = H+1,center = false, twist = Twist,$fn=1000) square([W,L],center=true);
}

module CutRectangleAngle(){
	difference(){
		translate([0,0,-2]) linear_extrude(height = H+TH+2,scale=2,center = false, twist = Twist,$fn=1000)  square([W+TH*3,L+TH*3],center=true);
		translate([0,0,-2]) linear_extrude(height = H+TH+2,scale=1.5,center = false, twist = Twist,$fn=1000) square([W+TH/2,L+TH/2],center=true);
	}
}

// ************* Module part For RectangleBevel************
module BaseRectangleBevel(){
	translate([0,0,0]) linear_extrude(height = H+TH,center = false, twist = Twist,$fn=500)
	minkowski(){
		square([W+TH*2-5,L+TH*2-5],center=true);
		circle(r=10,2,$fn = 50);
	}
}

module PusherRectangleBevel(){
	difference(){
		// Pusher
		translate([0,0,0]) linear_extrude(height = H+1,center = false, twist =Twist,$fn=500)
		minkowski(){
			square([W-6,L+-6],center=true);
			circle(r=9,1.5,$fn = RSB);
		}
		// cube cute Pusher
		translate([0,0,TP]) cylinder(H, W*2, W*2,$fn=4);
	}

} 

module CutRectangleBevel(){
	translate([0,0,-1]) linear_extrude(height = H+1,center = false, twist = Twist,$fn=500)
	minkowski(){
		square([W-5,L+-5],center=true);
		circle(r=10,2,$fn = RSB);
	}
}

module CutRectangleBevelAngle(){
	difference(){
		// Base Angle
			translate([0,0,-H/2+-TH+-1])
			translate([0,0,-1]) linear_extrude(height = H+TH+2,scale=2,center = false, twist = Twist,$fn=200)
		minkowski(){
			square([W+TH*3-5,L+TH*3-5],center=true);
			circle(r=10,2,$fn = 50);
		}
		// Cut Base Angle
			translate([0,0,0]) linear_extrude(height = H+TH,scale=1.5,center = false, twist =Twist,$fn=500)
		minkowski(){
			square([W+TH-5,L+TH-5],center=true);
			circle(r=10,2,$fn = 50);
		}
	}
	
}

// ************* Module part For Oval *************
module BaseOval(){
	linear_extrude(height = H+TH,center = false, twist = Twist,$fn=500)
		hull(){
			translate([0,-L/4,-H/2]) circle(W/2.5+TH, W/2.5+TH,$fn=50);
			translate([0,L/4,-H/2]) circle(W/2.5+TH, W/2.5+TH,$fn=50);
		}
}

module PusherOval(){
	difference(){
		// Pusher
		translate([0,0,0]) linear_extrude(height = H+1,center = false, twist = Twist,$fn=500)
		hull(){
			translate([0,-L/4,-H/2]) circle((W/2.5)-0.5, W/3,$fn=50);
			translate([0,L/4,-H/2]) circle((W/2.5)-0.5, W/3,$fn=50);
		}
		// cube cute Pusher
		translate([0,0,TP]) cylinder(H, W*2, W*2,$fn=4);
	}
} 

module CutOval(){
translate([0,0,-1]) linear_extrude(height = H+1,center = false, twist = Twist,$fn=500)
	hull(){
		translate([0,-L/4,-H/2]) circle(W/2.5, W/2.5,$fn=50);
		translate([0,L/4,-H/2]) circle(W/2.5, W/2.5,$fn=50);
	}
}

module CutOvalAngle(){	
	difference(){
		// Base for angle
		translate([0,0,-1]) linear_extrude(height = H+TH+1,scale=2,center = false, twist = Twist,$fn=500)
			hull(){
				translate([0,-L/4,-H/2]) circle(W/2.5+TH, W/2.5+TH,$fn=50);
				translate([0,L/4,-H/2]) circle(W/2.5+TH, W/2.5+TH,$fn=50);
			}
		//Cut for Base Angle
		translate([0,0,-1]) linear_extrude(height = H+TH+1,scale=1.5,center = false, twist = Twist,$fn=500)
			hull(){
				translate([0,-L/4,-H/2]) circle(W/2.5+TH/3, W/2.5+TH/3,$fn=50);
				translate([0,L/4,-H/2]) circle(W/2.5+TH/3, W/2.5+TH/3,$fn=50);
			}
	}
}

// ************* Module part For Heart ************
module BaseHeart1(){
	translate ([-W/1.7+-TH,-W/1.7+-TH,0]) union (){
			square (W+TH,W+TH);
			translate ([W/2+TH,W+TH,0]) circle(W/2+TH,$fn=50);
			translate ([W+TH,W/2+TH,0]) circle(W/2+TH,$fn=50);
			}
}
module BaseHeart(){
	translate ([0,0,0])  linear_extrude(height = H+TH,center = false, twist = Twist,$fn=500) BaseHeart1();
}


module PusherHeart(){
	difference(){
		// Pusher
		translate ([0,0,0])  linear_extrude(height = H+TH,center = false, twist = Twist,$fn=500) PusherHeart1();
		// cube cute Pusher
		rotate([0,0,0]) translate([0,0,TP]) cylinder(H, W*2, W*2,$fn=4);
	}
} 
module PusherHeart1(){
	translate ([-W/1.7,-W/1.7,0]) union (){
		square (W-1,W-1);
		translate ([(W-1)/2,W-1,0]) circle((W-1)/2,$fn=50);
		translate ([W-1,(W-1)/2,0]) circle((W-1)/2,$fn=50);
		}
}

module CutHeart1(){
	translate ([-W/1.7,-W/1.7,0]) union (){
			square (W,W);
			translate ([W/2,W,0]) circle(W/2,$fn=50);
			translate ([W,W/2,0]) circle(W/2,$fn=50);
		}


}
module CutHeart(){
	translate ([0,0,-1])  linear_extrude(height = H+1,center = false, twist = Twist,$fn=500) CutHeart1();
}


module CutHeartAngle(){	
	difference(){
	translate ([0,0,-0.1]) linear_extrude(height = H+TH,scale=2,center = false, twist = Twist,$fn=500) BaseHeartAngle1();
	translate ([0,0,-0.1]) linear_extrude(height = H+TH,scale=1.5,center = false, twist = Twist,$fn=500) CutHeartAngle2();
	}
}


module BaseHeartAngle1(){
	translate ([-W/1.5+-TH,-W/1.5+-TH,H+TH]) 
			union (){
			square (W+TH+3,W+TH+3);
			translate ([(W+3)/2+TH,W+TH+3,0]) circle((W+3)/2+TH,$fn=50);
			translate ([W+TH+3,(W+3)/2+TH,0]) circle((W+3)/2+TH,$fn=50);
		}	
}

module CutHeartAngle2(){
		translate ([-W/1.7+-TH/2,-W/1.7+-TH/2,0]) union (){
			square (W+TH/2,W+TH/2);
			translate ([W/2+TH/2,W+TH/2,0]) circle(W/2+TH/2,$fn=50);
			translate ([W+TH/2,W/2+TH/2,0]) circle(W/2+TH/2,$fn=50);
		}
}


// ************* Type part *************

module Type_Part() {

// if all part for mini sandwich
	if(PartByPart == "no") {
	// For the Square
			if (Type == "Square") {
						// Square Base
						translate([0,0,H+TH]) rotate([180,0,0])
						difference(){
									BaseSquare();
									AxisOfPistonCylinderCutBase();
									CutSquare();
									CutSquareAngle();
						}
						// Pusher Square
						translate([W*1.2,0,0]) difference(){
									PusherSquare();
									AxisOfPistonCylinder();
						}
						// Axis Piston
						translate([0,-W*1.2,-1])AxisOfPistonCylinder();
						//cap
						translate([-W*1.2,0,-(HAP+TH-W/3)])difference(){
									CapPistionSphere();
									AxisOfPistonCylinder();
						}

		// For the Hex
			}else if (Type == "Hex") {
					// Base Hex
					translate([0,0,H+TH]) rotate([180,0,0]) difference(){
									BaseHex();
									AxisOfPistonCylinderCutBase();
									CutHex();
									CutHexAngle();
						}
					// Pusher Hex
					translate([W*1.2,0,0]) difference(){
									PusherHex();
									AxisOfPistonCylinder();
						}
					// Axis Piston
					translate([0,-W*1.2,-1])AxisOfPistonCylinder();
					//cap
						translate([-W*1.2,0,-(HAP+TH-W/3)])difference(){
									CapPistionSphere();
									AxisOfPistonCylinder();
						}

		// For the Octogonal
			}else if (Type == "Octagonal") {
						// Base Octagonal
						translate([0,0,H+TH]) rotate([180,0,0])difference(){
							BaseOctagonal();
							AxisOfPistonCylinderCutBase();
							CutOctagonal();
							CutOctagonalAngle();
						}
						// Pusher Octagonal
						translate([W*1.2,0,0]) difference(){
							PusherOctagonal();
							AxisOfPistonCylinder();
						}
						// Axis
						translate([0,-W*1.2,-1]) AxisOfPistonCylinder();
						//cap
						translate([-W*1.2,0,-(HAP+TH-W/3)]) difference(){
							CapPistionSphere();
							AxisOfPistonCylinder();
						}

		// For the Rectangle	
			}else if (Type == "Rectangle") {
						//Base Rectangle
						translate([0,0,H+TH]) rotate([180,0,0])difference(){
							BaseRectangle();
							AxisOfPistonCylinderCutBase();
							CutRectangle();
							CutRectangleAngle();
						}				
						// Pusher Rectangle
						translate([W*1.2,0,0]) difference(){
							PusherRectangle();
							AxisOfPistonCylinder();
						}
						// Axis
						translate([0,-W*1.2,-1]) AxisOfPistonCylinder();
						//cap
						translate([-W*1.2,0,-(HAP+TH-W/3)]) difference(){
							CapPistionSphere();
							AxisOfPistonCylinder();
							}

		// For the Rectangle Bevel
			}else if (Type == "RectangleBevel") {
						//Base RectangleBevel
						translate([0,0,H+TH]) rotate([180,0,0])difference(){
							BaseRectangleBevel();
							AxisOfPistonCylinderCutBase();
							CutRectangleBevel();
							CutRectangleBevelAngle();
						}				
						// Pusher RectangleBevel
						translate([W*1.2,0,0])difference(){
							PusherRectangleBevel();
							AxisOfPistonCylinder();
						}
						//	Axis
						translate([0,-W*1.2,-1]) AxisOfPistonCylinder();
						//cap
						translate([-W*1.2,0,-(HAP+TH-W/3)]) difference(){
							CapPistionSphere();
							AxisOfPistonCylinder();
						}

		// For the Oval
			}else if (Type == "Oval") {
						translate([0,0,H+TH]) rotate([180,0,0])difference(){
							BaseOval();
							AxisOfPistonCylinderCutBase();
							CutOval();
							CutOvalAngle();
						}						

						translate([W*1.2,0,0]) difference(){
							PusherOval();
							AxisOfPistonCylinder();
						}			
						translate([0,-W*1.2,-1]) AxisOfPistonCylinder();
						//cap
						translate([-W*1.2,0,-(HAP+TH-W/3)]) difference(){
							CapPistionSphere();
							AxisOfPistonCylinder();
						}
		// For the Heart
			}else {
						// Base Heart
						translate([0,0,H+TH]) rotate([180,0,120]) difference(){
							BaseHeart();
							AxisOfPistonCylinderCutBase();
							CutHeart();
							CutHeartAngle();
						}			
						//Pusher Heart			
						rotate([0,0,50]) translate([W*1.7,0,0]) difference(){
							PusherHeart();
							AxisOfPistonCylinder();
						}			
						// axis 
						translate([0,-W*1.5,-1])AxisOfPistonCylinder();
						//cap
						translate([-W*1.7,0,-(HAP+TH-W/3)]) difference(){
							CapPistionSphere();
							AxisOfPistonCylinder();
						}
			}





//********* if part by part for mini sandwich
	}else{
		// For the Square
			if (Type == "Square") {
				if (PartOfObject  == "Base"){
						translate([0,0,H+TH]) rotate([180,0,0])
						difference(){
							BaseSquare();
							AxisOfPistonCylinderCutBase();
							CutSquare();
							CutSquareAngle();
						}
				}else if (PartOfObject  == "Pusher") {
						difference(){
							PusherSquare();
							AxisOfPistonCylinder();
						}
				}else if (PartOfObject  == "Axispusher") {
					translate([0,0,-1]) AxisOfPistonCylinder();
				}else{//cap
					translate([0,0,-(HAP+TH-W/3)]) difference(){
								CapPistionSphere();
								AxisOfPistonCylinder();
							}
				}

		// For the Hex
			}else if (Type == "Hex") {
				if (PartOfObject  == "Base"){
						translate([0,0,H+TH]) rotate([180,0,0])
						difference(){
							BaseHex();
							AxisOfPistonCylinderCutBase();
							CutHex();
							CutHexAngle();
						}
				}else if (PartOfObject  == "Pusher") {
						difference(){
							PusherHex();
							AxisOfPistonCylinder();
						}
				}else if (PartOfObject  == "Axispusher") {
						translate([0,0,-1]) AxisOfPistonCylinder();
				}else{//cap
						translate([0,0,-(HAP+TH-W/3)]) difference(){
								CapPistionSphere();
								AxisOfPistonCylinder();
							}
				}

		// For the Octagonal
			}else if (Type == "Octagonal") {
				if (PartOfObject  == "Base"){
						translate([0,0,H+TH]) rotate([180,0,0])
						difference(){
							BaseOctagonal();
							AxisOfPistonCylinderCutBase();
							CutOctagonal();
							CutOctagonalAngle();
						}
				}else if (PartOfObject  == "Pusher") {
						difference(){
							PusherOctagonal();
							AxisOfPistonCylinder();
						}
				}else if (PartOfObject  == "Axispusher") {
					translate([0,0,-1]) AxisOfPistonCylinder();
				}else{//cap
					translate([0,0,-(HAP+TH-W/3)]) difference(){
								CapPistionSphere();
								AxisOfPistonCylinder();
							}
				}

		// For the Rectangle
			}else if (Type == "Rectangle") {
				if (PartOfObject  == "Base"){
						translate([0,0,H+TH]) rotate([180,0,0])
						difference(){
							BaseRectangle();
							AxisOfPistonCylinderCutBase();
							CutRectangle();
							CutRectangleAngle();
						}				
				}else if (PartOfObject  == "Pusher") {
						difference(){
							PusherRectangle();
							AxisOfPistonCylinder();
						}
				}else if (PartOfObject  == "Axispusher") {
					translate([0,0,-1]) AxisOfPistonCylinder();
				}else{//cap
					translate([0,0,-(HAP+TH-W/3)]) difference(){
								CapPistionSphere();
								AxisOfPistonCylinder();
							}
				}

		// For the Rectangle Bevel
			}else if (Type == "RectangleBevel") {
				if (PartOfObject  == "Base"){
						translate([0,0,H+TH]) rotate([180,0,0])
						difference(){
							BaseRectangleBevel();
							AxisOfPistonCylinderCutBase();
							CutRectangleBevel();
							CutRectangleBevelAngle();
						}				
				}else if (PartOfObject  == "Pusher") {
						difference(){
							PusherRectangleBevel();
							AxisOfPistonCylinder();
						}
				}else if (PartOfObject  == "Axispusher") {
					translate([0,0,-1]) AxisOfPistonCylinder();
				}else{//cap
					translate([0,0,-(HAP+TH-W/3)]) difference(){
								CapPistionSphere();
								AxisOfPistonCylinder();
							}
				}

		// For the Oval
			}else if (Type == "Oval") {
				if (PartOfObject  == "Base"){
						translate([0,0,H+TH]) rotate([180,0,0])
						difference(){
							BaseOval();
							AxisOfPistonCylinderCutBase();
							CutOval();
							CutOvalAngle();
						}						
				}else if (PartOfObject  == "Pusher") {
						difference(){
							PusherOval();
							AxisOfPistonCylinder();
						}			
				}else if (PartOfObject  == "Axispusher") {
					translate([0,0,-1]) AxisOfPistonCylinder();
				}else{//cap
					translate([0,0,-(HAP+TH-W/3)]) difference(){
								CapPistionSphere();
								AxisOfPistonCylinder();
							}
				}

		// For the Heart
			}else {// For the Heart
				if (PartOfObject  == "Base"){
						translate([0,0,H+TH]) rotate([180,0,0])
						difference(){
							BaseHeart();
							AxisOfPistonCylinderCutBase();
							CutHeart();
							CutHeartAngle();
						}						
				}else if (PartOfObject  == "Pusher") {
						difference(){
							PusherHeart();
							AxisOfPistonCylinder();
						}			
				}else if (PartOfObject  == "Axispusher") {
					translate([0,0,-1]) AxisOfPistonCylinder();
				}else{//cap
					translate([0,0,-(HAP+TH-W/3)]) difference(){
								CapPistionSphere();
								AxisOfPistonCylinder();
							}
				}

			}
		}
}









