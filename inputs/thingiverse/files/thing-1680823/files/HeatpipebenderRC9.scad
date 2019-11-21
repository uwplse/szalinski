///////////////////PIPEBENDER//////////////////////////////////// 
//done quickly on a Sunday evening and succesfully fought boredom 
//by Christoph Queck 18.07.2016//////////////////////////////////
//chris(AT)q3d.de////////////////////////////////////////////////
//This Design by Christoph Queck ( 3ddruckqueck ) is licensed under the Creative Commons - Attribution - Non-Commercial - Share Alike license.
//https://creativecommons.org/licenses/by-nc/3.0/de/
//https://creativecommons.org/licenses/by-nc/3.0/de/deed.en

//Bending radius should be at least three times the heatpipe diameter
//Printing:
//I recommend at least 3 perimeter shells and low infill (~10%)
//No supports needed

//Update1 (RC2.scad):
//Rounded the bending lever for smoother results.

//Update2 (RC3.scad):
//Set the default back to r=30mm and updated the .stl

//Update3 (RC4.scad):
//Turned the lever 90 degrees again for easier printing of the axle mounting hole


//Update4 (RC5.scad):
//Bending lever is rounded only on the backside now as it should be

//Update5 (RC6.scad):
//fixed an error for high radius bending lever

//Update7 (RC7.scad):
//colored the preview and reduced the amount of material needed for r>39

//Update8 (RC8.scad):
//Option to change the handle position for bends >90 degrees up to 180

//Update9 (RC9.scad):
//Added option for custom pipe diameters

// Which Part?
part = "Preview"; // [Preview:Preview,Handle:Handle,Bender:Lever,Axle:Axle,Bracket:Bracket]

//Bending Radius in mm
rad=40;//[15:80]
//Tolerance in mm
tolerance=0.20;//[0:0.05:1]

//Use single custom pipe instead of 6, 8, 10 mm ?
CustomPipe = "no"; // [yes,no]

//Custom pipe outer diameter in mm (only up to 16 mm supported)
CustomPipeDia=9.52;

CustomPipeRad=CustomPipeDia/2;

//Bend > 90 degrees ?
bend_180 = "no"; // [yes,no]


// preview[view:north west, tilt:top]


winkel=atan(((rad/2)-6)/(rad+15));
winkel2=atan(((20)-6)/(rad+15));
echo(winkel);

if (part == "Preview") {
	translate([0,0,8])Vorschau();
} else if (part == "Handle") {
	if (bend_180=="no"){
		Main_part();}
	else{
		Main_part180();}
} else if (part == "Bender") {
	translate([0,0,0])rotate([0,0,0])rotate([0,0,-60])translate([0,-rad-15,36])rotate([0,180,90])presse();
} else if (part == "Axle") {
	translate([0,0,rad/2-3])rotate([-90,0,0])rotate([0,0,-winkel])Flataxle();
} else if (part == "Bracket"){
	translate([0,0,-36])axlebracket();
}
else{
	echo("WAT");
}

module Vorschau(){
	preview(); 
	
}
module preview(){ 
	if (bend_180=="no"){
		color("yellow",1)Main_part();
	}
	else{
		color("yellow",1)Main_part180();
	}
	color("lime",1)axlebracket();
	color("blue",1)presse();
	color("magenta",1)Flataxle();

}


module Flataxle(){
	if (rad<40){
		rotate([0,0,winkel])rotate([90,0,0])translate([0,0,-rad/2+3])
		difference(){ //turn and flatten bottom
			translate([0,0,rad/2-3])rotate([-90,0,0])rotate([0,0,-winkel])axle();
			translate([0,0,-50])cube([200,200,100],center=true);
		}
	}
	else{
		rotate([0,0,winkel2])rotate([90,0,0])translate([0,0,-17])
		difference(){ //turn and flatten bottom
			translate([0,0,17])rotate([-90,0,0])rotate([0,0,-winkel2])axle();
			translate([0,0,-50])cube([200,200,100],center=true);
		}
	}
}

