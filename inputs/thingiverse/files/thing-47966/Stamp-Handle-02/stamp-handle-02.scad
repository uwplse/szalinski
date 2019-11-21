WIDTH 	= 18; // [0:200]
LENGTH 	= 61; // [0:200]


translate([-WIDTH/2,-LENGTH/2,0]) {
	difference() {
		pyramid(WIDTH,LENGTH,200);
	   translate([0,0,5]) cube([WIDTH,LENGTH,200]);
	}
	
	translate([WIDTH/2,LENGTH/2,5]) {
		rotate_extrude($fn=200) polygon(points=[[0,0],[3.5,0],[4.5,3],[3.5,6],[5.5,25],[0,27]]);
		translate([5,0,22]) sphere(r=1, $fn=20);
	}
}



// By Danny Staple, https://github.com/dannystaple/OpenSCAD-Parts-Library
module pyramid(w, l, h) {
	mw = w/2;
	ml = l/2;
	polyhedron(points = [
		[0, 0, 0],
		[w, 0, 0],
		[0, l, 0],
		[w, l, 0],
		[mw, ml, h]
	], triangles = [
		[4, 1, 0],
		[4, 3, 1],
		[4, 2, 3],
		[4, 0, 2],
	//base
		[0, 1, 2],
		[2, 1, 3]
	]);
}