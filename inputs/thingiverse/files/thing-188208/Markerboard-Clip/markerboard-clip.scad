// The thickness of your marker board
BOARD_THICKNESS=10; //[1:100]

// The radius of your marker
MARKER_RADIUS=10; //[1:100]

// The thickness of the resulting clip
CLIP_THICKNESS=1.5; //[1:10]

// How wide the clip will be
CLIP_WIDTH=20; // [1:100]

// preview[view:south east, tilt:top]

rotate([90, 0, 0]) {
	difference() {
		cube(size=[BOARD_THICKNESS+CLIP_THICKNESS*2, CLIP_WIDTH, MARKER_RADIUS*2]);
		translate([CLIP_THICKNESS, -1, CLIP_THICKNESS]) cube(size=[BOARD_THICKNESS, CLIP_WIDTH+3, MARKER_RADIUS*3]);
	}
	translate([-BOARD_THICKNESS+CLIP_THICKNESS, 0.001, MARKER_RADIUS]) {
		rotate([270, 0, 0]) difference() {
			cylinder(r=MARKER_RADIUS, h=CLIP_WIDTH-0.001);
			translate([0, 0, -1]) cylinder(r=MARKER_RADIUS-CLIP_THICKNESS, h=CLIP_WIDTH+3);
			translate([0, MARKER_RADIUS/2, -1]) cylinder(r=MARKER_RADIUS-CLIP_THICKNESS, h=CLIP_WIDTH+3);
		}
	}
}
