$fn=50;
lenght = 10;
lenght2 = 5;
height1 = 2;
height2 = 5;
width = 4;
space = 0.2;

hole_radius = 0.9;
rod_radius =1;

module hole(pos){
	translate([0,0,-0.01]){
		linear_extrude(height = height2){
			translate([pos,width/2,0]){
				circle(r = hole_radius+0.01);
			}
		}
	}
}

difference(){
	union(){
		cube([lenght,width,height1]);
		translate([(lenght-lenght2)/2,0,0]){
			cube([lenght2,width,height2]);
		}
	}
	union(){
		union(){
			hole((lenght-lenght2)/4);
			hole(lenght-(lenght-lenght2)/4);
		}
		translate([lenght/2,-0.01,height2-(height2-height1)/2]){
			rotate([-90,0,0]){
				linear_extrude(height=width+0.02){
					union(){
						circle(r=rod_radius);
						translate([-space/2,-height2,0]){
							square([space,height2]);
						}
					}
				}
			}
		}
	}
}


