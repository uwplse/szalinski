use <utils/build_plate.scad>

// Select a type of block to make
1_type = "4 Way Connector"; // [4 Way Connector,3 Way Connector A,3 Way Connector B,2 Way Connector A,2 Way Connector B,2 Way Connector C,2 Way Connector D,1 Way Connector A,1 Way Connector B,No Connectors]
// Size of square in mm
2_square_size = 50;
// Thickness of walls in mm
3_wall_thickness = 2;
// Depth of block in mm
4_depth = 50;
// Do you want a back wall on the block?
5_back_wall = "no";//[yes,no]
// Do you want a bevel on the back of the block?
6_bevel = "yes";//[yes,no]
// Clearance between connectors in mm? Increase to make looser fits, decrease to make tighter fits.
7_connector_clearance = .25;

type =1_type;
square_size =2_square_size;
wall_thickness = 3_wall_thickness;
depth = 4_depth;
back_wall = 5_back_wall;
bevel = 6_bevel;
connector_clearance = 7_connector_clearance;

grid_size = square_size;
CC = connector_clearance;
off = wall_thickness/grid_size;
backWallOffset = back_wall == "yes" ? 1 : -1;
shape = type;
grid_pattern = bevel;
dif = connector_clearance/grid_size/4;
adif = dif*1.70710678118;

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

// preview[view:south east,tilt:top]
makeShape(shape);


module makeShape(shape){
	color("Blue")
	difference(){			
		difference(){
			linear_extrude(height=depth, convexity = 10)
			scale([grid_size,grid_size,1])
			if (shape == "1 Way Connector B") square1B();
			else if (shape == "1 Way Connector A") square1A();
			else if (shape == "2 Way Connector D") square2D();
			else if (shape == "2 Way Connector C") square2C();
			else if (shape == "2 Way Connector B") square2B();
			else if (shape == "2 Way Connector A") square2A();
			else if (shape == "3 Way Connector B") square3B();
			else if (shape == "3 Way Connector A") square3A();
			else if (shape == "4 Way Connector") square();
			else if (shape == "No Connectors") square0();
			cuttingGrid();
		}
		difference(){
			translate([0,0,backWallOffset*wall_thickness])
			linear_extrude(height=depth*2, convexity = 10)
			scale([grid_size,grid_size,1])
			if (shape == "1 Way Connector B") offSquare1B();
			else if (shape == "1 Way Connector A") offSquare1A();
			else if (shape == "2 Way Connector D") offSquare2D();
			else if (shape == "2 Way Connector C") offSquare2C();
			else if (shape == "2 Way Connector B") offSquare2B();
			else if (shape == "2 Way Connector A") offSquare2A();
			else if (shape == "3 Way Connector B") offSquare3B();
			else if (shape == "3 Way Connector A") offSquare3A();
			else if (shape == "4 Way Connector") offSquare();
			else if (shape == "No Connectors") offSquare0();
			if (grid_pattern == "yes"){
				translate([0,0,wall_thickness])
				cuttingGrid();
			}
		}
		if (grid_pattern == "yes") cuttingGrid();
	}
}

module cuttingGrid(){
	rotate([0,0,90])
	rotate([90,0,0])
	translate([0,0,-grid_size*1.05])
	linear_extrude(height=grid_size*2.1, convexity = 10)
	scale([grid_size,grid_size,1])
	polygon(points = [ [-1,-1],[-1,.65],[0,-.35],[1,.65],[1,-1]],paths = [[0,1,2,3,4]]);
	
	rotate([90,0,0])
	translate([0,0,-grid_size*1.05])
	linear_extrude(height=grid_size*2.1, convexity = 10)
	scale([grid_size,grid_size,1])
	polygon(points = [ [-1,-1],[-1,.65],[0,-.35],[1,.65],[1,-1]],paths = [[0,1,2,3,4]]);
}

module square0() {
	polygon(points = [ [-.5,-.5],
						[.5,-.5],
						[.5,.5],
						[-.5,.5]],paths = [[0,1,2,3]]);
}

module offSquare0() {
	polygon(points = [ [-.5+off,-.5+off],
						[.5-off,-.5+off],
						[.5-off,.5-off],
						[-.5+off,.5-off]],paths = [[0,1,2,3]]);
}

module square1B() {
	polygon(points = [ [-.5,-.5],[-.1-dif,-.5],[-.2-adif,-.4+dif],[.2+adif,-.4+dif],[.1+dif,-.5],
						[.5,-.5],
						[.5,.5],
						[-.5,.5]],paths = [[0,1,2,3,4,5,6,7]]);
}

module offSquare1B() {
	polygon(points = [ [-.5+off,-.4+off],
						[.5-off,-.4+off],
						[.5-off,.5-off],
						[-.5+off,.5-off]],paths = [[0,1,2,3]]);
}

module square1A() {
	polygon(points = [ [-.5,-.5],
						[.5,-.5],
						[.5,.5],
						[-.5,.5],[-.5,.1-dif],[-.6+dif,.2-adif],[-.6+dif,-.2+adif],[-.5,-.1+dif]],paths = [[0,1,2,3,4,5,6,7]]);
}

module offSquare1A() {
	polygon(points = [ [-.5+off,-.5+off],
						[.5-off,-.5+off],
						[.5-off,.5-off],
						[-.5+off,.5-off]],paths = [[0,1,2,3]]);
}

