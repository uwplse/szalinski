//======================================================
// Multiple Slot Card Holder for BoardGames by @satanin.
//======================================================
// EDITABLE PARAMETERS
//======================================================
// Part
part="body";//["body":Body, "divider":Divider]
// Card/Sleeve height
card_height=89; // [10:150]
// Card/Sleeve width
card_width=57; // [10:120]
// Organizer length
length=150;// [10:220]
// Organizer height
height=50;//[1:150]
// Wall thickness
wall_thickness=1.5; // [1,1.25,1.5,1.75,2]
//----------------------------------------
// Dividers
//----------------------------------------
//divider angle for v3 dividers
divider_angle=10; // [0:20]
//----------------------------------------
// Notch
//----------------------------------------
// vertical notch size
vertical_notch_size=20;//[1:20]
// use vertical notch in structure
structure_vertical_notch="yes";//["yes":yes, "no":no]
// use horizontal notch in structure
structure_lateral_notch="no";//["yes":yes, "no":no]
// horizontal insert size
structure_lateral_notch_width=20;//[1:20]
//----------------------------------------
// Text *optional
//----------------------------------
// Game name / Leave empty to disable
game_name="Eldritch Horror";
// Text Size
text_size=8;//[1:30]
// Move text Up
move_text_up=0; //[0:100]
// Move text Down
move_text_down=20; //[0:100]


/* [Hidden] */
// These variables are parametrizable but not compatible with customizer app. 


//======================================================
// DO NOT EDIT BEYOND THIS POINT;
//======================================================
// Card slots
card_spacer=3;
width=card_height+card_spacer+wall_thickness;
dock_width = width/5;
dock_wall = 1.5;
spacer = 1.03;

// If typography is returning an error comment the following line
//font="Teutonic";
divider_thickness=1.5;

module base_dock(){
	color("magenta"){
		cube([dock_width,dock_wall,height]);
	}
}

module structure_lateral_notch(){
  rad=structure_lateral_notch_width/2;
	hull(){
		translate([0,height,0]){
			cylinder(wall_thickness*15,rad,rad, $fn=60);
		}
		cylinder(wall_thickness*15,rad,rad, $fn=60);
	}
}


module horizontal_notch(){
	translate([-wall_thickness,(length/2)-(height/2),height-(height/3)]){
		rotate([0,90,0]){
			color("red"){
				structure_lateral_notch();
			}
		}
	}
}

module vertical_notch(){
	translate([width/2,height/5,height/2]){
		color("lime"){
			rotate([90,0,0]){
				rad=vertical_notch_size/2;
				hull(){
					translate([0,height,0]){
						cylinder(wall_thickness*15,rad,rad, $fn=60);
					}
					cylinder(wall_thickness*15,rad,rad, $fn=60);
				}
			}
		}
	}
}

module structure_short_side (){
	difference(){
		cube([width,wall_thickness,height]);
		if(structure_vertical_notch=="yes"){
			vertical_notch();		
		}
	}
}


module divider_2(h){
	divider_spacer=0.2;
	hypotenuse = (h-wall_thickness)/sin(90-divider_angle);
	color("OrangeRed"){
		rotate([-divider_angle,0,0]){
			translate([0,0,wall_thickness]){
				difference(){
					cube([width,divider_thickness,hypotenuse]);
					cube([wall_thickness+divider_spacer,divider_thickness,height-(height/4)]);
					translate([width-wall_thickness-divider_spacer,0,0]){
						cube([wall_thickness+divider_spacer,divider_thickness,height-(height/4)]);
					}
				}
			}
		}
	}
}

module structure_long_side(x,y,z) {
	translate([x,y,z]){
		difference(){
			cube([wall_thickness,length,height]);
			if (structure_lateral_notch=="yes"){
				horizontal_notch();
			}
		}
	}
}

module bottom_side () {
	cube([width,length,wall_thickness]);
}

module left_wall(){
	structure_long_side();
}

module right_wall(){
	structure_long_side(width-wall_thickness,0,0);
}

module front_wall(){
	structure_short_side();
}

module rear_wall(){	
	translate([0,length-wall_thickness,0]){
		structure_short_side();
	}
}

module game_name(){
	color("Red"){
		translate([width/2,0,height/2+move_text_up-move_text_down]){
			rotate([90,0,0],center=true){
				linear_extrude(0.5){
					text(game_name, text_size, halign="center", font=font);
				}
			}
		}
	}
}

module body(){
	bottom_side();
	difference(){
		union(){
			left_wall();
			right_wall();
		}
		for(i=[10:10:length-divider_angle*1.5]){
			translate([0,i,0]){
				divider_2(height*2);
			}
		}
	}

	front_wall();
	rear_wall();
	game_name();
}



if(part=="body"){
	body();
}else{
	rotate([90+divider_angle,0,0]){
		divider_2(height);
	}
}

