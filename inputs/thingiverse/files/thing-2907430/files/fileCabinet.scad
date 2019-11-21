// Which one would you like to see?
part = "printable"; // [drawer:Drawer Only,printable:Printable Only,fileCabinet:File Cabinet with Drawers, emptyFileCabinet:Empty File Cabinet,draw:View]

/* [Height] */

height_size = 36; // [1:1000]

/* [Width] */

width_size = 24; // [1:1000]

/* [Depth] */

depth_size = 24; // [1:1000]

/* [Number Of Drawers] */

numOfDrawers_size = 5; // [1:100]

/* [Drawer Handle Size] */

handle_size = 1; // [1:50]
divideby_size = 1; // [1:50]

/* [Hidden] */

print_part(height_size,width_size,depth_size,numOfDrawers_size);

//Quality
$fn=50;

//Print Part
module print_part(height,width,depth,numOfDrawers) {
	if (part == "drawer") {
		drawer(height,width,depth);
	} else if (part == "printable") {
		printable(height,width,depth,numOfDrawers);
	} else if (part == "fileCabinet") {
		fileCabinet(height,width,depth,numOfDrawers);
	} else if (part == "emptyFileCabinet") {
		emptyFileCabinet(height,width,depth);
	} else if (part == "draw") {
        draw(height,width,depth,numOfDrawers);
    } else {
        draw(height,width,depth,numOfDrawers);
    }
}


module top(width, depth) {
    hull() {
        translate([0,0,0]) sphere(1);
        translate([0,width,depth]) sphere(1);
        translate([0,width,0]) sphere(1);
        translate([0,0,depth]) sphere(1);
    }
}

//Empty File Cabinet
module emptyFileCabinet(height,width,depth) {
    translate([-1,0,0]) top(width,depth);
    difference() {
        cube([height,width,depth]);
        translate([1,2,0]) cube([height-2,width-4,depth-2]);
    }
}

//File Cabinet
module fileCabinet(height,width,depth,numDrawers) {
    emptyFileCabinet(height,width,depth);
    drawers(height-2,width-2,depth-2,numDrawers);
}

//Drawers
module drawers(height,width,depth,numDrawers) {
   sizeH = height/numDrawers;
    for (i =[0:1:numDrawers-1]) {
        translate([i*sizeH+1,1, 0]) drawer(sizeH-.05,width,depth);
    }
}

//Drawer
module drawer(height,width,depth) {
    difference() {
        cube([height,width,depth]);
        translate([0,1,1]) cube([height-1.5,width-2,depth-2]);
    }
    translate([height/2,width/2,0]) drawerHandle(handle_size,divideby_size);
    echo("This is a Drawer with h=", height, " and w=", width, " and d=", depth, ".");
}

// Drawer Handle
module drawerHandle(handle,divideby) {
    sphere(handle/divideby);  
}

//Draw
module draw(height,width,depth,drawCount) {
    fileCabinet(height,width,depth,drawCount);
    translate([0,-width-5,0]) emptyFileCabinet(height,width,depth);
    translate([0,-width*2-5,0]) drawer((height-2)/drawCount,width-2,depth-2);
}

//Printable Draw
module printable(height,width,depth,drawCount) {
    translate([0,-width-5,0]) emptyFileCabinet(height,width,depth);
    for (i = [0:1:drawCount-1]) {
        translate([i*(drawCount+(height/drawCount)),-width*3,0]) drawer((height-2)/drawCount,width-2,depth-2);
    }
}