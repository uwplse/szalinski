include <utils/build_plate.scad>

//preview[view:west, tilt:top]

//Overall Scale	
worldScale = 1; 


//Direction of eyes
eyeRotate = 90; //[0:360]

//Distance to center of eye
eyeDistance = 0; //[0:15] 
pupilDist = eyeDistance/10; 


//How long are his antenna.
antennaLength = 5; //[1:10]

// Antennas
antenna = true; //["true", "false"]

// Attach a loop to hang it with.
keyAttachPos = [22, 0, 0];

// Cut out the center from the rest.
keyAttachCutOut = false; //[true, false]

// Width of the body.
bodyWidth = 13; //[4:20]

// Height of body.
bodyLength = 18; //[2:25]

// Angle of head
headAngle = 0; //[-15:15]


//Right Claw Open
rightClawAmount = 30; //[0:100]


// Width of arms.
armWidth = 4; //[2:10]
rightUpperArmAngle = -45; //[-180:180]
rightUpperArmLength = 8; //[2:20]
rightLowerArmAngle = 45; //[-180:180]
rightLowerArmLength = 7; //[2:20]

leftUpperArmAngle = 45; //[-180:180]
leftUpperArmLength = 8; //[2:20]
leftLowerArmAngle = -45; //[-180:180]
leftLowerArmLength = 7; //[2:20]

//left Claw Open
leftClawAmount = 30; //[0:100]

// Width of legs.
legWidth = 5; //[2:10]
rightUpperLegAngle = 0; //[-180:180]
rightUpperLegLength = 8; //[2:20]
rightLowerLegAngle = 0; //[-180:180]
rightLowerLegLength = 7; //[2:20]
rightFootAngle = 0; //[-180:180]

leftUpperLegAngle = 0; //[-180:180]
leftUpperLegLength = 8; //[2:20]
leftLowerLegAngle = 0; //[-180:180]
leftLowerLegLength = 7; //[2:20]
leftFootAngle = 0; //[-180:180]

//	This section is creates the build plates for scale
//	for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//	when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//	when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

//CUSTOMIZER VARIABLES END

//	This is just a Build Plate for scale
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);


module head_A(){

	union(){
	
		translate([5, 0, 0])
		
			scale([1, 1, 0.6]) rotate([0, 90, 0]) rotate([0, 0, 45]) cylinder(h=2, r1=8, r2=5, $fn=4);

			
		
		
		translate([0, -3.5, 5]){
			difference() {
				cylinder(h=2, r1=4, r2=4, center=true, $fn=32);
				translate([0, 0, 1]) cylinder(h=2, r1=3, r2=3, center=true,$fn=32);
			}
		}
		
		translate([0, -3.5, 4.5]) rotate([0, 0, eyeRotate]) translate([0, pupilDist, 0]) cylinder(h=1.4, r1=2, r2=2, $fn=32);
		translate([0, 3.5, 4.5]) rotate([0, 0, eyeRotate]) translate([0, pupilDist, 0]) cylinder(h=1.4, r1=2, r2=2, $fn=32);
	
	
		translate([0, 3.5, 5]){
			difference() {
				cylinder(h=2, r1=4, r2=4, center=true, $fn=32);
				translate([0, 0, 1]) cylinder(h=2, r1=3, r2=3, center=true, $fn=32);
			}
		}
		
		
	
		
		translate([0, 0, 1]){
					difference(){
						cube(size=[9.99, 15.99, 7.9], center=true);

						difference(){
							union(){
								translate([6, 9, 0]) cube(size=[4, 4, 8.5], center=true);
								translate([6, -9, 0]) cube(size=[4, 4, 8.5], center=true);
								translate([-6, -9, 0]) cube(size=[4, 4, 8.5], center=true);
								translate([-6, 9, 0]) cube(size=[4, 4, 8.5], center=true);
								translate([-6, 0, 5]) cube(size=[4, 16, 4], center=true);	
								translate([6, 0, 5]) cube(size=[4, 16, 4], center=true);	
								translate([0, -9, 5]) cube(size=[10, 4, 4], center=true);
								translate([0, 9, 5]) cube(size=[10, 4, 4], center=true);			
							}
		
							union(){
								translate([4, 7, 0])cylinder(h=6, r1=1, r2=1, center=true, $fn=32);
								translate([-4, 7, 0])cylinder(h=6, r1=1, r2=1, center=true, $fn=32);
								translate([-4, -7, 0])cylinder(h=6, r1=1, r2=1, center=true, $fn=32);
								translate([4, -7, 0])cylinder(h=6, r1=1, r2=1, center=true, $fn=32);
								translate([4, 7, 3]) sphere(r=1.001, $fn=32);
								translate([-4, 7, 3]) sphere(r=1.001, $fn=32);
								translate([-4, -7, 3]) sphere(r=1.001, $fn=32);
								translate([4, -7, 3]) sphere(r=1.001, $fn=32);
								translate([4, 0, 3]) rotate([90, 0, 0]) cylinder(h=14, r1=1, r2=1, center=true, $fn=32);
								translate([-4, 0, 3]) rotate([90, 0, 0]) cylinder(h=14, r1=1, r2=1, center=true, $fn=32);
	
								translate([0, 7, 3]) rotate([90, 0, 90]) cylinder(h=8, r1=1, r2=1, center=true, $fn=32);
								translate([0, -7, 3]) rotate([90, 0, 90]) cylinder(h=8, r1=1, r2=1, center=true, $fn=32);
					
							}					
						}


				}
					
		}
	
