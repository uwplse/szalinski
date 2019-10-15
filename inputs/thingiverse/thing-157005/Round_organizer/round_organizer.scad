numberOfColumns = 5; 
numberOfRows = 3; 

singleBoxWidth = 30;
singleBoxHeight = 30;

baseHeight = 3; 
boxHeight = 30; 

internalWallThickness = 3;
externalWallThickness = 3;

internalRadius = 5;
quality=30; // [10:60]

// ignore
$fn=quality;


module roundbox(r,wi,he,dz) {
	hull()
	{
		cube([wi, he, dz]);
		translate([0,0,0])
			cylinder(r=r, h=dz);
		translate([wi, 0, 0])
			cylinder(r=r, h=dz);
		translate([wi, he, 0])
			cylinder(r=r, h=dz);
		translate([0, he, 0])
			cylinder(r=r, h=dz);
	}

}


module organizer() {
	difference() {
	   roundbox(externalWallThickness, numberOfColumns*singleBoxWidth+(numberOfColumns-1)*internalWallThickness, numberOfRows*singleBoxHeight+(numberOfRows-1)*internalWallThickness, baseHeight+boxHeight);
	   for (y=[0:numberOfRows-1])
			for (x=[0:numberOfColumns-1]) {
				translate([(internalWallThickness+singleBoxWidth)*x, (internalWallThickness+singleBoxHeight)*y, baseHeight]) {
				translate([internalRadius,internalRadius,0])
					roundbox(internalRadius,singleBoxWidth-2*internalRadius,singleBoxHeight-2*internalRadius, boxHeight+1);
			}
		}
	}
}


organizer();
