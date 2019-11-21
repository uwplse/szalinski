//for kites :)
/*[Universal Features]*/
outter_diameter = .375;
//aka what is the skiniest you will want this to be regardless of what you enter.
minimum_shell = .0625;
minimum_length = 1;
/*[units]*/
//Basically are you using american units or real units
units_entered = 25.4;//[1:mm, 10:cm, 1000:meter, 25.4:inch, 304.8:foot]
//default is mm for most printers
desired_units_for_output = 1;//[1:mm, .1:cm, 0.001:meter, 0.0393701:inch, 0.00328084:foot]

/*[arm 1]*/
arm_1_length = 1;
arm_1_inner_diameter = 0.25;
//x,y,z
arm_1_angle = [0,0,0];
//color in rgb values
arm_1_color = [1,0,0];
/*[arm 2]*/
arm_2_length = 1;
arm_2_inner_diameter = 0.25;
//x,y,z
arm_2_angle = [0,90,0];
//color in rgb values
arm_2_color = [0,1,0];
/*[arm 3]*/
arm_3_length = 1;
arm_3_inner_diameter = 0.25;
//x,y,z
arm_3_angle = [0,90,90];
//color in rgb values
arm_3_color = [0,0,1];
/*[arm 4]*/
arm_4_length = 1;
arm_4_inner_diameter = 0.25;
//x,y,z
arm_4_angle = [0,-90,0];
//color in rgb values
arm_4_color = [1,1,0];
/*[arm 5]*/
arm_5_length = 1;
arm_5_inner_diameter = 0.25;
//x,y,z
arm_5_angle = [90,0,0];
//color in rgb values
arm_5_color = [1,0,1];
/*[arm 6]*/
arm_6_length = 1;
arm_6_inner_diameter = 0.25;
//x,y,z
arm_6_angle = [0,180,0];
//color in rgb values
arm_6_color = [0,1,1];
/*[arm 7]*/
arm_7_length = 0;
arm_7_inner_diameter = 0.25;
//x,y,z
arm_7_angle = [0,0,0];
//color in rgb values
arm_7_color = [1,1,1];
/*[arm 8]*/
arm_8_length = 0;
arm_8_inner_diameter = 0.25;
//x,y,z
arm_8_angle = [0,0,0];
//color in rgb values
arm_8_color = [.5,.5,0];
/*[arm 9]*/
arm_9_length = 0;
arm_9_inner_diameter = 0.25;
//x,y,z
arm_9_angle = [0,0,0];
//color in rgb values
arm_9_color = [0,.5,.5];
/*[arm 10]*/
arm_10_length = 0;
arm_10_inner_diameter = 0.25;
//x,y,z
arm_10_angle = [0,0,0];
//color in rgb values
arm_10_color = [.5,0,.5];

array_to_reference = 
[[arm_1_length,arm_1_inner_diameter,arm_1_angle,arm_1_color],[arm_2_length,arm_2_inner_diameter,arm_2_angle,arm_2_color],[arm_3_length,arm_3_inner_diameter,arm_3_angle,arm_3_color],[arm_4_length,arm_4_inner_diameter,arm_4_angle,arm_4_color],[arm_5_length,arm_5_inner_diameter,arm_5_angle,arm_5_color],[arm_6_length,arm_6_inner_diameter,arm_6_angle,arm_6_color],[arm_7_length,arm_7_inner_diameter,arm_7_angle,arm_7_color],[arm_8_length,arm_8_inner_diameter,arm_8_angle,arm_8_color],[arm_9_length,arm_9_inner_diameter,arm_9_angle,arm_9_color],[arm_10_length,arm_10_inner_diameter,arm_10_angle,arm_10_color]];
unit_conversion_factor = units_entered*desired_units_for_output;

scale(unit_conversion_factor){
	difference(){
		union(){
			sphere(outter_diameter,$fs=.05);
			for(current_arm = [0:9]){
				rotate(array_to_reference[current_arm][2]){
					difference(){
						if(true){
							color(array_to_reference[current_arm][3]){
								linear_extrude(array_to_reference[current_arm][0]){
									circle(outter_diameter,$fs = .05);
								}
							}
						}
					}
				}
			}
		}
		union(){
			for(current_arm = [0:9]){
				rotate(array_to_reference[current_arm][2]){
					translate([0,0,-.01]){
						color(array_to_reference[current_arm][3]*.9){
							linear_extrude(array_to_reference[current_arm][0]+.02){
								circle(array_to_reference[current_arm][1],$fs = .025);
							}	
						}
					}
				}
			}
		}
	}
}

