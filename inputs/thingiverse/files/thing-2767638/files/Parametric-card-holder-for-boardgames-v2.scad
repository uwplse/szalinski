//======================================================
// Multiple Slot Card Holder for BoardGames by @satanin.
//======================================================
// EDITABLE PARAMETERS
//======================================================
// Card/Sleeve height
card_height=92; // [10:150]
// vertical or oblique card dividers?
card_dividers_angle="no"; //["yes":Vertical, "no":Oblique]
// Card/Sleeve width
card_width=59; // [10:150]
//----------------------------------------
// Organizer length
length=143;// [10:220]
// Organizer height
height=54;//[1:150]
// Wall thickness
wall_thickness=1.5; // [1,1.25,1.5,1.75,2,2.25,2.5,2.75,3]
// Card slots
card_slots=4; // [0:10]
// use equidistant divider sizes?
equidistant_slot_sizes="no"; //["yes":yes, "no":no]
// To use custom slot sizes fill the following array with the position of the dividers. the position is absolute so I recommend to play with the preview before printing. I made this because of the limitations about updating variable values in openscad. example: [20,40,80], will generate spacers in 20mm, 40mm and 80mm
divider_position=[20,50,80]; //
//----------------------------------------
// Will save time and filament
minimalist="true"; // ["true": true, "false": false]
// use vertical notch in dividers
dividers_vertical_notch="yes";//["yes":yes, "no":no]
// vertical notch size
vertical_notch_size=20;//[1:20]
// use vertical notch in structure, TIP: not compatible with attachable organizers.
structure_vertical_notch="yes";//["yes":yes, "no":no]
// use horizontal notch in structure
structure_lateral_notch="no";//["yes":yes, "no":no]
// horizontal insert size
structure_lateral_notch_width=20;//[1:20]

//----------------------------------
// Game name / Leave empty to disable
game_name="";
// Text Size
text_size=10;//[1:30]
// Move text Up
move_text_up=0; //[0:100]
// Move text Down
move_text_down=0; //[0:100]


/* [Hidden] */
// These variables are parametrizable but not compatible with customizer app. 

//======================================================
// DO NOT EDIT BEYOND THIS POINT;
//======================================================
card_spacer=3;
width=card_height+card_spacer+wall_thickness;
dividers = card_slots-1;
min_slot_space=length/card_slots;
dock_width = width/5;
dock_wall = 1.5;
spacer = 1.03;
//font="Teutonic";
divider_thickness=1.5;

module base_dock(){
	color("magenta"){
		cube([dock_width,dock_wall,height]);
	}
}

module dock(){
	difference(){
		base_dock();
		translate([0,0,-1]){
			rotate([0,0,45]){
				color("red"){
					scale([2,dock_wall,1.1]){base_dock();}
					//cube([width,1.5,height]);
				}
			}
		}
		translate([dock_width,0,-1]){
			rotate([0,0,45]){
				color("red"){
					scale([2,dock_wall,1.1]){base_dock();}
				}
			}
		}
	}
}

module fdock(){
	translate([(width/4)-(dock_width/4),-dock_wall,height/2]){
		scale([1,1,0.5]){dock();}
	}
	translate([(width/1.333)-(dock_width/1.333),-dock_wall,height/2]){
		scale([1,1,0.5]){dock();}
	}
}

module fdock_v2(){
	translate([(width/4)-(dock_width/4)*spacer,0,height/2]){
		scale([spacer,1,0.5]){dock();}
	}
	translate([(width/1.333)-(dock_width/1.333)*spacer,0,height/2]){
		scale([spacer,1,0.5]){dock();}
	}
}

module rdock(){
	multiplier=1.3;
	color("indigo"){
		difference(){
			translate([(width/2)-(dock_width/2)*multiplier,wall_thickness,0]){
				scale([multiplier,1,1]){base_dock();}
			}
			translate([(width/2)-(dock_width/2)*spacer,wall_thickness,0]){
				scale([spacer,1,1.5]){dock();}
			}
		}
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


module divider (){
	difference(){
		if (card_dividers_angle=="yes"){
			cube([width,divider_thickness,height-wall_thickness]);
		}else{
			cube([width,divider_thickness,card_width]);
		}
		if(dividers_vertical_notch=="yes"){
			vertical_notch();		
		}
		catch_helper();
		vertical_notch();
	}	
}

module catch_helper(){
	catch_width=width/1.5;
	catch_height=height/6;
	catch_thickness=divider_thickness*2;
	color("indigo"){
		translate([(width/2)-(catch_width/2),-catch_thickness/4,card_width-catch_height]){
			cube([catch_width, catch_thickness, catch_height*2]);
		}
	}
}

module structure_long_side () {
	difference (){
		cube([wall_thickness,length,height]);
		if (structure_lateral_notch=="yes"){
			horizontal_notch();
		}
	}
}

module bottom_side () {
		cube([width,length,wall_thickness]);
}
module body(){
	bottom_side();
	structure_long_side();
	
	translate([width-wall_thickness,0,0]){
		structure_long_side();
	}
  difference(){
    structure_short_side();
    translate([width/2,length/2,height/2+move_text_up-move_text_down]){rotate([90,0,0],center=true){
			linear_extrude(){text(game_name, text_size, halign="center", font=font);}}}
  }

	translate([0,length-wall_thickness,0]){
			structure_short_side();
	}
	if(equidistant_slot_sizes=="yes"){
		for(i=[0:1:dividers-1]){
			echo(min_slot_space*(i+1));
			separator((min_slot_space)*(i+1));
		}
	}else{
		for(i=[0:1:dividers-1]){
			separator(divider_position[i]);
		}
	}
}

module separator(distance){
	translate([0,distance,1]){
		alpha=-acos((height-wall_thickness)/card_width);
		if (card_dividers_angle=="no"){
				rotate([alpha,0,0]) {
				divider();
			}
		}else{
			divider();
		}
	}
}

if (minimalist=="true") {
	difference (){
		body();
		translate([width/6,divider_thickness,0]){
			cube([width/1.5,length-(divider_thickness*2),height*2]);
		}
	}
}
else{
	body();
}




//rdock();
