
// This doesn't work with customizer :(
// The indicator line
//linestyle = "slot"; // ["slot", "raised", "none"]

// base dimensions
width=8.9;
length=15.25;

// top dimensions
topwidth=6.6;
toplength=14.25;

// height
height=13;

// slot in bottom
slotwidth=4.1;
slotlength=1.27;
slotdepth=10.5;

/* [hidden] */
point0=[0,0,0];
point1=[0,width,0];
point2=[length,width,0];
point3=[length,0,0];
point4=[(length-toplength)/2,(width-topwidth)/2,height];
point5=[(length-toplength)/2,width-(width-topwidth)/2,height];
point6=[length - (length-toplength)/2,width-(width-topwidth)/2,height];
point7=[length - (length-toplength)/2,(width-topwidth)/2,height];


difference() {
polyhedron(
points=[ point0, point1, point2, point3, point4, point5, point6, point7],
triangles= [ [0,2,1],[0,3,2], // cw bottom
		   [0,1,5],[0,5,4], // cw short 1
		   [0,4,7],[0,7,3], // cw wide 1
             [2,3,7],[2,7,6], // cw short 2
             [1,2,5],[2,6,5], // cw wide 2
             [4,5,6],[4,6,7] ] // cw top
);

// carve out line for fader slot.
translate([length/2-slotlength/2, width/2-slotwidth/2, 0])
cube([slotlength,slotwidth,slotdepth]);

// line in top, if a slot.
//	if (linestyle == "slot") {
		translate([(length-toplength)/2 + 1,(topwidth/2 + (width - topwidth)/2)-.5 ,height-1])
		cube([toplength-2,1,2]);
//	}
}


// line in top, if a raised line
//	if (linestyle == "raised") {
//		translate([(length-toplength)/2 + 1,(topwidth/2 + (width - topwidth)/2)-.5 ,height-1])
//		cube([toplength-2,1,2]);
//	}

