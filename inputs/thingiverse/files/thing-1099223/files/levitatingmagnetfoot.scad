//the size of the top(floating) foot
foot_radius = 30;

//How how thick the floating foot should be(this should be increased for stronger magnets)
foot_height = 18;

//the radius of the magnet
magnet_radius = 4.85;

//the thickness of the magnet
magnet_height = 6.33;

//how much extra space should be between the two pieces (increase if peices are rubbing too much, decrease if they wobble too much)
fudge_factor = 0.6;

//how much tolerance for the magnet holes
mag_fudge_factor = 0.1;

//How thick the wall is on the bottom piece.
wall_width = 3;

//Number of magnets on each side of the foot
magnet_n = 4;

module hull_magnet() {
	cylinder(r=(magnet_radius+mag_fudge_factor), h=magnet_height, $fn=500);
}

module magnet_ring(flip) {
	for( i = [0:magnet_n]) {
		translate([flip*2*magnet_radius*cos(i*(360/magnet_n)), flip*2*magnet_radius*sin(i*(360/magnet_n)), 0])
			hull_magnet();
	}
}
module top(radius, height, magnet_r, magnet_h){
	difference() {
		union() {
				//main cylinder
				cylinder(r=radius, h=height, $fn=500);
		
				//side protrusion
				translate([radius-1,-2.5,0])
					cube([wall_width,wall_width,height]);
		}
		translate([0,0,height-magnet_h]) magnet_ring(1);
	}
}
module bottom(inner_radius, inner_height, magnet_r, magnet_h){
	difference() {
		//main cylinder
		cylinder(r=(inner_radius+wall_width+fudge_factor), h=(inner_height+wall_width+magnet_h), $fn=500);
		
		//hull out space for top piece
		translate([0,0,wall_width+magnet_h])
			cylinder(r=inner_radius+fudge_factor, h = inner_height, $fn=500);
		
		//cut out a notch in the wall
		translate([-1*(inner_radius+wall_width)-fudge_factor,-0.5*wall_width,wall_width+magnet_h])
			cube([wall_width+1,(wall_width+fudge_factor),inner_height]);
		
		translate([0,0,wall_width]) magnet_ring(-1);
	}
}
//magnet_ring();
//hull_magnet();
top(foot_radius, foot_height, magnet_radius, magnet_height);
translate([2*foot_radius+fudge_factor+10,0,0]) bottom(foot_radius, foot_height, magnet_radius, magnet_height);