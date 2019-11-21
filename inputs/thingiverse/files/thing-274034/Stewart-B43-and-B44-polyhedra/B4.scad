// Approximation of Stewart polyhedra B4,3 and B4,4
//  (aka. the octahemioctahedron and cubohemioctahedron)
//
// Bill Owens   March 16, 2014
//
// The designation B4,3 is from _Adventures Among the Toroids_ by Professor Bonnie M.
// Stewart; he described the shape in Chapter II, Exercise 2 as an example of a 
// polyhedron that can only be modeled in 3-space if its faces are allowed to 
// intersect each other. It is based on the familiar cuboctahedron (which he called B4)
// with the square faces removed and four hexagon faces added.
// 
// The similar polyhedron B4,4 has the triangular faces removed; unlike B4,3 it
// is non-orientable.
//
// This is only an approximation of the polyhedron since the true shape 
// isn't manifold and can't be rendered correctly. 
// The inward-facing triangle faces are actually one-sixth of hexagon faces that 
// intersect with each other, so in order to make the model manifold I 
// built it out of eight regular tetrahedra and added small fillets along each 
// intersection line.
//
// Note that although the script allows a choice of printing on a solid or hollow side,
// the B4,3 model is printable without support only on the hollow side, and B4,4 only
// on the solid side. Both are likely to need fixup with Netfabb, Meshlab or the like
// before they can be sliced.
//
// The vertices and faces for the cuboctahedron came from pdragy's Customizable Convex Polyhedra
// <http://www.thingiverse.com/thing:233540>, 
// which in turn drew from pmoews' polyhedra designs
// <http://www.thingiverse.com/thing:16508>,
// and George Hart's VRML versions 
// <http://www.georgehart.com/virtual-polyhedra/vp.html>  
// In keeping with the previous sources, this code is released under the 
// Creative Commons - Attribution - Share Alike license (CC-BY-SA).

// for Thingiverse Customizer

/* Global */

// Polyhedron B4,3, B4,4 or plain B4
poly = "B44"; // [B43,B44,B4]

// Length of one edge of the object (mm)
size = 30;

// Size of the fillet block (mm)
fsize = 0.03;

// Printing orientation
orientation = "solid"; // [solid:On a solid side,hollow:On a hollow side]

/* Hidden */
s2 = 1/sqrt(2);

module onetetra() {
polyhedron(
	points = [
		[0,0,0],				//0
		[1,0,0],				//1
		[0.5,0.5,s2],	//2
		[0.5,-0.5,s2]	//3
	],
	triangles = [
		[0,3,1],
		[1,3,2],
		[0,2,3],
		[0,1,2]
	]);
}

module twotetra() {
union() {
	onetetra();
	rotate(90,[1,1,0]) onetetra();
}
}

module cuboctahedron() {        // cuboctahedron points and triangles from pdragy, tweaked to use
polyhedron(                     // a more accurate sqrt(2) value.
	points = [
        [  -1,   0,   0],
        [  -0.5,  -0.5,  -s2],
        [  -0.5,  -0.5,   s2],
        [  -0.5,   0.5,  -s2],
        [  -0.5,   0.5,   s2],
        [   0,  -1,   0],
        [   0,   1,   0],
        [   0.5,  -0.5,  -s2],
        [   0.5,  -0.5,   s2],
        [   0.5,   0.5,  -s2],
        [   0.5,   0.5,   s2],
        [   1,   0,   0],
   ],
   triangles = [
        [    0,    2,    1],[    0,    3,    4],
        [    0,    4,    2],[    0,    1,    3],
        [    4,    3,    6],[    1,    2,    5],
        [   11,    7,    8],[   11,   10,    9],
        [   11,    8,   10],[   11,    9,    7],
        [    6,    9,   10],[    5,    8,    7],
        [    2,    8,    5],[   10,    4,    6],
        [    9,    6,    3],[    7,    1,    5],
        [    9,    3,    7],[    7,    3,    1],
        [    2,   10,    8],[    2,    4,   10],
	]);
}

module fillet() {
intersection() {
	union() {
		cube([2,s2*fsize,fsize], center=true);      // produce rectangular fillets in six directions
		rotate(90,[0,0,1]) cube([2,s2*fsize,fsize], center=true);
		rotate([0,45,45]) cube([2,fsize,s2*fsize], center=true);
		rotate([0,-45,45]) cube([2,fsize,s2*fsize], center=true);
		rotate([0,45,-45]) cube([2,fsize,s2*fsize], center=true);
		rotate([0,-45,-45]) cube([2,fsize,s2*fsize], center=true);
	} 
	cuboctahedron();                                // trim their points to fit the finished shape
}
}

module B43() {
union() {
	twotetra();
	rotate(90,[0,0,1]) twotetra();
	rotate(180,[0,0,1]) twotetra();
	rotate(270,[0,0,1]) twotetra();
	fillet();
} 
}

module B44() {
union() {
	difference() {
		cuboctahedron();
		scale(1.0001) twotetra();       // the 1.0001 scale makes a clean cut out of the cuboctahedron
		scale(1.0001) rotate(90,[0,0,1]) twotetra();
		scale(1.0001) rotate(180,[0,0,1]) twotetra();
		scale(1.0001) rotate(270,[0,0,1]) twotetra();
	}
	fillet();
}
}

// Choose the polyhedron and decide whether the model should sit on a solid or 
// hollow side
if (poly == "B43") {
	if (orientation == "hollow") {
		scale(size) B43();
	} else {
		scale(size) rotate(90-atan(1/sqrt(2)),[1,0,0]) B43();
	}
} else if (poly == "B44") {
	if (orientation == "hollow") {
		scale(size) rotate(90-atan(1/sqrt(2)),[1,0,0]) B44();
	} else {
		scale(size) B44();
	}
} else {
	scale(size) cuboctahedron();	
}
