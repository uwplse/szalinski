/* [Global] */

// Base polygon
POLYGON = 5; // [3,4,5,6,7,8,9,10,11,12]
// Recursion depth
DEPTH = 2; // [1,2,3,4,5]
// Ellipse axis A
RADIUS_A = 50; // [5:100]
// Ellipse axis B
RADIUS_B = 50; // [5:100]
// Height of Vase
HEIGHT = 120; // [10:200]
// // Slices (Decrease for faster render speed)
// SLICES = 50; // [4:100]
// Scale of Top Surface
SCALE = 0.75; // [0.1:0.1:3]
// Rotation angle
TWIST = 120; // [0:360]
// // Wall Width
// WIDTH = 0.8; // [0.4:0.1:3]
// [0.4,0.5,0.6,0.7,0.8,1,1.2,1.5,2]

// Preferred layer height (Increase for faster render speed)
LAYER = 0.2; // [0.1:0.05:5]

// Slices (Decrease for faster render speed)
SLICES = HEIGHT / LAYER;


/* [Hidden] */
// preview[view:south west, tilt:top diagonal]
$vpr=[55,0,45];
$vpt=[0,0,0];
$vpd=500;


points = [for (i=[0:ceil(360/POLYGON):ceil(360/POLYGON)*(POLYGON-1)])
			[cos(i)*RADIUS_A, sin(i)*RADIUS_B]];
points_koch = [for (i=[0:len(points)-1], p=koch(DEPTH, [points[i], points[(i+1)%len(points)]])) p];


// koch_vase();
koch_vase_test();

module koch_vase_test(){
	linear_extrude(height=HEIGHT, center=true, slices=SLICES, twist=TWIST, scale=SCALE)
		polygon(points_koch);

}

module koch_vase(){
	union(){
		difference(){
			linear_extrude(height=HEIGHT, center=true, slices=SLICES, twist=TWIST, scale=SCALE)
				polygon(points_koch);
			scale([1,1,1.01])
				linear_extrude(height=HEIGHT, center=true, slices=SLICES, twist=TWIST, scale=SCALE)
					offset(r = -WIDTH)
						polygon(points_koch);
		}
		translate([0,0,-HEIGHT/2]) linear_extrude(height=WIDTH, center=false, slices=1)
			polygon(points_koch);
	}
}

function koch(N, points, first = false) = N==0 ? (first ? points : [points[1]]) :
	let (
		m = (points[0]+points[1])/2,
		v = points[1]-points[0],
		l = norm(v),
		n = [v[1], -v[0]]/l,
		a = l/3,
		h = a * sqrt(3) / 2,
		p1 = points[0] + v / 3,
		p2 = m + n*h,
		p3 = points[0] +2*v/3
	)
	concat(
		first ? [points[0]] : [],
		koch(N-1, [points[0], p1]),
		koch(N-1, [p1, p2]),
		koch(N-1, [p2, p3]),
		koch(N-1, [p3, points[1]])
		);
