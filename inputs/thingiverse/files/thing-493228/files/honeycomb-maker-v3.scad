/* model honeycomb
Gian Pablo Villamil
October 2014

Customizable honeycomb generator. You can choose open or closed ended cells.
The overlap parameter controls the wall thickness of internal vs. external borders. If overlap is true, all walls will be same thickness. If overlap is false, then the
internal borders will be thicker and external thinner, so if you put two sections
together, they will mesh correctly.

 */

// Cell Radius mm
cellrad = 6; 
// Cell Depth mm
cellheight = 20; 
// Cell Wall Thickness mm
cellthick = 0.8; 

// Rows
rows = 6;
// Columns
cols = 5; 

// Open or closed cells?
celltype = "open"; // [open,closed]
// Inner and outer cell walls same thickness?
overlaptype = "yes"; // [yes,no]

closed = (celltype == "closed") ? true : false;
overlap = (overlaptype == "yes") ? true: false;

module flatcube(x,y,z) {
	translate([0,0,z/2]) cube([x,y,z],center=true);
}

module closedcell(radius,height,thickness) {
	difference() {
		cylinder(r=radius,h=height,$fn=6);
		for (i=[-1:1]) {
			translate([0,0,height]) rotate([0,-30,i*120]) flatcube(cellrad*3,cellrad*3,10);
		}
		translate([0,0,-1])
		difference() {
			cylinder(r=radius-thickness,h=height-thickness,$fn=6);
			for (i=[-1:1]) {
				translate([0,0,height-thickness]) rotate([0,-30,i*120]) flatcube(cellrad*3,cellrad*3,10);
			}
		}
	}
}

module opencell(radius,height,thickness) {
	difference() {
		cylinder(r=radius,h=height,$fn=6);
		translate([0,0,-0.5]) cylinder(r=radius-thickness,h=height+1,$fn=6);
	}
}


module honeycomb(rows,cols,closed) {
	cellsize = overlap ? cellrad-cellthick/2 : cellrad ;
	voff = cellsize*1.5;
	hoff = sqrt(pow(cellsize*2,2)-pow(cellsize,2));

	for (i=[0:rows-1]) {
		for (j=[0:cols-1]){
			translate([j*hoff+i%2*(hoff/2),i*voff,0])
			rotate([0,0,30]) 
			if (closed==true) {closedcell(cellrad,cellheight,cellthick);} 
				else
			{opencell(cellrad,cellheight,cellthick);} 
		}
	}
}


honeycomb(rows,cols,closed);

//opencell(cellrad,cellheight,cellthick);
//closedcell(cellrad,cellheight,cellthick);