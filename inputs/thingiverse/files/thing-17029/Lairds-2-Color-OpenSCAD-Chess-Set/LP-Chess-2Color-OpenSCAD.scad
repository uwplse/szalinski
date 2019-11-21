include <bitmap.scad> // for labeling the pieces

size = 1; // pieces are 1 inch across (base)
offset = 1.5; // pieces are placed every 2 inches
$fs=0.05;


c=1; // 1 = black, 2=white, 0=all

// draw the 'label' character on the back of the body of the piece, indented 0.05 inches

module label(l) {
	translate ([size/2,0,size/2]) rotate ([90,90,0]) scale([1,1,2]) translate([0,0,-0.05]) 8bit_char(l,0.1, 0.1);
   }

// draw king

module king_trim(size, height) {
	small=size/3;
	left=0;
	right=size-small; 
	lrm=(left+right)/2; 
	back=0; 
	front=size-small; 
	bfm=(back+front)/2;

	union() {
	   label("K");
		
		difference() { // crown
			translate([left,back,height]) cube(size=[size,size,small]); // top
			translate([lrm, bfm, height]) cube(small); // minus cube in the middle
			}
	   }
	}

module king_body(size, height) {
  	difference() {
      cube(size=[size, size, height]); 	// body
      king_trim(size, height); 				// minus indentations of trim
      }
   }

module king(size, x, y) {
	height=3*size;

   if (c==0) {
   		union() {
			translate([x*offset, y*offset, 0]) {
    			king_body(size, height);
	   			king_trim(size, height);
				}
 			}
		}
	if (c==1) {
			translate([x*offset, y*offset, 0])
		   		king_trim(size, height);
		}
	if (c==2) {
    		translate([x*offset, y*offset, 0])
		   		king_body(size, height);
		}
   }

// draw bishop

module bishop_body(size) {
	difference() {
		cube(size=[size,size,2*size]); // body
		bishop_trim(size); // minus trim
		}
	}

module bishop_trim(size) {
 	dsize=size*1.5;
	mid=size/2;
	top=size*2;
	tip = size*3;

	label("B");

 	translate([mid, mid, tip]) sphere(r=size/6); // sphere on top

   	translate([mid, mid, top]) { // diagonal diamonds
   		rotate([90,45,45]) cube([dsize,dsize,size/10], center=true);
   		rotate([90,45,-45]) cube([dsize,dsize,size/10], center=true);
   		} // translate
   } // bishop

module bishop(size, x, y) {
   if (c==0) {
   		union() {
			translate([x*offset, y*offset, 0]) {
    			bishop_body(size);
	   			bishop_trim(size);
				}
 			}
		}
	if (c==1) {
			translate([x*offset, y*offset, 0])
		   		bishop_trim(size);
		}
	if (c==2) {
    		translate([x*offset, y*offset, 0])
		   		bishop_body(size);
		}
   }

// draw a knight

module k_crown(small) {
   sphere(r=small/2);
   translate([-2*small, 0, -small]) cube(small, center=true);
   translate([-small, 0, -2*small]) cube(small, center=true);
   translate([2*small, 0, small]) cube(small, center=true);
   translate([small, 0, 2*small]) cube(small, center=true);
   translate([-2*small, 0, small]) cube(small, center=true);
   translate([-small, 0, 2*small]) cube(small, center=true);
   translate([2*small, 0, -small]) cube(small, center=true);
   translate([small, 0, -2*small]) cube(small, center=true);
   }

module knight_body(size, height, small) {
   ho = small/2; // head overhands body by this much
   hleft = 0-ho;
   hright = size + ho;
   hback = 0-ho;
   hfront = size + ho;
   htop = height + ho;
   hbbottom = height-size-ho;
   hfbottom = htop - small;

	difference() {
	   union() { // body and head are the same color
			cube([size, size, height]);
      		polyhedron(
        		points = [[hleft,hback,hbbottom],[hright,hback,hbbottom],[hleft,hback,htop],[hright,hback,htop],	[hleft,hfront,hfbottom],[hright,hfront,hfbottom],[hleft,hfront,htop],[hright,hfront,htop]], 
        		triangles=[[0,2,1],[1,2,3], [0, 4, 2], [2, 4, 6], [1, 3, 5], [3, 7, 5], [4, 5, 6], [6, 5, 7], [2, 6, 3], [3, 6, 7], [0, 1, 5], [0, 5, 4]] );
			}
		knight_trim(size, height, small); // subtract the insets for the trim
		}
	}

module knight_trim(size, height, small) {
	label("k");

	// crowns of cubes at top and back of head
   	translate ([size/2, -small/2, height-size/2]) k_crown(small);
   	translate([size/2, size/2, height+small/2]) rotate([90,0,0]) k_crown(small); 
	}

module knight (size, x, y) {
	small=size/3;
   height=2.5*size;

