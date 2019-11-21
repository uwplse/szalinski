/*[the holder]*/
//1 unit = 8mm
card_width = 12;//[1:25]
//each wall will be this wide
side_wall_width=2;//[1:10]
//how deep/tall do you want it?
depth=6;//[1:10]
/*[the holder adcanced options]*/
front_wall_width=1;//[1:10]
rear_wall_width=1;//[1:20]
//set higer if you want higer res, lower if you want lower res, applies to text too.
fn = 20;
/* [Text] */

//	the words you want shown
name = "Name/Title";

//	how large do you want the text?
font_size = 11;	//	[1:11]

/*[advanced options for text]*/
//no negative numbers, just don't touch unless you know you know what your doing.
text_spacing = 1;
//CUSTOMIZER VARIABLES END

//reminder for me, 1 width needs to = 8mm
height = depth+3;
x_width = card_width+side_wall_width*2;
y_width = depth+front_wall_width+rear_wall_width;

module cut_stair_steps(){
	translate([x_width*-4.5,(y_width)*-4-.1,(2)*9.6]){
			cube([x_width*9,front_wall_width*8+.1,height*9.6]);
		}
	for(counter=[0:depth-1])
	{
		translate([x_width*-4.5,(y_width-2*(counter+front_wall_width))*-4-.1,(counter+3)*9.6]){
			cube([x_width*9,1*8+.1,height*9.6]);
		}
	}
}

module cut_center(){
	translate([card_width*-4,depth*-4-.01-(front_wall_width-rear_wall_width)*-4,9.9]){
		cube([card_width*8,depth*8+.01,height*9.6]);
	}
}
module cut_the_bottom(){
	difference(){
		translate([0,0,2-.1]){
			cube([x_width*8-3.2,y_width*8-3.2,4.1],center=true);
		}
		for(x_val =[0:x_width-2]){
			for(y_val =[0:y_width-2]){
				translate([(.5*x_width-x_val)*8-8,(.5*y_width-y_val)*8-8,-1]){
					difference(){
						linear_extrude(6){
							circle(6.8/2,$fn=fn);
						}
						linear_extrude(6){
							circle(4.8/2,$fn=fn);
						}
					}
				}
			}
		}
	}
}
module add_the_dots(){
	toggle = 4;
		
	module add_dot(xCord = 0, yCord = 0, zCord = 9.6){
		translate([xCord,yCord,zCord]){
			linear_extrude(1.6){
							circle(4.75/2,$fn=fn);
						}
		}
	}
	module add_to_bottom(){
		for(x_val =[0:x_width-2]){
			for(y_val =[0:y_width-2]){
				add_dot(xCord = (.5*x_width-x_val)*8-4,yCord = (.5*y_width-y_val)*8-toggle);
			}
		}
	}
	
	module add_to_sides(leftOright = 1){
		for(x_val = [0:side_wall_width-1]){
			for(y_val = [0:depth]){
				add_dot(xCord = ((.5*x_width-x_val)*8-4)*leftOright, yCord = (-.5*y_width+y_val)*8+4, zCord = (y_val+2)*9.6);
			}
		}
	}
	
	module add_to_front_wall(){
		for(x_val = [0:x_width-1]){
			for(y_val = [0:front_wall_width-1]){
				add_dot(xCord = (.5*x_width-x_val)*8-4, yCord = (-.5*y_width+y_val)*8+4, zCord = 2*9.6);
			}
		}
	}
	
	module add_to_back_wall(){
		for(x_val = [0:x_width-1]){
			for(y_val = [0:front_wall_width-1]){
				add_dot(xCord = (.5*x_width-x_val)*8-4, yCord = (.5*y_width-y_val)*8-toggle, zCord = height*9.6);
			}
		}
	}
	add_to_bottom();
	add_to_sides();
	add_to_sides(leftOright = -1);
	add_to_front_wall();
	add_to_back_wall();
}
difference(){
	union(){
		difference(){
			translate([x_width*-4,y_width*-4,0]){
				cube([x_width*8,y_width*8,height*9.6]);
			}
			cut_stair_steps();
			cut_center();
			cut_the_bottom();
		}
		add_the_dots();
	}
	
	//the text stuff at the end
	translate([0,-y_width*4+.8,9.6/2]){
		rotate([90,0,0]){
			linear_extrude(1){
				text(name, size=font_size, halign ="center", valign = "boardline", spacing=text_spacing,$fn=fn);
			}
		}
	}
}