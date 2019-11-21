// zonk resolution test

// height
height1 = 1;

// line width
width1 = .5;

// radius
radius1 = 40;

// offset
xoffset1 = 5;

// number of lines
lines1 = 60;

step = 180 / lines1;

module do_line(angle) {
	rotate(angle)
		square([width1, radius1 * 2], true);
}

linear_extrude(height= height1) {
	for (angle = [step : step : 180]) {
		do_line(angle);
		translate([xoffset1, 0])
			do_line(angle);
	}
}
