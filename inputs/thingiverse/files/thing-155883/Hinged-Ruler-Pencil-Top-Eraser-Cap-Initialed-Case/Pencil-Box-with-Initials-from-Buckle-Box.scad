use </Users/georgewchilds/Desktop/aRepRap/Scad Library/elmom-MCAD-8930770/Write.scad>
include </users/georgewchilds/Desktop/aRepRap/configuration.scad>
include </users/georgewchilds/Desktop/aRepRap/Scad Library/wedge.scad>

message = "L H C";
Font = "write/orbitron.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic,"write/braille.dxf":Braille,"write/BlackRose.dxf":Fancy]
//Font= "/Users/georgewchilds/Desktop/aRepRap/Scad Library/elmom-MCAD-8930770/BlackRose.dxf";

//How many different hinge parts are there?
hingePieces = 3; //[2:24]

//Overall height (turns into this - tolerance!)
hingeHeight = 25.75; //[12:240]


//Smoothness of latch
$fn = 100; //[12:100]
// Width of Pencil Box
width = 27; //[14:30]
// Length of Pencil Box
depth = 187; //[50:200]
// Height of Pencil Box
height = 14; //[10:40]
// Wall Thickness
wallThickness = 2.0; //[1:10]
// Hinge Outer Diameter
hingeOuter = 7; //[5:20]
// Hinge Inner Diameter
hingeInner = 3; //[2:16
// Hinge Slop
hingeInnerSlop = .95; //[.35:1]
// Hinge Finger Slop
hingeFingerSlop = .94; //[.35:1]

fingerLength = hingeOuter/1.65;
fingerSize = 6.8;
topFingerSize = fingerSize;
latchWidth = 10;

difference(){union(){
bottom();
top();
bottomLatch();
}
#	translate([-fingerLength*4.75, -depth/35, 0]) writecube(message,rotate=[0,0,90],where=[0,6+0,1.25],size=[14.7,2*2,5],h=16.5,t=20,face="top",font=str(Font));

}

module bottom() {
	union() {
		// main box and cutout
		difference() {
			translate([-width - fingerLength, -depth/2, 0]) {
				cube([width,depth,height]);
			}
	
			translate([(-width - fingerLength) + wallThickness, -depth/2 + wallThickness, wallThickness]) {
				cube([width - (wallThickness * 2), depth - (wallThickness * 2), height]);
			}			
		}

		// new latch
		difference() {
			hull() {
					translate([-(fingerLength*2) - width,-latchWidth,height-2.25]) {
						rotate([-90,0,0]) {
							cylinder(r = hingeOuter/2, h = latchWidth*2);
						}
					}
					translate([-width - fingerLength, -latchWidth, height-hingeOuter-2.25]) {
						cube([.1, latchWidth * 2, hingeOuter]);
					}
					translate([-(fingerLength*2) -width, -latchWidth,height-2.25]){
							cube([fingerLength,latchWidth * 2,.1]);
						}
						translate([-(fingerLength*2) -width, -latchWidth,height-2.25]){
							rotate([0,-20,0]) {
								cube([hingeOuter-wallThickness,latchWidth*2,.01]);
							}
						}
				}
			translate([-(fingerLength*3) - width, -(latchWidth/2) - hingeFingerSlop,0]) {
					cube([fingerLength*3, latchWidth + hingeFingerSlop * 2,height*2]);
			}
		}
		// latch rod
		translate([-(fingerLength*2) -width, -latchWidth/2 - hingeFingerSlop, height-2.25]) {
			rotate([-90,0,0]) {
				cylinder(r = hingeInner /2, h = latchWidth + (hingeFingerSlop*2));
			}
		}

		difference() {
			hull() {
				translate([0,-depth/2,height]) {
					rotate([-90,0,0]) {
						cylinder(r = hingeOuter/2, h = depth);
					}
				}
				translate([-fingerLength - .1, -depth/2,height - hingeOuter]){
					cube([.1,depth,hingeOuter]);
				}
				translate([-fingerLength, -depth/2,height-.1]){
					cube([fingerLength,depth,.1]);
				}
				translate([0, -depth/2,height]){
					rotate([0,45,0]) {
						cube([hingeOuter/2,depth,.01]);
					}
				}
			}
			// finger cutouts

			for  (i = [-depth/2 + fingerSize:fingerSize*2:depth/2]) {
				translate([-fingerLength,i - (fingerSize/2) - (hingeFingerSlop/2),0]) {
					cube([fingerLength*2,fingerSize + hingeFingerSlop,height*2]);
				}
			}
		}

		// center rod
		translate([0, -depth/2, height]) {
			rotate([-90,0,0]) {
				cylinder(r = hingeInner /2, h = depth);
			}
		}
	}
}

