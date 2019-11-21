// Determines the radius of the cogwheel.
r = 5;

// Determines the depth of the cogwheel.
depth = 2;

// Determines the radius of the cutout for the axis.
axis_scale = 0.4;


// Determines the number of teeth on the cogwheel. Should be even.
num_teeth = 16;


tooth_l = r;
tooth_w_scale = 4/num_teeth;
tooth_w = tooth_l * tooth_w_scale;


module 2teeth(pos,angle) {
	translate(pos){
		rotate(a = angle) {
			polygon(points=[[-tooth_l,-tooth_w/2],[tooth_l,-tooth_w/2],[tooth_l+tooth_l/4,-tooth_w/4],[tooth_l+tooth_l/4,tooth_w/4],[tooth_l,tooth_w/2],[-tooth_l,tooth_w/2],[-tooth_l-tooth_l/4,tooth_w/4],[-tooth_l-tooth_l/4,-tooth_w/4]]);
		}
	}
}

module cogwheel() {
	$fs = 0.5;
	linear_extrude(depth) {
	translate(pos) {
		
		difference() {
			union(){
				circle(r);
				for(i = [0:floor(num_teeth/2)-1]) {
					2teeth([0,0,0],(360*i/num_teeth));
				}
			}
			circle(r*axis_scale);
		}
	}
	}
}

cogwheel();




