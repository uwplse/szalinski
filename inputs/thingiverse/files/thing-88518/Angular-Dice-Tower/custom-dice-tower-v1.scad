root_2 = sqrt(2);

// the slope of the ramps
slope = 40;	//[15:75]

// the slope of the final ramp
exit_slope = 27;    // [15:75]

// the width of the ramp walls
wall = 2; // [1:5]

// the distance between the outer edge of walls of the ramp
ramp_width = 30; //[10:70]

// the overhang amount on the top funnel
overhang=7;	// [0:10]


// the total width of the entire structure
// wall/2 + ramp_width + ramp_width + wall/2
total_width = wall + ramp_width*2;


// height of each level
level_height = (ramp_width-wall)*tan(slope);

// trim the lower edge of each ramp to fit into the one below
trim=(wall/sin(slope) - wall)*tan(slope);


//echo("level height : ", level_height);
//echo("4 levels high: ", level_height*4);


module ramp(corner=true, angle=slope, cut_top=true){
	translate([-wall/2,-wall/2,0]) 
		union(){
			intersection() {
				translate([0,0,ramp_width*tan(angle) - wall/cos(angle)])
					rotate([0,angle,0])
					 translate([-ramp_width*2,0,0])
						difference(){
							cube([ramp_width*5,ramp_width,ramp_width]);
							translate([-ramp_width,wall,wall]) cube([ramp_width*6,ramp_width-wall*2, ramp_width]);
						}
				if(cut_top==true){
					translate([0,0,-trim]) cube([ramp_width,ramp_width,(ramp_width-wall)*tan(angle)+trim]);
				} else {
					translate([0,0,-trim]) cube([ramp_width,ramp_width,ramp_width*tan(exit_slope)+level_height]);
					// add 
				}
			}
			if (corner== true){
				translate([0,0,level_height])
				 difference(){
					cube([ramp_width,ramp_width,level_height]);
					translate([wall,-wall,-ramp_width])	cube([ramp_width,ramp_width,ramp_width*2]);
				}
			}
		}
}

module exit_ramp(){
	ramp(false,exit_slope, false);
//	translate([-wall/2,-wall/2,0]) cube([ramp_width,wall,level_height]);
//	translate([-wall/2,ramp_width-wall*3/2,0]) cube([ramp_width,wall,level_height]);
}

module funnel() {
	difference() {
		translate([0,0,overhang*tan(slope)])
		difference(){
			pyramid();
			translate([0,0,wall*tan(slope)]) pyramid();
		}
		translate([0,0,-ramp_width]) cube(center=true, [ramp_width*2 - wall,ramp_width*2 -wall,ramp_width*2]);
	}	
}

module pyramid(){
	assign(total_overhang = ramp_width-wall/2+overhang){
	polyhedron(
		points = [ 	[total_overhang,total_overhang,0],	
					[total_overhang,-total_overhang,0],
					[-total_overhang,-total_overhang,0],
					[-total_overhang,total_overhang,0],
					[0,0,-total_overhang*tan(slope)]],
		triangles = [	[0,1,4],
						[1,2,4],
						[2,3,4],
						[3,0,4],
						[0,3,2],
						[0,2,1]],
		convexity=10);
	}
}


module tower(){
	union(){
		ramp();
		translate([ramp_width-wall,wall-ramp_width,(ramp_width-wall)*tan(slope)]) 
			rotate(90)
				ramp();
		translate([(ramp_width-wall)*2,0,(ramp_width-wall)*tan(slope)*2]) 
			rotate(180)
				ramp();
	
		translate([(ramp_width-wall),ramp_width-wall,(ramp_width-wall)*tan(slope)*3]) 	
			rotate(270)
				ramp(false);
	}
}


translate([0,0,wall + (ramp_width-wall)*tan(exit_slope)])
union(){
	tower();
	translate([(ramp_width-wall)*2,0,0]) rotate([0,0,180]) tower();
	translate([ramp_width-wall,0,level_height*4]) funnel();
}
// exit ramps
translate([ramp_width-wall,0,wall]) exit_ramp();
translate([ramp_width-wall,0,wall]) rotate([0,0,180]) exit_ramp();

// base:
translate([-wall/2,-ramp_width+wall/2,0]) cube([ramp_width*2 - wall,ramp_width*2 -wall,wall]);

// bounding box:

