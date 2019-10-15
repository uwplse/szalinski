// preview[view:south west, tilt:top diagonal]

/* [Drawer: Base] */
// Inner width of the drawer
drawerWidthInner = 20;
// Inner height of the drawer
drawerHeightInner = 10;
// Inner length of the drawer
drawerLengthInner = 65;

/* [Drawer: Label] */
// Enable cutout for a label?
enabelLabel = "true"; // [true,false]
// The depth of the label should be the multiple of your nozzle size
depthLabel = 0.4;

/* [Drawer: Handle] */
// Height of the handle
handleHeight = 3;
// How  much the handle sticks out of the drawer
handleDepth = 7;
// The length of the handle. This should not be more than the width of the drawer 
handleLength = 18.4;
// Indent Width
handleIndentWidth = 0;
// Indent depth of top of handle
handleIndentTop = 0;
// Indent depth on the side of the handle
handleIndentSide = 0; 

/* [Enclosure] */
// Choose the amount of columns
columns = 4; // [1:100]
// Choose the amount of rows
rows = 3; // [1:100]
// The slot for the drawer will be by this much bigger than the drawer itself. Set this to a value accounting for shrinking/expansion of the material you are using.
enclosureClearance = 0.7;

/* [Printer specific] */
// Nozzle diameter of your printer
nozzleSize = 0.4;
// Walls should be a multiple of your nozzle size
walls = 0.8;

/* [View] */
// Which parts would you like to see?
part = "all"; // [drawer:Drawer Only, enclosure:Enclosure Only, all:Enclosure and Drawer]

/* [Hidden] */
drawerWidthOuter = drawerWidthInner + walls * 2;
drawerHeightOuter = drawerHeightInner + walls;
drawerLengthOuter = drawerLengthInner + walls * 2;

print_part();

module print_part() {
	if(part == "enclosure")
		rotate([270, 0, 0])
			printEnclosure();
	else if(part == "drawer")
		printDrawer();
	else
		printBoth();
}

module printEnclosure() {
	enclosure(rows, columns, drawerLengthOuter, drawerWidthOuter, drawerHeightOuter, enclosureClearance, walls);
}

module printDrawer() {
	drawer(drawerWidthInner, drawerHeightInner, drawerLengthInner, walls, enabelLabel, depthLabel, handleLength, handleDepth, handleHeight, handleIndentTop, handleIndentSide, handleIndentWidth);
}

module printBoth() {
	printDrawer();

	translate([drawerWidthOuter + 10, 0, 0])
		printEnclosure();
}

module enclosure(rows, columns, length, width, height, padding, walls) {
	widthSingle = width + padding;
	heightSingle = height + padding;
	lengthSingle = length + (padding / 2);

	widthOuter = (widthSingle + walls) * columns + walls;
	heightOuter = (heightSingle + walls) * rows + walls;
	lengthOuter = lengthSingle + walls;

	difference() {
		cube([widthOuter, lengthOuter, heightOuter]);
		
		for(row = [0 : rows - 1])
			for(column = [0 : columns - 1])
				translate([walls + (widthSingle + walls) * column, -1, walls + (heightSingle + walls) * row])
					cube([widthSingle, lengthSingle + 1, heightSingle]);
	}
	
}

module drawer(width, height, length, walls, label, depthLabel, lengthHandle, depthHandle, heightHandle, topIndent, sideIndent, widthIndent) {
	widthOuter = width + walls * 2;
	heightOuter = height + walls;
	lengthOuter = length + walls * 2;

	difference() {
		cube([widthOuter, lengthOuter, heightOuter]);

		translate([walls, walls, walls])
			cube([width, length, height + 1]);

		/* Cutout for the label */
		if(label== "true")
			translate([walls * 2, -1, handleHeight + walls * 2])
				cube([width - (walls * 2), 1 + depthLabel, height + 1]);
	}

	/* Attach the handle */
	translate([(widthOuter - lengthHandle) / 2, -depthHandle, 0]) {
		difference() {
			cube([lengthHandle, depthHandle, heightHandle]);

			/* Top indent */
			if(topIndent > 0 && widthIndent > 0)
				translate([-1, depthHandle - widthIndent, heightHandle - topIndent])
					cube([lengthHandle + 2, widthIndent + 1, topIndent + 1]);

			/* Left indent */
			if(sideIndent > 0 && widthIndent > 0)
				translate([-1, depthHandle - widthIndent, -1])
					cube([sideIndent + 1, widthIndent + 1, heightHandle + 2]);

			/* Right indent */
			if(sideIndent > 0 && widthIndent > 0)
				translate([lengthHandle - sideIndent, depthHandle - widthIndent, -1])
					cube([sideIndent + 1, widthIndent + 1, heightHandle + 2]);
		}
	}
}