		if (antenna) {
			translate([0, -7.5, 0]) rotate([90, 0, 0]){
				translate([0, 0, 1]) cylinder(h=antennaLength-0.5, r1=1, r2=0.3, $fn=32) ;
		
				scale([1, 1, 0.4]) sphere(r=3.5, $fn=32);
				translate([0, 0, antennaLength]) sphere(r=1, $fn=32);
		
			}
		
			translate([0, 7.5, 0]) rotate([90, 0, 0]){
				translate([0, 0, -1]) rotate([180, 0, 0])cylinder(h=antennaLength-0.5, r1=1, r2=0.3, $fn=32) ;
				scale([1, 1, 0.4]) sphere(r=3.5, $fn=32);
				translate([0, 0, -antennaLength]) sphere(r=1, $fn=32);
			}
		}else{
			translate([0, -7.5, 0]) rotate([90, 0, 0]){
				scale([1, 1, 0.4]) sphere(r=3.5, $fn=32);
			}
		
			translate([0, 7.5, 0]) rotate([90, 0, 0]){
				scale([1, 1, 0.4]) sphere(r=3.5, $fn=32);
			}

		}

	}
}




module body(){
		
	bodyHeight = 7;

	union(){
	
		translate([bodyLength/2, 0, -0.01]) cylinder(h=3.1, r1=3.5, r2=3.5, $fn=32);

