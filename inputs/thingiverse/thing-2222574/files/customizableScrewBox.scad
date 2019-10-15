//Customizable stackable screw box

/* [Outside Box Dimensions] */
//Box Length
boxLen=200;
//Box Width
boxWid=100;
//Box Height
boxHgt=30;
//Wall thickness
boxThick=2;

/* [Divitions] */
// Number of Divitions
numSections=5;
// Merge sections (make one side bigger, use 2 or more to merge, 0 or 1 to normal)
mergeSections=2;


/* [Slope] */
// Shape of slope (4 = slope, more sections creates circular shape)
slopeSections=100;//[4:100]
// Use straight sides
straightSide=0;//0,1

/* [Hidden] */
dividerCount=mergeSections?numSections-mergeSections:numSections-1;


screwBox();

module screwBox() {
	echo("Number of dividers:",dividerCount);
	difference() {
		// outerbox
		translate([0,0,boxHgt/2])
			cube([boxLen,boxWid,boxHgt],center=true);
		if (straightSide) {
			// innerbox
			translate([0,0,0.1+(boxHgt/2+boxThick/2)]) 
				cube([boxLen-boxThick*2,boxWid-boxThick*2,boxHgt-boxThick+0.1],center=true);
		} else {
			// innerbox
			translate([0,0-boxHgt/2,0.1+(boxHgt/2+boxThick/2)]) 
				cube([boxLen-boxThick*2,boxWid-boxHgt-boxThick*2,boxHgt-boxThick+0.1],center=true);
			// slope
			translate([0,boxWid/2-boxHgt-boxThick,boxHgt+boxThick]) 
				rotate([0,90,0])cylinder(boxLen-boxThick*2,boxHgt,boxHgt,center=true,$fn=slopeSections);
		}
	}
	// dividers
	for (sep=[1:dividerCount]) {
		translate([(boxLen-boxThick)/2-sep*(boxLen-boxThick)/numSections,0,boxHgt/2])
			cube([boxThick,boxWid,boxHgt],center=true);
	}
	// rim
	rotate([180,0,0])union() {
		translate([0,0,0-boxHgt])difference() {
			cube([boxLen+boxThick*2+0.8,boxWid+boxThick*2+0.8,boxThick*2],center=true);
			cube([boxLen,boxWid,boxThick*2+1],center=true);
			// extra cut out for stacking
			translate([0,0,0-boxThick/2-0.1])cube([boxLen+0.8,boxWid+0.8,boxThick],center=true);
			// 45 degree support for outer edge
			translate([0,boxWid/2+boxThick*1.05,boxThick*0.7071]) 
				rotate([45,0,0])cube([boxLen+boxThick*2+1,boxThick,boxThick*2],center=true);
			translate([0,0-(boxWid/2+boxThick*1.05),boxThick*0.7071]) 
				rotate([-45,0,0])cube([boxLen+boxThick*2+1,boxThick,boxThick*2],center=true);
			translate([boxLen/2+boxThick*1.05,0,boxThick*0.7071]) 
				rotate([0,-45,0])cube([boxThick,boxWid+boxThick*2+1,boxThick*2],center=true);
			translate([0-(boxLen/2+boxThick*1.05),0,boxThick*0.7071]) 
				rotate([0,45,0])cube([boxThick,boxWid+boxThick*2+1,boxThick*2],center=true);
		}
	}
}


