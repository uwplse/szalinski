// Tumbler Tag by xifle
// Modified by teejaydub to add an embossed image.

// preview[view:west, tilt:top diagonal]
/* [Global] */

// The maximum glass thickness this tag will work with [mm]
GLASS_MAX = 3.5;

// The minimum glass thickness this tag will work with [mm]
GLASS_MIN = 1;

// The height of the tag [mm]
HEIGHT = 15; //[5:30]

// The width of the tag [mm]
WIDTH = 10; //[5:30]

// Wall thickness [mm]
WALL = 1.1;

// Load a 30x30 pixel image to be embossed onto your tag.  
// Simple shapes with blurry edges work best. 
// Try the Invert Colors checkbox!
image_file = "symbol.dat"; // [image_surface:30x30]

/* [Hidden] */

RADIUS = (WALL-0.1)/2;

ANGLE = atan2(GLASS_MAX/2, HEIGHT);

SYMBOL_WIDTH = WIDTH * 0.8;

difference() {
	linear_extrude(height=WIDTH) {
		union() {
			halfed_outline(GLASS_MAX, GLASS_MIN, HEIGHT*0.7, RADIUS, WALL);
			mirror([1,0,0]) {
				halfed_outline(GLASS_MAX, GLASS_MIN, HEIGHT, RADIUS, WALL);
			}
		}
	}
	translate([-GLASS_MAX/2-WALL, HEIGHT/2, WIDTH/2])
		rotate([90-ANGLE, -90, 90])
//			resize([SYMBOL_WIDTH, SYMBOL_WIDTH, 0])  // not supported by Customizer
//				scale([1, 1, WALL]) 
			scale([SYMBOL_WIDTH/30, SYMBOL_WIDTH/30, WALL]) 
				surface(file=image_file, center=true, convexity=5); 
}

module halfed_outline(max, min, height, radius, wall) {
	polygon(points=[[0,0],[max/2+radius,0],[min/2,height],[min/2+wall,height], 
		[max/2+radius+wall,-wall], [0,-wall]], paths=[[0,1,2,3,4,5]]);
}
