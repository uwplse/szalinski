seat_tube_diameter = 28.9;
top_tube_diameter = 28.7;
seat_tube_angle = 74;

seat_stay_diameter = 19.1;

inflateMM = 0.5; // allow room for a piece of inner tube under the clip

seat_staytube_triangle_lengths = [
	125, // seat stay
	85, // seat tube
	107, // distance from st point to ss point
];

seat_stay_triangle_lengths = [
	120, // seat stay
	120, // seat stay
	59, // distance from ss point to ss point
];

translate([0,0,25]) rotate([0,-90,0]) tigrMount();

module tigrMount() {
	difference() {
	rotate([0, 270-ttRotate()[1], 0]) {
		difference() {
			union() {
				ttClip(25);
				// stClip(25, 4);
			}
			#seat_assembly(inflateBy = inflateMM);
			zipCutout( seat_tube_diameter/2+3+inflateMM, stRotate()[1]+90, -16);
		}
	}
		translate([-50,-50,-100 - top_tube_diameter*0.4]) cube([100,100,100]);
	}

	difference() {
		translate([-10,0,0]) union() {
			tigrCatch2(3, 15);
			tigrCatch2(3, 15, true);
		}
		rotate([0, 270-ttRotate()[1], 0]) seat_assembly(inflateBy = inflateMM+0.7);
	}
}
module zipCutout(r, angle, z) {
	wid = 2.5;
	rotate([0, 90+angle, 0])
	translate([0,0,-z])
	rotate_extrude() polygon([
		[r, 3],
		[r+wid, 2],
		[r+wid, -2],
		[r, -3],
		]);
	// rotate_extrude() translate([r+wid/2,0,0]) square(size=[ wid, 6], center=true);
}

module tigrCatch2(offset = 3, length = 8, zflip = false) {
	tigrZ = 21;
	tigry = top_tube_diameter/2+offset;
	tigrx = 7;
	zrot = zflip ? 180 : 0;
	difference() {
		translate([zflip ? -length : 0, 0, 0])
		rotate([0,-90,zrot])
		linear_extrude(height=length) 
			polygon([
				[-4,top_tube_diameter/4],
				// [-tigrZ/2 - 3, tigry - offset],
				[-tigrZ/2 - 4, tigry],
				[-tigrZ/2 - 3, tigry + tigrx + 1],
				[-tigrZ/2 - 1, tigry + tigrx + 3],
				[0, tigry + tigrx + 4],
				[tigrZ/2 + 3, tigry + tigrx + 3],
				[tigrZ/2 + 3, tigry + tigrx + 0],
				[tigrZ/2 + 2, tigry + tigrx - 1],
				[tigrZ/2 + 1, tigry + tigrx - 1],
				[tigrZ/2 + 0, tigry + tigrx ],
				[-tigrZ/2 + 0, tigry + tigrx ],
				[-tigrZ/2 + 0, tigry ],
				[tigrZ/2-1, tigry - offset],
				]);
		rotate([0,0,zrot]) translate([0,tigry + tigrx/2,0]) cube(size=[100, tigrx, tigrZ], center=true);
	}
	
}


module ttClip(len=30, zip = true) {
	difference() {
		union() {
			top_tube(len, 3, offset = 0);
			if (zip) {
				intersection() {
					rotate(ttRotate()) 
						cylinder(
							r1=top_tube_diameter/2 + 18, 
							r2=top_tube_diameter/2 + 3, 
							h=len, center=false);
					translate([0,0,top_tube_diameter/2-4]) rotate(stRotate()) 
						cube(size=[100, seat_tube_diameter+6, 20], center=true);
				}
	
			}
		}
		top_tube(len+1, inflateMM, offset = 0);
		translate([-len/2,0,-top_tube_diameter * 0.465]) 
			rotate(ttRotate()) 
				rotate([45,90,0]) 
					cube(size=[len*5, len, len], center=true);
	}
}

module seat_assembly(inflateBy = 0) {
	seat_tube(inflateBy = inflateBy);
	seat_stay(inflateBy = inflateBy);
	seat_stay(-1, inflateBy = inflateBy);	
	top_tube(inflateBy = inflateBy);
}

module top_tube(len=200, inflateBy = 0, offset = 0) {
	rotate(ttRotate()) 
		rawTT(len, inflateBy, offset);
}

module seat_tube(len=200, inflateBy = 0) {
	rotate(stRotate()) 
		rawST(zTranslate = -seat_stay_diameter*2, inflateBy = inflateBy);		
}

module rawST(len=200, zTranslate = 0, inflateBy = 0) {
	translate([0,0,zTranslate])
		cylinder(r=seat_tube_diameter/2 + inflateBy, h=len, center=false);			
}
module rawTT(len=200, inflateBy = 0, offset = 0) {
	translate([0,0,offset])
		cylinder(r=top_tube_diameter/2 + inflateBy, h=len, center=false);			
}

function stRotate() = [0,270-seat_tube_angle,0];
function ttRotate() = [0,270-seat_tube_angle+ atan( 60.65 / 10),0];

module seat_stay(direction=1, len=200, inflateBy = 0) {
	rotate([
		direction * seat_stay_angle(seat_stay_triangle_lengths)/2,
		270-(seat_stay_angle(seat_staytube_triangle_lengths)+seat_tube_angle),
		0
	]) {
		cylinder(r=seat_stay_diameter/2 + inflateBy, h=len, center=false);		
	}
}

function sqr(val) = val*val;

function seat_stay_angle(triangle) = acos(
	(
		sqr(triangle[0]) + 
		sqr(triangle[1]) -
		sqr(triangle[2])
	) / (
		2 * triangle[0] * triangle[1]
	)
);
