use <Libs.scad>
$fn=50;
lenght = 40;
lenght2 = 25;
height1 = 7;
height2 = 31;
width = 24;
space = 1;

hole_radius = 2.6;
rod_radius =8;

module hole(pos){
	translate([0,0,-0.1]){
		linear_extrude(height = height2){
			translate([pos,width/2,0]){
				circle(r = hole_radius+0.1);
			}
		}
	}
}
difference(){
	difference(){
		union(){
			cube([lenght,width,height1]);
			translate([(lenght-lenght2)/2,0,0]){
				cube([lenght2,width,height2]);
			}
		}
		union(){
		
			hole((lenght-lenght2)/4);
			hole(lenght-(lenght-lenght2)/4);
		
			translate([lenght/2,-0.1,height1+rod_radius]){
				rotate([-90,0,0]){
					linear_extrude(height=width+0.2){
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
	/* screw */
	translate([(lenght-lenght2)/2-0.1,width/2,height2 - 5]){
		rotate([0,90,0]){
			rotate([0,0,90]){
				hexNut(size="M5");
			}
			linear_extrude(height=lenght){
				circle(r=2.6);
			}
			translate([0,0,lenght2-4.8]){
				linear_extrude(height=5){
					circle(r=4);
				}
			}
		}
	}
}