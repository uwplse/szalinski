
/* [Size of bead] */
//other shapes will be inscribed in a circle with that diameter
diameter_of_bead = .5;
height_of_bead = .1875;
/*[the hole in the bead]*/
diameter_of_hole = .0625;
axis_hole_is_on = 2;//[1:"z",2:"x",3:"y",4:"no hole"]
/*[advanced features]*/
//only mess with if you dare ^_^
ignore_error_messages = 2;//[1:true,0:false]

bead_shape = 9; //[0: circle, 1: 5 point star, 2: 6 point star, 3: triangle, 4: square, 5: pentagon, 6: hexagon, 8: octogon, 9: heart, 10: android, 11: (also not ready yet) apple]
resoultion = 40;//[5:100]
rounded_center =1;//[1:true,0:false]
//won't be implemented (yet...)
number_of_Colors = 1;


/* [Unit adjustment] */
//Basically are you using american units or real units
units_entered = 25.4;//[1:mm, 10:cm, 1000:meter, 25.4:inch, 304.8:foot]

//default is mm for most printers
desired_units_for_output = 1;//[1:mm, .1:cm, 0.001:meter, 0.0393701:inch, 0.00328084:foot]
//CUSTOMIZER VARIABLES END

unit_conversion_factor = units_entered*desired_units_for_output;

module base_shape (type_of_shape = 0){
	linear_extrude(height_of_bead*unit_conversion_factor){
		if(type_of_shape == 0){
			//circle
			circle(diameter_of_bead*unit_conversion_factor/2,$fn=resoultion);
		}
		else if(type_of_shape ==1){
			//5 point star
			rotate([0,0,-90]){
				polygon([[0,.5],[.476,.155],[.294,-.405],[-.294,-.405],[-.476,.155]]*diameter_of_bead*unit_conversion_factor,[[0,2,4,1,3]]);
				polygon([[.113,.156],[.182,-.059],[0,-.192],[-.182,-.059],[-.113,.156]]*diameter_of_bead*unit_conversion_factor,[[0,1,2,3,4]]);
			}
		}
		else if(type_of_shape ==2){
			//6 point star
			circle(diameter_of_bead*unit_conversion_factor/2,$fn=3);
			rotate([0,0,180]){
				circle(diameter_of_bead*unit_conversion_factor/2,$fn=3);
			}
		}
		else if(type_of_shape ==3){
			//triangle
			circle(diameter_of_bead*unit_conversion_factor/2,$fn=3);
		}
		else if(type_of_shape ==4){
			//square
			circle(diameter_of_bead*unit_conversion_factor/2,$fn=4);
		}
		else if(type_of_shape ==5){
			//pentagon
			circle(diameter_of_bead*unit_conversion_factor/2,$fn=5);
		}
		else if(type_of_shape ==6){
			//hexagon
			circle(diameter_of_bead*unit_conversion_factor/2,$fn=6);
		}
		else if(type_of_shape ==8){
			//octogon
				circle(diameter_of_bead*unit_conversion_factor/2,$fn=8);
		}
		/*else if(true){
			text("invalid shape of bead");
		}*/
		else if(type_of_shape == 9){
			rotate([0,0,90]){
				scale([diameter_of_bead*unit_conversion_factor,diameter_of_bead*unit_conversion_factor,0]){
					polygon([[.433,.25],[0,-.5],[-.433,.25],[-.393,.302],[-.342,.342],[-.281,.366],[-.217,.375],[-.152,.366],[-.092,.342],[-.04,.302],[0,.25],[.04,.302],[.092,.342],[.152,.366],[.217,.375],[.281,.366],[.342,.342],[.393,.302]]);
				}
			}
		}
		else if(type_of_shape ==10){
			//android
			scale([diameter_of_bead*unit_conversion_factor,diameter_of_bead*unit_conversion_factor,0]){
				translate([.25,0,0]){
					//head
					circle(.25,$fn = resoultion);
				}
				//body
				square(.5,center=true);
				translate([0,.25+.0312,0]){
					//left arm
					polygon(points=[[-.125,-.03125],[-.125,.03125],[.125,.03125],[.125,-.03125]]);
					translate([.125,0,0]){
						circle(.03125,$fn = resoultion);
					}
					translate([-.125,0,0]){
						circle(.03125,$fn = resoultion);
					}
				}
				translate([0,-.25-.0312,0]){
					//right arm
					polygon(points=[[-.125,-.03125],[-.125,.03125],[.125,.03125],[.125,-.03125]]);
					translate([.125,0,0]){
						circle(.03125,$fn = resoultion);
					}
					translate([-.125,0,0]){
						circle(.03125,$fn = resoultion);
					}
				}
				translate([-.25,.125,0]){
					//left leg
					polygon(points=[[-.125,-.0625],[-.125,.0625],[.125,.0625],[.125,-.0625]]);
					translate([-.125,0,0]){
						circle(.0625,$fn = resoultion);
					}
				}
				translate([-.25,-.125,0]){
					//right leg
					polygon(points=[[-.125,-.0625],[-.125,.0625],[.125,.0625],[.125,-.0625]]);
					translate([-.125,0,0]){
						circle(.0625,$fn = resoultion);
					}
				}
			}
			
		}
		else if(type_of_shape ==11){
			
		}


	}
}
module holes_to_be_cut(){	
	translate([0,0,-.1*unit_conversion_factor]){
		linear_extrude((height_of_bead+diameter_of_bead+1)*unit_conversion_factor,center=true)
				circle([diameter_of_hole*unit_conversion_factor,diameter_of_hole*unit_conversion_factor],$fn=resoultion/2);
	}
}
	
module round_bead(){
	translate([0,0,height_of_bead*unit_conversion_factor/2]){
		resize(newsize=[diameter_of_bead*unit_conversion_factor,diameter_of_bead*unit_conversion_factor,height_of_bead*unit_conversion_factor],center=true){
				sphere(diameter_of_bead*unit_conversion_factor,$fn=resoultion);
		}
	}
}
//user error message, aka warning you broke it

intersection(){
	difference(){
		base_shape(type_of_shape =bead_shape);
		if(axis_hole_is_on == 1){
			rotate([0,0,0]){
				holes_to_be_cut();
			}
		}
		else if(axis_hole_is_on == 2){
			translate([0,0,height_of_bead*unit_conversion_factor/2]){
				rotate([0,90,0]){
					holes_to_be_cut();
				}
			}
		}
		else if(axis_hole_is_on==3){
			translate([0,0,height_of_bead*unit_conversion_factor/2]){
				rotate([90,0,0]){
					holes_to_be_cut();
				}
			}
		}
	}
	
	if(rounded_center==1){
		round_bead();
	}
}