   if (c==0) {
   		union() {
			translate([x*offset, y*offset, 0]) {
    			knight_body(size, height, small);
	   			knight_trim(size, height, small);
				}
 			}
		}
	if (c==1) {
			translate([x*offset, y*offset, 0])
		   		knight_trim(size, height, small);
		}
	if (c==2) {
    		translate([x*offset, y*offset, 0])
		   		knight_body(size, height, small);
		}
	}



// draw one pawn

module pawn_body(size) {
	difference() {
		cube(size-0.001);		// body of pawn, trimmed very slightly to avoid overlapping sides
		pawn_trim(size);
		}
	}

module pawn_trim(size) {
	small=size/3; // size of small cubes relative to body

   label("P");

	translate([0,2*small,size*5/6]) cube(small);
	translate([small,2*small,size]) cube(small);
	translate([small,size,size*5/6]) cube(small);
	translate([2*small,2*small,size*5/6]) cube(small);
	translate([size/2, size/2, size]) sphere(small/2, center=true);
	}

module pawn (size, x, y) {

   if (c==0) {
   		union() {
			translate([x*offset, y*offset, 0]) {
    			pawn_body(size);
	   			pawn_trim(size);
				}
 			}
		}
	if (c==1) {
			translate([x*offset, y*offset, 0])
		   		pawn_trim(size);
		}
	if (c==2) {
    		translate([x*offset, y*offset, 0])
		   		pawn_body(size);
		}
	}

// draw room

module rook_body(size) {
	difference() {
		cube([size, size, 2.5*size]);
		rook_trim(size);
		}
	}

module rook_trim(size) {
   dsize=size*1.25;

   label("R");
   translate([size/2,size/2,size*2]) {
		rotate([90,0,0]) {
	   		cube([dsize,dsize,size/10], center=true);
	      }
	   rotate([90,0,90]) {
	      cube([dsize,dsize,size/10], center=true);
	      }
	   }
	}

module rook (size, x, y) {
   if (c==0) {
   		union() {
			translate([x*offset, y*offset, 0]) {
    			rook_body(size);
	   			rook_trim(size);
				}
 			}
		}
	if (c==1) {
			translate([x*offset, y*offset, 0])
		   		rook_trim(size);
		}
	if (c==2) {
    		translate([x*offset, y*offset, 0])
		   		rook_body(size);
		}
	}

// draw queen

module q_top (size, dsize) {
   //cylinder(h=size/10, r=dsize);
   cube([dsize,dsize,size/10], center=true);
   }

module queen_body(size) {
	difference() {
		cube([size, size, 3*size]);
		queen_trim(size);	// subtract trim intersection
		}
	}

module queen_trim(size) {
   dsize = size*1.5;
   height = 3*size;
   topcenter = height;

	label("Q");
	// ball on top
	translate([size/2, size/2, 4*size]) {
		sphere(r=size/6);
	   	}
	translate([size/2,size/2,topcenter]) { // translate up
	
		// four diamonds rotated (every 45 degrees) to form crown
	
		rotate([90,45,90]) q_top(size, dsize);
	   rotate([90,45,0]) q_top(size, dsize);
	   rotate([90,45,45]) q_top(size, dsize);
	   rotate([90,45,-45]) q_top(size, dsize);
		} // translate
	}

module queen(size, x, y) {
   if (c==0) {
   		union() {
			translate([x*offset, y*offset, 0]) {
    			queen_body(size);
	   			queen_trim(size);
				}
 			}
		}
	if (c==1) {
			translate([x*offset, y*offset, 0])
		   		queen_trim(size);
		}
	if (c==2) {
    		translate([x*offset, y*offset, 0])
		   		queen_body(size);
		}
	}

module drawset () {
	// draw 8 pawns, up one row
	
	for ( count = [0:7]) {
	   pawn(size, count, 1);
	}
	
	// draw home row pieces
	
	rook(size, 0, 0);
	bishop(size, 1, 0);
	knight(size, 2, 0);
	king(size, 3, 0);
	queen(size, 4, 0);
	knight(size,5, 0);
	bishop(size, 6, 0);
	rook(size, 7, 0);
	}

// for color parts, put cubes at the corners so that 2 color printing works

bl = -0.25;
br = 11.5;
bf = -0.25;
bb = 2.75;

if (c > 0) {
	translate ([bl,bf, 0]) cube(0.1);
	translate ([br,bf, 0]) cube(0.1);
	translate ([bl,bb, 0]) cube(0.1);
	translate ([br,bb, 0]) cube(0.1);
	}

// uncomment one at a time to print each piece

//pawn(size,0,0);
//rook(size, 0, 0);
//bishop(size, 0, 0);
//knight(size, 0, 0);
//king(size, 0, 0);
//queen(size, 0, 0);

drawset();