			difference(){
				difference(){
					cube(size=[bodyLength, bodyWidth, 7], center=true);
					translate([-2.0, 0, 5])	cube(size=[bodyLength-8, bodyWidth-4, 4], center=true);
		


				difference(){
					union(){
						translate([bodyLength/2+1.5, bodyWidth/2+1.5, 0]) cube(size=[4, 4, 8.5], center=true);
						translate([bodyLength/2+1.5, -bodyWidth/2-1.5, 0]) cube(size=[4, 4, 8.5], center=true);
						translate([-bodyLength/2-1.5, -bodyWidth/2-1.5, 0]) cube(size=[4, 4, 8.5], center=true);
						translate([-bodyLength/2-1.5, bodyWidth/2+1.5, 0]) cube(size=[4, 4, 8.5], center=true);

						translate([-bodyLength/2-1.5, 0, bodyHeight/2+1.5]) cube(size=[4, bodyWidth, 4], center=true);	
						translate([bodyLength/2+1.5, 0, bodyHeight/2+1.5]) cube(size=[4, bodyWidth, 4], center=true);	
						translate([0, -bodyWidth/2-1.5, bodyHeight/2+1.5]) cube(size=[bodyLength, 4, 4], center=true);
						translate([0, bodyWidth/2+1.5, bodyHeight/2+1.5]) cube(size=[bodyLength, 4, 4], center=true);			
					}

					union(){
						translate([bodyLength/2-0.5, bodyWidth/2-0.5, 0])cylinder(h=bodyHeight-1, r1=0.5, r2=0.5, center=true, $fn=32);
						translate([-bodyLength/2+0.5, bodyWidth/2-0.5, 0])cylinder(h=bodyHeight-1, r1=0.5, r2=0.5, center=true, $fn=32);
						translate([-bodyLength/2+0.5, -bodyWidth/2+0.5, 0])cylinder(h=bodyHeight-1, r1=0.5, r2=0.5, center=true, $fn=32);
						translate([bodyLength/2-0.5, -bodyWidth/2+0.5, 0])cylinder(h=bodyHeight-1, r1=0.5, r2=0.5, center=true, $fn=32);
						
						translate([bodyLength/2-0.5, 0, bodyHeight/2-0.5]) rotate([90, 0, 0]) cylinder(h=bodyWidth-1, r1=0.5, r2=0.5, center=true, $fn=32);
						translate([-bodyLength/2+0.5, 0, bodyHeight/2-0.5]) rotate([90, 0, 0]) cylinder(h=bodyWidth-1, r1=0.5, r2=0.5, center=true, $fn=32);
						translate([0, bodyWidth/2-0.5, bodyHeight/2-0.5]) rotate([90, 0, 90]) cylinder(h=bodyLength-1, r1=0.5, r2=0.5, center=true, $fn=32);
						translate([0, -bodyWidth/2+0.5, bodyHeight/2-0.5]) rotate([90, 0, 90]) cylinder(h=bodyLength-1, r1=0.5, r2=0.5, center=true, $fn=32);

						translate([bodyLength/2-0.5, bodyWidth/2-0.5, bodyHeight/2-0.5]) sphere(r=0.5, $fn=32);
						translate([-bodyLength/2+0.5, bodyWidth/2-0.5, bodyHeight/2-0.5]) sphere(r=0.5, $fn=32);
						translate([-bodyLength/2+0.5, -bodyWidth/2+0.5, bodyHeight/2-0.5]) sphere(r=0.5, $fn=32);
						translate([bodyLength/2-0.5, -bodyWidth/2+0.5, bodyHeight/2-0.5]) sphere(r=0.5, $fn=32);
			
					}					
				}

		}
			
			

			
			
	}
	
		translate([bodyLength/2-3, bodyWidth/2-3, 3.9]) cylinder(h=0.6, r1=1.6, r2=1.4, $fn=32);
		translate([bodyLength/2-3, 0, 3.9]) cylinder(h=0.6, r1=1.6, r2=1.4, $fn=32);
		translate([bodyLength/2-3, -bodyWidth/2+3, 3.9]) cylinder(h=0.6, r1=1.6, r2=1.4, $fn=32);


	}

}




module armComponent(length, width) {
	
	union(){
		difference (){
			cylinder(h=3, r1=width/2, r2=width/2, $fn=32);
			translate([0, 0, 2.5]) cylinder(h=2.01, r1=width/2-1, r2=width/2-1, $fn=32);
		}
		
		difference(){
				
				translate([-length/2, 0, 0]){
					difference(){
						cube(size=[length, width-0.2, 5], center=true, $fn=32);
				
						//translate([0, 0, 4.7]) cube(size=[length-2, width-2, 5], center=true);
					}
				}

			translate([0, 0, 1]) cylinder(h=2.01, r1=width/2-0.2, r2=width/2-0.2, $fn=32);
			translate([-length, 0,-1.5]) cylinder(h=5.001, r1=width/2-0.2, r2=width/2-0.2, $fn=32);

		
		}

	}
}


module arm(position, width, foreArmLength, foreArmAngle, bicepLength, bicepAngle, clawAmount){
	
	union(){
		translate(position){
			rotate([0, 0, bicepAngle]){
				armComponent(bicepLength, width);
				translate([-bicepLength, 0, 0]){
					 rotate([0, 0, foreArmAngle]){
						armComponent(foreArmLength, width);
						translate([-foreArmLength, 0, 0]) hand(clawAmount, width);
					}
				}

			}
		}
	}

}

module foot(width, offset, mirror, openAngle){
	