module square2D() {
	polygon(points = [ [-.5,-.5],[-.1-dif,-.5],[-.2-adif,-.4+dif],[.2+adif,-.4+dif],[.1+dif,-.5],
						[.5,-.5],
						[.5,.5],
						[-.5,.5],[-.5,.1-dif],[-.6+dif,.2-adif],[-.6+dif,-.2+adif],[-.5,-.1+dif]],paths = [[0,1,2,3,4,5,6,7,8,9,10,11]]);
}

module offSquare2D() {
	polygon(points = [ [-.5+off,-.4+off],
						[.5-off,-.4+off],
						[.5-off,.5-off],
						[-.5+off,.5-off]],paths = [[0,1,2,3]]);
}

module square2C() {
	polygon(points = [ [-.5,-.5],[-.1-dif,-.5],[-.2-adif,-.4+dif],[.2+adif,-.4+dif],[.1+dif,-.5],
						[.5,-.5],
						[.5,.5],[.1+dif,.5],[.2+adif,.4-dif],[-.2-adif,.4-dif],[-.1-dif,.5],
						[-.5,.5]],paths = [[0,1,2,3,4,5,6,7,8,9,10,11]]);
}

module offSquare2C() {
	polygon(points = [ [-.5+off,-.4+off],
						[.5-off,-.4+off],
						[.5-off,.4-off],
						[-.5+off,.4-off]],paths = [[0,1,2,3]]);
}

module square2B() {
	polygon(points = [ [-.5,-.5],
						[.5,-.5],[.5,-.1+dif],[.6-dif,-.2+adif],[.6-dif,.2-adif],[.5,.1-dif],
						[.5,.5],
						[-.5,.5],[-.5,.1-dif],[-.6+dif,.2-adif],[-.6+dif,-.2+adif],[-.5,-.1+dif]],paths = [[0,1,2,3,4,5,6,7,8,9,10,11]]);
}

module offSquare2B() {
	polygon(points = [ [-.5+off,-.5+off],
						[.5-off,-.5+off],
						[.5-off,.5-off],
						[-.5+off,.5-off]],paths = [[0,1,2,3]]);
}

module square2A() {
	polygon(points = [ [-.5,-.5],
						[.5,-.5],
						[.5,.5],[.1+dif,.5],[.2+adif,.4-dif],[-.2-adif,.4-dif],[-.1-dif,.5],
						[-.5,.5],[-.5,.1-dif],[-.6+dif,.2-adif],[-.6+dif,-.2+adif],[-.5,-.1+dif]],paths = [[0,1,2,3,4,5,6,7,8,9,10,11]]);
}

module offSquare2A() {
	polygon(points = [ [-.5+off,-.5+off],
						[.5-off,-.5+off],
						[.5-off,.4-off],
						[-.5+off,.4-off]],paths = [[0,1,2,3]]);
}

module square3B() {
	polygon(points = [ [-.5,-.5],[-.1-dif,-.5],[-.2-adif,-.4+dif],[.2+adif,-.4+dif],[.1+dif,-.5],
						[.5,-.5],
						[.5,.5],[.1+dif,.5],[.2+adif,.4-dif],[-.2-adif,.4-dif],[-.1-dif,.5],
						[-.5,.5],[-.5,.1-dif],[-.6+dif,.2-adif],[-.6+dif,-.2+adif],[-.5,-.1+dif]],paths = [[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]]);
}

module offSquare3B() {
	polygon(points = [ [-.5+off,-.4+off],
						[.5-off,-.4+off],
						[.5-off,.4-off],
						[-.5+off,.4-off]],paths = [[0,1,2,3]]);
}

module square3A() {
	polygon(points = [ [-.5,-.5],
						[.5,-.5],[.5,-.1+dif],[.6-dif,-.2+adif],[.6-dif,.2-adif],[.5,.1-dif],
						[.5,.5],[.1+dif,.5],[.2+adif,.4-dif],[-.2-adif,.4-dif],[-.1-dif,.5],
						[-.5,.5],[-.5,.1-dif],[-.6+dif,.2-adif],[-.6+dif,-.2+adif],[-.5,-.1+dif]],paths = [[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]]);
}

module offSquare3A() {
	polygon(points = [ [-.5+off,-.5+off],
						[.5-off,-.5+off],
						[.5-off,.4-off],
						[-.5+off,.4-off]],paths = [[0,1,2,3]]);
}

module square() {
	polygon(points = [ [-.5,-.5],[-.1-dif,-.5],[-.2-adif,-.4+dif],[.2+adif,-.4+dif],[.1+dif,-.5],
						[.5,-.5],[.5,-.1+dif],[.6-dif,-.2+adif],[.6-dif,.2-adif],[.5,.1-dif],
						[.5,.5],[.1+dif,.5],[.2+adif,.4-dif],[-.2-adif,.4-dif],[-.1-dif,.5],
						[-.5,.5],[-.5,.1-dif],[-.6+dif,.2-adif],[-.6+dif,-.2+adif],[-.5,-.1+dif]],paths = [[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]]);
}

module offSquare() {
	polygon(points = [ [-.5+off,-.4+off],
						[.5-off,-.4+off],
						[.5-off,.4-off],
						[-.5+off,.4-off]],paths = [[0,1,2,3]]);
}

module backSquare() {
	polygon(points = [ [-.5,-.5],[.5,-.5],[.5,.5],[-.5,.5]],paths = [[0,1,2,3]]);
}