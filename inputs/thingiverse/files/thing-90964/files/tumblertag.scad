/* Tumbler Tag by xifle */

// preview[view:north, tilt:top]
/* [Parameters] */

// The maximum glass thickness this tag will work with in mm
GLASS_MAX = 2.5;

// The minimum glass thickness this tag will work with in mm
GLASS_MIN = 0.5;

// The height of the tag in mm
HEIGHT = 15; //[5:30]

// The width of the tag in mm
WIDTH = 10; //[5:30]

// Wall thickness in mm
WALL = 1;

/* [Hidden] */

RADIUS = (WALL-0.1)/2;

linear_extrude(height=WIDTH) {
union() {
	halfed_outline(GLASS_MAX, GLASS_MIN, HEIGHT*0.7, RADIUS, WALL);
	mirror([1,0,0]) {
		halfed_outline(GLASS_MAX, GLASS_MIN, HEIGHT, RADIUS, WALL);
	}
}
}

module halfed_outline(max, min, height, radius, wall) {

	polygon(points=[[0,0],[max/2+radius,0],[min/2,height],[min/2+wall,height], [max/2+radius+wall,-wall], [0,-wall]], paths=[[0,1,2,3,4,5]]);

}
