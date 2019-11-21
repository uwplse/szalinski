//Customizable Bezier Bowl
//preview[tilt:side]

// Bezier curve control points. Draw two to five blobs; the center of each blob is used as the actual point. The first and last points are the endpoints of the curve. Any intermediate control points pull the line towards them into a curve. Object is formed by connecting curve endpoints to left edge with horizontal lines, then rotating that shape around the left edge as if it is the axis of a lathe or potter's wheel.
bezier_points = [[[-0.1273972602739726,-0.46164383561643835],[-0.12465753424657534,-0.47534246575342465],[-0.12465753424657534,-0.47534246575342465],[-0.13013698630136986,-0.48904109589041095],[-0.1410958904109589,-0.5],[-0.1547945205479452,-0.5027397260273972],[-0.17123287671232876,-0.49726027397260275],[-0.17397260273972603,-0.48356164383561645],[-0.1684931506849315,-0.46986301369863015],[-0.15205479452054796,-0.46164383561643835],[0.06712328767123288,-0.25068493150684934],[0.06164383561643835,-0.26438356164383564],[0.06164383561643835,-0.27808219178082194],[0.06986301369863014,-0.29178082191780824],[0.08356164383561644,-0.29726027397260274],[0.09726027397260274,-0.29178082191780824],[0.1,-0.27808219178082194],[0.10547945205479452,-0.26438356164383564],[0.10547945205479452,-0.25068493150684934],[0.1,-0.236986301369863],[0.09178082191780822,-0.22602739726027396],[0.0013698630136986301,0.04246575342465753],[-0.012328767123287671,0.03972602739726028],[-0.026027397260273973,0.031506849315068496],[-0.036986301369863014,0.023287671232876714],[-0.036986301369863014,0.009589041095890411],[-0.028767123287671233,-0.0013698630136986301],[-0.015068493150684932,-0.0013698630136986301],[0.0013698630136986301,-0.0013698630136986301],[0.015068493150684932,0.00410958904109589],[0.023287671232876714,0.015068493150684932],[0.026027397260273973,0.031506849315068496],[0.026027397260273973,0.045205479452054796],[-0.42054794520547945,0.19041095890410958],[-0.4315068493150685,0.17945205479452056],[-0.4315068493150685,0.16575342465753426],[-0.42054794520547945,0.15753424657534246],[-0.40684931506849314,0.1547945205479452],[-0.39315068493150684,0.15205479452054796],[-0.37945205479452054,0.15753424657534246],[-0.37945205479452054,0.17123287671232876],[-0.37945205479452054,0.18493150684931506],[-0.37945205479452054,0.18493150684931506],[-0.3821917808219178,0.19863013698630136],[-0.2534246575342466,0.4452054794520548],[-0.26164383561643834,0.43424657534246575],[-0.2589041095890411,0.42054794520547945],[-0.2452054794520548,0.41506849315068495],[-0.23150684931506849,0.41506849315068495],[-0.21780821917808219,0.42054794520547945],[-0.21506849315068494,0.43424657534246575],[-0.21506849315068494,0.44794520547945205]],[[0,1,2,3,4,5,6,7,8,9],[10,11,12,13,14,15,16,17,18,19,20],[21,22,23,24,25,26,27,28,29,30,31,32],[33,34,35,36,37,38,39,40,41,42,43],[44,45,46,47,48,49,50,51]]]; // [draw_polygon]

// Stretch result to this radius. (Technically, width of the Bezier Points sketch box; object radius may differ.)
radius = 30;

// Stretch result to this height. (Technically, height of the Bezier Points sketch box; object height may differ.)
height = 30;

// Approximate curve with this many layers. High values (like 100) yield smooth surfaces; low values (like 10) yield a faceted appearance.
slices = 100;

/* [Hidden] */

// When the polygon drawing is cleared, bezier_points[] is borked;
// however, as long as we draw *something* (ie the stock cylinder),
// error messages aren't shown. OK since they're expected & temporary.

// Number of control points. We need two to four.
vn = len(bezier_points[1]);

// v_mean defaults control points to [0, 0] until drawn
v0 = v_mean(bezier_points[0], bezier_points[1][0]);
v1 = v_mean(bezier_points[0], bezier_points[1][1]);
v2 = v_mean(bezier_points[0], bezier_points[1][2]);
v3 = v_mean(bezier_points[0], bezier_points[1][3]);
v4 = v_mean(bezier_points[0], bezier_points[1][4]);

// v is a list of vertex vectors
// p is a list of indices
// (i is used to terminate recursion at end of p)
// return the sum of the vertex vectors in v identified by p
function v_sum(v, p, i = 0) = (i == len(p) ? [0, 0] : v[p[i]] + v_sum(v, p, i + 1));

// v is a list of vertex vectors
// p is a list of indices
// return the mean of the vertex vectors in v identified by p (ie, the centroid of selected vertices)
// returns [0, 0] if p is empty
function v_mean(v, p) = (len(p) > 0 ? v_sum(v, p) / len(p) : [0, 0]);

// Linear Bezier (linear interpolation)
function lb(t, p0, p1) = p0 + (t * (p1 - p0));

// Quadratic Bezier (one control point)
function qb(t, p0, p1, p2) = lb(t,
		lb(t, p0, p1),
		lb(t, p1, p2));

// Cubic Bezier (two control points)
function cb(t, p0, p1, p2, p3) = lb(t,
		qb(t, p0, p1, p2),
		qb(t, p1, p2, p3));

// Fourth-order Bezier (three control points)
function b4(t, p0, p1, p2, p3, p4) = lb(t,
		cb(t, p0, p1, p2, p3),
		cb(t, p1, p2, p3, p4));

// Vertex at position t on Bezier curve
// Use curve appropriate to number of available control points
function b(t) =
		(vn == 2 ? lb(t, v0, v1) :
		(vn == 3 ? qb(t, v0, v1, v2) :
		(vn == 4 ? cb(t, v0, v1, v2, v3) :
		(vn == 5 ? b4(t, v0, v1, v2, v3, v4) : [0, 0]))));

if (vn < 2 || vn == undef) {

	// Just show a dummy object if there aren't enough control points;
	// suppresses confusing Customizer error messages while drawing.
	cylinder(r=radius, h=height, $fn=180);

} else {
	
	// 4. Bring result to requested size and position above floor
	translate([0, 0, height/2]) scale([radius, radius, height])
	
	// 3. Spin the profile on the lathe/potter's wheel/whatever
	rotate_extrude($fn=180)
	
	// 2. Move the profile so the lathe axis (left edge of drawing) is on the origin
	translate([0.5, 0, 0])
	
	// 1. Assemble approximated profile from the requested number of slices.
	union() {
	
		// Each slice of the profile is a strip that runs from the lathe axis (x = -0.5) to
		// a segment of the Bezier curve. p and q are bottom and top points of the segment.
		for (i = [1 : slices]) {
			assign(p = b((i-1)/slices), q = b(i/slices)) {			
				polygon(points=[
						[-0.5, p[1]], // bottom left (on axis; x = -0.5)
						[-0.5, q[1]], // top left (on axis; x = -0.5)
						[q[0], q[1]], // top right (on curve; x = q[0])
						[p[0], p[1]]  // bottom right (on curve; x = p[1])
				]);	
			}
		}	
	}
}
