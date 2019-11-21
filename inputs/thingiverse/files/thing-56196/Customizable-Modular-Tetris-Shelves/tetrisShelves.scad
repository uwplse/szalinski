use <utils/build_plate.scad>

// Select a shape to make
shape = "L"; // [I,J,L,O,S,Z,T]
// Size of each grid square in mm
grid_size = 50;
// Thickness of walls in mm
wall_thickness = 2;
// Depth of shape in mm
depth = 50;
// Do you want a back wall on the shape?
back_wall = "yes";//[yes,no]
// Do you want a grid pattern on the back of the shape?
grid_pattern = "yes";//[yes,no]
// Do you want to build a shape?
want_shape = "yes";//[yes,no]

// Depth of connectors in mm
connector_depth = 15;
// Width of connectors in mm
connector_width = 15;
// Clearance between connectors and shapes in mm? Increase to make looser fits, decrease to make tighter fits.
connector_clearance = 0.25;
// Circle or square connectors?
connector_shape = "square";//[circle,square]
// How many 4 slot connectors to layout?
number_of_4_slot_connectors = 0;//[0:12]
// How many 3 slot connectors to layout?
number_of_3_slot_connectors = 0;//[0:12]
// How many straight slot connectors to layout?
number_of_2_slot_straight_connectors = 0;//[0:12]
// How many corner slot connectors to layout?
number_of_2_slot_corner_connectors = 0;//[0:12]

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

connector_diameter = connector_width;
numConnectors = number_of_4_slot_connectors+number_of_3_slot_connectors+number_of_2_slot_straight_connectors+number_of_2_slot_corner_connectors;
CC = connector_clearance;
off = wall_thickness/grid_size;
backWallOffset = back_wall == "yes" ? 1 : -1;

// preview[view:south east,tilt:top]
if (want_shape == "yes") makeShape(shape);
translate([-grid_size,grid_size*1.5,0])
makeConnectors();

module makeConnectors(){
	if (numConnectors > 0){
		for (i = [0:numConnectors-1]){
			makeConnectorX(i);
		}
	}
}

module makeConnectorX(i){
	color("Gray")
	translate([grid_size*(i%4),grid_size*round(i/4-0.49),0])
	if (number_of_4_slot_connectors > i) make4Connector();
	else if (number_of_4_slot_connectors + number_of_3_slot_connectors > i) make3Connector();
	else if (number_of_4_slot_connectors + number_of_3_slot_connectors + number_of_2_slot_straight_connectors > i) make2ConnectorA();
	else make2ConnectorB();
}

module connectorBase(){
	if (connector_shape == "circle") cylinder(h=connector_depth,r=connector_diameter/2);
	else{
		translate([-connector_diameter/2,-connector_diameter/2,0])
		cube(size = [connector_diameter,connector_diameter,connector_depth]);
	}
}

module make4Connector(){
	difference(){
		connectorBase();
		translate([0,0,wall_thickness*2+connector_depth/2])
		cube(size = [connector_diameter*1.1,wall_thickness*2+CC,connector_depth],center = true);
		translate([0,0,wall_thickness*2+connector_depth/2])
		cube(size = [wall_thickness*2+CC,connector_diameter*1.1,connector_depth],center = true);
	}
}

module make3Connector(){
	difference(){
		connectorBase();
		translate([0,0,wall_thickness*2+connector_depth/2])
		cube(size = [connector_diameter*1.1,wall_thickness*2+CC,connector_depth],center = true);
		translate([-wall_thickness-CC/2,0,wall_thickness*2])
		cube(size = [wall_thickness*2+CC,connector_diameter*.55,connector_depth]);
	}
}

module make2ConnectorA(){
	difference(){
		connectorBase();
		translate([0,0,wall_thickness*2+connector_depth/2])
		cube(size = [connector_diameter*1.1,wall_thickness*2+CC,connector_depth],center = true);
	}
}

module make2ConnectorB(){
	difference(){
		connectorBase();
		translate([-wall_thickness-CC/2,-wall_thickness-CC/2,wall_thickness*2])
		cube(size = [connector_diameter*1,wall_thickness*2+CC,connector_depth]);
		translate([-wall_thickness-CC/2,0,wall_thickness*2])
		cube(size = [wall_thickness*2+CC,connector_diameter*.55,connector_depth]);
	}
}

module makeShape(shape){
	color(shape == "L" ? "Orange" : shape == "J" ? "Blue" : shape == "O" ? "Yellow" : shape == "I" ? "Cyan" : shape == "S" ? "Lime" : shape == "Z" ? "Red" : "Magenta")
	difference(){
		linear_extrude(height=depth, convexity = 10)
		scale([grid_size,grid_size,1])
		if (shape == "L") L();
		else if (shape == "J") J();
		else if (shape == "O") O();
		else if (shape == "I") I();
		else if (shape == "S") S();
		else if (shape == "Z") Z();
		else if (shape == "T") T();
	
		difference(){
			translate([0,0,backWallOffset*wall_thickness])
			linear_extrude(height=depth*2, convexity = 10)
			scale([grid_size,grid_size,1])
			if (shape == "L") offsetL();
			else if (shape == "J") offsetJ();
			else if (shape == "O") offsetO();
			else if (shape == "I") offsetI();
			else if (shape == "S") offsetS();
			else if (shape == "Z") offsetZ();
			else if (shape == "T") offsetT();
			if (grid_pattern == "yes"){
				translate([0,0,wall_thickness])
				cuttingGrid();
			}
		}
		if (grid_pattern == "yes") cuttingGrid();
	}
}

