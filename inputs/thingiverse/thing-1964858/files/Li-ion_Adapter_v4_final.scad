//preview[view:north, tilt:top]

/* [Basic] */
//width of battery (x axis)
width = 32.5;
//depth of battery (y axis)
depth = 47.5;
//height of batter (z axis) 
height = 10.5;
//vertical walls and top holder 
wallThickness = 1.2;
//base horizontal wall thickness
baseThickness = 3; 
//additonal depth of adapter for battery lock
lockLength = 3;
//width of top horizontal battery holder frame 
holderWidth = 5;
//create contact cover (yes/no) 
contactCover = 1; //[0:No,1:Yes]
//contact 1 distance from left battery edge 
contact1Distance = 10;
//contact 2 distance from left battery edge 
contact2Distance = 24;
//create mount holes (yes/no) 
Holes = 1; //[0:No,1:Yes] 
holeDiameter = 3;
//diameter of top screw head
holeHeadDiameter = 6.5;
//height of top screw head 
holeHeadHeight = 2;
//hole distance at x axis (width) 
holeXDistance = 20;
//hole distance at y axis (depth) 
holeYDistance = 20; 

/* [Advanced] */
//contact depth in inner battery box (how much is sinked into)
contactDepth = 5;
//total contact lenght 
contactLength = 10;
//contact bottom width 
contactBWidth = 2.1;
//contact top width (exposed to battery) 
contactTWidth = 1.6;
//contact hole height, should be less than contact height 
contactHeight = 2.5;
//distance of contact lock from contact tip 
contactLockDist = 4; 

/* [Hidden] */
//Number of facets
$fn = 20;

difference() {
	battery_box();
	//contact1
	translate([contact1Distance + wallThickness,contactDepth + wallThickness - contactLength, baseThickness - contactHeight + 0.1]) {
		contact();
	}
	//contact2
	translate([contact2Distance + wallThickness,contactDepth + wallThickness - contactLength, baseThickness - contactHeight + 0.1]) {
		contact();
	}
	//lock spacer
	translate([width/2-2*wallThickness,depth+lockLength+wallThickness -15,-baseThickness+1.5]){
	cube([7,lockLength + 15,baseThickness]);
	}
	//mount holes
	if(Holes == 1) {
		translate([(width-holeXDistance)/2+wallThickness,(depth-holeYDistance)/2+wallThickness,0]) { screwHole();}
		translate([(width-holeXDistance)/2+wallThickness+holeXDistance,(depth-holeYDistance)/2+wallThickness+holeYDistance,0]) { screwHole();}

	}
}


module battery_box() {
	difference() {
		cube([width+2*wallThickness,depth+wallThickness+lockLength,height+wallThickness+baseThickness],false);
		translate([wallThickness,wallThickness,baseThickness]){
			cube([width,depth+lockLength+0.1,height]);
		}
		translate([wallThickness+holderWidth,wallThickness+lockLength,baseThickness]){
			cube([width-2*holderWidth,depth+0.1,height+wallThickness+0.1]);
		}
		translate([wallThickness+width/2+3,depth+wallThickness+lockLength-20+0.1,-0.1]){
			cube([1,20,baseThickness+0.2]);
		}
		translate([wallThickness+width/2-4,depth+wallThickness+lockLength-20+0.1,-0.1]){
			cube([1,20,baseThickness+0.2]);
		}
		//chamfer
		translate([width/2+wallThickness,depth+wallThickness+lockLength-width/2,baseThickness+height-0.1]){
			rotate([0,0,45]){
				cube([sqrt(pow(width+2*wallThickness,2)/2),sqrt(pow(width+2*wallThickness,2)/2),wallThickness+0.2]);
			}
		}
	
	}
	//contact cover
	if (contactCover == 1) {
		translate([0,wallThickness+contactDepth-contactLength+0.1,0]){
		cube([width+2*wallThickness,contactLength-wallThickness-contactDepth-0.1,baseThickness+1.5]);
		}
	}
	//lock stump
		translate([wallThickness+width/2,depth+wallThickness,baseThickness-1]){
			sphere(d=5);
	}
}

module contact() {

union() {	
		cube([contactBWidth,contactLength,0.5]);
		translate([(contactBWidth - contactTWidth)/2, contactLength - contactDepth,0]){
			cube([contactTWidth,contactDepth,contactHeight]);
		}
		cube([contactBWidth,contactLength- contactDepth,contactHeight]);
		translate([(contactBWidth - 1)/2,contactLength - contactLockDist,-5]){
			cube([1,2.5,5]);
		}
	
		translate([0, 0,0]){
			cube([contactBWidth,contactLength-contactDepth+0.1,3]);
		}

	}
}

module screwHole() {
	union() {
		translate([0, 0,-0.1]){
			cylinder(h=baseThickness+0.2, r=holeDiameter/2);
		}
		translate([0, 0,baseThickness - holeHeadHeight]){
			cylinder(h=holeHeadHeight+0.1, r=holeHeadDiameter/2);
		}
	}
}

