//BEGIN CUSTOMIZER VARIABLES
/*[WEB]*/
//units are in mm
size = 100;
thickness = 3;
strands =5;
wedges = 7;//[4:20]
/*[Advanced Stuffs]*/
resoultion = 25;
spoke_showing = 2.5;//[2.5:100]
flat_bottom = true;
//END CUSTOMIZER VARIABLES
module spoke(){
	rotate([-90,0,0])
		cylinder(r=thickness/2, h=size/2, $fn=resoultion);
}

module arc(){
	for(i = [1:strands]){
		intersection([0,0,30]){
			translate([0,0,-thickness*.5]){
				rotate([0,0,360/wedges]){
					linear_extrude(thickness){
						polygon((size/2*i/strands*(1+spoke_showing/100))*[[0,0],[0,1],[sin(360/wedges),cos(360/wedges)]]);
					}
				}
			}
			rotate([0,0,360/wedges/2]){
				translate([0,cos(360/(2*wedges))*i*size/((1+spoke_showing/100)*strands),0]){
					rotate_extrude(convexity = 15){
						translate([i*size/(2*strands), 0, 0]){
							circle(r = thickness/2, $fn = resoultion);
						}
					}
				}
			}
		}
	}
}

intersection(){
	if(flat_bottom)
		translate([0, 0, size])
			cube(2*size, center =true);
	for(i = [1:wedges]){
		rotate([0,0,(360/wedges)*(i-1)]){
			union(){
				spoke();
				arc();
			}
		}
	}
}