module presse(){
	difference() {
		union(){
			translate([-rad-15,0,0])cylinder(r=8,$fn=32,h=36);
			intersection(){
				translate([-rad-15,0,18])cube([30,rad*2/3,36],center=true);
				union(){
					translate([-rad-15,10,18])cube([30,rad*2/3,36],center=true);    
					translate([-rad-15,0,0])cylinder(r=15,h=60,$fn=64);
				}
			}
			translate([-rad-20,0,26])minkowski(){
				rotate([0,0,90+30])
				translate([35+rad/4,0,0])cube([60+rad/2,8,10],center=true);
				cylinder(r=6,h=5);
			}   
		}
		union(){
			intersection(){
				difference(){
					union(){
						translate([-rad-15,0,0])cylinder(r=50,h=80,$fn=32,center=true);
						//translate([-rad-15,0,19])cylinder(r=50,h=8+tolerance*2,$fn=32,center=true);
						//translate([-rad-15,0,28])cylinder(r=50,h=6+tolerance*2,$fn=32,center=true);
					}
					union(){
						translate([-rad-15,0,0])cylinder(r=15,h=80,$fn=32,center=true);
						//translate([-rad-15,0,19])cylinder(r=15,h=8+tolerance*2,$fn=32,center=true);
						//translate([-rad-15,0,28])cylinder(r=15,h=6+tolerance*2,$fn=32,center=true);
					}
				}
				translate([-rad-15,-50,0])cube([50,50,50]);
			}
			//bent pipe cut out 
            if (CustomPipe=="no"){
			translate([-rad-15,0,0])intersection(){
                
				scale([1,1.2,1])union(){
					translate([0,0,8])   
					rotate_extrude(convexity = 10, $fn = 64){
						translate([15, 0, 0])
						circle(r = 5+tolerance/2, $fn = 32);}

					translate([0,0,19])   
					rotate_extrude(convexity = 10, $fn = 64){
						translate([15, 0, 0])
						circle(r = 4+tolerance/2, $fn = 32);}

					translate([0,0,28])   
					rotate_extrude(convexity = 10, $fn = 64){
						translate([15, 0, 0])
						circle(r = 3+tolerance/2, $fn = 32);}

				}
				translate([0,-100,0])cube([100,100,100]);     
			}
        }
        else{
            
			translate([-rad-15,0,0])intersection(){
                
				scale([1,1.2,1])translate([0,0,19])   
					rotate_extrude(convexity = 10, $fn = 64){
						translate([15, 0, 0])
						circle(r = CustomPipeRad+tolerance/2, $fn = 32);}

				
				translate([0,-100,0])cube([100,100,100]);     
			}
            }
			translate([-rad-15,0,0])cylinder(r=6+tolerance,$fn=32,h=40);
			//pipe cut out straight
        if (CustomPipe=="no"){
			translate([-rad,0,8])rotate([90,0,0])cylinder(r=5+tolerance/2,h=rad*2,$fn=32,center=true);
			translate([-rad,0,19])rotate([90,0,0])cylinder(r=4+tolerance/2,h=rad*2,$fn=32,center=true);
			translate([-rad,0,28])rotate([90,0,0])cylinder(r=3+tolerance/2,h=rad*2,$fn=32,center=true);
        }
        else{
            translate([-rad,0,19])rotate([90,0,0])cylinder(r=CustomPipeRad+tolerance/2,h=rad*2,$fn=32,center=true);
            }
			translate([-rad-15-50,-40,0])rotate([0,0,90+30])
			translate([30+rad/2,0,0])cube([220,100,100],center=true);   
		}
	}
}
module presseOLD(){
	difference() {
		union(){
			translate([-rad-15,0,0])cylinder(r=7.5,$fn=32,h=36);
			translate([-rad-15,0,18])cube([30,rad*2/3,36],center=true);
			translate([-rad-15,0,26])minkowski(){
				rotate([0,0,90+30])
				translate([30+rad/2,0,0])cube([60+rad,8,10],center=true);
				cylinder(r=5,h=5);
			}   
		}
		union(){
			translate([-rad-15,0,0])cylinder(r=6+tolerance,$fn=32,h=40);
			
			translate([-rad,0,8])rotate([90,0,0])cylinder(r=5+tolerance,h=rad*2,$fn=32,center=true);
			translate([-rad,0,19])rotate([90,0,0])cylinder(r=4+tolerance,h=rad*2,$fn=32,center=true);
			translate([-rad,0,28])rotate([90,0,0])cylinder(r=3+tolerance,h=rad*2,$fn=32,center=true);
		}
	}
}

