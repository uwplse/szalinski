// Radius of Circle
circleRadius = 8; // [1:0.25:15]

// Width of Post
postWidth = 10; // [0.5:0.5:10]

// Height of Post Before Circle
postHeightBeforeCircle = 16; // [0:0.5:20]

// Width of Base
baseWidth = 10; // [1:0.25:10]

// Width of Gap Between Posts
gap = 10; // [1:0.5:15]

// Number of Posts
numPosts = 9; // [1:1:20]

// Depth of Holder
depth = 40; // [1:1:50]

// Calculated Variables
postHeight = postHeightBeforeCircle + circleRadius;
totalLength = (numPosts * postWidth) + (gap * (numPosts - 1));

// Model Generation
module example() {
	cube ([depth,totalLength,baseWidth]);
	
	for (i = [0 : postWidth + gap : totalLength]){
		translate([0, i, baseWidth]){
			cube([depth, postWidth, postHeight]);
		}
		translate([0, (i+postWidth/2), postHeight+baseWidth]){
			rotate([0, 90, 0]){
				cylinder(h=depth, r=circleRadius);
			}
		}
	}
			
}

example();