module cuttingGrid(){
	translate([0,-grid_size*.5,0])
	rotate([0,0,90])
	rotate([90,0,0])
	translate([0,0,-grid_size*1.55])
	linear_extrude(height=grid_size*4.1, convexity = 10)
	scale([grid_size,grid_size,1])
	polygon(points = [ [-1,-1],[-1,-.35],[-.5,.15],[0,-.35],[.5,.15],[1,-.35],[1.5,.15],[2,-.35],[2,-1]],paths = [[0,1,2,3,4,5,6,7,8]]);
	
	rotate([90,0,0])
	translate([0,0,-grid_size*1.05])
	linear_extrude(height=grid_size*2.1, convexity = 10)
	scale([grid_size,grid_size,1])
	polygon(points = [ [-2,-1],[-2,-.35],[-1.5,.15],[-1,-.35],[-.5,.15],[0,-.35],[.5,.15],[1,-.35],[1.5,.15],[2,-.35],[2.5,.15],[3,-.35],[3,-1]],paths = [[0,1,2,3,4,5,6,7,8,9,10,11,12]]);
}

module L() {
	color("Orange")
	polygon(points = [ [-1.5,-1],[1.5,-1],[1.5,1],[.5,1],[.5,0],[-1.5,0]],paths = [[0,1,2,3,4,5]]);
}

module J() {
	color("Blue")	
	polygon(points = [ [-1.5,-1],[1.5,-1],[1.5,0],[-.5,0],[-.5,1],[-1.5,1]],paths = [[0,1,2,3,4,5]]);
}

module O() {
	color("Yellow")	
	polygon(points = [ [-.5,-1],[1.5,-1],[1.5,1],[-.5,1]],paths = [[0,1,2,3]]);
}

module I() {
	color("Cyan")	
	polygon(points = [ [-1.5,0],[2.5,0],[2.5,1],[-1.5,1]],paths = [[0,1,2,3]]);
}

module S() {
	color("Lime")	
	polygon(points = [ [-1.5,-1],[.5,-1],[.5,0],[1.5,0],[1.5,1],[-.5,1],[-.5,0],[-1.5,0]],paths = [[0,1,2,3,4,5,6,7]]);
}

module Z() {
	color("Red")	
	polygon(points = [ [1.5,-1],[-.5,-1],[-.5,0],[-1.5,0],[-1.5,1],[.5,1],[.5,0],[1.5,0]],paths = [[0,1,2,3,4,5,6,7]]);
}

module T() {
	color("Magenta")	
	polygon(points = [ [-1.5,-1],[1.5,-1],[1.5,0],[.5,0],[.5,1],[-.5,1],[-.5,0],[-1.5,0]],paths = [[0,1,2,3,4,5,6,7]]);
}

module offsetL() {
	color("Orange")
	polygon(points = [ [-1.5+off,-1+off],[1.5-off,-1+off],[1.5-off,1-off],[.5+off,1-off],[.5+off,0-off],[-1.5+off,0-off]],paths = [[0,1,2,3,4,5]]);
}

module offsetJ() {
	color("Blue")	
	polygon(points = [ [-1.5+off,-1+off],[1.5-off,-1+off],[1.5-off,0-off],[-.5-off,0-off],[-.5-off,1-off],[-1.5+off,1-off]],paths = [[0,1,2,3,4,5]]);
}

module offsetO() {
	color("Yellow")	
	polygon(points = [ [-.5+off,-1+off],[1.5-off,-1+off],[1.5-off,1-off],[-.5+off,1-off]],paths = [[0,1,2,3]]);
}

module offsetI() {
	color("Cyan")	
	polygon(points = [ [-1.5+off,off],[2.5-off,off],[2.5-off,1-off],[-1.5+off,1-off]],paths = [[0,1,2,3]]);
}

module offsetS() {
	color("Lime")	
	polygon(points = [ [-1.5+off,-1+off],[.5-off,-1+off],[.5-off,0+off],[1.5-off,0+off],[1.5-off,1-off],[-.5+off,1-off],[-.5+off,0-off],[-1.5+off,0-off]],paths = [[0,1,2,3,4,5,6,7]]);
}

module offsetZ() {
	color("Red")	
	polygon(points = [ [1.5-off,-1+off],[-.5+off,-1+off],[-.5+off,0+off],[-1.5+off,0+off],[-1.5+off,1-off],[.5-off,1-off],[.5-off,0-off],[1.5-off,0-off]],paths = [[0,1,2,3,4,5,6,7]]);
}

module offsetT() {
	color("Magenta")
	polygon(points = [ [-1.5+off,-1+off],[1.5-off,-1+off],[1.5-off,0-off],[.5-off,0-off],[.5-off,1-off],[-.5+off,1-off],[-.5+off,0-off],[-1.5+off,0-off]],paths = [[0,1,2,3,4,5,6,7]]);
}