module axlebracket(){
	if(rad<40){            
		
		difference(){
			union(){

					hull(){
						translate([0,0,36+tolerance*1.75])cylinder(r=rad/2+6,$fn=32,h=8-tolerance*2);
						translate([-rad-15,0,36+tolerance*1.75])cylinder(r=12,$fn=32,h=8-tolerance*2);
					}
                    
                    translate([0,0,36+tolerance*1.75])difference(){
                        cylinder(r=rad/2+10,$fn=32,h=8-tolerance*2);
                        rotate([0,0,30])translate([-50,-100,0])cube([100,100,100]);}
					translate([-rad-15,0,36+tolerance*1.75])difference(){
                        cylinder(r=16,$fn=32,h=8-tolerance*2);
                        rotate([0,0,-30])translate([-50,-100,0])cube([100,100,100]);}
                        

			}
			union()
			rotate([0,0,winkel])rotate([90,0,0])translate([0,0,-rad/2+3])
			difference(){
				translate([0,0,rad/2-3])rotate([-90,0,0])rotate([0,0,-winkel])union(){
					{
						intersection(){
							translate([0,0,40+tolerance])cube([rad/2+tolerance*3,rad+tolerance,8],center=true);
							translate([0,0,-8])cylinder(r=rad/2+tolerance,$fn=32,h=60);
						}
						
						intersection(){
							translate([-rad-15,0,40+tolerance])cube([6+tolerance*3,rad+tolerance,8],center=true);
							translate([-rad-15,0,-8])cylinder(r=6+tolerance,$fn=32,h=60);
						}
						
						translate([0,-10,40+tolerance])cube([rad/2+tolerance*1.5,rad,8],center=true);
						translate([-rad-15,-10,40+tolerance])cube([6+tolerance*1.5,rad,8],center=true);
					}
				}

				translate([0,0,-50-tolerance])cube([200,200,100],center=true);

			}
		}
	}
	else{
		difference(){
			union(){
				
					hull(){
						translate([0,0,36+tolerance*1.75])cylinder(r=20+6,$fn=32,h=8-tolerance*2);
						translate([-rad-15,0,36+tolerance*1.75])cylinder(r=12,$fn=32,h=8-tolerance*2);
					}
					                    translate([0,0,36+tolerance*1.75])difference(){
                        cylinder(r=20+10,$fn=32,h=8-tolerance*2);
                        rotate([0,0,30])translate([-50,-100,0])cube([100,100,100]);}
					translate([-rad-15,0,36+tolerance*1.75])difference(){
                        cylinder(r=16,$fn=32,h=8-tolerance*2);
                        rotate([0,0,-30])translate([-50,-100,0])cube([100,100,100]);}
                        
				
			}
			union()
			rotate([0,0,winkel2])rotate([90,0,0])translate([0,0,-20+3])
			difference(){
				translate([0,0,20-3])rotate([-90,0,0])rotate([0,0,-winkel2])union(){
					{
						intersection(){
							translate([0,0,40+tolerance])cube([20+tolerance*3,40+tolerance,8],center=true);
							translate([0,0,-8])cylinder(r=20+tolerance,$fn=32,h=60);
						}
						
						intersection(){
							translate([-rad-15,0,40+tolerance])cube([6+tolerance*3,40+tolerance,8],center=true);
							translate([-rad-15,0,-8])cylinder(r=6+tolerance,$fn=32,h=60);
						}
						
						translate([0,-10,40+tolerance])cube([20+tolerance*1.5,40,8],center=true);
						translate([-rad-15,-10,40+tolerance])cube([6+tolerance*1.5,40,8],center=true);
					}
				}

				translate([0,0,-50-tolerance])cube([200,200,100],center=true);
				
			}
			//translate([(-rad-27)/2,0,-10])cylinder(r=rad/4-6,$fn=32,h=80);
		}
		
	}
}
module axle(){
	
	
	if (rad<40){
		
		union(){//axle
			translate([0,0,-8])cylinder(r=rad/2,$fn=32,h=44+tolerance*2.5);
			translate([-rad-15,0,-8])cylinder(r=6,$fn=32,h=44+tolerance*2.5);
			intersection(){
				translate([0,0,40+tolerance])cube([rad/2,rad,8+tolerance*3],center=true);
				translate([0,0,-8])cylinder(r=rad/2,$fn=32,h=60);
			}
			
			intersection(){
				translate([-rad-15,0,40+tolerance])cube([6,rad,8+tolerance*3],center=true);
				translate([-rad-15,0,-8])cylinder(r=6,$fn=32,h=60);
			}
			hull(){
				translate([0,0,-8])cylinder(r=rad/2,$fn=32,h=8-tolerance);
				translate([-rad-15,0,-8])cylinder(r=6,$fn=32,h=8-tolerance);
			}
			
			translate([0,0,44+tolerance*2.5])cylinder(r=rad/2,$fn=32,h=4);
			translate([-rad-15,0,44+tolerance*2.5])cylinder(r=6,$fn=32,h=4);
		}
	}
	else{
		difference(){
			union(){//axle
				translate([0,0,-8])cylinder(r=20,$fn=32,h=44+tolerance*2.5);
				translate([-rad-15,0,-8])cylinder(r=6,$fn=32,h=44+tolerance*2.5);
				intersection(){
					translate([0,0,40+tolerance])cube([20,40,8+tolerance*3],center=true);
					translate([0,0,-8])cylinder(r=20,$fn=32,h=60);
				}
				
				intersection(){
					translate([-rad-15,0,40+tolerance])cube([6,40,8+tolerance*3],center=true);
					translate([-rad-15,0,-8])cylinder(r=6,$fn=32,h=60);
				}
				hull(){
					translate([0,0,-8])cylinder(r=20,$fn=32,h=8-tolerance);
					translate([-rad-15,0,-8])cylinder(r=6,$fn=32,h=8-tolerance);
				}
				
				translate([0,0,44+tolerance*2.5])cylinder(r=20,$fn=32,h=4);
				translate([-rad-15,0,44+tolerance*2.5])cylinder(r=6,$fn=32,h=4);
			}
			translate([0,0,-10])scale([1,1.7,1])cylinder(r=5,$fn=32,h=70+tolerance*2.5);

		}
	}
}






