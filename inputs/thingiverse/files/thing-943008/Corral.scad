//Keep your 3D prints corralled within a nice picket fence.
//Input your printer's build size, and have a corral generated for you!

//Written by Brandon Pomeroy at intentional3D

/* [Select Your Printer Bed Size] */

// in mm. This should be slightly smaller than your max build length.
corralLength = 140;

//in mm. This should be sligthly smaller than your max build width
corralWidth = 140;

/* [Hidden] */
fencePostWidth = 10;
fencePostTaperHeight = 12;
fencePostHeight = 50;
fencePostThickness = 2.5;
fencePostSpacing = 5;

lengthNumberOfPosts = floor(corralLength/(fencePostSpacing+fencePostWidth));
widthNumberOfPosts = floor(corralWidth/(fencePostSpacing+fencePostWidth));
halfPostWidth = (fencePostWidth + fencePostSpacing)/2;

//echo(lengthNumberOfPosts);
//echo(widthNumberOfPosts);



module fencePost(x,y,z, thickness, spacing){
	cubeLength = x + spacing;
	union(){
		linear_extrude(height = thickness, center = true, convexity = 10, twist = 0)
			translate([-x/2, 0, 0])
			polygon(points = [[0,0], [x,0], [x,z-y], [x/2,z], [0,z-y]], paths = [[0,1,2,3,4]]);

		translate([-(x+spacing)/2, spacing, -thickness/4])
			cube([cubeLength, 5, thickness/2], center = false);

		translate([-(x+spacing)/2, z-y-(spacing*2), -thickness/4])
			cube([cubeLength, 5, thickness/2], center = false);
		
	}
}

module fenceLine(spacing, postWidth, length){
	numberOfPosts = floor(length/(spacing+postWidth));
	//echo(numberOfPosts);
	//echo(numberOfPosts*(spacing+postWidth));
	for( i = [1 : 1 : numberOfPosts] ) {
		translate([(spacing+postWidth)*(i-1), 0, 0])
		fencePost(fencePostWidth, fencePostTaperHeight, fencePostHeight, fencePostThickness,fencePostSpacing);
	}
}

module cornerPosts() {
	//First find the corner coordinates

	bottomLeft = [-halfPostWidth, 0, fencePostHeight/2];
	bottomRight = [lengthNumberOfPosts * (fencePostWidth+fencePostSpacing) - halfPostWidth, 0 , fencePostHeight/2];
	topLeft = [-halfPostWidth, widthNumberOfPosts * (fencePostWidth+fencePostSpacing), fencePostHeight/2];
	topRight = [lengthNumberOfPosts * (fencePostWidth+fencePostSpacing) - halfPostWidth, widthNumberOfPosts * (fencePostWidth+fencePostSpacing) , fencePostHeight/2];

	translate(bottomLeft)
		cube([fencePostSpacing,fencePostSpacing,fencePostHeight], center = true);
	translate(topLeft)
		cube([fencePostSpacing,fencePostSpacing,fencePostHeight], center = true);
	translate(bottomRight)
		cube([fencePostSpacing,fencePostSpacing,fencePostHeight], center = true);
	translate(topRight)
		cube([fencePostSpacing,fencePostSpacing,fencePostHeight], center = true);

}


module corral(){
	union(){
		translate([0,0,0])
			rotate([90,0,0])
			fenceLine(fencePostSpacing, fencePostWidth, corralLength);
	
		
		translate([0, widthNumberOfPosts * (fencePostWidth+fencePostSpacing),0])
			rotate([90,0,0])
			fenceLine(fencePostSpacing, fencePostWidth, corralLength);
	
		translate([-halfPostWidth, halfPostWidth , 0])
			rotate([90,0,90])
			fenceLine(fencePostSpacing, fencePostWidth, corralWidth);
	
		translate([lengthNumberOfPosts * (fencePostWidth+fencePostSpacing) - halfPostWidth, halfPostWidth , 0])
			rotate([90,0,90])
			fenceLine(fencePostSpacing, fencePostWidth, corralWidth);
	}

	cornerPosts();
	
}



corral();
