use <utils/build_plate.scad>

// type of tetris piece
_1_piece = "T"; //[I,Z,L,T,O]

// size of a tetris block (parts will be larger)
_2_size = 60;

// depth of the tetris piece
_3_depth = 60;

// thickness of the walls
_4_thickness = 2;

module createPart(type, size, depth, thickness) {
	eps = 0.1;

	translate([0,0,depth/2]) {
		if (type == "I") {
			difference() {
				cube(size=[size*4, size, depth], center=true);
				cube(size=[size*4-thickness*2, size-thickness*2, depth+eps], center=true);
			}
		} else if (type == "O") {
			difference() {
				cube(size=[size*2, size*2, depth], center=true);
				cube(size=[size*2-thickness*2, size*2-thickness*2, depth+eps], center=true);
			}
		} else if (type == "T" || type == "L") {
			translate([0, -size/2,0])
			difference() {
				union() {
					cube(size=[size*3, size, depth], center=true);
					translate([type == "L" ? size : 0, size/2,0]) {
						cube(size=[size, size*2, depth], center=true);
					}
				}
				cube(size=[size*3-thickness*2, size-thickness*2, depth+eps], center=true);
				translate([type == "L" ? size : 0, size/2,0]) {
					cube(size=[size-thickness*2, size*2-thickness*2, depth+eps], center=true);
				}
			}
		} else if (type == "Z") {
			difference() {
				union() {
					cube(size=[size, size*2, depth], center=true);
					translate([size/2, size/2,0]) {
						cube(size=[size*2, size, depth], center=true);
					}
					translate([-size/2, -size/2,0]) {
						cube(size=[size*2, size, depth], center=true);
					}
				}
				cube(size=[size - thickness*2, size*2 - thickness*2, depth+eps], center=true);
				translate([size/2, size/2,0]) {
					cube(size=[size*2 - thickness*2, size - thickness*2, depth+eps], center=true);
				}
				translate([-size/2, -size/2,0]) {
					cube(size=[size*2 - thickness*2, size - thickness*2, depth+eps], center=true);
				}
			}
		}
	}
}

build_plate(0);
createPart(_1_piece, _2_size, _3_depth, _4_thickness);