	difference (){
		cylinder(h=3, r1=width/2, r2=width/2, $fn=32);
		translate([0, 0, 2.5]) cylinder(h=2, r1=width/2-1, r2=width/2-1, $fn=32);
	}
	rotate([0, 0, openAngle]){
		translate([0, 0, 0]){
			difference(){
				translate([-width/2-width/6, width/3*mirror, 0]) cube(size=[4, width*1.6, 5], center=true);
				rotate([0, 0, 45*mirror ]) translate([-width/2+width*1.2, offset, 0]) cube(size=[4, width*15, 8], center=true);
				translate([0, 0, -2.5]) cylinder(h=10, r1=width/2, r2=width/2, $fn=32);
		
			}
		}
	}
}


module leg(position, width, foreArmLength, foreArmAngle, bicepLength, bicepAngle, mirror, footAngle){
	
	union(){
		translate(position){
			rotate([0, 0, bicepAngle]){
				armComponent(bicepLength, width);
				translate([-bicepLength, 0, 0]){
					 rotate([0, 0, foreArmAngle]){
						armComponent(foreArmLength, width);
						translate([-foreArmLength, 0, 0]) foot(width+0.5, 2,mirror, footAngle);
					}
				}

			}
		}
	}

}



module hand(openAmount, width){
	
	difference (){
		cylinder(h=3, r1=width/2, r2=width/2, $fn=32);
		translate([0, 0, 2.5]) cylinder(h=2, r1=width/2-1, r2=width/2-1, $fn=32);
	}
	
			openAngle = openAmount/100*45;
			rotate([0, 0, -openAngle]){
				translate([-width+0.2, 0, 0]){
				difference(){
					cylinder(h=2.3, r1=width/2+1, r2=width/2+1, $fn=32);
					translate([0.3, 0, -1]) cylinder(h=5, r1=width/2-0.5, r2=width/2-0.5, $fn=32);
					translate([0, -5, 0]) cube(size = [10, 10, 10], center=true);
				}
			}
			}
			rotate([0, 0, openAngle]){
				translate([-width+0.2, 0, 0]){
				difference(){
					cylinder(h=2.3, r1=width/2+1, r2=width/2+1, $fn=32);
					translate([0.3, 0, -1]) cylinder(h=5, r1=width/2-0.5, r2=width/2-0.5, $fn=32);
					translate([0, 5, 0]) cube(size = [10, 10, 10], center=true);
				}
			}	

	
}
	


}


scale([worldScale, worldScale, worldScale]){
difference(){
	union(){
		if (!keyAttachCutOut){
			

			difference(){
				translate(keyAttachPos) cylinder(h=1.5, r1=3, r2=3, $fn=32);
				translate([keyAttachPos[0], keyAttachPos[1], keyAttachPos[2]-0.2]) cylinder(h=10, r1=2, r2=2, $fn=32);
				}
		}else{
			translate(keyAttachPos) cylinder(h=1, r1=3, r2=3, $fn=32);

		}


		translate([bodyLength/2, 0, 0]) rotate([0, 0, headAngle]) translate([6, 0, 0]) head_A();	
		
		body();
		arm([bodyLength/2-4, bodyWidth/2, 0], armWidth, rightLowerArmLength, rightLowerArmAngle, rightUpperArmLength, rightUpperArmAngle, rightClawAmount);
		arm([bodyLength/2-4, -bodyWidth/2, 0], armWidth, leftLowerArmLength, leftLowerArmAngle, leftUpperArmLength, leftUpperArmAngle, leftClawAmount);
		
		leg([-bodyLength/2-0.5, bodyWidth/2-legWidth/2+0.5, 0], legWidth, rightLowerLegLength, rightLowerLegAngle, rightUpperLegLength, rightUpperLegAngle, 1, rightFootAngle);
		leg([-bodyLength/2-0.5, -bodyWidth/2+legWidth/2-0.5, 0], legWidth, leftLowerLegLength, leftLowerLegAngle, leftUpperLegLength, leftUpperLegAngle, -1, leftFootAngle);
	


	}

	
	translate([0, 0, -5])	cube(size=[100, 100, 10], center=true);

	if (keyAttachCutOut){
		translate([keyAttachPos[0], keyAttachPos[1], keyAttachPos[2]-0.2]) cylinder(h=10, r1=2, r2=2, $fn=32);
	}

}


}






