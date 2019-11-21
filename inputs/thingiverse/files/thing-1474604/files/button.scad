
/* [Size of button] */
//other shapes will be inscribed in a circle with that diameter
diameter_of_button = 1;
height_of_button = .125;
/*[holes in the button]*/
radi_to_center_of_hole = .125;
diameter_of_hole = .0625;
number_of_holes = 4; //[2:8]

/*[advanced features]*/
//only mess with if you dare ^_^
ignore_error_messages = 2;//[1:true,2:false]

button_shape = 0; //[0: circle, 1: 5 point star, 2: 6 point star, 3: triangle, 4: square, 5: pentagon, 6: hexagon, 8: octogon, 9: heart, 10: android, 11: (also not ready yet) apple]
resoultion = 40;//[5:100]
rounded_center = 1;//[1:true,2:false]
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
	linear_extrude(height_of_button*unit_conversion_factor){
		if(type_of_shape == 0){
			//circle
			circle(diameter_of_button*unit_conversion_factor/2,$fn=resoultion);
		}
		else if(type_of_shape ==1){
			//5 point star
			rotate([0,0,-90]){
				polygon([[0,.5],[.476,.155],[.294,-.405],[-.294,-.405],[-.476,.155]]*diameter_of_button*unit_conversion_factor,[[0,2,4,1,3]]);
				polygon([[.113,.156],[.182,-.059],[0,-.192],[-.182,-.059],[-.113,.156]]*diameter_of_button*unit_conversion_factor,[[0,1,2,3,4]]);
			}
		}
		else if(type_of_shape ==2){
			//6 point star
			circle(diameter_of_button*unit_conversion_factor/2,$fn=3);
			rotate([0,0,180]){
				circle(diameter_of_button*unit_conversion_factor/2,$fn=3);
			}
		}
		else if(type_of_shape ==3){
			//triangle
			circle(diameter_of_button*unit_conversion_factor/2,$fn=3);
		}
		else if(type_of_shape ==4){
			//square
			circle(diameter_of_button*unit_conversion_factor/2,$fn=4);
		}
		else if(type_of_shape ==5){
			//pentagon
			circle(diameter_of_button*unit_conversion_factor/2,$fn=5);
		}
		else if(type_of_shape ==6){
			//hexagon
			circle(diameter_of_button*unit_conversion_factor/2,$fn=6);
		}
		else if(type_of_shape ==8){
			//octogon
				circle(diameter_of_button*unit_conversion_factor/2,$fn=8);
		}
		/*else if(true){
			text("invalid shape of button");
		}*/
		else if(type_of_shape == 9){
			rotate([0,0,90]){
				scale([diameter_of_button*unit_conversion_factor,diameter_of_button*unit_conversion_factor,0]){
					polygon([[.433,.25],[0,-.5],[-.433,.25],[-.393,.302],[-.342,.342],[-.281,.366],[-.217,.375],[-.152,.366],[-.092,.342],[-.04,.302],[0,.25],[.04,.302],[.092,.342],[.152,.366],[.217,.375],[.281,.366],[.342,.342],[.393,.302]]);
				}
			}
		}
		else if(type_of_shape ==10){
			//android
			scale([diameter_of_button*unit_conversion_factor,diameter_of_button*unit_conversion_factor,0]){
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
		//7: (not implemeted yet) android, 8: (also not ready yet) apple
	}
}
module holes_to_be_cut(){
	if(number_of_holes<2){
		if(number_of_holes==1){
			translate([0,0,-.1*unit_conversion_factor]){
				linear_extrude((height_of_button+1)*unit_conversion_factor)
						circle([diameter_of_hole*unit_conversion_factor,diameter_of_hole*unit_conversion_factor],$fn=resoultion/2);
				}
			}
		}
	else{
		for(angle = [0:number_of_holes])
		{
			rotate([0,0,360/number_of_holes*angle]){
				translate([radi_to_center_of_hole*unit_conversion_factor,0,-.1*unit_conversion_factor]){
					linear_extrude((height_of_button+1)*unit_conversion_factor)
						circle([diameter_of_hole*unit_conversion_factor,diameter_of_hole*unit_conversion_factor],$fn=resoultion/2);
				}
			}
		}
	}
}
module round_center(){
	translate([0,0,diameter_of_button*unit_conversion_factor*.125]){
		resize(newsize=[diameter_of_button*unit_conversion_factor*.95,diameter_of_button*unit_conversion_factor*.95,height_of_button*unit_conversion_factor],center=true){
				sphere(diameter_of_button*unit_conversion_factor,$fn=resoultion);
		}
	}
}
//user error message, aka warning you broke it
if(ignore_error_messages==1){
	difference(){
		base_shape(type_of_shape =button_shape);
		holes_to_be_cut();
		if(rounded_center==1){
			round_center();
		}
	}
}
else if(diameter_of_button<(diameter_of_hole+radi_to_center_of_hole)){
	linear_extrude(2){
		text("you broke me! make sure the holes are inside of the button. To ignore me select so in advanced options");
	}
}
else{
	difference(){
		base_shape(type_of_shape =button_shape);
		holes_to_be_cut();
		if(rounded_center==1){
			round_center();
		}
	}
}