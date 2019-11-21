content = "1";

bottomX = 6;
middleX = 15;
topY = 28;
middleY = 18.5;

baseHeight = 4;
totalHeight = 6;
textSize = 14;
textHeight = totalHeight - baseHeight;
fitFactor = 1.01;

cutWidth = 2;
cutDepth = baseHeight/2;

$fn = 360;

item(content);
//view();
//print();

corners = [[-bottomX, 0], [bottomX, 0], [middleX, middleY], [0, topY], [-middleX, middleY]];

module print(){
	item("1");
	translate([2*middleX + cutWidth, 0, 0]) item("2"); 
	translate([2*(2*middleX + cutWidth), 0, 0]) item("3"); 
	translate([3*(2*middleX + cutWidth), 0, 0]) item("4"); 
	translate([4*(2*middleX + cutWidth), 0, 0]) item("5"); 
}

module view() {
	item("1");
	translate([0, 0, 0]) rotate([0, 180, 0]) item("1");
}

module item(content) {
	color("black") base();
	rotate([0, 0, 180]) translate([0, 0, baseHeight]) color("red") label(content);
}

module base() {
	difference() {
		basePoly();
		cutter(fitFactor);
	}
	intersection() {
		translate([-middleX, 0, -cutDepth]) cutter(1);
		translate([0, 0, -baseHeight]) basePoly();
	}
}

module basePoly() {
	linear_extrude(baseHeight) translate([0, -13, 0]) polygon(points = corners);
}

module label(content) {
	linear_extrude(textHeight) text(text = content, size = textSize, font = "Arial", halign = "center", valign = "center");
}

module cutter(factor) {
	cube([middleX*factor, cutWidth*factor, cutDepth*factor]);
}
