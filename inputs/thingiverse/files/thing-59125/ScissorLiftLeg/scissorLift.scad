//General Variables
legLength = 80;
width = 12; //width of the bar
thickness = 5; //thickness of the bar
pivotDiameter = 6; //diameter of the holes on the ends and center
holes = 4; //number of holes in between end and middle holes
holeDiameter = 4; //size of the holes

//fine-tuning (aka can't get the code just right)
holeOffset = 2;

//printing-related
spaceBetweenPrints = 3;
printCount = 1;


//generated variables
holeStart   = legLength/2 + pivotDiamater;

module scissorLiftLeg() {

	difference() {
		hull() {
			translate([(legLength/2),0,0]) cylinder(r=width/2,h=thickness);
			translate([(legLength/-2),0,0]) cylinder(r=width/2,h=thickness);
		}
		for (i=[0:holes-1]) {
			translate([legLength/2 - legLength/2/(holes+1)*i - pivotDiameter - holeDiameter/2,0,0])
				cylinder(r=holeDiameter/2, h=thickness);
			translate([-legLength/2 + legLength/2/(holes+1)*i + pivotDiameter + holeOffset,0,0])
				cylinder(r=holeDiameter/2, h=thickness);
		}
		//End holes and center
		translate([legLength/2,0,0])
			cylinder(r=pivotDiameter/2, h=thickness);	
		translate([-legLength/2,0,0])
			cylinder(r=pivotDiameter/2, h=thickness);
		cylinder(r=pivotDiameter/2, h=thickness);	
	}
}


offsetPerPrint = width+spaceBetweenPrints;
for ( i = [0 : printCount/2] ) { //do -printcount/2:printcount/2 for centered
	translate([0, i*offsetPerPrint, 0])
		scissorLiftLeg();
	if (i*2 < printCount) {
	translate([0, -i*offsetPerPrint, 0])
		scissorLiftLeg();
	}
}
scissorLiftLeg(); //at least print the middle one!