module ausschnitt(){
	difference(){
		union(){
			translate([0,0,-1])cylinder(r=rad-10,h=40,$fn=64);
			//translate([-rad-12,-rad-5,0])cube([rad+12,rad/2+2,36]);  
		}
		union(){
			cylinder(r=26+tolerance,h=36,$fn=64);
			rotate([0,0,0])translate([rad/2,0,18])cube([rad,8,38],center=true);
			rotate([0,0,120])translate([rad/2,0,18])cube([rad,8,38],center=true);
			rotate([0,0,240])translate([rad/2,0,18])cube([rad,8,38],center=true);
			
		}
	}
}
module Main_part(){
	if (rad<40){
		union(){  
			difference(){
				union(){//center part
					cylinder(r=rad-0.5-tolerance,h=36,$fn=64);

					//pipe holder
					translate([-rad-12,-rad-5,0])cube([rad+12,rad/2+2,36]);
					//cut out pipes straight part
				}     
				translate([-rad,-rad,8])rotate([90,0,0])cylinder(r=5+tolerance,h=rad*2,$fn=32,center=true);
				translate([-rad,-rad,19])rotate([90,0,0])cylinder(r=4+tolerance,h=rad*2,$fn=32,center=true);
				translate([-rad,-rad,28])rotate([90,0,0])cylinder(r=3+tolerance,h=rad*2,$fn=32,center=true);
				
				//cut out pipes round part


				union(){
					difference(){

						union(){
							translate([0,0,8])   
							rotate_extrude(convexity = 10, $fn = 64){
								translate([rad, 0, 0])
								circle(r = 5+tolerance, $fn = 32);}

							translate([0,0,19])   
							rotate_extrude(convexity = 10, $fn = 64){
								translate([rad, 0, 0])
								circle(r = 4+tolerance, $fn = 32);}

							translate([0,0,28])   
							rotate_extrude(convexity = 10, $fn = 64){
								translate([rad, 0, 0])
								circle(r = 3+tolerance, $fn = 32);}

						}
						hull(){
							translate([rad+20,-rad-20,0])cube([1,1,50]);
							rotate([0,0,-5])translate([rad+20,0,0])cube([1,1,50]);
							rotate([0,0,180])translate([rad+20,0,0])cube([1,1,50]);
							translate([-rad-20,-rad-20,0])cube([1,1,50]);
						}
						//translate([-50,-100,0])cube([100,100,100]);
						

					}
					cylinder(r=rad/2+tolerance,h=36,$fn=64);
				}
			}
			difference(){
				translate([0,-rad+5,0])minkowski(){
					
					cube([80+rad,5,10]);
					cylinder(r=8,h=5);
				}
				cylinder(r=rad/2+tolerance,h=36,$fn=64);
			}
		}
	}
	else{
		union(){
			difference(){
				union(){//center part
					cylinder(r=rad-0.5-tolerance,h=36,$fn=64);
					
					//pipe holder
					translate([-rad-12,-rad-5,0])cube([rad+12,rad/2+2,12]);
					translate([-rad-12,-rad-5,0])cube([25+rad/10,rad/2+2,36]);
					//cut out pipes straight part
				}     
				translate([-rad,-rad,8])rotate([90,0,0])cylinder(r=5+tolerance,h=rad*2,$fn=32,center=true);
				translate([-rad,-rad,19])rotate([90,0,0])cylinder(r=4+tolerance,h=rad*2,$fn=32,center=true);
				translate([-rad,-rad,28])rotate([90,0,0])cylinder(r=3+tolerance,h=rad*2,$fn=32,center=true);
				
				//cut out pipes round part


				union(){
					difference(){

						union(){
							translate([0,0,8])   
							rotate_extrude(convexity = 10, $fn = 64){
								translate([rad, 0, 0])
								circle(r = 5+tolerance, $fn = 32);}

							translate([0,0,19])   
							rotate_extrude(convexity = 10, $fn = 64){
								translate([rad, 0, 0])
								circle(r = 4+tolerance, $fn = 32);}

							translate([0,0,28])   
							rotate_extrude(convexity = 10, $fn = 64){
								translate([rad, 0, 0])
								circle(r = 3+tolerance, $fn = 32);}

						}
						hull(){
							translate([rad+20,-rad-20,0])cube([1,1,50]);
							rotate([0,0,-5])translate([rad+20,0,0])cube([1,1,50]);
							rotate([0,0,180])translate([rad+20,0,0])cube([1,1,50]);
							translate([-rad-20,-rad-20,0])cube([1,1,50]);
						}
						//translate([0,100,0])cube([100,100,100],center=true);

					}
					cylinder(r=20+tolerance,h=36,$fn=64);
					ausschnitt();
				}
			}
			difference(){
				translate([0,-rad+5,0])minkowski(){
					
					cube([80+rad,5,10]);
					cylinder(r=10,h=5);
				}
				cylinder(r=20+tolerance,h=36,$fn=64);
				ausschnitt();
			}
		}
		
	}
}

