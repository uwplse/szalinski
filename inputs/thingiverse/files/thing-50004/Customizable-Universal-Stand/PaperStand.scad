//preview[view:south west, tilt:top diagonal]
stand_width = 80; //[20:100]
paper_thickness = 16; //[5:50]
paper_height = 115; //[50:300]
holdback_height = 12; //[5:50]
wall_thickness = 3; //[1:10]
fuzz = 0.01; 
//Paper angle
rotate_angle = 15; //[0:85]
rotate_a = -rotate_angle;
//extra part on the back to prevent tipping over
tail_length=20; //[0:100]
//IMPORTANT set this when exporting to STL (to print on its side !! supportless)
print_mode = "preview"; //[preview,print]

start();

module start(){
	if (print_mode == "preview"){
		difference(){
 			ding();
			//maak onderkant plat
			translate([-300,-300,-600]) cube([600,600,600]);
		}
	} else {
		rotate(-90,[0,1,0]){
			difference(){
 				ding();
				//maak onderkant plat
				translate([-300,-300,-600]) cube([600,600,600]);
			}
		}
	}
}

module ding(){
	rotate(rotate_a,[1,0,0]) a();
	b();
	c();
}

module a(){
	//back, papier leunt hier tegenaan
	cube([stand_width, wall_thickness,paper_height]);
	//bakje, papier staat hierop
	translate([0,-paper_thickness+fuzz,0]) cube([stand_width, paper_thickness, wall_thickness]);
	//holdback, dit houd tegen
	translate([0,-paper_thickness+fuzz,0]) cube([stand_width, wall_thickness,holdback_height]);
}

module b(){
	//onderkant
	cube([stand_width,sin(rotate_a*-1)*paper_height,wall_thickness]);
	//achterkant
	translate([0,sin(rotate_a*-1)*paper_height,0]) cube([stand_width,wall_thickness,cos(rotate_a*1)*paper_height]);
}

module c(){
	cube([stand_width,sin(rotate_a*-1)*paper_height+tail_length,wall_thickness]);
}