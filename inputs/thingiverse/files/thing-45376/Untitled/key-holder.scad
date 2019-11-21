
//CUSTOMIZER VARIABLES

//Number of slots in holder.
numOfSlots = 1; // [1 : 5]

//Height of the holder.
totalHeight = 4;

//Total length.
totalWidth = 15;

//Space around the edge.
edgeGap = 1;

//Gap size for the keys
keyGap = 0.4;

//Size of hole for screws
screwHoleDiameter = 0.5;

//Size of hoe where screw heads are sunk.
screwHeadDiameter = 0.75;

//CUSTOMIZER END


function getInterp(p) = lookup(p, [[0, -(totalHeight-edgeGap)/2], [(numOfSlots-1)/2, 0], [(numOfSlots-1), (totalHeight-edgeGap)/2]]);

function getGapInterp(p) = lookup(p, [[0, -(totalHeight-edgeGap)/2], [(numOfSlots-1)/2, 0], [(numOfSlots-1), (totalHeight-edgeGap)/2]]);



difference(){
	union() {
	translate([0, 0, 2.25]) cube(size=[totalHeight, totalWidth-totalHeight, 4.5], center=true);
	translate([0, totalWidth/2-totalHeight/2, 0]) cylinder(h=4.5, r1=totalHeight/2, r2=totalHeight/2, $fn=60);
	translate([0, -(totalWidth/2-totalHeight/2), 0]) cylinder(h=4.5, r1=totalHeight/2, r2=totalHeight/2, $fn=60);
	}

	difference(){
		
		if (numOfSlots > 2){
			for (i =[0 : numOfSlots-1]){
				translate([getInterp(i), 0, 2.75]) cube(size=[keyGap, totalWidth, 3.6], center=true);
			}
		}
		if (numOfSlots == 2){
			for (i =[0 : numOfSlots-1]){
				translate([getInterp(i)/1.5, 0, 2.75]) cube(size=[keyGap, totalWidth, 3.6], center=true);
			}
		}
		if (numOfSlots == 1){
			for (i =[0 : numOfSlots-1]){
				translate([0, 0, 2.75]) cube(size=[keyGap, totalWidth, 3.6], center=true);
			}
		}

		difference(){
			translate([0, totalWidth/2-totalHeight/2+2.5, 3]) cube(size=[5, 5, 5], center=true);
			translate([0, totalWidth/2-totalHeight/2, -1]) cylinder(h=7, r1=(totalHeight/2)-edgeGap/2+keyGap/2, r2=(totalHeight/2)-edgeGap/2+keyGap/2, $fn=60);
			}
	
		difference(){
			translate([0, -(totalWidth/2-totalHeight/2)-2.5, 3]) cube(size=[5, 5, 5], center=true);
			translate([0, -(totalWidth/2-totalHeight/2), -1]) cylinder(h=7, r1=(totalHeight/2)-edgeGap/2+keyGap/2, r2=(totalHeight/2)-edgeGap/2+keyGap/2, $fn=60);
			}

	}

	translate([0, totalWidth/2-totalHeight/2, 0]) cylinder(h=15, r1=screwHoleDiameter/2, r2=screwHoleDiameter/2, $fn=60, center=true);
	translate([0, totalWidth/2-totalHeight/2, 2.0]) cylinder(h=15, r1=screwHeadDiameter/2, r2=screwHeadDiameter/2, $fn=60);
	translate([0, -(totalWidth/2-totalHeight/2), 0]) cylinder(h=15, r1=screwHoleDiameter/2, r2=screwHoleDiameter/2, $fn=60, center=true);
	translate([0, -(totalWidth/2-totalHeight/2), 2.0]) cylinder(h=15, r1=screwHeadDiameter/2, r2=screwHeadDiameter/2, $fn=60);	

}


