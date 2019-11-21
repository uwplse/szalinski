// toothbrush holder

// Length of the holder
LENGTH = 140;

HEIGHT = 90;
WIDTH = 30;
// Width of the far end
WIDTH2 = 25;
ROUNDING = 10;

// Number of brushes
NUM_BRUSHES = 5;

BRUSH_R = 9;
BRUSH_OFFSET = 25;
BRUSH_OFFSET2 = BRUSH_R + 5;
BRUSH_DISTANCE = (LENGTH - BRUSH_OFFSET - BRUSH_OFFSET2) / (NUM_BRUSHES-1);

module rounded_box2d(x, y, z, r) {
	translate([r, r, 0])
	minkowski() {
		cylinder(r=r, h=1);
		cube([x-2*r, y-2*r, z-1]);
	}

}

module base() {
intersection() {
difference() {
	rounded_box2d(LENGTH+ROUNDING,HEIGHT,WIDTH,ROUNDING);

	translate([6,6,-1])
	rounded_box2d(LENGTH,HEIGHT-12,WIDTH+2,ROUNDING-6);
}

translate([0,HEIGHT+1,0])
rotate([90,0,0])
hull() {
	translate([0,WIDTH/2,0])
	cylinder(r=WIDTH/2, h=100);

	translate([LENGTH-WIDTH2/2,WIDTH2/2,0])
	cylinder(r=WIDTH2/2, h=100);
}

}
}

difference() {
	base();
	for ( i = [0 : NUM_BRUSHES-1] )
	{
    translate([i*(BRUSH_DISTANCE)+BRUSH_OFFSET, HEIGHT/2, (1-(i*(BRUSH_DISTANCE)+BRUSH_OFFSET)/LENGTH)*WIDTH/2+(i*(BRUSH_DISTANCE)+BRUSH_OFFSET)/LENGTH*WIDTH2/2])
	 rotate([-90,0,0])
    cylinder(r = BRUSH_R, h=HEIGHT);
	}

	for ( i = [0 : NUM_BRUSHES-1] )
	{
    translate([i*(BRUSH_DISTANCE)+BRUSH_OFFSET, BRUSH_R+2, (1-(i*(BRUSH_DISTANCE)+BRUSH_OFFSET)/LENGTH)*WIDTH/2+(i*(BRUSH_DISTANCE)+BRUSH_OFFSET)/LENGTH*WIDTH2/2])
    sphere(r = BRUSH_R);
	}
}