// remix by foofoodog of thing 96411
// http://en.wikipedia.org/wiki/Soma_cube
/* [Options] */
// of a single cube
size = 7;
cubes = [
	[[0,0,0],[0,1,0],[1,0,0]], // V
	[[0,0,0],[0,1,0],[0,2,0],[1,0,0]], // L
	[[0,0,0],[1,0,0],[2,0,0],[1,1,0]], // T
	[[0,0,0],[1,0,0],[1,1,0],[0,-1,0]], // Z
	[[0,0,0],[1,0,0],[1,1,0], [1,1,1]], // A
	[[0,0,0],[-1,-1,0],[0,0,1],[-1,0,0]], // B
	[[0,0,0],[0,0,1],[1,0,0],[0,1,0]] // P
];
// cheesy spacing calcs, start at x go clockwise
function slice() = -360/len(cubes);
function space() = size*3;
for(i=[0:len(cubes)-1]) { // one off does not even matter here, go figure
	rotate([0,0,slice() * i])
		translate([space(),0,0]) 
			part(cubes[i]);
}
module part(cubes) {
	for (i=cubes) {
		translate(i * size) cube(size);
	}
}