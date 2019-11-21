// (c) JPT 2014
// http://www.thingiverse.com/thing:375759

// length of rail (including arm_height)
rail_len = 60;

// length of arm from center of rail (i.e. plus/minus arm_width/2)
arm_len = 30;

// elevation of the arm from center of rail (may be negative)
arm_elevation = -20;

// Add a support between arm and rail?
support1 = true;
support2 = false;

// number of screw holes in the arm
arm_screwcount = 2;

// distance between screw holes
arm_screwdistance = 10;

// rail thickness
rail_width = 5;

// diameter of the opening for the screws
rail_screws = 4;

// rail height excluding the 45° part (so it's plus rail_width)
rail_height = 9;

// arm thickness
arm_width = 5;

arm_height = 10;

// diameter of screw holes 
arm_screws = 3.5;

// OpenScad option: how many parts should a full circle be rendered of?
$fn = 24;

s = arm_elevation > 0 ? arm_elevation + arm_width/2 : -arm_elevation + arm_width/2;
t = arm_elevation > 0 ? s/2 : -s/2;

// support
s1p0 = [arm_height/2,                          0, rail_width/2];
s1p1 = [arm_height/2, -arm_elevation-arm_width/2, rail_width/2];
s1p2 = [arm_height/2, -arm_elevation-arm_width/2, rail_width/2 + arm_len - arm_screwcount * arm_screwdistance];
s1p3 = [0  , -arm_elevation-arm_width/2, rail_width/2 + arm_len - arm_screwcount * arm_screwdistance];
s1p4 = [0  , -arm_elevation-arm_width/2, rail_width/2];
s1p5 = [0  ,                          0, rail_width/2];

s1t = [
	[2, 1, 0],
	[5, 3, 2, 0],
	[5, 4, 3],
	[0, 1, 4, 5],
	[1, 2, 3, 4]
];

if ((support1) && (abs (arm_elevation) > 4)) {

	if (arm_elevation < 0) {
		polyhedron(
			points = [s1p0, s1p1, s1p2, s1p3, s1p4, s1p5],
			triangles = s1t,
			convexity = 2
		);
	} else {
		polyhedron(
			points = [s1p5, s1p4, s1p3, s1p2, s1p1, s1p0],
			triangles = s1t,
			convexity = 2
		);
	}
}

sign = arm_elevation > 0?-1:1;
s2y=sign * rail_height/2;

s2p0 = [arm_height, -arm_elevation+arm_width/2*sign, +rail_width/2];
s2p1 = [arm_height, -arm_elevation+arm_width/2*sign, -rail_width/2];
s2p2 = [arm_height,   s2y, -rail_width/2];
s2p3 = [arm_height,   s2y, +rail_width/2];
s2p4 = [arm_height*2, s2y, +rail_width/2];
s2p5 = [arm_height*2, s2y, -rail_width/2];

s2t = [
	[0, 1, 2, 3],
	[4, 5, 1, 0],
	[5, 2, 1],
	[0, 3, 4],
	[5, 4, 3, 2]
];

if ((support2) && (abs (arm_elevation) > rail_width/2)) {
	if (arm_elevation < 0) {
		polyhedron(
//			points = [s2p0, s2p1, s2p2, s2p3, s2p4, s2p5],
			points = [s2p5, s2p4, s2p3, s2p2, s2p1, s2p0],
			triangles = s2t,
			convexity = 2
		);
	} else {
		polyhedron(
			points = [s2p0, s2p1, s2p2, s2p3, s2p4, s2p5],
//			points = [s2p5, s2p4, s2p3, s2p2, s2p1, s2p0],
			triangles = s2t,
			convexity = 2
		);
	}

}



// fix wrong placement. TODO fix all points below so this rotation is not necessary any more
rotate(a=[90,0,0]) {
	
	union() {

		translate(v=[
			arm_height/2, 
			arm_len/2 + rail_width/2, 
			arm_elevation]) {
		
		   difference() {
				// arm
				cube(size=[arm_height, arm_len, arm_width], center = true);
			
				// screw holes
				translate([0, arm_len/2 - arm_screwdistance/2,0]) 
				for (i = [0 : arm_screwcount-1] ) {
			   		translate([0, - i * arm_screwdistance, 0])
					cylinder(h = arm_width+2, r = arm_screws/2, center = true);
				}
			}
		}
		
		// arm elevation
		translate([arm_height/2, 0, t]) {
			cube(size = [arm_height, rail_width , s], center = true);
		}		
		
		// rail
		difference() {
			// rail
			polyhedron(
				points = [
					[0, -rail_width/2, -rail_height/2],
					[0,             0, -(rail_height + rail_width)/2],
					[0,  rail_width/2, -rail_height/2],
					[0,  rail_width/2,  rail_height/2],
					[0,             0, (rail_height + rail_width)/2],
					[0, -rail_width/2,  rail_height/2],
			
					[rail_len, -rail_width/2, -rail_height/2],
					[rail_len,             0, -(rail_height + rail_width)/2],
					[rail_len,  rail_width/2, -rail_height/2],
					[rail_len,  rail_width/2,  rail_height/2],
					[rail_len,             0,  (rail_height + rail_width)/2],
					[rail_len, -rail_width/2,  rail_height/2]
			
				],
				triangles = [
					[0, 1, 2, 3, 4, 5],
					[6, 7, 1, 0],
					[7, 8, 2, 1],
					[8, 9, 3, 2],
					[9,10, 4, 3],
					[10,11,5, 4],
					[11,6, 0, 5],
					[11, 10, 9, 8, 7, 6]
				], 
		
				convexity = 2
			);
		
			// rail opening
			union() {
				translate (v=[rail_len/2+5, 0, 0]) {
					cube(size = [rail_len-20,rail_width+2,rail_screws], center = true);
				}
				
				translate (v=[15, 0, 0]) {
					rotate(a=[90,0,0]) {
						cylinder(h = rail_width+2, r = rail_screws/2, center = true);
					}
				}
				
				translate (v=[rail_len-5, 0, 0]) {
					rotate(a=[90,0,0]) {
						cylinder(h = rail_width+2, r = rail_screws/2, center = true);
					}
				}
				
			}
		}
	}
};