module Main_part180(){
	if (rad<40){
		union(){  
			difference(){
				union(){//center part
					cylinder(r=rad-0.5-tolerance,h=36,$fn=64);

					//pipe holder
					translate([-rad-12,-rad-5,0])cube([rad+12,rad/2+2,36]);
					//cut out pipes straight part 6, 8, 10 mm
				}
                if (CustomPipe=="no"){
				translate([-rad,-rad,8])rotate([90,0,0])cylinder(r=5+tolerance,h=rad*3,$fn=32,center=true);
				translate([-rad,-rad,19])rotate([90,0,0])cylinder(r=4+tolerance,h=rad*3,$fn=32,center=true);
				translate([-rad,-rad,28])rotate([90,0,0])cylinder(r=3+tolerance,h=rad*3,$fn=32,center=true);
				}
                else{ ////cut out pipes straight part custom dia
                    translate([-rad,-rad,19])rotate([90,0,0])cylinder(r=CustomPipeRad+tolerance,h=rad*3,$fn=32,center=true);
                    }
				//cut out pipes round part 6, 8, 10 mm


				union(){
					difference(){
                        if (CustomPipe=="no"){
						union(){
							translate([0,0,8])   
							rotate_extrude(convexity = 10, $fn = 64){
								translate([rad, 0, 0])
								circle(r = 5+tolerance, $fn = 32);}

							translate([0,0,19])   
							rotate_extrude(convexity = 10, $fn = 64){
								translate([rad, 0, 0])
								circle(r = 4+tolerance, $fn = 32);}

							translate([0,0,28])   
							rotate_extrude(convexity = 10, $fn = 64){
								translate([rad, 0, 0])
								circle(r = 3+tolerance, $fn = 32);}

						}
                    }else{ ////cut out pipes round custom dia
                        translate([0,0,19])   
							rotate_extrude(convexity = 10, $fn = 64){
								translate([rad, 0, 0])
								circle(r = CustomPipeRad+tolerance, $fn = 32);}
                        
                        }
						hull(){
							translate([rad+20,-rad-20,0])cube([1,1,50]);
							rotate([0,0,0])translate([0,0,0])cube([1,1,50]);
							rotate([0,0,180])translate([rad+20,0,0])cube([1,1,50]);
							translate([-rad-20,-rad-20,0])cube([1,1,50]);
						}

						//translate([-50,-100,0])cube([100,100,100]);
						

					}
					cylinder(r=rad/2+tolerance,h=36,$fn=64);
				}
			}
			difference(){
				translate([0,-rad+5,0])rotate([0,0,-90])minkowski(){
					
					cube([80+rad,5,10]);
					cylinder(r=8,h=5);
					
				}
				cylinder(r=rad/2+tolerance,h=36,$fn=64);
			}
		}
	}
	else{
		union(){
			difference(){
				union(){//center part
					cylinder(r=rad-0.5-tolerance,h=36,$fn=64);
					
					//pipe holder
					translate([-rad-12,-rad-5,0])cube([rad+12,rad/2+2,12]);
					translate([-rad-12,-rad-5,0])cube([25+rad/10,rad/2+2,36]);
					//cut out pipes straight part
				}     
			if (CustomPipe=="no"){
				translate([-rad,-rad,8])rotate([90,0,0])cylinder(r=5+tolerance,h=rad*3,$fn=32,center=true);
				translate([-rad,-rad,19])rotate([90,0,0])cylinder(r=4+tolerance,h=rad*3,$fn=32,center=true);
				translate([-rad,-rad,28])rotate([90,0,0])cylinder(r=3+tolerance,h=rad*3,$fn=32,center=true);
				}
                else{ ////cut out pipes straight part custom dia
                    translate([-rad,-rad,19])rotate([90,0,0])cylinder(r=CustomPipeRad+tolerance,h=rad*3,$fn=32,center=true);
                    }
				
				//cut out pipes round part


				union(){
					difference(){

					if (CustomPipe=="no"){
						union(){
							translate([0,0,8])   
							rotate_extrude(convexity = 10, $fn = 64){
								translate([rad, 0, 0])
								circle(r = 5+tolerance, $fn = 32);}

							translate([0,0,19])   
							rotate_extrude(convexity = 10, $fn = 64){
								translate([rad, 0, 0])
								circle(r = 4+tolerance, $fn = 32);}

							translate([0,0,28])   
							rotate_extrude(convexity = 10, $fn = 64){
								translate([rad, 0, 0])
								circle(r = 3+tolerance, $fn = 32);}

						}
                    }else{ ////cut out pipes round custom dia
                        translate([0,0,19])   
							rotate_extrude(convexity = 10, $fn = 64){
								translate([rad, 0, 0])
								circle(r = CustomPipeRad+tolerance, $fn = 32);}
                        
                        }
						hull(){
							translate([rad+20,-rad-20,0])cube([1,1,50]);
							rotate([0,0,0])translate([0,0,0])cube([1,1,50]);
							rotate([0,0,180])translate([rad+20,0,0])cube([1,1,50]);
							translate([-rad-20,-rad-20,0])cube([1,1,50]);
						}
						//translate([0,100,0])cube([100,100,100],center=true);

					}
					cylinder(r=20+tolerance,h=36,$fn=64);
					ausschnitt();
				}
			}
			difference(){
				translate([0,-rad+5,0])rotate([0,0,-90])minkowski(){
					
					cube([80+rad,5,10]);
					cylinder(r=10,h=5);
				}
				cylinder(r=20+tolerance,h=36,$fn=64);
				ausschnitt();
			}
		}
		
	}
}