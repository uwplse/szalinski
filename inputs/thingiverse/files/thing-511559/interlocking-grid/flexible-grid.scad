// flexible grid
// https://github.com/davidelliott/parametric-lab 
// License: CC-BY

// This design is for a flexible interlocking grid system
// initially made for holding small petri dishes in position
// Code is quite rough but it works for the original purpose
// Design is not fully parameterised

// TO DO / known problems
// bug- Grid has to be a square - i.e. cells_x = cells_y
// feature- option for cells to not be square

// set parameters
wall_width=5;

// Cryo tube rack
hole_size=11;
cells_x=4;
cells_y=4;
height=20;
floor_thickness=1.5; // Set 0 for no base
//

// calculated dimensions
socket_enlargement=1.1+(height/500); // make the sockets slightly bigger with height increase
unit_length=hole_size+wall_width;
total_x=unit_length*cells_x;
total_y=unit_length*cells_y;

// print the total dimensions
echo(total_x);
echo(total_y);

///////////////////////
// build the objects //
///////////////////////
// In OpenSCAD 2014.09.05 rendering both grid and walls does not work properly
// In OpenSCAD 2014.03 it was fine, don't know why.
// hence here a choice to build walls or grid separately.

grid=1; // build the main grid [0,1]
walls=0; // build extra walls [0,1]

if(grid){
// the main grid
main();
}

if(walls){
// the extra walls to close the grid.
translate([0,total_y+wall_width*1.5,0]){
extra_wall_b();
}

rotate([0,0,-90]){
translate([-total_x-wall_width,total_y+wall_width*1.5,0]){
extra_wall_a();
}
}

}

//////////////
// MODULES //
/////////////

module extra_wall_a(){
	
	difference(){
		cube([total_x,wall_width,height]);
		translate([0,0,-2]){
			connector_array(h=height+5,adj=socket_enlargement+0.05,start=0,end=cells_x);
		}
	}
}



module extra_wall_b(){

	difference(){
	union(){
		cube([total_x,wall_width,height]);
rotate([180,0,90]){
	translate([0,total_x,-height]){
		connector_array(start=0,end=0);
	}
}
} // end of union
// now remove the sockets
		
		translate([0,0,-2]){
			connector_array(h=height+5,adj=socket_enlargement+0.05,start=0,end=cells_x-1);
		}
	}

}


module main(){
difference() {
union() {
// build the base.
color("brown")
difference(){
	cube([total_x,total_y,floor_thickness]);
	perforations();
}

// build the grid
for(i=[0:cells_x-1]) {
		translate([0,i*(unit_length),0]){
			cube([total_x,wall_width,height]);
		}
	}

for(i=[0:cells_y-1]) {
		translate([i*(unit_length),0,0]){
			cube([wall_width,total_y,height]);
		}
}

// add reinforcements if there is no floor
if(floor_thickness<0.1) {
for(i=[0:cells_x-1]) {
	
	translate([0,i*(unit_length)+wall_width,0]){
rotate([0,0,270]){
		reinforcement(i);
	}
}
}

for(i=[0:cells_y]) {
		translate([i*(unit_length),0,0]){
			reinforcement(i);
		}
}
} // end of if

// add connectors
translate([0,total_y,0]){
connector_array(start=0,end=cells_y-1);
}

rotate([180,0,90]){
	translate([0,total_x,-height]){
		connector_array(start=0,end=cells_x-1);
	}
}



} // end of union

// remove connector sockets
translate([0,0,-2]){
	connector_array(h=height+5,adj=socket_enlargement,start=0,end=cells_x-1);
}
rotate([180,0,90]){
	translate([0,0,-height-2]){
		connector_array(h=height+5,adj=socket_enlargement,start=0,end=cells_y);
	}
}


} // end of difference group
} // end of module main


module connector_array(h=height,adj=1,start=0,end=cells_y) {
	for(i=[start:end]) {
		translate([i*(unit_length),0,0]){
			connector(h=h,adjust=adj);
		}
	}
}

module connector(subtract=false,adjust=1) {
translate([0,0,0]){
hull(){
translate([-wall_width*adjust/2,wall_width*adjust/2,0]){
cube([wall_width*2*adjust,1*adjust,h]);
}
cube([wall_width*adjust,1*adjust,h]);
}
translate([0,-3,0]){
	cube([wall_width*adjust,5,h]);
}
}
}


module reinforcement(i=1) {
if(i<cells_x){
reinforcement_part();
}
if(i>0) {
translate([wall_width-0.1,0,0]){
mirror("x"){
reinforcement_part();
}
}
}
}





module reinforcement_part() {
	r=wall_width;
	difference(){
		translate([wall_width-0.1,r,0]){
			cylinder(r=r,h=height);
		}

		translate([-0.1,-0.1,-1]){
			cube([r*4,wall_width,height*2]);
			cube([wall_width-0.01,r*3,height*2]);
		}

	} // end of difference
}


module perforations(rad=2.5,space=0.25){
	perf_total = (rad*2)+space; // length of each perforation inc spacing
	offset=perf_total/2; // offset alternate rows for better packing
	//packing_factor - calculate spacing by Pythagoras
	// looking for value of b in a2 + b2 = c2
	
	a=perf_total/2; 
	c=perf_total;
	
	x_spacing = pow((c*c) - (a*a) , 1/2);
//	perf_n=total_x/perf_total; // number of perforations needed
	perf_x=total_x/x_spacing; // number of perforations needed
	perf_y=total_x/perf_total; // number of perforations needed


	for(y=[0:perf_y-1]) {
		for(x=[0:perf_x-1]) {
			translate([x*x_spacing,y*perf_total+(even(x)*offset),-2]) {
				cylinder(h=floor_thickness+4,r=rad,$fn=6);
			}
		}
	}
}

function even(n) = n%2;



