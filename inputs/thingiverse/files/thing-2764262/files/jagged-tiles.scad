//cut a square jaggedly along its diagonal:
// +----+
// |   /|
// |/\/ |
// +----+
//paste together two of the remaining sides
//8 possible combinations
//4 solutions

//base piece size. Solved puzzle is 2x8 widths
width = 25; // [10:0.1:60]
//Height of piece
height = 3; // [1:0.05:10]
//Number of random edges
n = 500; // [1:1:2000]
//Jaggedness of random edge
jaggedness = 5; // [0:0.1:30]
//Minimum feature thickness
minSize = 1.5;
diag = width*sqrt(2); //length along diagonal
dMinSize = minSize*sqrt(2); //min size measured along diagonal
w = diag/n; //width of each edge
spacing = width*1.1; //used for part placement
epsilon = 0.0001*1;

function randNormPair() = let (pt = rands(-1, 1, 2))
     let (s = pt[0]*pt[0]+pt[1]*pt[1])
     s >= 1 || s == 0 ? randNormPair() : //reroll numbers (in unit square but not unit circle)
	 pt*sqrt(-2*ln(s)/s);

function clip(x, y) = //clips edge to ensure manifold puzzle
    let (x = min(x, diag-x)) //choose edge we are closest to hitting
	let (pad = dMinSize < x ? dMinSize : x*0.9)
    sign(y)*min(x-pad, abs(y));
function meander(old) = old + w*w*jaggedness*randNormPair()[0];
function randomWalk(n) = n > 1 ?
    let (old = randomWalk(n-1)) //recurse
	let (deltay = old[0][1] - old[1][0][1]) //calculate change in last step
	let (newpt = clip(old[0][0]+w, meander(old[0][1]+deltay))) //meander and truncate
    [[old[0][0]+w, newpt], old] : [[0, 0], [[0, 0], []]];

edge = reverse(make_vec([[diag, 0], randomWalk(n)]));

/*for (i=[0:len(edge)-1]) { //double check edge is correct
	let (x = edge[i][0], y = abs(edge[i][1]))
	if (x > dMinSize && diag - x > dMinSize) {
		assert(y + dMinSize <= x);
		assert(y + dMinSize <= diag - x);
	}
}*/

//half pieces, to be unioned in different orientations
module piece1() {
	translate([0, width]) rotate(-45) polygon(concat([[diag/2, -diag/2]], edge));
}
module piece2() {
	rotate(90) translate([0, -width]) rotate(45) polygon(concat([[diag/2, diag/2]], edge));
}

for (i=[0:7]) {
	linear_extrude(height)
	translate([spacing*(i%4),2*spacing*floor(i/4)])
	rotate((floor(i/2)%2 == i%2) ? -90 : 0) //arranges pieces nicely
	union() {
		if (floor(i/4)) {
			mirror([1,-1,0]) piece1(); //flip first piece for second row
		} else { piece1(); }
		if(floor(i/2)%2) {
			if (i%2) {
				translate([epsilon, width]) rotate(180) piece2();
			} else {
				translate([width, epsilon]) rotate(-180) piece2();
			}
		} else {
			if (i%2) {
				translate([0,epsilon]) rotate(-90) piece2();
			} else {
				translate([epsilon, 0]) rotate(90) piece2();
			}
		}
	}
}

// <libraries/lists.scad>
function make_vec(list) = len(list) == 0 ? [] :
                             concat([list[0]], make_vec(list[1]));
function reverse(vec) = [ for (i=[1:len(vec)]) vec[len(vec)-i] ];