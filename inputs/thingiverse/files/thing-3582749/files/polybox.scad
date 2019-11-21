/* [Global] */
// Which one would you like to see?
part = "both"; // [box:Box Only,lid:Lid Only,both:Box and Lid]

/* [Main Structure] */
//need to define a valid shape by it's points [[x1,y1],[x2,y2],[x3,y3]] - remember to have 2 sets of square brackets at begining and end
myvector=[[0,23.8],[20.2,38.5],[12.5,62.2],[32.7, 47.6],[53,62.2],[45.2,38.5],[65.5,23.8],[40.5,23.8],[32.7,0],[25,23.8]]; //star


//Factor to scale shape up by incase your vector points are the wrong size
scalefactor=2;
myscaledvector=myvector*scalefactor;
//Overall height of box
depth=40;
//thickness of base
base=2;
//thickness of wall
wall=2;

/* [Lid Structure] */
//height of lid
liddepth=2;
//height of internal lip
lipdepth=4;
//width of internal lip
lipwidth=2;
//clearance between lip and wall
clearance = 0.4;

/* [Hidden] */
//myvector=[[0,0],[5,5],[10,15],[5,20],[10,25],[5,35],[4,55],[0,60],[-4,55],[-5,35],[-10,25],[-5,20],[-10,15],[-5,5]];  //random
//myvector=[[0,0],[0,10],[10,10],[10,0]]; //square
//myvector=[[0,0],[20,0],[10,sin(60)*20]];  //triangle
//myvector=[[25,50],[34,40],[29,40],[36, 30],[31,30],[38,20],[33,20],[42,7],[30,7],[30,0],[20,0],[20,7],[8,7],[17,20],[12,20],[19,30],[14,30],[21,40],[16,40]]; //christmas tree
//myvector=[[28,12],[27,9],[26,7],[27,4],[24,6],[18,5],[17,3],[15,4],[10,4],[8,5],[8,0],[6,2],[5,5],[1,6],[3,7],[0,8],[2,9],[5,10],[10,10],[12,14],[14,10],[17,9],[23,8],[28,12]]; //shark
//myvector=[[-1,6],[-1,4],[-0.5,3],[0.5,3],[1,4],[1,6],[2,4],[3,3],[5,3.5],[7,5],[8,7],[7,10],[5,13],[7,16],[8,19],[8,21],[7.6,22],[7,23],[6,23.7],[4,23],[3,22],[2,20],[1,17],[1,18],[0.5,19],[-0.5,19],[-1,18],[-1,17],[-2,20],[-3,22],[-4,23],[-6,23.7],[-7,23],[-7.6,22],[-8,21],[-8,19],[-7,16],[-5,13],[-7,10],[-8,7],[-7,5],[-5,3.5],[-3,3],[-2,4]]; //butterfly
//myvector=[[0,23.8],[20.2,38.5],[12.5,62.2],[32.7, 47.6],[53,62.2],[45.2,38.5],[65.5,23.8],[40.5,23.8],[32.7,0],[25,23.8]]; //star

module doshape(depth1,depth2){
difference(){
linear_extrude(height=depth1) polygon(points=myscaledvector);
translate([0,0,base]) linear_extrude(height=depth2) offset(r=-wall) polygon(points=myscaledvector);
}
}

module dolip(depth1,off1,off2){
difference(){
    translate([0,0,0]) linear_extrude(height=depth1) offset(r=-off1) polygon(points=myscaledvector);
    translate([0,0,0]) linear_extrude(height=depth1+0.01) offset(r=-off2) polygon(points=myscaledvector);
}
}

module makebox(){
    doshape(depth,depth-base+0.01);
}

module makelid(){
    translate([0,-10,0]) mirror([0,1,0]) doshape(liddepth,0);
    translate([0,-10,liddepth]) mirror([0,1,0]) dolip(lipdepth,wall+clearance,wall+clearance+lipwidth);
}

module both() {
	makebox();
	makelid();
}

module print_part() {
	if (part == "box") {
		makebox();
	} else if (part == "lid") {
		makelid();
	} else if (part == "both") {
		both();
	} else {
		both();
	}
}

print_part();

