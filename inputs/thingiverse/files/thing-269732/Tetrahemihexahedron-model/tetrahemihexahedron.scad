// Approximation of a tetrahemihexahedron
//
// Bill Owens   March 12, 2014
//
// This is only an approximation of the polyhedron since the true shape 
// isn't manifold and can't be rendered correctly. 
// The right-triangle faces are actually quarters of square faces that 
// intersect with each other, so in order to make the model manifold I 
// built it out of four tetrahedra and added small fillets along each 
// intersection line.

// for Thingiverse Customizer

/* Global */

// Length of one edge of the object (mm)
size = 50;

// Printing orientation
orientation = "hollow"; // [solid:On a solid triangle,hollow:On a hollow triangle]


module onetetra() {
polyhedron(
	points = [
		[0.5,0.5,0],			// 0
		[-0.5,0.5,0],		// 1
		[0,0,1/sqrt(2)],		// 2 (top vertex)
		[0,0,0],				// 3 (center)
    ],
    triangles = [
		[0,2,1],
		[0,1,3],
		[0,3,2],
		[1,2,3],
	]);
}

module octahedron() {
polyhedron(
	points = [
		[0.5,0.5,0],			// 0
		[-0.5,0.5,0],		// 1
		[0,0,1/sqrt(2)],		// 2 (top vertex)
		[-0.5,-0.5,0],		// 3
		[0.5,-0.5,0],			// 4
		[0,0,-1/sqrt(2)]		// 5 (bottom vertex)
    ],
    triangles = [
		[0,2,1],
		[1,2,3],
		[3,2,4],
		[4,2,0],
		[0,1,5],
		[1,3,5],
		[3,4,5],
		[4,0,5]
	]);
}

module fillet() {
intersection() {
	cube([0.01,0.01,sqrt(2)], center=true);
	octahedron();
}
}

module tetrahemihexahedron() {
union() {
	onetetra();
	rotate(180,[0,0,1]) onetetra();
	rotate(180,[1,1,0]) onetetra();
	rotate(180,[-1,1,0]) onetetra();
	fillet();
	rotate(90,[-1,1,0]) fillet();
	rotate(90,[1,1,0]) fillet();
} 
}

// Decide whether the model should sit on a solid or hollow side
if (orientation == "solid") {
	scale(size) rotate(90-atan(1/sqrt(2)),[0,1,0]) tetrahemihexahedron();
} else {
	scale(size) rotate(90-atan(1/sqrt(2)),[1,0,0]) tetrahemihexahedron();
} 
