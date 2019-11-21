// preview[view:south west, tilt:top diagonal]

/* [Base] */
// Width of the grinding surface
width = 60;
// Length of the grinding surface
length = 60;
// Height of the grinding surface
height = 3;

/* [Bracket] */
// The height of the bracket
bracketHeight = 5;
// Wall thickness of the bracket
bracketWall = 5;
// The padding between base and bracket has to fit the sandpaper and account for shrinking
padding = 1;

/* [Handle] */
// Height of the handle
handleHeight = 15;
// Width of the handle
handleWidth = 5;

/* [View] */
// Which parts would you like to see?
part = "all"; // [all:Base and Bracket, base:Base Only, bracket:Bracket Only]

/* [Hidden] */
backen = 5;
bracketWidth = width;
bracketLength = length - backen * 2 - padding * 2;

print_part();

module print_part() {
	if(part == "base")
		printBase();
	else if(part == "bracket")
		printBracket();
	else
		printBoth();
}

module printBoth() {
	basePlate();

	translate([0, padding + backen, height + padding])
		bracket();
}

module printBase() {
	basePlate();
}

module printBracket() {
	bracket();
}

module basePlate() {
	handleLength = width - backen * 2;

	difference() {
		cube([width, length, height + bracketHeight]);
		
		translate([-1, backen, height])
			cube([width + 2, length - backen * 2, bracketHeight + 1]);
	}
	
	/* Handle */
	translate([backen, (length / 2) - (handleWidth / 2), height])
		cube([handleLength, handleWidth, handleHeight]);
}

module bracket() {
	innerWidth = bracketWidth - bracketWall * 2;
	innerLength = bracketLength - bracketWall * 2;
	bracketHeight = bracketHeight - padding;

	difference() {
		cube([bracketWidth, bracketLength, bracketHeight]);

		translate([bracketWall, bracketWall, -1])
			cube([innerWidth, innerLength, bracketHeight + 2]);
	}
}