module top() {
	union() {
		difference() {
			translate([fingerLength, -depth/2, 0]) {
				cube([width,depth,height - .5]);
			}
	
			translate([fingerLength + wallThickness, -depth/2 + wallThickness, wallThickness]) {
				cube([width - (wallThickness * 2), depth - (wallThickness * 2), height]);
			}

//#		mirror([1,0,0]) translate([+fingerLength*3.5, -depth/35, 0]) writecube(message,rotate=[0,0,90],where=[0,6+0,1.25],size=[14.7,2*2,5],h=16.5,t=20,face="top",font=str(Font));
			
		}

		// new latch
		difference() {
			hull() {
					translate([(fingerLength*2) + width,-latchWidth,height/2]) {
						rotate([-90,0,0]) {
							cylinder(r = hingeOuter/2, h = latchWidth*2);
						}
					}
					translate([width + fingerLength, -latchWidth, 0]) {
						cube([.1, latchWidth * 2, hingeOuter]);
					}
					translate([fingerLength + width, -latchWidth,height/2]){
						cube([fingerLength,latchWidth * 2,.1]);
					}
					translate([fingerLength + width, -latchWidth,(height/2) + (hingeOuter/1.5)]){
						rotate([0,45,0]) {
							cube([hingeOuter,latchWidth*2,.01]);
						}
					}
			}
			translate([fingerLength + width, -(latchWidth/2) - hingeFingerSlop,0]) {
					cube([fingerLength*2, latchWidth + (hingeFingerSlop * 2),height*2]);
			}
		}
		// latch rod
		translate([(fingerLength*2) + width, -latchWidth/2 - hingeFingerSlop, height/2]) {
			rotate([-90,0,0]) {
				cylinder(r = hingeInner /2, h = latchWidth + (hingeFingerSlop*2));
			}
		}

		difference() {
			hull() {
				translate([0,-depth/2,height]) {
					rotate([-90,0,0]) {
						cylinder(r = hingeOuter/2, h = depth);
					}
				}
				translate([fingerLength, -depth/2,height - hingeOuter - .5]){
					cube([.1,depth,hingeOuter - .5]);
				}
				translate([-fingerLength/2, -depth/2,height-.1]){
					cube([fingerLength,depth,.1]);
				}
				translate([0, -depth/2,height]){
					rotate([0,45,0]) {
						cube([hingeOuter/2,depth,.01]);
					}
				}
			}
			// finger cutouts
			for  (i = [-depth/2:fingerSize*2:depth/2 + fingerSize]) {
				translate([-fingerLength,i - (fingerSize/2) - (hingeFingerSlop/2),0]) {
					cube([fingerLength*2,fingerSize + hingeFingerSlop,height*2]);
				}
				if (depth/2 - i < (fingerSize * 1.5)) {
					translate([-fingerLength,i - (fingerSize/2) - (hingeFingerSlop/2),0]) {
						cube([fingerLength*2,depth,height*2]);
					}
				}
			}

			// center cutout
			translate([0, -depth/2, height]) {
				rotate([-90,0,0]) {
					cylinder(r = hingeInner /2 + hingeInnerSlop, h = depth);
				}
			}
		}
	}
}

module bottomLatch() {
	difference() {
		union() {
			hull() {
				translate([-(fingerLength *2) - width,-latchWidth/2,height-2.25]) {
					rotate([-90,0,0]) {
						cylinder( r = hingeOuter /2, h = latchWidth);
					}
				}
				translate([-fingerLength*2 - width,-latchWidth/2,height-hingeOuter-2.25]) {
					rotate([0,20,0]) {
						cube([.1,latchWidth,hingeOuter]);
					}
				}
				
			}
			translate([-fingerLength*2 - width -2.6 + hingeOuter/2 - wallThickness,-latchWidth/2,0]) {
				cube([2.5,latchWidth,height-4.5]);
			}
			// latch foot
			translate([-fingerLength*3 - width - 2.6,-latchWidth/2,0]) {
				cube([hingeOuter/2 + fingerLength,latchWidth,wallThickness]);
			}
			// latch cylinder catch
			translate([-fingerLength*3 - width + 1 - 2.6,-latchWidth/2,wallThickness]) {
				rotate([-90,0,0]) {
					cylinder(r = 1, h = latchWidth);
				}
			}
		}
		translate([-(fingerLength *2) - width,-latchWidth/2 - .1,height-2.25]) {
			rotate([-90,0,0]) {
				cylinder( r = hingeInner /2 + hingeInnerSlop, h = latchWidth + .2);
			}
		}
	}
}