//preview[view:south west, tilt:top diagonal]
//original
//base_width1 = 70
//base_width2 = 60
//base_length = 86
//base_height = 2

//bottom
base_width = 70; //[10:100]
base_length = 70; //[50:120]
wall_thickness= 3; //[1:7]
//back
sa_height = 80; //[60:150]
sa_angle = 110; //[90:125] 
//front
sv_height = 60; //[20:80]
sv_angle = 75; //[20:90]
//tray bottom
to_length = 20; //[10:30]
to_angle = 340; //[330:360]
//tray front
tv_length = 10; //[5:25]
//IMPORTANT set this when exporting to STL (to print on its side !! supportless)
print_mode = "preview"; //[preview,print]
fuzz = 0.1; //prevents rendering glitches

start();

module start(){
	if (print_mode == "preview"){
		stand();
	} else {
		rotate(-90,[0,1,0])
		stand();
	}
}

module stand(){
	difference(){
 		ding();
		//maak onderkant plat
		translate([-300,-300,-600 + fuzz]) cube([600,600,600]);
	}
}

module ding(){
	//onderkant
	cube([base_width,base_length,wall_thickness]);
	//schuine achterkant
	 translate([0,base_length,0]) 
	rotate(sa_angle,[1,0,0]) 
	cube([base_width,sa_height,wall_thickness]);
	//schuine voorkant
	translate([0,base_length+cos(sa_angle)*sa_height,sin(sa_angle)*sa_height]) 
	rotate(sv_angle,[1,0,0]) 
	translate([0,-sv_height,0]) 
	cube([base_width,sv_height,wall_thickness]);
	//tray onderkant
	translate([0,-cos(sv_angle)*sv_height,-sin(sv_angle)*sv_height])
	translate([0,base_length+cos(sa_angle)*sa_height,sin(sa_angle)*sa_height])
	rotate(to_angle,[1,0,0])
	translate([0,-to_length,0])
	cube([base_width,to_length,wall_thickness]);
	//tray_voorkant
	translate([0,-cos(to_angle)*to_length,,-sin(to_angle)*to_length])
	translate([0,-cos(sv_angle)*sv_height,-sin(sv_angle)*sv_height])
	translate([0,base_length+cos(sa_angle)*sa_height,sin(sa_angle)*sa_height])
	rotate(to_angle+90,[1,0,0])
	cube([base_width,tv_length,wall_thickness]);
}

module oud(){
//base
cube([base_width,base_length,base_height]);

back_length = 110;
back_thickness = 3;
back_angle = 23;

//back
translate([0,base_length,0])
rotate(back_angle,[1,0,0])
cube([base_width,back_thickness,back_length]);

front_length = 62;
front_thickness = 3;
front_transY = sin(back_angle) * back_length;
front_transZ = cos(back_angle) * back_length;
front_angle = 240;

//front
translate([0,front_transY, front_transZ])
rotate(front_angle, [1,0,0])
cube([base_width,front_length,front_thickness]);

h_length = 22;

//houder
translate([0,16,49]) //-7, 46?
rotate(150,[1,0,0])
cube([base_width,h_length,base_height]);

s_length  = 10;

//stuff
translate([0,-2,56]) //-7, 46?
rotate(60,[1,0,0])
cube([base_width,s_length,base_height]);
}

