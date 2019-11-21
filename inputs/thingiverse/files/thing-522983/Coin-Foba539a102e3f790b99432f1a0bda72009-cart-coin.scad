/*    Module for the coin  */

/*  [Coin]  */
// engraved text
text = "Sven";
// length of the handle
handle_length = 20;  // [20:40]
//position of the text
text_pos_offset = 5; // [0:40]
// Size of the hole
hole_size = 2; // [2:10]
// preview[view:east, tilt:top]

/* [Hidden] */
d = 24;
h = 2.3;
handle_width = 15;
betweenCharOffset = 7;
defaultTextPosOffsetHorizontally  = -5;
textPosOffsetLengthVertically = 3;
textDepth = 1;
dHole = hole_size;
holeOffset = 3;
smooth = 360;

module coin()
{
	r = d/2;
        rHole = dHole/2;
        difference(){
            
            // coin + handle
            union(){
                    cylinder(h,r,r,true,$fn=smooth);
                    translate([0,(handle_length+r)/2,0]){
                            cube([handle_width, handle_length+r,h],true);     
                    }
            }
            
            // hole
            translate([0,handle_length + r - dHole/2 - holeOffset,0]){
                cylinder(h+10,rHole,rHole,true,$fn=smooth);  //make sure hole is deeper than coin
                
            }       
        
            // text display
            for(i = [0:len(text)-1]){
                    translate([textPosOffsetLengthVertically,defaultTextPosOffsetHorizontally+text_pos_offset+i*betweenCharOffset,h/2+1-textDepth]){ 
                        scale([0.2,0.2,0.2]){
                            rotate([0,0,90]){
                            FreeSerif(text[i]);
                        }
                    }
                }
            }
        }
}

coin();



















/*   Here FreeSerif.scad starts from ... */
module FreeSerif_contour00x21_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[12, 11], [11.5, 11.0], [11, 11], 

		[11.0, 14.5], [11, 18], [10, 20], 

		[9.0, 28.0], [8, 36], [8, 38], 

		[8, 41], [9.0, 42.0], [10, 43], 

		[12, 43], [15, 43], [15, 38], 

		[15, 37], [15, 36], [13.5, 23.5], 

		 ]);

}

module FreeSerif_contour00x21_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([15, 38], [15, 37], [15, 36],steps,10);

}

}

module FreeSerif_contour00x21_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([11, 18], [10, 20], [9.0, 28.0],steps,10);

	BezConic([9.0, 28.0], [8, 36], [8, 38],steps,10);

	BezConic([8, 38], [8, 41], [9.0, 42.0],steps,10);

	BezConic([9.0, 42.0], [10, 43], [12, 43],steps,10);

	BezConic([12, 43], [15, 43], [15, 38],steps,10);

}

}

module FreeSerif_contour00x21(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x21_skeleton();
			FreeSerif_contour00x21_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x21_subtractive_curves(steps);
	}
}

module FreeSerif_contour10x21_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[9.0, 5.0], [10, 6], [11.5, 6.0], 

		[13, 6], [14.0, 5.0], [15, 4], 

		[15.0, 2.5], [15, 1], [14.0, 0.0], 

		[13, -1], [12, -1], [10, -1], 

		[9.0, 0.0], [8, 1], [8.0, 2.5], 

		[8, 4], ]);

}

module FreeSerif_contour10x21_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour10x21_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([9.0, 5.0], [10, 6], [11.5, 6.0],steps,10);

	BezConic([11.5, 6.0], [13, 6], [14.0, 5.0],steps,10);

	BezConic([14.0, 5.0], [15, 4], [15.0, 2.5],steps,10);

	BezConic([15.0, 2.5], [15, 1], [14.0, 0.0],steps,10);

	BezConic([14.0, 0.0], [13, -1], [12, -1],steps,10);

	BezConic([12, -1], [10, -1], [9.0, 0.0],steps,10);

	BezConic([9.0, 0.0], [8, 1], [8.0, 2.5],steps,10);

	BezConic([8.0, 2.5], [8, 4], [9.0, 5.0],steps,10);

}

}

module FreeSerif_contour10x21(steps=2) {
	difference() {
		union() {
			FreeSerif_contour10x21_skeleton();
			FreeSerif_contour10x21_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour10x21_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x21(steps=2) {
	difference() {
		FreeSerif_contour00x21(steps);
		
	}
}

module FreeSerif_chunk20x21(steps=2) {
	difference() {
		FreeSerif_contour10x21(steps);
		
	}
}

FreeSerif_bbox0x21=[[8, -1], [15, 43]];

module FreeSerif_letter0x21(detail=2) {

	FreeSerif_chunk10x21(steps=detail);

	FreeSerif_chunk20x21(steps=detail);

} //end skeleton



module FreeSerif_contour00x22_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[19, 28], [18.5, 28.0], [18, 28], 

		[16, 38], [16, 41], [16, 42], 

		[16.5, 42.5], [17, 43], [18, 43], 

		[20, 43], [20.5, 42.5], [21, 42], 

		[21, 41], [21, 38], [20, 30], 

		[19.5, 29.0], ]);

}

module FreeSerif_contour00x22_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x22_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([18, 28], [16, 38], [16, 41],steps,10);

	BezConic([16, 41], [16, 42], [16.5, 42.5],steps,10);

	BezConic([16.5, 42.5], [17, 43], [18, 43],steps,10);

	BezConic([18, 43], [20, 43], [20.5, 42.5],steps,10);

	BezConic([20.5, 42.5], [21, 42], [21, 41],steps,10);

	BezConic([21, 41], [21, 38], [20, 30],steps,10);

}

}

module FreeSerif_contour00x22(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x22_skeleton();
			FreeSerif_contour00x22_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x22_subtractive_curves(steps);
	}
}

module FreeSerif_contour10x22_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[8, 28], [7.5, 28.0], [7, 28], 

		[5, 38], [5, 41], [5, 42], 

		[6.0, 42.5], [7, 43], [8, 43], 

		[9, 43], [9.5, 42.5], [10, 42], 

		[10, 41], [10, 38], [9, 30], 

		[8.5, 29.0], ]);

}

module FreeSerif_contour10x22_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour10x22_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([7, 28], [5, 38], [5, 41],steps,10);

	BezConic([5, 41], [5, 42], [6.0, 42.5],steps,10);

	BezConic([6.0, 42.5], [7, 43], [8, 43],steps,10);

	BezConic([8, 43], [9, 43], [9.5, 42.5],steps,10);

	BezConic([9.5, 42.5], [10, 42], [10, 41],steps,10);

	BezConic([10, 41], [10, 38], [9, 30],steps,10);

}

}

module FreeSerif_contour10x22(steps=2) {
	difference() {
		union() {
			FreeSerif_contour10x22_skeleton();
			FreeSerif_contour10x22_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour10x22_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x22(steps=2) {
	difference() {
		FreeSerif_contour00x22(steps);
		
	}
}

module FreeSerif_chunk20x22(steps=2) {
	difference() {
		FreeSerif_contour10x22(steps);
		
	}
}

FreeSerif_bbox0x22=[[5, 28], [21, 43]];

module FreeSerif_letter0x22(detail=2) {

	FreeSerif_chunk10x22(steps=detail);

	FreeSerif_chunk20x22(steps=detail);

} //end skeleton



module FreeSerif_contour00x23_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[30, 17], [30.0, 15.5], [30, 14], 

		[26.5, 14.0], [23, 14], [22.0, 7.0], 

		[21, 0], [19.0, 0.0], [17, 0], 

		[18.0, 7.0], [19, 14], [15.0, 14.0], 

		[11, 14], [10.0, 7.0], [9, 0], 

		[7.0, 0.0], [5, 0], [6.0, 7.0], 

		[7, 14], [3.5, 14.0], [0, 14], 

		[0.0, 15.5], [0, 17], [4.0, 17.0], 

		[8, 17], [8.5, 21.5], [9, 26], 

		[5.5, 26.0], [2, 26], [2.0, 27.5], 

		[2, 29], [6.0, 29.0], [10, 29], 

		[11.0, 35.5], [12, 42], [13.5, 42.0], 

		[15, 42], [14.0, 35.5], [13, 29], 

		[17.5, 29.0], [22, 29], [23.0, 35.5], 

		[24, 42], [25.5, 42.0], [27, 42], 

		[26.5, 35.5], [26, 29], [29.0, 29.0], 

		[32, 29], [32.0, 27.5], [32, 26], 

		[28.5, 26.0], [25, 26], [24.5, 21.5], 

		[24, 17],[27.0, 17.0], ]);

}

module FreeSerif_contour00x23_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x23_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x23(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x23_skeleton();
			FreeSerif_contour00x23_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x23_subtractive_curves(steps);
	}
}

module FreeSerif_contour10x23_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[21, 26], [17.0, 26.0], [13, 26], 

		[12.0, 21.5], [11, 17], [15.5, 17.0], 

		[20, 17],[20.5, 21.5], ]);

}

module FreeSerif_contour10x23_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour10x23_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour10x23(steps=2) {
	difference() {
		union() {
			FreeSerif_contour10x23_skeleton();
			FreeSerif_contour10x23_subtractive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour10x23_additive_curves(steps);
	}
}

module FreeSerif_chunk10x23(steps=2) {
	difference() {
		FreeSerif_contour00x23(steps);
		scale([1,1,1.1]) FreeSerif_contour10x23(steps);
	}
}

FreeSerif_bbox0x23=[[0, 0], [32, 42]];

module FreeSerif_letter0x23(detail=2) {

	FreeSerif_chunk10x23(steps=detail);

} //end skeleton



module FreeSerif_contour00x24_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[3, 33], [3, 37], [6.0, 39.5], 

		[9, 42], [15, 42], [15.0, 44.5], 

		[15, 47], [16.0, 47.0], [17, 47], 

		[17.0, 44.5], [17, 42], [24, 42], 

		[27, 39], [27.0, 35.5], [27, 32], 

		[26.5, 32.0], [26, 32], [25, 36], 

		[23.0, 38.0], [21, 40], [17, 41], 

		[17.0, 33.0], [17, 25], [18, 25], 

		[19.5, 24.0], [21, 23], [21.5, 22.5], 

		[22, 22], [23.5, 21.0], [25, 20], 

		[25.5, 19.5], [26, 19], [27.0, 18.0], 

		[28, 17], [28.5, 16.0], [29, 15], 

		[29.0, 13.5], [29, 12], [29, 11], 

		[29, 6], [26.0, 3.5], [23, 1], 

		[17, 0], [17.0, -3.0], [17, -6], 

		[16.0, -6.0], [15, -6], [15.0, -3.0], 

		[15, 0], [11, 0], [8.5, 0.5], 

		[6, 1], [3, 3], [3.0, 7.5], 

		[3, 12], [3.5, 12.0], [4, 12], 

		[5, 7], [7.5, 4.5], [10, 2], 

		[15, 2], [15.0, 11.0], [15, 20], 

		[8, 23], [5.5, 26.0], [3, 29], 

		 ]);

}

module FreeSerif_contour00x24_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([26, 32], [25, 36], [23.0, 38.0],steps,10);

	BezConic([23.0, 38.0], [21, 40], [17, 41],steps,10);

	BezConic([21.5, 22.5], [22, 22], [23.5, 21.0],steps,10);

	BezConic([25.5, 19.5], [26, 19], [27.0, 18.0],steps,10);

	BezConic([29.0, 13.5], [29, 12], [29, 11],steps,10);

	BezConic([4, 12], [5, 7], [7.5, 4.5],steps,10);

	BezConic([7.5, 4.5], [10, 2], [15, 2],steps,10);

}

}

module FreeSerif_contour00x24_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([3, 33], [3, 37], [6.0, 39.5],steps,10);

	BezConic([6.0, 39.5], [9, 42], [15, 42],steps,10);

	BezConic([17, 42], [24, 42], [27, 39],steps,10);

	BezConic([17, 25], [18, 25], [19.5, 24.0],steps,10);

	BezConic([19.5, 24.0], [21, 23], [21.5, 22.5],steps,10);

	BezConic([23.5, 21.0], [25, 20], [25.5, 19.5],steps,10);

	BezConic([27.0, 18.0], [28, 17], [28.5, 16.0],steps,10);

	BezConic([28.5, 16.0], [29, 15], [29.0, 13.5],steps,10);

	BezConic([29, 11], [29, 6], [26.0, 3.5],steps,10);

	BezConic([26.0, 3.5], [23, 1], [17, 0],steps,10);

	BezConic([15, 0], [11, 0], [8.5, 0.5],steps,10);

	BezConic([8.5, 0.5], [6, 1], [3, 3],steps,10);

	BezConic([15, 20], [8, 23], [5.5, 26.0],steps,10);

	BezConic([5.5, 26.0], [3, 29], [3, 33],steps,10);

}

}

module FreeSerif_contour00x24(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x24_skeleton();
			FreeSerif_contour00x24_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x24_subtractive_curves(steps);
	}
}

module FreeSerif_contour10x24_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[15, 26], [15.0, 33.5], [15, 41], 

		[8, 39], [8, 34], [8, 32], 

		[9.5, 30.5],[11, 29], ]);

}

module FreeSerif_contour10x24_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([15, 41], [8, 39], [8, 34],steps,10);

	BezConic([8, 34], [8, 32], [9.5, 30.5],steps,10);

	BezConic([9.5, 30.5], [11, 29], [15, 26],steps,10);

}

}

module FreeSerif_contour10x24_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour10x24(steps=2) {
	difference() {
		union() {
			FreeSerif_contour10x24_skeleton();
			FreeSerif_contour10x24_subtractive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour10x24_additive_curves(steps);
	}
}

module FreeSerif_contour20x24_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[17, 19], [17.0, 10.5], [17, 2], 

		[24, 3], [24, 9], [24, 12], 

		[22.5, 14.0],[21, 16], ]);

}

module FreeSerif_contour20x24_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([17, 2], [24, 3], [24, 9],steps,10);

	BezConic([24, 9], [24, 12], [22.5, 14.0],steps,10);

	BezConic([22.5, 14.0], [21, 16], [17, 19],steps,10);

}

}

module FreeSerif_contour20x24_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour20x24(steps=2) {
	difference() {
		union() {
			FreeSerif_contour20x24_skeleton();
			FreeSerif_contour20x24_subtractive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour20x24_additive_curves(steps);
	}
}

module FreeSerif_chunk10x24(steps=2) {
	difference() {
		FreeSerif_contour00x24(steps);
		scale([1,1,1.1]) FreeSerif_contour10x24(steps);
	scale([1,1,1.1]) FreeSerif_contour20x24(steps);
	}
}

FreeSerif_bbox0x24=[[3, -6], [29, 47]];

module FreeSerif_letter0x24(detail=2) {

	FreeSerif_chunk10x24(steps=detail);

} //end skeleton



module FreeSerif_contour00x25_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[43, 24], [46, 24], [47.5, 22.0], 

		[49, 20], [49, 17], [49, 13], 

		[47.5, 9.5], [46, 6], [44, 3], 

		[41, 0], [36, 0], [33, 0], 

		[31.0, 2.5], [29, 5], [29, 8], 

		[29, 14], [33.0, 19.0], [37, 24], 

		 ]);

}

module FreeSerif_contour00x25_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x25_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([43, 24], [46, 24], [47.5, 22.0],steps,10);

	BezConic([47.5, 22.0], [49, 20], [49, 17],steps,10);

	BezConic([49, 17], [49, 13], [47.5, 9.5],steps,10);

	BezConic([47.5, 9.5], [46, 6], [44, 3],steps,10);

	BezConic([44, 3], [41, 0], [36, 0],steps,10);

	BezConic([36, 0], [33, 0], [31.0, 2.5],steps,10);

	BezConic([31.0, 2.5], [29, 5], [29, 8],steps,10);

	BezConic([29, 8], [29, 14], [33.0, 19.0],steps,10);

	BezConic([33.0, 19.0], [37, 24], [43, 24],steps,10);

}

}

module FreeSerif_contour00x25(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x25_skeleton();
			FreeSerif_contour00x25_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x25_subtractive_curves(steps);
	}
}

module FreeSerif_contour10x25_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[38, 2], [40, 2], [42.5, 4.5], 

		[45, 7], [46.5, 10.5], [48, 14], 

		[48, 17], [48, 19], [46.5, 20.5], 

		[45, 22], [43, 22], [40, 22], 

		[38.0, 18.5], [36, 15], [35.0, 11.5], 

		[34, 8], [34, 6], [34, 4], 

		[35.0, 3.0],[36, 2], ]);

}

module FreeSerif_contour10x25_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([38, 2], [40, 2], [42.5, 4.5],steps,10);

	BezConic([42.5, 4.5], [45, 7], [46.5, 10.5],steps,10);

	BezConic([46.5, 10.5], [48, 14], [48, 17],steps,10);

	BezConic([48, 17], [48, 19], [46.5, 20.5],steps,10);

	BezConic([46.5, 20.5], [45, 22], [43, 22],steps,10);

	BezConic([43, 22], [40, 22], [38.0, 18.5],steps,10);

	BezConic([38.0, 18.5], [36, 15], [35.0, 11.5],steps,10);

	BezConic([35.0, 11.5], [34, 8], [34, 6],steps,10);

	BezConic([34, 6], [34, 4], [35.0, 3.0],steps,10);

	BezConic([35.0, 3.0], [36, 2], [38, 2],steps,10);

}

}

module FreeSerif_contour10x25_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour10x25(steps=2) {
	difference() {
		union() {
			FreeSerif_contour10x25_skeleton();
			FreeSerif_contour10x25_subtractive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour10x25_additive_curves(steps);
	}
}

module FreeSerif_contour20x25_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[18, 42], [20, 42], [21.0, 41.5], 

		[22, 41], [23.5, 40.0], [25, 39], 

		[28, 39], [31, 39], [33.5, 40.0], 

		[36, 41], [38, 43], [39.5, 43.0], 

		[41, 43], [28.5, 21.0], [16, -1], 

		[14.5, -1.0], [13, -1], [24.0, 19.0], 

		[35, 39], [32, 37], [28, 37], 

		[26, 37], [24, 38], [25, 36], 

		[25, 35], [25, 29], [21.0, 23.5], 

		[17, 18], [11, 18], [8, 18], 

		[6.0, 20.5], [4, 23], [4, 27], 

		[4, 33], [8.5, 37.5], [13, 42], 

		 ]);

}

module FreeSerif_contour20x25_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([23.5, 40.0], [25, 39], [28, 39],steps,10);

	BezConic([28, 39], [31, 39], [33.5, 40.0],steps,10);

	BezConic([33.5, 40.0], [36, 41], [38, 43],steps,10);

}

}

module FreeSerif_contour20x25_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([18, 42], [20, 42], [21.0, 41.5],steps,10);

	BezConic([21.0, 41.5], [22, 41], [23.5, 40.0],steps,10);

	BezConic([35, 39], [32, 37], [28, 37],steps,10);

	BezConic([28, 37], [26, 37], [24, 38],steps,10);

	BezConic([24, 38], [25, 36], [25, 35],steps,10);

	BezConic([25, 35], [25, 29], [21.0, 23.5],steps,10);

	BezConic([21.0, 23.5], [17, 18], [11, 18],steps,10);

	BezConic([11, 18], [8, 18], [6.0, 20.5],steps,10);

	BezConic([6.0, 20.5], [4, 23], [4, 27],steps,10);

	BezConic([4, 27], [4, 33], [8.5, 37.5],steps,10);

	BezConic([8.5, 37.5], [13, 42], [18, 42],steps,10);

}

}

module FreeSerif_contour20x25(steps=2) {
	difference() {
		union() {
			FreeSerif_contour20x25_skeleton();
			FreeSerif_contour20x25_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour20x25_subtractive_curves(steps);
	}
}

module FreeSerif_contour30x25_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[18, 40], [15, 40], [12.0, 34.5], 

		[9, 29], [9, 25], [9, 23], 

		[10.0, 22.0], [11, 21], [13, 21], 

		[16, 21], [19.5, 25.5], [23, 30], 

		[23, 35], [23, 36], [22, 38], 

		[21, 39], [20.0, 39.5], [19, 40], 

		[19.0, 40.0], [19, 40], [18.5, 40.0], 

		[18, 40], ]);

}

module FreeSerif_contour30x25_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([18, 40], [15, 40], [12.0, 34.5],steps,10);

	BezConic([12.0, 34.5], [9, 29], [9, 25],steps,10);

	BezConic([9, 25], [9, 23], [10.0, 22.0],steps,10);

	BezConic([10.0, 22.0], [11, 21], [13, 21],steps,10);

	BezConic([13, 21], [16, 21], [19.5, 25.5],steps,10);

	BezConic([19.5, 25.5], [23, 30], [23, 35],steps,10);

	BezConic([23, 35], [23, 36], [22, 38],steps,10);

	BezConic([22, 38], [21, 39], [20.0, 39.5],steps,10);

	BezConic([20.0, 39.5], [19, 40], [19.0, 40.0],steps,10);

	BezConic([19.0, 40.0], [19, 40], [18.5, 40.0],steps,10);

	BezConic([18.5, 40.0], [18, 40], [18, 40],steps,10);

}

}

module FreeSerif_contour30x25_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour30x25(steps=2) {
	difference() {
		union() {
			FreeSerif_contour30x25_skeleton();
			FreeSerif_contour30x25_subtractive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour30x25_additive_curves(steps);
	}
}

module FreeSerif_chunk10x25(steps=2) {
	difference() {
		FreeSerif_contour00x25(steps);
		scale([1,1,1.1]) FreeSerif_contour10x25(steps);
	}
}

module FreeSerif_chunk20x25(steps=2) {
	difference() {
		FreeSerif_contour20x25(steps);
		scale([1,1,1.1]) FreeSerif_contour30x25(steps);
	}
}

FreeSerif_bbox0x25=[[4, -1], [49, 43]];

module FreeSerif_letter0x25(detail=2) {

	FreeSerif_chunk10x25(steps=detail);

	FreeSerif_chunk20x25(steps=detail);

} //end skeleton



module FreeSerif_contour00x26_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[29.0, 41.0], [31, 39], [31.0, 35.5], 

		[31, 32], [29.0, 29.5], [27, 27], 

		[22, 25], [25, 17], [30, 11], 

		[36, 19], [36, 23], [36, 25], 

		[35.0, 25.5], [34, 26], [32, 26], 

		[32.0, 26.5], [32, 27], [39.0, 27.0], 

		[46, 27], [46.0, 26.5], [46, 26], 

		[43, 26], [42.0, 25.0], [41, 24], 

		[39, 22], [38.5, 20.5], [38, 19], 

		[35, 15], [31, 10], [36, 4], 

		[41, 4], [43, 4], [44.5, 4.5], 

		[46, 5], [47, 7], [47.5, 6.5], 

		[48, 6], [47, 3], [44.0, 1.0], 

		[41, -1], [38, -1], [33, -1], 

		[27, 5], [24, 2], [21.0, 0.5], 

		[18, -1], [14, -1], [9, -1], 

		[6.0, 1.5], [3, 4], [3, 9], 

		[3, 17], [13, 23], [14.0, 23.5], 

		[15, 24], [13, 30], [13, 33], 

		[13, 38], [16.0, 40.5], [19, 43], 

		[23, 43],[27, 43], ]);

}

module FreeSerif_contour00x26_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([22, 25], [25, 17], [30, 11],steps,10);

	BezConic([30, 11], [36, 19], [36, 23],steps,10);

	BezConic([36, 23], [36, 25], [35.0, 25.5],steps,10);

	BezConic([35.0, 25.5], [34, 26], [32, 26],steps,10);

	BezConic([46, 26], [43, 26], [42.0, 25.0],steps,10);

	BezConic([42.0, 25.0], [41, 24], [39, 22],steps,10);

	BezConic([31, 10], [36, 4], [41, 4],steps,10);

	BezConic([41, 4], [43, 4], [44.5, 4.5],steps,10);

	BezConic([44.5, 4.5], [46, 5], [47, 7],steps,10);

}

}

module FreeSerif_contour00x26_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([29.0, 41.0], [31, 39], [31.0, 35.5],steps,10);

	BezConic([31.0, 35.5], [31, 32], [29.0, 29.5],steps,10);

	BezConic([29.0, 29.5], [27, 27], [22, 25],steps,10);

	BezConic([38, 19], [35, 15], [31, 10],steps,10);

	BezConic([48, 6], [47, 3], [44.0, 1.0],steps,10);

	BezConic([44.0, 1.0], [41, -1], [38, -1],steps,10);

	BezConic([38, -1], [33, -1], [27, 5],steps,10);

	BezConic([27, 5], [24, 2], [21.0, 0.5],steps,10);

	BezConic([21.0, 0.5], [18, -1], [14, -1],steps,10);

	BezConic([14, -1], [9, -1], [6.0, 1.5],steps,10);

	BezConic([6.0, 1.5], [3, 4], [3, 9],steps,10);

	BezConic([3, 9], [3, 17], [13, 23],steps,10);

	BezConic([15, 24], [13, 30], [13, 33],steps,10);

	BezConic([13, 33], [13, 38], [16.0, 40.5],steps,10);

	BezConic([16.0, 40.5], [19, 43], [23, 43],steps,10);

	BezConic([23, 43], [27, 43], [29.0, 41.0],steps,10);

}

}

module FreeSerif_contour00x26(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x26_skeleton();
			FreeSerif_contour00x26_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x26_subtractive_curves(steps);
	}
}

module FreeSerif_contour10x26_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[21, 27], [24, 29], [26.0, 31.0], 

		[28, 33], [28, 36], [28, 38], 

		[26.5, 39.5], [25, 41], [23, 41], 

		[21, 41], [19.5, 39.5], [18, 38], 

		[18, 36],[18, 32], ]);

}

module FreeSerif_contour10x26_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([21, 27], [24, 29], [26.0, 31.0],steps,10);

	BezConic([26.0, 31.0], [28, 33], [28, 36],steps,10);

	BezConic([28, 36], [28, 38], [26.5, 39.5],steps,10);

	BezConic([26.5, 39.5], [25, 41], [23, 41],steps,10);

	BezConic([23, 41], [21, 41], [19.5, 39.5],steps,10);

	BezConic([19.5, 39.5], [18, 38], [18, 36],steps,10);

	BezConic([18, 36], [18, 32], [21, 27],steps,10);

}

}

module FreeSerif_contour10x26_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour10x26(steps=2) {
	difference() {
		union() {
			FreeSerif_contour10x26_skeleton();
			FreeSerif_contour10x26_subtractive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour10x26_additive_curves(steps);
	}
}

module FreeSerif_contour20x26_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[16, 22], [12, 19], [10.5, 17.0], 

		[9, 15], [9, 12], [9, 8], 

		[11.0, 5.0], [13, 2], [17, 2], 

		[21, 2], [26, 7], [21, 12], 

		 ]);

}

module FreeSerif_contour20x26_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([16, 22], [12, 19], [10.5, 17.0],steps,10);

	BezConic([10.5, 17.0], [9, 15], [9, 12],steps,10);

	BezConic([9, 12], [9, 8], [11.0, 5.0],steps,10);

	BezConic([11.0, 5.0], [13, 2], [17, 2],steps,10);

	BezConic([17, 2], [21, 2], [26, 7],steps,10);

}

}

module FreeSerif_contour20x26_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([26, 7], [21, 12], [16, 22],steps,10);

}

}

module FreeSerif_contour20x26(steps=2) {
	difference() {
		union() {
			FreeSerif_contour20x26_skeleton();
			FreeSerif_contour20x26_subtractive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour20x26_additive_curves(steps);
	}
}

module FreeSerif_chunk10x26(steps=2) {
	difference() {
		FreeSerif_contour00x26(steps);
		scale([1,1,1.1]) FreeSerif_contour10x26(steps);
	scale([1,1,1.1]) FreeSerif_contour20x26(steps);
	}
}

FreeSerif_bbox0x26=[[3, -1], [48, 43]];

module FreeSerif_letter0x26(detail=2) {

	FreeSerif_chunk10x26(steps=detail);

} //end skeleton



module FreeSerif_contour00x27_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[6, 28], [5.5, 28.0], [5, 28], 

		[3, 38], [3, 41], [3, 42], 

		[4.0, 42.5], [5, 43], [6, 43], 

		[7, 43], [8.0, 42.5], [9, 42], 

		[9, 41], [9, 38], [7, 30], 

		[6.5, 29.0], ]);

}

module FreeSerif_contour00x27_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x27_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([5, 28], [3, 38], [3, 41],steps,10);

	BezConic([3, 41], [3, 42], [4.0, 42.5],steps,10);

	BezConic([4.0, 42.5], [5, 43], [6, 43],steps,10);

	BezConic([6, 43], [7, 43], [8.0, 42.5],steps,10);

	BezConic([8.0, 42.5], [9, 42], [9, 41],steps,10);

	BezConic([9, 41], [9, 38], [7, 30],steps,10);

}

}

module FreeSerif_contour00x27(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x27_skeleton();
			FreeSerif_contour00x27_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x27_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x27(steps=2) {
	difference() {
		FreeSerif_contour00x27(steps);
		
	}
}

FreeSerif_bbox0x27=[[3, 28], [9, 43]];

module FreeSerif_letter0x27(detail=2) {

	FreeSerif_chunk10x27(steps=detail);

} //end skeleton



module FreeSerif_contour00x28_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[19, -11], [17, -10], [15.0, -8.5], 

		[13, -7], [11.0, -4.5], [9, -2], 

		[7.0, 1.0], [5, 4], [4.0, 8.0], 

		[3, 12], [3, 16], [3, 21], 

		[4.0, 25.0], [5, 29], [7.0, 31.5], 

		[9, 34], [11.5, 36.5], [14, 39], 

		[15.5, 40.5], [17, 42], [19, 43], 

		[19.0, 42.5], [19, 42], [17, 40], 

		[15.0, 38.0], [13, 36], [11.5, 33.0], 

		[10, 30], [9.5, 26.0], [9, 22], 

		[9, 16], [9, 10], [9.5, 6.0], 

		[10, 2], [11.5, -1.0], [13, -4], 

		[15.0, -6.0], [17, -8], [19, -10], 

		[19.0, -10.5], ]);

}

module FreeSerif_contour00x28_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([19, 42], [17, 40], [15.0, 38.0],steps,10);

	BezConic([15.0, 38.0], [13, 36], [11.5, 33.0],steps,10);

	BezConic([11.5, 33.0], [10, 30], [9.5, 26.0],steps,10);

	BezConic([9.5, 26.0], [9, 22], [9, 16],steps,10);

	BezConic([9, 16], [9, 10], [9.5, 6.0],steps,10);

	BezConic([9.5, 6.0], [10, 2], [11.5, -1.0],steps,10);

	BezConic([11.5, -1.0], [13, -4], [15.0, -6.0],steps,10);

}

}

module FreeSerif_contour00x28_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([19, -11], [17, -10], [15.0, -8.5],steps,10);

	BezConic([15.0, -8.5], [13, -7], [11.0, -4.5],steps,10);

	BezConic([11.0, -4.5], [9, -2], [7.0, 1.0],steps,10);

	BezConic([7.0, 1.0], [5, 4], [4.0, 8.0],steps,10);

	BezConic([4.0, 8.0], [3, 12], [3, 16],steps,10);

	BezConic([3, 16], [3, 21], [4.0, 25.0],steps,10);

	BezConic([4.0, 25.0], [5, 29], [7.0, 31.5],steps,10);

	BezConic([7.0, 31.5], [9, 34], [11.5, 36.5],steps,10);

	BezConic([11.5, 36.5], [14, 39], [15.5, 40.5],steps,10);

	BezConic([15.5, 40.5], [17, 42], [19, 43],steps,10);

	BezConic([15.0, -6.0], [17, -8], [19, -10],steps,10);

}

}

module FreeSerif_contour00x28(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x28_skeleton();
			FreeSerif_contour00x28_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x28_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x28(steps=2) {
	difference() {
		FreeSerif_contour00x28(steps);
		
	}
}

FreeSerif_bbox0x28=[[3, -11], [19, 43]];

module FreeSerif_letter0x28(detail=2) {

	FreeSerif_chunk10x28(steps=detail);

} //end skeleton



module FreeSerif_contour00x29_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[3, 43], [4, 42], [6.0, 40.5], 

		[8, 39], [10.0, 36.5], [12, 34], 

		[14.0, 31.0], [16, 28], [17.0, 24.0], 

		[18, 20], [18, 16], [18, 11], 

		[17.0, 7.0], [16, 3], [14.5, 0.5], 

		[13, -2], [10.5, -5.0], [8, -8], 

		[6.5, -9.0], [5, -10], [2, -11], 

		[2.0, -10.5], [2, -10], [5, -8], 

		[6.5, -6.0], [8, -4], [9.5, -1.0], 

		[11, 2], [12.0, 6.0], [13, 10], 

		[13, 16], [13, 23], [11.5, 28.5], 

		[10, 34], [8.0, 36.5], [6, 39], 

		[2, 42],[2.5, 42.5], ]);

}

module FreeSerif_contour00x29_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([3, 43], [4, 42], [6.0, 40.5],steps,10);

	BezConic([2, -10], [5, -8], [6.5, -6.0],steps,10);

	BezConic([6.5, -6.0], [8, -4], [9.5, -1.0],steps,10);

	BezConic([9.5, -1.0], [11, 2], [12.0, 6.0],steps,10);

	BezConic([12.0, 6.0], [13, 10], [13, 16],steps,10);

	BezConic([13, 16], [13, 23], [11.5, 28.5],steps,10);

	BezConic([11.5, 28.5], [10, 34], [8.0, 36.5],steps,10);

	BezConic([8.0, 36.5], [6, 39], [2, 42],steps,10);

}

}

module FreeSerif_contour00x29_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([6.0, 40.5], [8, 39], [10.0, 36.5],steps,10);

	BezConic([10.0, 36.5], [12, 34], [14.0, 31.0],steps,10);

	BezConic([14.0, 31.0], [16, 28], [17.0, 24.0],steps,10);

	BezConic([17.0, 24.0], [18, 20], [18, 16],steps,10);

	BezConic([18, 16], [18, 11], [17.0, 7.0],steps,10);

	BezConic([17.0, 7.0], [16, 3], [14.5, 0.5],steps,10);

	BezConic([14.5, 0.5], [13, -2], [10.5, -5.0],steps,10);

	BezConic([10.5, -5.0], [8, -8], [6.5, -9.0],steps,10);

	BezConic([6.5, -9.0], [5, -10], [2, -11],steps,10);

}

}

module FreeSerif_contour00x29(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x29_skeleton();
			FreeSerif_contour00x29_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x29_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x29(steps=2) {
	difference() {
		FreeSerif_contour00x29(steps);
		
	}
}

FreeSerif_bbox0x29=[[2, -11], [18, 43]];

module FreeSerif_letter0x29(detail=2) {

	FreeSerif_chunk10x29(steps=detail);

} //end skeleton



module FreeSerif_contour00x2a_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[14, 19], [14, 20], [14.5, 22.5], 

		[15, 25], [15, 27], [15.0, 27.5], 

		[15, 28], [15.0, 28.5], [15, 29], 

		[15.0, 29.0], [15, 29], [13, 28], 

		[11.5, 26.5], [10, 25], [9.5, 24.0], 

		[9, 23], [8.5, 22.5], [8, 22], 

		[7, 22], [4, 22], [4, 25], 

		[4, 26], [5.5, 26.5], [7, 27], 

		[9.5, 28.0], [12, 29], [15, 30], 

		[14.5, 30.5], [14, 31], [13, 32], 

		[10.5, 32.5], [8, 33], [6.0, 33.5], 

		[4, 34], [4, 36], [4, 36], 

		[5.0, 37.0], [6, 38], [7, 38], 

		[8, 38], [8.5, 37.0], [9, 36], 

		[11.0, 34.5], [13, 33], [15, 31], 

		[15.0, 31.5], [15, 32], [15, 34], 

		[14.5, 37.0], [14, 40], [14, 41], 

		[14, 42], [14.5, 42.5], [15, 43], 

		[16.0, 43.0], [17, 43], [17.5, 42.5], 

		[18, 42], [18, 41], [18, 40], 

		[17.5, 37.0], [17, 34], [17, 33], 

		[17.0, 32.0], [17, 31], [18, 32], 

		[20.0, 34.0], [22, 36], [23.0, 37.0], 

		[24, 38], [25, 38], [26, 38], 

		[27.0, 37.5], [28, 37], [28, 35], 

		[28, 34], [27.0, 33.5], [26, 33], 

		[25.0, 33.0], [24, 33], [21.5, 32.0], 

		[19, 31], [17, 30], [19, 29], 

		[21.0, 28.5], [23, 28], [24.5, 27.5], 

		[26, 27], [27.0, 26.5], [28, 26], 

		[28, 25], [28, 24], [27.0, 23.0], 

		[26, 22], [25, 22], [24, 22], 

		[23.0, 23.5], [22, 25], [20.5, 26.5], 

		[19, 28], [17, 29], [17.0, 29.0], 

		[17, 29], [17, 26], [17.5, 23.0], 

		[18, 20], [18, 20], [18, 18], 

		[17.5, 17.5], [17, 17], [16, 17], 

		[15, 17], [14.5, 17.5], [14, 18], 

		 ]);

}

module FreeSerif_contour00x2a_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([14.5, 22.5], [15, 25], [15, 27],steps,10);

	BezConic([15, 29], [13, 28], [11.5, 26.5],steps,10);

	BezConic([11.5, 26.5], [10, 25], [9.5, 24.0],steps,10);

	BezConic([5.5, 26.5], [7, 27], [9.5, 28.0],steps,10);

	BezConic([14, 31], [13, 32], [10.5, 32.5],steps,10);

	BezConic([4, 36], [4, 36], [5.0, 37.0],steps,10);

	BezConic([8.5, 37.0], [9, 36], [11.0, 34.5],steps,10);

	BezConic([15, 32], [15, 34], [14.5, 37.0],steps,10);

	BezConic([17.5, 37.0], [17, 34], [17, 33],steps,10);

	BezConic([17, 31], [18, 32], [20.0, 34.0],steps,10);

	BezConic([25.0, 33.0], [24, 33], [21.5, 32.0],steps,10);

	BezConic([21.5, 32.0], [19, 31], [17, 30],steps,10);

	BezConic([17, 30], [19, 29], [21.0, 28.5],steps,10);

	BezConic([23.0, 23.5], [22, 25], [20.5, 26.5],steps,10);

	BezConic([20.5, 26.5], [19, 28], [17, 29],steps,10);

	BezConic([17, 29], [17, 26], [17.5, 23.0],steps,10);

	BezConic([17.5, 23.0], [18, 20], [18, 20],steps,10);

}

}

module FreeSerif_contour00x2a_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([14, 19], [14, 20], [14.5, 22.5],steps,10);

	BezConic([9.5, 24.0], [9, 23], [8.5, 22.5],steps,10);

	BezConic([8.5, 22.5], [8, 22], [7, 22],steps,10);

	BezConic([7, 22], [4, 22], [4, 25],steps,10);

	BezConic([4, 25], [4, 26], [5.5, 26.5],steps,10);

	BezConic([9.5, 28.0], [12, 29], [15, 30],steps,10);

	BezConic([10.5, 32.5], [8, 33], [6.0, 33.5],steps,10);

	BezConic([6.0, 33.5], [4, 34], [4, 36],steps,10);

	BezConic([5.0, 37.0], [6, 38], [7, 38],steps,10);

	BezConic([7, 38], [8, 38], [8.5, 37.0],steps,10);

	BezConic([11.0, 34.5], [13, 33], [15, 31],steps,10);

	BezConic([14.5, 37.0], [14, 40], [14, 41],steps,10);

	BezConic([14, 41], [14, 42], [14.5, 42.5],steps,10);

	BezConic([14.5, 42.5], [15, 43], [16.0, 43.0],steps,10);

	BezConic([16.0, 43.0], [17, 43], [17.5, 42.5],steps,10);

	BezConic([17.5, 42.5], [18, 42], [18, 41],steps,10);

	BezConic([18, 41], [18, 40], [17.5, 37.0],steps,10);

	BezConic([20.0, 34.0], [22, 36], [23.0, 37.0],steps,10);

	BezConic([23.0, 37.0], [24, 38], [25, 38],steps,10);

	BezConic([25, 38], [26, 38], [27.0, 37.5],steps,10);

	BezConic([27.0, 37.5], [28, 37], [28, 35],steps,10);

	BezConic([28, 35], [28, 34], [27.0, 33.5],steps,10);

	BezConic([27.0, 33.5], [26, 33], [25.0, 33.0],steps,10);

	BezConic([21.0, 28.5], [23, 28], [24.5, 27.5],steps,10);

	BezConic([24.5, 27.5], [26, 27], [27.0, 26.5],steps,10);

	BezConic([27.0, 26.5], [28, 26], [28, 25],steps,10);

	BezConic([28, 25], [28, 24], [27.0, 23.0],steps,10);

	BezConic([27.0, 23.0], [26, 22], [25, 22],steps,10);

	BezConic([25, 22], [24, 22], [23.0, 23.5],steps,10);

	BezConic([18, 20], [18, 18], [17.5, 17.5],steps,10);

	BezConic([17.5, 17.5], [17, 17], [16, 17],steps,10);

	BezConic([16, 17], [15, 17], [14.5, 17.5],steps,10);

	BezConic([14.5, 17.5], [14, 18], [14, 19],steps,10);

}

}

module FreeSerif_contour00x2a(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x2a_skeleton();
			FreeSerif_contour00x2a_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x2a_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x2a(steps=2) {
	difference() {
		FreeSerif_contour00x2a(steps);
		
	}
}

FreeSerif_bbox0x2a=[[4, 17], [28, 43]];

module FreeSerif_letter0x2a(detail=2) {

	FreeSerif_chunk10x2a(steps=detail);

} //end skeleton



module FreeSerif_contour00x2b_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[16, 18], [16.0, 25.0], [16, 32], 

		[18.0, 32.0], [20, 32], [20.0, 25.0], 

		[20, 18], [27.0, 18.0], [34, 18], 

		[34.0, 16.0], [34, 14], [27.0, 14.0], 

		[20, 14], [20.0, 7.0], [20, 0], 

		[18.0, 0.0], [16, 0], [16.0, 7.0], 

		[16, 14], [9.0, 14.0], [2, 14], 

		[2.0, 16.0], [2, 18], [9.0, 18.0], 

		 ]);

}

module FreeSerif_contour00x2b_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x2b_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x2b(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x2b_skeleton();
			FreeSerif_contour00x2b_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x2b_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x2b(steps=2) {
	difference() {
		FreeSerif_contour00x2b(steps);
		
	}
}

FreeSerif_bbox0x2b=[[2, 0], [34, 32]];

module FreeSerif_letter0x2b(detail=2) {

	FreeSerif_chunk10x2b(steps=detail);

} //end skeleton



module FreeSerif_contour00x2c_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[9, 0], [9, 0], [9, 0], 

		[8, 0], [7, 0], [6, 0], 

		[5.0, 0.5], [4, 1], [4, 3], 

		[4, 4], [5.0, 5.5], [6, 7], 

		[7, 7], [10, 7], [11.0, 5.0], 

		[12, 3], [12, 1], [12, -2], 

		[10.5, -4.5], [9, -7], [5, -9], 

		[5.0, -8.5], [5, -8], [10, -4], 

		[10, -1],[10, 0], ]);

}

module FreeSerif_contour00x2c_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([9, 0], [9, 0], [9, 0],steps,10);

	BezConic([9, 0], [8, 0], [7, 0],steps,10);

	BezConic([5, -8], [10, -4], [10, -1],steps,10);

	BezConic([10, -1], [10, 0], [9, 0],steps,10);

}

}

module FreeSerif_contour00x2c_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([7, 0], [6, 0], [5.0, 0.5],steps,10);

	BezConic([5.0, 0.5], [4, 1], [4, 3],steps,10);

	BezConic([4, 3], [4, 4], [5.0, 5.5],steps,10);

	BezConic([5.0, 5.5], [6, 7], [7, 7],steps,10);

	BezConic([7, 7], [10, 7], [11.0, 5.0],steps,10);

	BezConic([11.0, 5.0], [12, 3], [12, 1],steps,10);

	BezConic([12, 1], [12, -2], [10.5, -4.5],steps,10);

	BezConic([10.5, -4.5], [9, -7], [5, -9],steps,10);

}

}

module FreeSerif_contour00x2c(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x2c_skeleton();
			FreeSerif_contour00x2c_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x2c_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x2c(steps=2) {
	difference() {
		FreeSerif_contour00x2c(steps);
		
	}
}

FreeSerif_bbox0x2c=[[4, -9], [12, 7]];

module FreeSerif_letter0x2c(detail=2) {

	FreeSerif_chunk10x2c(steps=detail);

} //end skeleton



module FreeSerif_contour00x2d_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[2, 16], [10.0, 16.0], [18, 16], 

		[18.0, 14.0], [18, 12], [10.0, 12.0], 

		[2, 12],[2.0, 14.0], ]);

}

module FreeSerif_contour00x2d_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x2d_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x2d(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x2d_skeleton();
			FreeSerif_contour00x2d_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x2d_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x2d(steps=2) {
	difference() {
		FreeSerif_contour00x2d(steps);
		
	}
}

FreeSerif_bbox0x2d=[[2, 12], [18, 16]];

module FreeSerif_letter0x2d(detail=2) {

	FreeSerif_chunk10x2d(steps=detail);

} //end skeleton



module FreeSerif_contour00x2e_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[8, 6], [9, 6], [10.5, 5.0], 

		[12, 4], [12, 3], [12, 1], 

		[10.5, 0.0], [9, -1], [8, -1], 

		[7, -1], [5.5, 0.0], [4, 1], 

		[4, 3], [4, 4], [5.5, 5.0], 

		[7, 6], ]);

}

module FreeSerif_contour00x2e_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x2e_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([8, 6], [9, 6], [10.5, 5.0],steps,10);

	BezConic([10.5, 5.0], [12, 4], [12, 3],steps,10);

	BezConic([12, 3], [12, 1], [10.5, 0.0],steps,10);

	BezConic([10.5, 0.0], [9, -1], [8, -1],steps,10);

	BezConic([8, -1], [7, -1], [5.5, 0.0],steps,10);

	BezConic([5.5, 0.0], [4, 1], [4, 3],steps,10);

	BezConic([4, 3], [4, 4], [5.5, 5.0],steps,10);

	BezConic([5.5, 5.0], [7, 6], [8, 6],steps,10);

}

}

module FreeSerif_contour00x2e(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x2e_skeleton();
			FreeSerif_contour00x2e_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x2e_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x2e(steps=2) {
	difference() {
		FreeSerif_contour00x2e(steps);
		
	}
}

FreeSerif_bbox0x2e=[[4, -1], [12, 6]];

module FreeSerif_letter0x2e(detail=2) {

	FreeSerif_chunk10x2e(steps=detail);

} //end skeleton



module FreeSerif_contour00x2f_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[18, 43], [11.0, 21.0], [4, -1], 

		[1.5, -1.0], [-1, -1], [6.5, 21.0], 

		[14, 43],[16.0, 43.0], ]);

}

module FreeSerif_contour00x2f_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x2f_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x2f(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x2f_skeleton();
			FreeSerif_contour00x2f_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x2f_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x2f(steps=2) {
	difference() {
		FreeSerif_contour00x2f(steps);
		
	}
}

FreeSerif_bbox0x2f=[[-1, -1], [18, 43]];

module FreeSerif_letter0x2f(detail=2) {

	FreeSerif_chunk10x2f(steps=detail);

} //end skeleton



module FreeSerif_contour00x30_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[16, -1], [13, -1], [10.0, 0.5], 

		[7, 2], [5.5, 4.5], [4, 7], 

		[3.0, 10.0], [2, 13], [2.0, 16.0], 

		[2, 19], [2, 22], [2, 27], 

		[3.5, 32.0], [5, 37], [8, 40], 

		[11, 43], [16, 43], [23, 43], 

		[26.5, 37.0], [30, 31], [30, 21], 

		[30, 11], [26.5, 5.0], [23, -1], 

		 ]);

}

module FreeSerif_contour00x30_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([2.0, 16.0], [2, 19], [2, 22],steps,10);

}

}

module FreeSerif_contour00x30_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([16, -1], [13, -1], [10.0, 0.5],steps,10);

	BezConic([10.0, 0.5], [7, 2], [5.5, 4.5],steps,10);

	BezConic([5.5, 4.5], [4, 7], [3.0, 10.0],steps,10);

	BezConic([3.0, 10.0], [2, 13], [2.0, 16.0],steps,10);

	BezConic([2, 22], [2, 27], [3.5, 32.0],steps,10);

	BezConic([3.5, 32.0], [5, 37], [8, 40],steps,10);

	BezConic([8, 40], [11, 43], [16, 43],steps,10);

	BezConic([16, 43], [23, 43], [26.5, 37.0],steps,10);

	BezConic([26.5, 37.0], [30, 31], [30, 21],steps,10);

	BezConic([30, 21], [30, 11], [26.5, 5.0],steps,10);

	BezConic([26.5, 5.0], [23, -1], [16, -1],steps,10);

}

}

module FreeSerif_contour00x30(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x30_skeleton();
			FreeSerif_contour00x30_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x30_subtractive_curves(steps);
	}
}

module FreeSerif_contour10x30_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[16, 42], [8, 42], [8, 21], 

		[8, 1], [16.0, 1.0], [24, 1], 

		[24, 21], [24, 31], [22.0, 36.5], 

		[20, 42], ]);

}

module FreeSerif_contour10x30_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([16, 42], [8, 42], [8, 21],steps,10);

	BezConic([8, 21], [8, 1], [16.0, 1.0],steps,10);

	BezConic([16.0, 1.0], [24, 1], [24, 21],steps,10);

	BezConic([24, 21], [24, 31], [22.0, 36.5],steps,10);

	BezConic([22.0, 36.5], [20, 42], [16, 42],steps,10);

}

}

module FreeSerif_contour10x30_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour10x30(steps=2) {
	difference() {
		union() {
			FreeSerif_contour10x30_skeleton();
			FreeSerif_contour10x30_subtractive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour10x30_additive_curves(steps);
	}
}

module FreeSerif_chunk10x30(steps=2) {
	difference() {
		FreeSerif_contour00x30(steps);
		scale([1,1,1.1]) FreeSerif_contour10x30(steps);
	}
}

FreeSerif_bbox0x30=[[2, -1], [30, 43]];

module FreeSerif_letter0x30(detail=2) {

	FreeSerif_chunk10x30(steps=detail);

} //end skeleton



module FreeSerif_contour00x31_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[12, 38], [11, 38], [7, 37], 

		[7.0, 37.0], [7, 37], [13.0, 40.0], 

		[19, 43], [19.0, 43.0], [19, 43], 

		[19.0, 24.0], [19, 5], [19, 2], 

		[20.0, 1.5], [21, 1], [25, 1], 

		[25.0, 0.5], [25, 0], [16.5, 0.0], 

		[8, 0], [8.0, 0.5], [8, 1], 

		[11, 1], [12.5, 2.0], [14, 3], 

		[14, 6], [14.0, 20.5], [14, 35], 

		[14, 38], ]);

}

module FreeSerif_contour00x31_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([12, 38], [11, 38], [7, 37],steps,10);

	BezConic([19, 5], [19, 2], [20.0, 1.5],steps,10);

	BezConic([20.0, 1.5], [21, 1], [25, 1],steps,10);

	BezConic([8, 1], [11, 1], [12.5, 2.0],steps,10);

	BezConic([12.5, 2.0], [14, 3], [14, 6],steps,10);

	BezConic([14, 35], [14, 38], [12, 38],steps,10);

}

}

module FreeSerif_contour00x31_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x31(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x31_skeleton();
			FreeSerif_contour00x31_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x31_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x31(steps=2) {
	difference() {
		FreeSerif_contour00x31(steps);
		
	}
}

FreeSerif_bbox0x31=[[7, 0], [25, 43]];

module FreeSerif_letter0x31(detail=2) {

	FreeSerif_chunk10x31(steps=detail);

} //end skeleton



module FreeSerif_contour00x32_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[2, 31], [2, 32], [2.5, 33.0], 

		[3, 34], [4.0, 36.0], [5, 38], 

		[6.5, 39.5], [8, 41], [10.0, 42.0], 

		[12, 43], [15, 43], [20, 43], 

		[23.5, 40.0], [27, 37], [27, 32], 

		[27, 25], [19, 16], [13.5, 10.5], 

		[8, 5], [15.5, 5.0], [23, 5], 

		[26, 5], [27.0, 5.5], [28, 6], 

		[30, 9], [30.0, 9.0], [30, 9], 

		[28.5, 4.5], [27, 0], [14.5, 0.0], 

		[2, 0], [2.0, 0.5], [2, 1], 

		[7.5, 7.0], [13, 13], [22, 22], 

		[22, 30], [22, 34], [19.5, 36.5], 

		[17, 39], [13, 39], [9, 39], 

		[7.0, 37.0], [5, 35], [3, 30], 

		[2.5, 30.5], ]);

}

module FreeSerif_contour00x32_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([2.5, 33.0], [3, 34], [4.0, 36.0],steps,10);

	BezConic([23, 5], [26, 5], [27.0, 5.5],steps,10);

	BezConic([27.0, 5.5], [28, 6], [30, 9],steps,10);

	BezConic([13, 13], [22, 22], [22, 30],steps,10);

	BezConic([22, 30], [22, 34], [19.5, 36.5],steps,10);

	BezConic([19.5, 36.5], [17, 39], [13, 39],steps,10);

	BezConic([13, 39], [9, 39], [7.0, 37.0],steps,10);

	BezConic([7.0, 37.0], [5, 35], [3, 30],steps,10);

}

}

module FreeSerif_contour00x32_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([2, 31], [2, 32], [2.5, 33.0],steps,10);

	BezConic([4.0, 36.0], [5, 38], [6.5, 39.5],steps,10);

	BezConic([6.5, 39.5], [8, 41], [10.0, 42.0],steps,10);

	BezConic([10.0, 42.0], [12, 43], [15, 43],steps,10);

	BezConic([15, 43], [20, 43], [23.5, 40.0],steps,10);

	BezConic([23.5, 40.0], [27, 37], [27, 32],steps,10);

	BezConic([27, 32], [27, 25], [19, 16],steps,10);

}

}

module FreeSerif_contour00x32(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x32_skeleton();
			FreeSerif_contour00x32_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x32_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x32(steps=2) {
	difference() {
		FreeSerif_contour00x32(steps);
		
	}
}

FreeSerif_bbox0x32=[[2, 0], [30, 43]];

module FreeSerif_letter0x32(detail=2) {

	FreeSerif_chunk10x32(steps=detail);

} //end skeleton



module FreeSerif_contour00x33_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[5, 5], [7, 5], [9.5, 3.0], 

		[12, 1], [15, 1], [18, 1], 

		[20.5, 4.0], [23, 7], [23, 11], 

		[23, 14], [21.5, 16.5], [20, 19], 

		[17, 20], [15, 21], [10, 21], 

		[10.0, 21.5], [10, 22], [12, 23], 

		[13.5, 23.5], [15, 24], [17.0, 25.5], 

		[19, 27], [19.5, 28.5], [20, 30], 

		[20, 33], [20, 36], [18.5, 37.5], 

		[17, 39], [13, 39], [10, 39], 

		[8.0, 37.5], [6, 36], [4, 33], 

		[3.5, 33.0], [3, 33], [5, 37], 

		[7.5, 40.0], [10, 43], [15, 43], 

		[20, 43], [22.5, 40.5], [25, 38], 

		[25, 34], [25, 32], [24.0, 30.0], 

		[23, 28], [19, 26], [23, 24], 

		[25.5, 21.5], [28, 19], [28, 14], 

		[28, 7], [23.0, 3.0], [18, -1], 

		[10, -1], [7, -1], [5.0, 0.0], 

		[3, 1], [3, 3], [3, 4], 

		[3.5, 4.5],[4, 5], ]);

}

module FreeSerif_contour00x33_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([9.5, 3.0], [12, 1], [15, 1],steps,10);

	BezConic([15, 1], [18, 1], [20.5, 4.0],steps,10);

	BezConic([20.5, 4.0], [23, 7], [23, 11],steps,10);

	BezConic([23, 11], [23, 14], [21.5, 16.5],steps,10);

	BezConic([21.5, 16.5], [20, 19], [17, 20],steps,10);

	BezConic([17, 20], [15, 21], [10, 21],steps,10);

	BezConic([13.5, 23.5], [15, 24], [17.0, 25.5],steps,10);

	BezConic([17.0, 25.5], [19, 27], [19.5, 28.5],steps,10);

	BezConic([19.5, 28.5], [20, 30], [20, 33],steps,10);

	BezConic([20, 33], [20, 36], [18.5, 37.5],steps,10);

	BezConic([18.5, 37.5], [17, 39], [13, 39],steps,10);

	BezConic([13, 39], [10, 39], [8.0, 37.5],steps,10);

	BezConic([8.0, 37.5], [6, 36], [4, 33],steps,10);

}

}

module FreeSerif_contour00x33_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([5, 5], [7, 5], [9.5, 3.0],steps,10);

	BezConic([10, 22], [12, 23], [13.5, 23.5],steps,10);

	BezConic([3, 33], [5, 37], [7.5, 40.0],steps,10);

	BezConic([7.5, 40.0], [10, 43], [15, 43],steps,10);

	BezConic([15, 43], [20, 43], [22.5, 40.5],steps,10);

	BezConic([22.5, 40.5], [25, 38], [25, 34],steps,10);

	BezConic([25, 34], [25, 32], [24.0, 30.0],steps,10);

	BezConic([24.0, 30.0], [23, 28], [19, 26],steps,10);

	BezConic([19, 26], [23, 24], [25.5, 21.5],steps,10);

	BezConic([25.5, 21.5], [28, 19], [28, 14],steps,10);

	BezConic([28, 14], [28, 7], [23.0, 3.0],steps,10);

	BezConic([23.0, 3.0], [18, -1], [10, -1],steps,10);

	BezConic([10, -1], [7, -1], [5.0, 0.0],steps,10);

	BezConic([5.0, 0.0], [3, 1], [3, 3],steps,10);

	BezConic([3, 3], [3, 4], [3.5, 4.5],steps,10);

	BezConic([3.5, 4.5], [4, 5], [5, 5],steps,10);

}

}

module FreeSerif_contour00x33(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x33_skeleton();
			FreeSerif_contour00x33_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x33_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x33(steps=2) {
	difference() {
		FreeSerif_contour00x33(steps);
		
	}
}

FreeSerif_bbox0x33=[[3, -1], [28, 43]];

module FreeSerif_letter0x33(detail=2) {

	FreeSerif_chunk10x33(steps=detail);

} //end skeleton



module FreeSerif_contour00x34_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[30, 15], [30.0, 13.0], [30, 11], 

		[27.0, 11.0], [24, 11], [24.0, 5.5], 

		[24, 0], [21.5, 0.0], [19, 0], 

		[19.0, 5.5], [19, 11], [10.0, 11.0], 

		[1, 11], [1.0, 13.0], [1, 15], 

		[11.0, 29.0], [21, 43], [22.5, 43.0], 

		[24, 43], [24.0, 29.0], [24, 15], 

		[27.0, 15.0], ]);

}

module FreeSerif_contour00x34_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x34_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x34(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x34_skeleton();
			FreeSerif_contour00x34_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x34_subtractive_curves(steps);
	}
}

module FreeSerif_contour10x34_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[19, 15], [19.0, 26.0], [19, 37], 

		[11.0, 26.0], [3, 15], [11.0, 15.0], 

		 ]);

}

module FreeSerif_contour10x34_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour10x34_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour10x34(steps=2) {
	difference() {
		union() {
			FreeSerif_contour10x34_skeleton();
			FreeSerif_contour10x34_subtractive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour10x34_additive_curves(steps);
	}
}

module FreeSerif_chunk10x34(steps=2) {
	difference() {
		FreeSerif_contour00x34(steps);
		scale([1,1,1.1]) FreeSerif_contour10x34(steps);
	}
}

FreeSerif_bbox0x34=[[1, 0], [30, 43]];

module FreeSerif_letter0x34(detail=2) {

	FreeSerif_chunk10x34(steps=detail);

} //end skeleton



module FreeSerif_contour00x35_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[23, 12], [23, 16], [21.5, 18.5], 

		[20, 21], [18.0, 22.5], [16, 24], 

		[13.0, 25.0], [10, 26], [8.0, 26.0], 

		[6, 26], [5, 26], [4, 26], 

		[4, 27], [4, 27], [4, 27], 

		[7.5, 34.5], [11, 42], [18.0, 42.0], 

		[25, 42], [26, 42], [26.5, 42.5], 

		[27, 43], [27, 44], [27.5, 44.0], 

		[28, 44], [27.0, 41.0], [26, 38], 

		[25, 37], [24, 37], [18.0, 37.0], 

		[12, 37], [10.5, 34.5], [9, 32], 

		[18, 30], [22.5, 26.5], [27, 23], 

		[27, 15], [27, 12], [26.0, 9.0], 

		[25, 6], [23.0, 4.0], [21, 2], 

		[19.0, 1.0], [17, 0], [14.5, -0.5], 

		[12, -1], [10, -1], [6, -1], 

		[4.0, 0.0], [2, 1], [2, 3], 

		[2, 5], [5, 5], [7, 5], 

		[9.5, 3.0], [12, 1], [14, 1], 

		[18, 1], [20.5, 4.5], [23, 8], 

		 ]);

}

module FreeSerif_contour00x35_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([23, 12], [23, 16], [21.5, 18.5],steps,10);

	BezConic([21.5, 18.5], [20, 21], [18.0, 22.5],steps,10);

	BezConic([18.0, 22.5], [16, 24], [13.0, 25.0],steps,10);

	BezConic([13.0, 25.0], [10, 26], [8.0, 26.0],steps,10);

	BezConic([8.0, 26.0], [6, 26], [5, 26],steps,10);

	BezConic([4, 27], [4, 27], [4, 27],steps,10);

	BezConic([25, 42], [26, 42], [26.5, 42.5],steps,10);

	BezConic([26.5, 42.5], [27, 43], [27, 44],steps,10);

	BezConic([9.5, 3.0], [12, 1], [14, 1],steps,10);

	BezConic([14, 1], [18, 1], [20.5, 4.5],steps,10);

	BezConic([20.5, 4.5], [23, 8], [23, 12],steps,10);

}

}

module FreeSerif_contour00x35_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([5, 26], [4, 26], [4, 27],steps,10);

	BezConic([26, 38], [25, 37], [24, 37],steps,10);

	BezConic([9, 32], [18, 30], [22.5, 26.5],steps,10);

	BezConic([22.5, 26.5], [27, 23], [27, 15],steps,10);

	BezConic([27, 15], [27, 12], [26.0, 9.0],steps,10);

	BezConic([26.0, 9.0], [25, 6], [23.0, 4.0],steps,10);

	BezConic([23.0, 4.0], [21, 2], [19.0, 1.0],steps,10);

	BezConic([19.0, 1.0], [17, 0], [14.5, -0.5],steps,10);

	BezConic([14.5, -0.5], [12, -1], [10, -1],steps,10);

	BezConic([10, -1], [6, -1], [4.0, 0.0],steps,10);

	BezConic([4.0, 0.0], [2, 1], [2, 3],steps,10);

	BezConic([2, 3], [2, 5], [5, 5],steps,10);

	BezConic([5, 5], [7, 5], [9.5, 3.0],steps,10);

}

}

module FreeSerif_contour00x35(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x35_skeleton();
			FreeSerif_contour00x35_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x35_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x35(steps=2) {
	difference() {
		FreeSerif_contour00x35(steps);
		
	}
}

FreeSerif_bbox0x35=[[2, -1], [28, 44]];

module FreeSerif_letter0x35(detail=2) {

	FreeSerif_chunk10x35(steps=detail);

} //end skeleton



module FreeSerif_contour00x36_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[17, -1], [10, -1], [6.0, 4.0], 

		[2, 9], [2, 18], [2, 31], 

		[13, 39], [16, 41], [19.5, 42.0], 

		[23, 43], [29, 44], [29.0, 43.5], 

		[29, 43], [21, 42], [16.0, 37.0], 

		[11, 32], [10, 25], [13, 26], 

		[14.5, 26.5], [16, 27], [18, 27], 

		[23, 27], [26.5, 23.5], [30, 20], 

		[30, 14], [30, 7], [26.0, 3.0], 

		[22, -1], ]);

}

module FreeSerif_contour00x36_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([29, 43], [21, 42], [16.0, 37.0],steps,10);

	BezConic([16.0, 37.0], [11, 32], [10, 25],steps,10);

}

}

module FreeSerif_contour00x36_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([17, -1], [10, -1], [6.0, 4.0],steps,10);

	BezConic([6.0, 4.0], [2, 9], [2, 18],steps,10);

	BezConic([2, 18], [2, 31], [13, 39],steps,10);

	BezConic([13, 39], [16, 41], [19.5, 42.0],steps,10);

	BezConic([19.5, 42.0], [23, 43], [29, 44],steps,10);

	BezConic([10, 25], [13, 26], [14.5, 26.5],steps,10);

	BezConic([14.5, 26.5], [16, 27], [18, 27],steps,10);

	BezConic([18, 27], [23, 27], [26.5, 23.5],steps,10);

	BezConic([26.5, 23.5], [30, 20], [30, 14],steps,10);

	BezConic([30, 14], [30, 7], [26.0, 3.0],steps,10);

	BezConic([26.0, 3.0], [22, -1], [17, -1],steps,10);

}

}

module FreeSerif_contour00x36(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x36_skeleton();
			FreeSerif_contour00x36_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x36_subtractive_curves(steps);
	}
}

module FreeSerif_contour10x36_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[15, 24], [11, 24], [9.5, 22.5], 

		[8, 21], [8, 17], [8, 9], 

		[10.5, 5.0], [13, 1], [17, 1], 

		[21, 1], [22.5, 4.0], [24, 7], 

		[24, 12], [24, 18], [22.0, 21.0], 

		[20, 24], ]);

}

module FreeSerif_contour10x36_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([15, 24], [11, 24], [9.5, 22.5],steps,10);

	BezConic([9.5, 22.5], [8, 21], [8, 17],steps,10);

	BezConic([8, 17], [8, 9], [10.5, 5.0],steps,10);

	BezConic([10.5, 5.0], [13, 1], [17, 1],steps,10);

	BezConic([17, 1], [21, 1], [22.5, 4.0],steps,10);

	BezConic([22.5, 4.0], [24, 7], [24, 12],steps,10);

	BezConic([24, 12], [24, 18], [22.0, 21.0],steps,10);

	BezConic([22.0, 21.0], [20, 24], [15, 24],steps,10);

}

}

module FreeSerif_contour10x36_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour10x36(steps=2) {
	difference() {
		union() {
			FreeSerif_contour10x36_skeleton();
			FreeSerif_contour10x36_subtractive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour10x36_additive_curves(steps);
	}
}

module FreeSerif_chunk10x36(steps=2) {
	difference() {
		FreeSerif_contour00x36(steps);
		scale([1,1,1.1]) FreeSerif_contour10x36(steps);
	}
}

FreeSerif_bbox0x36=[[2, -1], [30, 44]];

module FreeSerif_letter0x36(detail=2) {

	FreeSerif_chunk10x36(steps=detail);

} //end skeleton



module FreeSerif_contour00x37_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[29, 42], [29.0, 41.5], [29, 41], 

		[22.0, 20.0], [15, -1], [13.0, -1.0], 

		[11, -1], [17.5, 18.5], [24, 38], 

		[17.0, 38.0], [10, 38], [7, 38], 

		[5.5, 37.0], [4, 36], [2, 32], 

		[1.5, 32.5], [1, 33], [3.0, 37.5], 

		[5, 42],[17.0, 42.0], ]);

}

module FreeSerif_contour00x37_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([10, 38], [7, 38], [5.5, 37.0],steps,10);

	BezConic([5.5, 37.0], [4, 36], [2, 32],steps,10);

}

}

module FreeSerif_contour00x37_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x37(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x37_skeleton();
			FreeSerif_contour00x37_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x37_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x37(steps=2) {
	difference() {
		FreeSerif_contour00x37(steps);
		
	}
}

FreeSerif_bbox0x37=[[1, -1], [29, 42]];

module FreeSerif_letter0x37(detail=2) {

	FreeSerif_chunk10x37(steps=detail);

} //end skeleton



module FreeSerif_contour00x38_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[19, 24], [24, 19], [26.0, 16.5], 

		[28, 14], [28, 10], [28, 5], 

		[25.0, 2.0], [22, -1], [16, -1], 

		[10, -1], [7.0, 2.0], [4, 5], 

		[4, 10], [4, 13], [5.5, 15.0], 

		[7, 17], [12, 21], [7, 26], 

		[5.5, 28.0], [4, 30], [4, 33], 

		[4, 38], [7.5, 40.5], [11, 43], 

		[16, 43], [21, 43], [24.0, 40.5], 

		[27, 38], [27, 34], [27, 31], 

		[25.0, 28.5],[23, 26], ]);

}

module FreeSerif_contour00x38_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x38_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([19, 24], [24, 19], [26.0, 16.5],steps,10);

	BezConic([26.0, 16.5], [28, 14], [28, 10],steps,10);

	BezConic([28, 10], [28, 5], [25.0, 2.0],steps,10);

	BezConic([25.0, 2.0], [22, -1], [16, -1],steps,10);

	BezConic([16, -1], [10, -1], [7.0, 2.0],steps,10);

	BezConic([7.0, 2.0], [4, 5], [4, 10],steps,10);

	BezConic([4, 10], [4, 13], [5.5, 15.0],steps,10);

	BezConic([5.5, 15.0], [7, 17], [12, 21],steps,10);

	BezConic([12, 21], [7, 26], [5.5, 28.0],steps,10);

	BezConic([5.5, 28.0], [4, 30], [4, 33],steps,10);

	BezConic([4, 33], [4, 38], [7.5, 40.5],steps,10);

	BezConic([7.5, 40.5], [11, 43], [16, 43],steps,10);

	BezConic([16, 43], [21, 43], [24.0, 40.5],steps,10);

	BezConic([24.0, 40.5], [27, 38], [27, 34],steps,10);

	BezConic([27, 34], [27, 31], [25.0, 28.5],steps,10);

	BezConic([25.0, 28.5], [23, 26], [19, 24],steps,10);

}

}

module FreeSerif_contour00x38(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x38_skeleton();
			FreeSerif_contour00x38_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x38_subtractive_curves(steps);
	}
}

module FreeSerif_contour10x38_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[17, 17], [15.5, 18.5], [14, 20], 

		[11, 18], [9.5, 15.5], [8, 13], 

		[8, 10], [8, 6], [10.5, 3.5], 

		[13, 1], [17, 1], [20, 1], 

		[22.0, 3.0], [24, 5], [24, 8], 

		[24, 11], [22.5, 13.0], [21, 15], 

		 ]);

}

module FreeSerif_contour10x38_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([14, 20], [11, 18], [9.5, 15.5],steps,10);

	BezConic([9.5, 15.5], [8, 13], [8, 10],steps,10);

	BezConic([8, 10], [8, 6], [10.5, 3.5],steps,10);

	BezConic([10.5, 3.5], [13, 1], [17, 1],steps,10);

	BezConic([17, 1], [20, 1], [22.0, 3.0],steps,10);

	BezConic([22.0, 3.0], [24, 5], [24, 8],steps,10);

	BezConic([24, 8], [24, 11], [22.5, 13.0],steps,10);

	BezConic([22.5, 13.0], [21, 15], [17, 17],steps,10);

}

}

module FreeSerif_contour10x38_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour10x38(steps=2) {
	difference() {
		union() {
			FreeSerif_contour10x38_skeleton();
			FreeSerif_contour10x38_subtractive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour10x38_additive_curves(steps);
	}
}

module FreeSerif_contour20x38_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[17, 25], [17, 25], [17.5, 25.5], 

		[18, 26], [18.5, 26.5], [19, 27], 

		[20.0, 27.5], [21, 28], [21.0, 28.5], 

		[21, 29], [21.5, 30.0], [22, 31], 

		[22.5, 32.0], [23, 33], [23, 34], 

		[23, 38], [21.0, 39.5], [19, 41], 

		[16, 41], [13, 41], [11.0, 39.5], 

		[9, 38], [9, 35], [9, 32], 

		[10.5, 30.0],[12, 28], ]);

}

module FreeSerif_contour20x38_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([17, 25], [17, 25], [17.5, 25.5],steps,10);

	BezConic([17.5, 25.5], [18, 26], [18.5, 26.5],steps,10);

	BezConic([20.0, 27.5], [21, 28], [21.0, 28.5],steps,10);

	BezConic([22.5, 32.0], [23, 33], [23, 34],steps,10);

	BezConic([23, 34], [23, 38], [21.0, 39.5],steps,10);

	BezConic([21.0, 39.5], [19, 41], [16, 41],steps,10);

	BezConic([16, 41], [13, 41], [11.0, 39.5],steps,10);

	BezConic([11.0, 39.5], [9, 38], [9, 35],steps,10);

	BezConic([9, 35], [9, 32], [10.5, 30.0],steps,10);

	BezConic([10.5, 30.0], [12, 28], [17, 25],steps,10);

}

}

module FreeSerif_contour20x38_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([18.5, 26.5], [19, 27], [20.0, 27.5],steps,10);

	BezConic([21.0, 28.5], [21, 29], [21.5, 30.0],steps,10);

	BezConic([21.5, 30.0], [22, 31], [22.5, 32.0],steps,10);

}

}

module FreeSerif_contour20x38(steps=2) {
	difference() {
		union() {
			FreeSerif_contour20x38_skeleton();
			FreeSerif_contour20x38_subtractive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour20x38_additive_curves(steps);
	}
}

module FreeSerif_chunk10x38(steps=2) {
	difference() {
		FreeSerif_contour00x38(steps);
		scale([1,1,1.1]) FreeSerif_contour10x38(steps);
	scale([1,1,1.1]) FreeSerif_contour20x38(steps);
	}
}

FreeSerif_bbox0x38=[[4, -1], [28, 43]];

module FreeSerif_letter0x38(detail=2) {

	FreeSerif_chunk10x38(steps=detail);

} //end skeleton



module FreeSerif_contour00x39_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[4, -1], [4.0, -0.5], [4, 0], 

		[11, 1], [16.0, 6.0], [21, 11], 

		[23, 19], [18, 15], [13, 15], 

		[8, 15], [5.0, 18.5], [2, 22], 

		[2, 28], [2, 35], [6.0, 39.0], 

		[10, 43], [15, 43], [21, 43], 

		[25.0, 38.0], [29, 33], [29, 25], 

		[29, 19], [26.5, 13.0], [24, 7], 

		[19, 4], [16, 1], [12.5, 0.0], 

		[9, -1], ]);

}

module FreeSerif_contour00x39_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([4, 0], [11, 1], [16.0, 6.0],steps,10);

	BezConic([16.0, 6.0], [21, 11], [23, 19],steps,10);

}

}

module FreeSerif_contour00x39_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([23, 19], [18, 15], [13, 15],steps,10);

	BezConic([13, 15], [8, 15], [5.0, 18.5],steps,10);

	BezConic([5.0, 18.5], [2, 22], [2, 28],steps,10);

	BezConic([2, 28], [2, 35], [6.0, 39.0],steps,10);

	BezConic([6.0, 39.0], [10, 43], [15, 43],steps,10);

	BezConic([15, 43], [21, 43], [25.0, 38.0],steps,10);

	BezConic([25.0, 38.0], [29, 33], [29, 25],steps,10);

	BezConic([29, 25], [29, 19], [26.5, 13.0],steps,10);

	BezConic([26.5, 13.0], [24, 7], [19, 4],steps,10);

	BezConic([19, 4], [16, 1], [12.5, 0.0],steps,10);

	BezConic([12.5, 0.0], [9, -1], [4, -1],steps,10);

}

}

module FreeSerif_contour00x39(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x39_skeleton();
			FreeSerif_contour00x39_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x39_subtractive_curves(steps);
	}
}

module FreeSerif_contour10x39_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[16, 18], [17, 18], [18.5, 18.5], 

		[20, 19], [21.5, 20.0], [23, 21], 

		[23, 23], [23.0, 24.0], [23, 25], 

		[23, 41], [15, 41], [13, 41], 

		[11.5, 40.0], [10, 39], [9.0, 37.5], 

		[8, 36], [8.0, 34.0], [8, 32], 

		[8, 30], [8, 25], [10.0, 21.5], 

		[12, 18], ]);

}

module FreeSerif_contour10x39_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([16, 18], [17, 18], [18.5, 18.5],steps,10);

	BezConic([18.5, 18.5], [20, 19], [21.5, 20.0],steps,10);

	BezConic([21.5, 20.0], [23, 21], [23, 23],steps,10);

	BezConic([23, 25], [23, 41], [15, 41],steps,10);

	BezConic([15, 41], [13, 41], [11.5, 40.0],steps,10);

	BezConic([11.5, 40.0], [10, 39], [9.0, 37.5],steps,10);

	BezConic([9.0, 37.5], [8, 36], [8.0, 34.0],steps,10);

	BezConic([8.0, 34.0], [8, 32], [8, 30],steps,10);

	BezConic([8, 30], [8, 25], [10.0, 21.5],steps,10);

	BezConic([10.0, 21.5], [12, 18], [16, 18],steps,10);

}

}

module FreeSerif_contour10x39_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour10x39(steps=2) {
	difference() {
		union() {
			FreeSerif_contour10x39_skeleton();
			FreeSerif_contour10x39_subtractive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour10x39_additive_curves(steps);
	}
}

module FreeSerif_chunk10x39(steps=2) {
	difference() {
		FreeSerif_contour00x39(steps);
		scale([1,1,1.1]) FreeSerif_contour10x39(steps);
	}
}

FreeSerif_bbox0x39=[[2, -1], [29, 43]];

module FreeSerif_letter0x39(detail=2) {

	FreeSerif_chunk10x39(steps=detail);

} //end skeleton



module FreeSerif_contour00x3a_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[9, 29], [10, 29], [11.0, 28.0], 

		[12, 27], [12, 26], [12, 24], 

		[11.0, 23.0], [10, 22], [9, 22], 

		[7, 22], [6.0, 23.0], [5, 24], 

		[5, 26], [5, 27], [6.0, 28.0], 

		[7, 29], ]);

}

module FreeSerif_contour00x3a_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x3a_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([9, 29], [10, 29], [11.0, 28.0],steps,10);

	BezConic([11.0, 28.0], [12, 27], [12, 26],steps,10);

	BezConic([12, 26], [12, 24], [11.0, 23.0],steps,10);

	BezConic([11.0, 23.0], [10, 22], [9, 22],steps,10);

	BezConic([9, 22], [7, 22], [6.0, 23.0],steps,10);

	BezConic([6.0, 23.0], [5, 24], [5, 26],steps,10);

	BezConic([5, 26], [5, 27], [6.0, 28.0],steps,10);

	BezConic([6.0, 28.0], [7, 29], [9, 29],steps,10);

}

}

module FreeSerif_contour00x3a(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x3a_skeleton();
			FreeSerif_contour00x3a_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x3a_subtractive_curves(steps);
	}
}

module FreeSerif_contour10x3a_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[9, 6], [10, 6], [11.0, 5.0], 

		[12, 4], [12, 3], [12, 1], 

		[11.0, 0.0], [10, -1], [9, -1], 

		[7, -1], [6.0, 0.0], [5, 1], 

		[5, 3], [5, 4], [6.0, 5.0], 

		[7, 6], ]);

}

module FreeSerif_contour10x3a_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour10x3a_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([9, 6], [10, 6], [11.0, 5.0],steps,10);

	BezConic([11.0, 5.0], [12, 4], [12, 3],steps,10);

	BezConic([12, 3], [12, 1], [11.0, 0.0],steps,10);

	BezConic([11.0, 0.0], [10, -1], [9, -1],steps,10);

	BezConic([9, -1], [7, -1], [6.0, 0.0],steps,10);

	BezConic([6.0, 0.0], [5, 1], [5, 3],steps,10);

	BezConic([5, 3], [5, 4], [6.0, 5.0],steps,10);

	BezConic([6.0, 5.0], [7, 6], [9, 6],steps,10);

}

}

module FreeSerif_contour10x3a(steps=2) {
	difference() {
		union() {
			FreeSerif_contour10x3a_skeleton();
			FreeSerif_contour10x3a_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour10x3a_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x3a(steps=2) {
	difference() {
		FreeSerif_contour00x3a(steps);
		
	}
}

module FreeSerif_chunk20x3a(steps=2) {
	difference() {
		FreeSerif_contour10x3a(steps);
		
	}
}

FreeSerif_bbox0x3a=[[5, -1], [12, 29]];

module FreeSerif_letter0x3a(detail=2) {

	FreeSerif_chunk10x3a(steps=detail);

	FreeSerif_chunk20x3a(steps=detail);

} //end skeleton



module FreeSerif_contour00x3b_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[11, 0], [11, 0], [10, 0], 

		[10, 0], [9, 0], [7, 0], 

		[6.0, 0.5], [5, 1], [5.0, 3.0], 

		[5, 5], [6.0, 6.0], [7, 7], 

		[9, 7], [11, 7], [12.5, 5.0], 

		[14, 3], [14, 1], [14, -2], 

		[12.0, -4.5], [10, -7], [7, -9], 

		[6.5, -8.5], [6, -8], [12, -4], 

		[12, -1],[12, 0], ]);

}

module FreeSerif_contour00x3b_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([11, 0], [11, 0], [10, 0],steps,10);

	BezConic([10, 0], [10, 0], [9, 0],steps,10);

	BezConic([6, -8], [12, -4], [12, -1],steps,10);

	BezConic([12, -1], [12, 0], [11, 0],steps,10);

}

}

module FreeSerif_contour00x3b_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([9, 0], [7, 0], [6.0, 0.5],steps,10);

	BezConic([6.0, 0.5], [5, 1], [5.0, 3.0],steps,10);

	BezConic([5.0, 3.0], [5, 5], [6.0, 6.0],steps,10);

	BezConic([6.0, 6.0], [7, 7], [9, 7],steps,10);

	BezConic([9, 7], [11, 7], [12.5, 5.0],steps,10);

	BezConic([12.5, 5.0], [14, 3], [14, 1],steps,10);

	BezConic([14, 1], [14, -2], [12.0, -4.5],steps,10);

	BezConic([12.0, -4.5], [10, -7], [7, -9],steps,10);

}

}

module FreeSerif_contour00x3b(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x3b_skeleton();
			FreeSerif_contour00x3b_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x3b_subtractive_curves(steps);
	}
}

module FreeSerif_contour10x3b_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[9, 29], [10, 29], [11.0, 28.0], 

		[12, 27], [12, 26], [12, 24], 

		[11.0, 23.0], [10, 22], [9, 22], 

		[7, 22], [6.0, 23.0], [5, 24], 

		[5, 26], [5, 27], [6.0, 28.0], 

		[7, 29], ]);

}

module FreeSerif_contour10x3b_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour10x3b_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([9, 29], [10, 29], [11.0, 28.0],steps,10);

	BezConic([11.0, 28.0], [12, 27], [12, 26],steps,10);

	BezConic([12, 26], [12, 24], [11.0, 23.0],steps,10);

	BezConic([11.0, 23.0], [10, 22], [9, 22],steps,10);

	BezConic([9, 22], [7, 22], [6.0, 23.0],steps,10);

	BezConic([6.0, 23.0], [5, 24], [5, 26],steps,10);

	BezConic([5, 26], [5, 27], [6.0, 28.0],steps,10);

	BezConic([6.0, 28.0], [7, 29], [9, 29],steps,10);

}

}

module FreeSerif_contour10x3b(steps=2) {
	difference() {
		union() {
			FreeSerif_contour10x3b_skeleton();
			FreeSerif_contour10x3b_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour10x3b_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x3b(steps=2) {
	difference() {
		FreeSerif_contour00x3b(steps);
		
	}
}

module FreeSerif_chunk20x3b(steps=2) {
	difference() {
		FreeSerif_contour10x3b(steps);
		
	}
}

FreeSerif_bbox0x3b=[[5, -9], [14, 29]];

module FreeSerif_letter0x3b(detail=2) {

	FreeSerif_chunk10x3b(steps=detail);

	FreeSerif_chunk20x3b(steps=detail);

} //end skeleton



module FreeSerif_contour00x3c_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[34, -1], [18.0, 6.5], [2, 14], 

		[2.0, 16.0], [2, 18], [18.0, 25.5], 

		[34, 33], [34.0, 30.5], [34, 28], 

		[20.5, 22.0], [7, 16], [20.5, 10.0], 

		[34, 4],[34.0, 1.5], ]);

}

module FreeSerif_contour00x3c_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x3c_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x3c(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x3c_skeleton();
			FreeSerif_contour00x3c_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x3c_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x3c(steps=2) {
	difference() {
		FreeSerif_contour00x3c(steps);
		
	}
}

FreeSerif_bbox0x3c=[[2, -1], [34, 33]];

module FreeSerif_letter0x3c(detail=2) {

	FreeSerif_chunk10x3c(steps=detail);

} //end skeleton



module FreeSerif_contour00x3d_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[34, 25], [34.0, 22.5], [34, 20], 

		[18.0, 20.0], [2, 20], [2.0, 22.5], 

		[2, 25],[18.0, 25.0], ]);

}

module FreeSerif_contour00x3d_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x3d_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x3d(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x3d_skeleton();
			FreeSerif_contour00x3d_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x3d_subtractive_curves(steps);
	}
}

module FreeSerif_contour10x3d_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[34, 12], [34.0, 10.0], [34, 8], 

		[18.0, 8.0], [2, 8], [2.0, 10.0], 

		[2, 12],[18.0, 12.0], ]);

}

module FreeSerif_contour10x3d_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour10x3d_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour10x3d(steps=2) {
	difference() {
		union() {
			FreeSerif_contour10x3d_skeleton();
			FreeSerif_contour10x3d_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour10x3d_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x3d(steps=2) {
	difference() {
		FreeSerif_contour00x3d(steps);
		
	}
}

module FreeSerif_chunk20x3d(steps=2) {
	difference() {
		FreeSerif_contour10x3d(steps);
		
	}
}

FreeSerif_bbox0x3d=[[2, 8], [34, 25]];

module FreeSerif_letter0x3d(detail=2) {

	FreeSerif_chunk10x3d(steps=detail);

	FreeSerif_chunk20x3d(steps=detail);

} //end skeleton



module FreeSerif_contour00x3e_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[2, -1], [2.0, 1.5], [2, 4], 

		[15.5, 10.0], [29, 16], [15.5, 22.0], 

		[2, 28], [2.0, 30.5], [2, 33], 

		[18.0, 25.5], [34, 18], [34.0, 16.0], 

		[34, 14],[18.0, 6.5], ]);

}

module FreeSerif_contour00x3e_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x3e_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x3e(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x3e_skeleton();
			FreeSerif_contour00x3e_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x3e_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x3e(steps=2) {
	difference() {
		FreeSerif_contour00x3e(steps);
		
	}
}

FreeSerif_bbox0x3e=[[2, -1], [34, 33]];

module FreeSerif_letter0x3e(detail=2) {

	FreeSerif_chunk10x3e(steps=detail);

} //end skeleton



module FreeSerif_contour00x3f_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[15, 43], [20, 43], [23.0, 40.5], 

		[26, 38], [26, 33], [26, 31], 

		[25.0, 28.5], [24, 26], [23.0, 24.5], 

		[22, 23], [20, 20], [17, 16], 

		[16, 10], [15.5, 10.0], [15, 10], 

		[15, 15], [16, 20], [17.0, 22.0], 

		[18, 24], [21, 29], [21, 34], 

		[21, 37], [19.0, 39.0], [17, 41], 

		[14, 41], [11, 41], [9.5, 40.0], 

		[8, 39], [8, 37], [8, 37], 

		[9.0, 35.5], [10, 34], [10, 33], 

		[10, 31], [9.5, 30.5], [9, 30], 

		[7, 30], [4, 30], [4.0, 34.0], 

		[4, 38], [7.0, 40.5], [10, 43], 

		 ]);

}

module FreeSerif_contour00x3f_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([23.0, 24.5], [22, 23], [20, 20],steps,10);

	BezConic([20, 20], [17, 16], [16, 10],steps,10);

	BezConic([18, 24], [21, 29], [21, 34],steps,10);

	BezConic([21, 34], [21, 37], [19.0, 39.0],steps,10);

	BezConic([19.0, 39.0], [17, 41], [14, 41],steps,10);

	BezConic([14, 41], [11, 41], [9.5, 40.0],steps,10);

	BezConic([9.5, 40.0], [8, 39], [8, 37],steps,10);

}

}

module FreeSerif_contour00x3f_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([15, 43], [20, 43], [23.0, 40.5],steps,10);

	BezConic([23.0, 40.5], [26, 38], [26, 33],steps,10);

	BezConic([26, 33], [26, 31], [25.0, 28.5],steps,10);

	BezConic([25.0, 28.5], [24, 26], [23.0, 24.5],steps,10);

	BezConic([15, 10], [15, 15], [16, 20],steps,10);

	BezConic([8, 37], [8, 37], [9.0, 35.5],steps,10);

	BezConic([9.0, 35.5], [10, 34], [10, 33],steps,10);

	BezConic([10, 33], [10, 31], [9.5, 30.5],steps,10);

	BezConic([9.5, 30.5], [9, 30], [7, 30],steps,10);

	BezConic([7, 30], [4, 30], [4.0, 34.0],steps,10);

	BezConic([4.0, 34.0], [4, 38], [7.0, 40.5],steps,10);

	BezConic([7.0, 40.5], [10, 43], [15, 43],steps,10);

}

}

module FreeSerif_contour00x3f(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x3f_skeleton();
			FreeSerif_contour00x3f_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x3f_subtractive_curves(steps);
	}
}

module FreeSerif_contour10x3f_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[15, 6], [17, 6], [18.0, 5.0], 

		[19, 4], [19, 3], [19, 1], 

		[18.0, 0.0], [17, -1], [15, -1], 

		[14, -1], [13.0, 0.0], [12, 1], 

		[12, 3], [12, 4], [13.0, 5.0], 

		[14, 6], ]);

}

module FreeSerif_contour10x3f_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour10x3f_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([15, 6], [17, 6], [18.0, 5.0],steps,10);

	BezConic([18.0, 5.0], [19, 4], [19, 3],steps,10);

	BezConic([19, 3], [19, 1], [18.0, 0.0],steps,10);

	BezConic([18.0, 0.0], [17, -1], [15, -1],steps,10);

	BezConic([15, -1], [14, -1], [13.0, 0.0],steps,10);

	BezConic([13.0, 0.0], [12, 1], [12, 3],steps,10);

	BezConic([12, 3], [12, 4], [13.0, 5.0],steps,10);

	BezConic([13.0, 5.0], [14, 6], [15, 6],steps,10);

}

}

module FreeSerif_contour10x3f(steps=2) {
	difference() {
		union() {
			FreeSerif_contour10x3f_skeleton();
			FreeSerif_contour10x3f_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour10x3f_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x3f(steps=2) {
	difference() {
		FreeSerif_contour00x3f(steps);
		
	}
}

module FreeSerif_chunk20x3f(steps=2) {
	difference() {
		FreeSerif_contour10x3f(steps);
		
	}
}

FreeSerif_bbox0x3f=[[4, -1], [26, 43]];

module FreeSerif_letter0x3f(detail=2) {

	FreeSerif_chunk10x3f(steps=detail);

	FreeSerif_chunk20x3f(steps=detail);

} //end skeleton



module FreeSerif_contour00x40_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[31, 41], [23, 41], [18.0, 35.0], 

		[13, 29], [13, 21], [13, 12], 

		[18.0, 7.0], [23, 2], [31, 2], 

		[37, 2], [44, 5], [44.5, 4.0], 

		[45, 3], [40, 1], [37.0, 0.0], 

		[34, -1], [31, -1], [21, -1], 

		[14.0, 5.5], [7, 12], [7, 21], 

		[7, 30], [14.0, 36.5], [21, 43], 

		[31, 43], [40, 43], [46.0, 37.5], 

		[52, 32], [52, 25], [52, 18], 

		[48.5, 13.5], [45, 9], [40, 9], 

		[38, 9], [36.0, 10.5], [34, 12], 

		[34, 14], [31, 9], [26, 9], 

		[24, 9], [22.5, 11.0], [21, 13], 

		[21, 16], [21, 22], [24.5, 27.5], 

		[28, 33], [33, 33], [35, 33], 

		[36.0, 32.0], [37, 31], [38, 29], 

		[38.0, 30.5], [38, 32], [40.5, 32.0], 

		[43, 32], [41.0, 23.5], [39, 15], 

		[38, 15], [38, 14], [38, 11], 

		[41, 11], [44, 11], [46.5, 15.0], 

		[49, 19], [49, 24], [49, 31], 

		[43.5, 36.0],[38, 41], ]);

}

module FreeSerif_contour00x40_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([31, 41], [23, 41], [18.0, 35.0],steps,10);

	BezConic([18.0, 35.0], [13, 29], [13, 21],steps,10);

	BezConic([13, 21], [13, 12], [18.0, 7.0],steps,10);

	BezConic([18.0, 7.0], [23, 2], [31, 2],steps,10);

	BezConic([31, 2], [37, 2], [44, 5],steps,10);

	BezConic([39, 15], [38, 15], [38, 14],steps,10);

	BezConic([38, 14], [38, 11], [41, 11],steps,10);

	BezConic([41, 11], [44, 11], [46.5, 15.0],steps,10);

	BezConic([46.5, 15.0], [49, 19], [49, 24],steps,10);

	BezConic([49, 24], [49, 31], [43.5, 36.0],steps,10);

	BezConic([43.5, 36.0], [38, 41], [31, 41],steps,10);

}

}

module FreeSerif_contour00x40_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([45, 3], [40, 1], [37.0, 0.0],steps,10);

	BezConic([37.0, 0.0], [34, -1], [31, -1],steps,10);

	BezConic([31, -1], [21, -1], [14.0, 5.5],steps,10);

	BezConic([14.0, 5.5], [7, 12], [7, 21],steps,10);

	BezConic([7, 21], [7, 30], [14.0, 36.5],steps,10);

	BezConic([14.0, 36.5], [21, 43], [31, 43],steps,10);

	BezConic([31, 43], [40, 43], [46.0, 37.5],steps,10);

	BezConic([46.0, 37.5], [52, 32], [52, 25],steps,10);

	BezConic([52, 25], [52, 18], [48.5, 13.5],steps,10);

	BezConic([48.5, 13.5], [45, 9], [40, 9],steps,10);

	BezConic([40, 9], [38, 9], [36.0, 10.5],steps,10);

	BezConic([36.0, 10.5], [34, 12], [34, 14],steps,10);

	BezConic([34, 14], [31, 9], [26, 9],steps,10);

	BezConic([26, 9], [24, 9], [22.5, 11.0],steps,10);

	BezConic([22.5, 11.0], [21, 13], [21, 16],steps,10);

	BezConic([21, 16], [21, 22], [24.5, 27.5],steps,10);

	BezConic([24.5, 27.5], [28, 33], [33, 33],steps,10);

	BezConic([33, 33], [35, 33], [36.0, 32.0],steps,10);

	BezConic([36.0, 32.0], [37, 31], [38, 29],steps,10);

}

}

module FreeSerif_contour00x40(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x40_skeleton();
			FreeSerif_contour00x40_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x40_subtractive_curves(steps);
	}
}

module FreeSerif_contour10x40_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[37, 26], [37, 28], [36.0, 29.0], 

		[35, 30], [34, 30], [31, 30], 

		[28.0, 26.5], [25, 23], [25, 17], 

		[25, 15], [26.0, 13.5], [27, 12], 

		[29, 12], [32, 12], [34.5, 17.0], 

		[37, 22], ]);

}

module FreeSerif_contour10x40_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([37, 26], [37, 28], [36.0, 29.0],steps,10);

	BezConic([36.0, 29.0], [35, 30], [34, 30],steps,10);

	BezConic([34, 30], [31, 30], [28.0, 26.5],steps,10);

	BezConic([28.0, 26.5], [25, 23], [25, 17],steps,10);

	BezConic([25, 17], [25, 15], [26.0, 13.5],steps,10);

	BezConic([26.0, 13.5], [27, 12], [29, 12],steps,10);

	BezConic([29, 12], [32, 12], [34.5, 17.0],steps,10);

	BezConic([34.5, 17.0], [37, 22], [37, 26],steps,10);

}

}

module FreeSerif_contour10x40_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour10x40(steps=2) {
	difference() {
		union() {
			FreeSerif_contour10x40_skeleton();
			FreeSerif_contour10x40_subtractive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour10x40_additive_curves(steps);
	}
}

module FreeSerif_chunk10x40(steps=2) {
	difference() {
		FreeSerif_contour00x40(steps);
		scale([1,1,1.1]) FreeSerif_contour10x40(steps);
	}
}

FreeSerif_bbox0x40=[[7, -1], [52, 43]];

module FreeSerif_letter0x40(detail=2) {

	FreeSerif_chunk10x40(steps=detail);

} //end skeleton



module FreeSerif_contour00x41_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[45, 1], [45.0, 0.5], [45, 0], 

		[37.0, 0.0], [29, 0], [29.0, 0.5], 

		[29, 1], [31, 1], [32.0, 1.5], 

		[33, 2], [33, 3], [33, 5], 

		[32, 8], [31.0, 11.0], [30, 14], 

		[21.5, 14.0], [13, 14], [11.5, 10.0], 

		[10, 6], [9, 5], [9, 4], 

		[9, 1], [14, 1], [14.0, 0.5], 

		[14, 0], [7.5, 0.0], [1, 0], 

		[1.0, 0.5], [1, 1], [3, 1], 

		[4.5, 3.0], [6, 5], [9, 12], 

		[15.5, 27.5], [22, 43], [22.5, 43.0], 

		[23, 43], [31.0, 25.0], [39, 7], 

		[41, 3], [42.0, 2.0], [43, 1], 

		 ]);

}

module FreeSerif_contour00x41_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([29, 1], [31, 1], [32.0, 1.5],steps,10);

	BezConic([32.0, 1.5], [33, 2], [33, 3],steps,10);

	BezConic([33, 3], [33, 5], [32, 8],steps,10);

	BezConic([10, 6], [9, 5], [9, 4],steps,10);

	BezConic([9, 4], [9, 1], [14, 1],steps,10);

	BezConic([1, 1], [3, 1], [4.5, 3.0],steps,10);

	BezConic([4.5, 3.0], [6, 5], [9, 12],steps,10);

	BezConic([39, 7], [41, 3], [42.0, 2.0],steps,10);

	BezConic([42.0, 2.0], [43, 1], [45, 1],steps,10);

}

}

module FreeSerif_contour00x41_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x41(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x41_skeleton();
			FreeSerif_contour00x41_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x41_subtractive_curves(steps);
	}
}

module FreeSerif_contour10x41_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[14, 16], [21.5, 16.0], [29, 16], 

		[25.0, 25.0], [21, 34], [17.5, 25.0], 

		 ]);

}

module FreeSerif_contour10x41_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour10x41_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour10x41(steps=2) {
	difference() {
		union() {
			FreeSerif_contour10x41_skeleton();
			FreeSerif_contour10x41_subtractive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour10x41_additive_curves(steps);
	}
}

module FreeSerif_chunk10x41(steps=2) {
	difference() {
		FreeSerif_contour00x41(steps);
		scale([1,1,1.1]) FreeSerif_contour10x41(steps);
	}
}

FreeSerif_bbox0x41=[[1, 0], [45, 43]];

module FreeSerif_letter0x41(detail=2) {

	FreeSerif_chunk10x41(steps=detail);

} //end skeleton



module FreeSerif_contour00x42_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[38, 12], [38, 10], [37.5, 8.0], 

		[37, 6], [35.0, 4.0], [33, 2], 

		[30.0, 1.0], [27, 0], [22, 0], 

		[11.5, 0.0], [1, 0], [1.0, 0.5], 

		[1, 1], [5, 1], [6.0, 2.0], 

		[7, 3], [7, 7], [7.0, 21.0], 

		[7, 35], [7, 39], [6.0, 40.0], 

		[5, 41], [1, 41], [1.0, 41.5], 

		[1, 42], [10.0, 42.0], [19, 42], 

		[36, 42], [36, 31], [36, 29], 

		[35.0, 27.5], [34, 26], [33.5, 25.0], 

		[33, 24], [31.0, 23.5], [29, 23], 

		[28.5, 23.0], [28, 23], [27, 22], 

		[28, 22], [29.0, 22.0], [30, 22], 

		[32.0, 21.0], [34, 20], [35.0, 19.0], 

		[36, 18], [37.0, 16.0], [38, 14], 

		 ]);

}

module FreeSerif_contour00x42_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([1, 1], [5, 1], [6.0, 2.0],steps,10);

	BezConic([6.0, 2.0], [7, 3], [7, 7],steps,10);

	BezConic([7, 35], [7, 39], [6.0, 40.0],steps,10);

	BezConic([6.0, 40.0], [5, 41], [1, 41],steps,10);

	BezConic([35.0, 27.5], [34, 26], [33.5, 25.0],steps,10);

	BezConic([28.5, 23.0], [28, 23], [27, 22],steps,10);

	BezConic([27, 22], [28, 22], [29.0, 22.0],steps,10);

}

}

module FreeSerif_contour00x42_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([38, 12], [38, 10], [37.5, 8.0],steps,10);

	BezConic([37.5, 8.0], [37, 6], [35.0, 4.0],steps,10);

	BezConic([35.0, 4.0], [33, 2], [30.0, 1.0],steps,10);

	BezConic([30.0, 1.0], [27, 0], [22, 0],steps,10);

	BezConic([19, 42], [36, 42], [36, 31],steps,10);

	BezConic([36, 31], [36, 29], [35.0, 27.5],steps,10);

	BezConic([33.5, 25.0], [33, 24], [31.0, 23.5],steps,10);

	BezConic([31.0, 23.5], [29, 23], [28.5, 23.0],steps,10);

	BezConic([29.0, 22.0], [30, 22], [32.0, 21.0],steps,10);

	BezConic([32.0, 21.0], [34, 20], [35.0, 19.0],steps,10);

	BezConic([35.0, 19.0], [36, 18], [37.0, 16.0],steps,10);

	BezConic([37.0, 16.0], [38, 14], [38, 12],steps,10);

}

}

module FreeSerif_contour00x42(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x42_skeleton();
			FreeSerif_contour00x42_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x42_subtractive_curves(steps);
	}
}

module FreeSerif_contour10x42_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[18, 2], [21, 2], [23.0, 2.5], 

		[25, 3], [27.0, 4.0], [29, 5], 

		[30.0, 7.0], [31, 9], [31, 11], 

		[31, 17], [25, 20], [22, 21], 

		[14, 21], [14.0, 13.0], [14, 5], 

		[14, 3], [14.5, 2.5], [15, 2], 

		 ]);

}

module FreeSerif_contour10x42_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([18, 2], [21, 2], [23.0, 2.5],steps,10);

	BezConic([23.0, 2.5], [25, 3], [27.0, 4.0],steps,10);

	BezConic([27.0, 4.0], [29, 5], [30.0, 7.0],steps,10);

	BezConic([30.0, 7.0], [31, 9], [31, 11],steps,10);

	BezConic([31, 11], [31, 17], [25, 20],steps,10);

	BezConic([25, 20], [22, 21], [14, 21],steps,10);

	BezConic([14, 5], [14, 3], [14.5, 2.5],steps,10);

	BezConic([14.5, 2.5], [15, 2], [18, 2],steps,10);

}

}

module FreeSerif_contour10x42_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour10x42(steps=2) {
	difference() {
		union() {
			FreeSerif_contour10x42_skeleton();
			FreeSerif_contour10x42_subtractive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour10x42_additive_curves(steps);
	}
}

module FreeSerif_contour20x42_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[14, 23], [17.0, 23.0], [20, 23], 

		[24, 23], [26.5, 25.0], [29, 27], 

		[29, 31], [29, 36], [26.0, 38.0], 

		[23, 40], [18, 40], [16.5, 40.0], 

		[15, 40], [14, 40], [14, 38], 

		[14.0, 30.5], ]);

}

module FreeSerif_contour20x42_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([20, 23], [24, 23], [26.5, 25.0],steps,10);

	BezConic([26.5, 25.0], [29, 27], [29, 31],steps,10);

	BezConic([29, 31], [29, 36], [26.0, 38.0],steps,10);

	BezConic([26.0, 38.0], [23, 40], [18, 40],steps,10);

	BezConic([15, 40], [14, 40], [14, 38],steps,10);

}

}

module FreeSerif_contour20x42_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour20x42(steps=2) {
	difference() {
		union() {
			FreeSerif_contour20x42_skeleton();
			FreeSerif_contour20x42_subtractive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour20x42_additive_curves(steps);
	}
}

module FreeSerif_chunk10x42(steps=2) {
	difference() {
		FreeSerif_contour00x42(steps);
		scale([1,1,1.1]) FreeSerif_contour10x42(steps);
	scale([1,1,1.1]) FreeSerif_contour20x42(steps);
	}
}

FreeSerif_bbox0x42=[[1, 0], [38, 42]];

module FreeSerif_letter0x42(detail=2) {

	FreeSerif_chunk10x42(steps=detail);

} //end skeleton



module FreeSerif_contour00x43_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[2, 21], [2, 31], [8.0, 37.0], 

		[14, 43], [23, 43], [27, 43], 

		[30.5, 42.0], [34, 41], [35, 41], 

		[37, 41], [38, 43], [38.5, 43.0], 

		[39, 43], [39.5, 36.0], [40, 29], 

		[39.0, 29.0], [38, 29], [35, 41], 

		[24, 41], [17, 41], [13.0, 35.5], 

		[9, 30], [9, 22], [9, 16], 

		[10.5, 12.0], [12, 8], [14.5, 6.0], 

		[17, 4], [19.5, 3.0], [22, 2], 

		[25, 2], [33, 2], [39, 8], 

		[40.0, 7.5], [41, 7], [38, 3], 

		[33.0, 1.0], [28, -1], [23, -1], 

		[14, -1], [8.0, 5.0], [2, 11], 

		 ]);

}

module FreeSerif_contour00x43_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([30.5, 42.0], [34, 41], [35, 41],steps,10);

	BezConic([35, 41], [37, 41], [38, 43],steps,10);

	BezConic([38, 29], [35, 41], [24, 41],steps,10);

	BezConic([24, 41], [17, 41], [13.0, 35.5],steps,10);

	BezConic([13.0, 35.5], [9, 30], [9, 22],steps,10);

	BezConic([9, 22], [9, 16], [10.5, 12.0],steps,10);

	BezConic([10.5, 12.0], [12, 8], [14.5, 6.0],steps,10);

	BezConic([14.5, 6.0], [17, 4], [19.5, 3.0],steps,10);

	BezConic([19.5, 3.0], [22, 2], [25, 2],steps,10);

	BezConic([25, 2], [33, 2], [39, 8],steps,10);

}

}

module FreeSerif_contour00x43_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([2, 21], [2, 31], [8.0, 37.0],steps,10);

	BezConic([8.0, 37.0], [14, 43], [23, 43],steps,10);

	BezConic([23, 43], [27, 43], [30.5, 42.0],steps,10);

	BezConic([41, 7], [38, 3], [33.0, 1.0],steps,10);

	BezConic([33.0, 1.0], [28, -1], [23, -1],steps,10);

	BezConic([23, -1], [14, -1], [8.0, 5.0],steps,10);

	BezConic([8.0, 5.0], [2, 11], [2, 21],steps,10);

}

}

module FreeSerif_contour00x43(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x43_skeleton();
			FreeSerif_contour00x43_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x43_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x43(steps=2) {
	difference() {
		FreeSerif_contour00x43(steps);
		
	}
}

FreeSerif_bbox0x43=[[2, -1], [41, 43]];

module FreeSerif_letter0x43(detail=2) {

	FreeSerif_chunk10x43(steps=detail);

} //end skeleton



module FreeSerif_contour00x44_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[44, 21], [44, 18], [43.5, 15.5], 

		[43, 13], [41.0, 10.0], [39, 7], 

		[36.5, 5.0], [34, 3], [29.5, 1.5], 

		[25, 0], [19, 0], [10.0, 0.0], 

		[1, 0], [1.0, 0.5], [1, 1], 

		[5, 1], [6.0, 2.5], [7, 4], 

		[7, 7], [7.0, 21.0], [7, 35], 

		[7, 39], [6.0, 40.0], [5, 41], 

		[1, 41], [1.0, 41.5], [1, 42], 

		[9.5, 42.0], [18, 42], [24, 42], 

		[28.5, 41.0], [33, 40], [36.0, 38.0], 

		[39, 36], [40.5, 33.0], [42, 30], 

		[43.0, 27.0],[44, 24], ]);

}

module FreeSerif_contour00x44_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([1, 1], [5, 1], [6.0, 2.5],steps,10);

	BezConic([6.0, 2.5], [7, 4], [7, 7],steps,10);

	BezConic([7, 35], [7, 39], [6.0, 40.0],steps,10);

	BezConic([6.0, 40.0], [5, 41], [1, 41],steps,10);

}

}

module FreeSerif_contour00x44_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([44, 21], [44, 18], [43.5, 15.5],steps,10);

	BezConic([43.5, 15.5], [43, 13], [41.0, 10.0],steps,10);

	BezConic([41.0, 10.0], [39, 7], [36.5, 5.0],steps,10);

	BezConic([36.5, 5.0], [34, 3], [29.5, 1.5],steps,10);

	BezConic([29.5, 1.5], [25, 0], [19, 0],steps,10);

	BezConic([18, 42], [24, 42], [28.5, 41.0],steps,10);

	BezConic([28.5, 41.0], [33, 40], [36.0, 38.0],steps,10);

	BezConic([36.0, 38.0], [39, 36], [40.5, 33.0],steps,10);

	BezConic([40.5, 33.0], [42, 30], [43.0, 27.0],steps,10);

	BezConic([43.0, 27.0], [44, 24], [44, 21],steps,10);

}

}

module FreeSerif_contour00x44(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x44_skeleton();
			FreeSerif_contour00x44_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x44_subtractive_curves(steps);
	}
}

module FreeSerif_contour10x44_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[37, 21], [37, 24], [36.5, 26.5], 

		[36, 29], [34.5, 31.5], [33, 34], 

		[30.5, 36.0], [28, 38], [24.5, 39.0], 

		[21, 40], [17, 40], [15, 40], 

		[14.0, 39.5], [13, 39], [13, 38], 

		[13.0, 21.5], [13, 5], [13, 3], 

		[14.0, 2.5], [15, 2], [17, 2], 

		[37, 2], ]);

}

module FreeSerif_contour10x44_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([37, 21], [37, 24], [36.5, 26.5],steps,10);

	BezConic([36.5, 26.5], [36, 29], [34.5, 31.5],steps,10);

	BezConic([34.5, 31.5], [33, 34], [30.5, 36.0],steps,10);

	BezConic([30.5, 36.0], [28, 38], [24.5, 39.0],steps,10);

	BezConic([24.5, 39.0], [21, 40], [17, 40],steps,10);

	BezConic([17, 40], [15, 40], [14.0, 39.5],steps,10);

	BezConic([14.0, 39.5], [13, 39], [13, 38],steps,10);

	BezConic([13, 5], [13, 3], [14.0, 2.5],steps,10);

	BezConic([14.0, 2.5], [15, 2], [17, 2],steps,10);

	BezConic([17, 2], [37, 2], [37, 21],steps,10);

}

}

module FreeSerif_contour10x44_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour10x44(steps=2) {
	difference() {
		union() {
			FreeSerif_contour10x44_skeleton();
			FreeSerif_contour10x44_subtractive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour10x44_additive_curves(steps);
	}
}

module FreeSerif_chunk10x44(steps=2) {
	difference() {
		FreeSerif_contour00x44(steps);
		scale([1,1,1.1]) FreeSerif_contour10x44(steps);
	}
}

FreeSerif_bbox0x44=[[1, 0], [44, 42]];

module FreeSerif_letter0x44(detail=2) {

	FreeSerif_chunk10x44(steps=detail);

} //end skeleton



module FreeSerif_contour00x45_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[13, 5], [13, 3], [14.0, 2.5], 

		[15, 2], [20, 2], [20.5, 2.0], 

		[21, 2], [28, 2], [31.0, 4.0], 

		[34, 6], [36, 11], [37.0, 11.0], 

		[38, 11], [36.5, 5.5], [35, 0], 

		[18.0, 0.0], [1, 0], [1.0, 0.5], 

		[1, 1], [4, 1], [5.0, 2.5], 

		[6, 4], [6, 7], [6.0, 21.0], 

		[6, 35], [6, 39], [5.0, 40.0], 

		[4, 41], [1, 41], [1.0, 41.5], 

		[1, 42], [18.0, 42.0], [35, 42], 

		[35.0, 37.5], [35, 33], [34.0, 33.0], 

		[33, 33], [33, 38], [31.0, 39.0], 

		[29, 40], [24, 40], [19.5, 40.0], 

		[15, 40], [14, 40], [13.5, 39.5], 

		[13, 39], [13, 38], [13.0, 31.0], 

		[13, 24], [18.0, 24.0], [23, 24], 

		[27, 24], [28.0, 25.0], [29, 26], 

		[30, 30], [30.5, 30.0], [31, 30], 

		[31.0, 22.5], [31, 15], [30.5, 15.0], 

		[30, 15], [29, 19], [28.0, 20.0], 

		[27, 21], [23, 21], [18.0, 21.0], 

		[13, 21],[13.0, 13.0], ]);

}

module FreeSerif_contour00x45_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([13, 5], [13, 3], [14.0, 2.5],steps,10);

	BezConic([14.0, 2.5], [15, 2], [20, 2],steps,10);

	BezConic([21, 2], [28, 2], [31.0, 4.0],steps,10);

	BezConic([31.0, 4.0], [34, 6], [36, 11],steps,10);

	BezConic([1, 1], [4, 1], [5.0, 2.5],steps,10);

	BezConic([5.0, 2.5], [6, 4], [6, 7],steps,10);

	BezConic([6, 35], [6, 39], [5.0, 40.0],steps,10);

	BezConic([5.0, 40.0], [4, 41], [1, 41],steps,10);

	BezConic([33, 33], [33, 38], [31.0, 39.0],steps,10);

	BezConic([31.0, 39.0], [29, 40], [24, 40],steps,10);

	BezConic([15, 40], [14, 40], [13.5, 39.5],steps,10);

	BezConic([13.5, 39.5], [13, 39], [13, 38],steps,10);

	BezConic([23, 24], [27, 24], [28.0, 25.0],steps,10);

	BezConic([28.0, 25.0], [29, 26], [30, 30],steps,10);

	BezConic([30, 15], [29, 19], [28.0, 20.0],steps,10);

	BezConic([28.0, 20.0], [27, 21], [23, 21],steps,10);

}

}

module FreeSerif_contour00x45_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x45(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x45_skeleton();
			FreeSerif_contour00x45_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x45_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x45(steps=2) {
	difference() {
		FreeSerif_contour00x45(steps);
		
	}
}

FreeSerif_bbox0x45=[[1, 0], [38, 42]];

module FreeSerif_letter0x45(detail=2) {

	FreeSerif_chunk10x45(steps=detail);

} //end skeleton



module FreeSerif_contour00x46_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[31, 15], [30.0, 15.0], [29, 15], 

		[29, 19], [27.5, 20.0], [26, 21], 

		[22, 21], [17.5, 21.0], [13, 21], 

		[13.0, 14.0], [13, 7], [13, 4], 

		[14.0, 2.5], [15, 1], [19, 1], 

		[19.0, 0.5], [19, 0], [10.0, 0.0], 

		[1, 0], [1.0, 0.5], [1, 1], 

		[4, 1], [5.0, 2.5], [6, 4], 

		[6, 8], [6.0, 21.5], [6, 35], 

		[6, 39], [5.0, 40.0], [4, 41], 

		[1, 41], [1.0, 41.5], [1, 42], 

		[18.0, 42.0], [35, 42], [35.0, 37.5], 

		[35, 33], [34.0, 33.0], [33, 33], 

		[33, 38], [31.0, 39.0], [29, 40], 

		[24, 40], [19.5, 40.0], [15, 40], 

		[14, 40], [13.5, 39.5], [13, 39], 

		[13, 38], [13.0, 31.0], [13, 24], 

		[17.5, 24.0], [22, 24], [26, 24], 

		[27.5, 25.0], [29, 26], [29, 30], 

		[30.0, 30.0], [31, 30], [31.0, 22.5], 

		 ]);

}

module FreeSerif_contour00x46_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([29, 15], [29, 19], [27.5, 20.0],steps,10);

	BezConic([27.5, 20.0], [26, 21], [22, 21],steps,10);

	BezConic([13, 7], [13, 4], [14.0, 2.5],steps,10);

	BezConic([14.0, 2.5], [15, 1], [19, 1],steps,10);

	BezConic([1, 1], [4, 1], [5.0, 2.5],steps,10);

	BezConic([5.0, 2.5], [6, 4], [6, 8],steps,10);

	BezConic([6, 35], [6, 39], [5.0, 40.0],steps,10);

	BezConic([5.0, 40.0], [4, 41], [1, 41],steps,10);

	BezConic([33, 33], [33, 38], [31.0, 39.0],steps,10);

	BezConic([31.0, 39.0], [29, 40], [24, 40],steps,10);

	BezConic([15, 40], [14, 40], [13.5, 39.5],steps,10);

	BezConic([13.5, 39.5], [13, 39], [13, 38],steps,10);

	BezConic([22, 24], [26, 24], [27.5, 25.0],steps,10);

	BezConic([27.5, 25.0], [29, 26], [29, 30],steps,10);

}

}

module FreeSerif_contour00x46_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x46(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x46_skeleton();
			FreeSerif_contour00x46_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x46_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x46(steps=2) {
	difference() {
		FreeSerif_contour00x46(steps);
		
	}
}

FreeSerif_bbox0x46=[[1, 0], [35, 42]];

module FreeSerif_letter0x46(detail=2) {

	FreeSerif_chunk10x46(steps=detail);

} //end skeleton



module FreeSerif_contour00x47_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[25, 41], [21, 41], [18.5, 39.5], 

		[16, 38], [14.0, 36.0], [12, 34], 

		[11.0, 31.0], [10, 28], [9.5, 25.5], 

		[9, 23], [9, 21], [9, 12], 

		[13.5, 7.0], [18, 2], [26, 2], 

		[30, 2], [32.5, 3.0], [35, 4], 

		[35, 5], [35.0, 10.5], [35, 16], 

		[35, 19], [34.0, 20.0], [33, 21], 

		[29, 22], [29.0, 22.5], [29, 23], 

		[37.0, 23.0], [45, 23], [45.0, 22.5], 

		[45, 22], [43, 21], [42.0, 20.0], 

		[41, 19], [41, 17], [41.0, 10.5], 

		[41, 4], [39, 2], [34.0, 0.5], 

		[29, -1], [25, -1], [22, -1], 

		[19.0, -0.5], [16, 0], [13.0, 1.5], 

		[10, 3], [7.5, 5.5], [5, 8], 

		[3.5, 12.0], [2, 16], [2, 21], 

		[2, 31], [8.0, 37.0], [14, 43], 

		[24, 43], [28, 43], [31.5, 42.0], 

		[35, 41], [36, 41], [37, 41], 

		[37.5, 41.5], [38, 42], [38, 43], 

		[39.0, 43.0], [40, 43], [40.0, 36.5], 

		[40, 30], [39.5, 30.0], [39, 30], 

		[37, 35], [34.0, 38.0], [31, 41], 

		 ]);

}

module FreeSerif_contour00x47_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([25, 41], [21, 41], [18.5, 39.5],steps,10);

	BezConic([18.5, 39.5], [16, 38], [14.0, 36.0],steps,10);

	BezConic([14.0, 36.0], [12, 34], [11.0, 31.0],steps,10);

	BezConic([11.0, 31.0], [10, 28], [9.5, 25.5],steps,10);

	BezConic([9.5, 25.5], [9, 23], [9, 21],steps,10);

	BezConic([9, 21], [9, 12], [13.5, 7.0],steps,10);

	BezConic([13.5, 7.0], [18, 2], [26, 2],steps,10);

	BezConic([26, 2], [30, 2], [32.5, 3.0],steps,10);

	BezConic([32.5, 3.0], [35, 4], [35, 5],steps,10);

	BezConic([35, 16], [35, 19], [34.0, 20.0],steps,10);

	BezConic([34.0, 20.0], [33, 21], [29, 22],steps,10);

	BezConic([45, 22], [43, 21], [42.0, 20.0],steps,10);

	BezConic([42.0, 20.0], [41, 19], [41, 17],steps,10);

	BezConic([31.5, 42.0], [35, 41], [36, 41],steps,10);

	BezConic([36, 41], [37, 41], [37.5, 41.5],steps,10);

	BezConic([37.5, 41.5], [38, 42], [38, 43],steps,10);

	BezConic([39, 30], [37, 35], [34.0, 38.0],steps,10);

	BezConic([34.0, 38.0], [31, 41], [25, 41],steps,10);

}

}

module FreeSerif_contour00x47_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([41, 4], [39, 2], [34.0, 0.5],steps,10);

	BezConic([34.0, 0.5], [29, -1], [25, -1],steps,10);

	BezConic([25, -1], [22, -1], [19.0, -0.5],steps,10);

	BezConic([19.0, -0.5], [16, 0], [13.0, 1.5],steps,10);

	BezConic([13.0, 1.5], [10, 3], [7.5, 5.5],steps,10);

	BezConic([7.5, 5.5], [5, 8], [3.5, 12.0],steps,10);

	BezConic([3.5, 12.0], [2, 16], [2, 21],steps,10);

	BezConic([2, 21], [2, 31], [8.0, 37.0],steps,10);

	BezConic([8.0, 37.0], [14, 43], [24, 43],steps,10);

	BezConic([24, 43], [28, 43], [31.5, 42.0],steps,10);

}

}

module FreeSerif_contour00x47(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x47_skeleton();
			FreeSerif_contour00x47_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x47_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x47(steps=2) {
	difference() {
		FreeSerif_contour00x47(steps);
		
	}
}

FreeSerif_bbox0x47=[[2, -1], [45, 43]];

module FreeSerif_letter0x47(detail=2) {

	FreeSerif_chunk10x47(steps=detail);

} //end skeleton



module FreeSerif_contour00x48_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[13, 23], [23.0, 23.0], [33, 23], 

		[33.0, 29.0], [33, 35], [33, 39], 

		[32.0, 40.0], [31, 41], [27, 41], 

		[27.0, 41.5], [27, 42], [36.0, 42.0], 

		[45, 42], [45.0, 41.5], [45, 41], 

		[41, 41], [40.0, 40.0], [39, 39], 

		[39, 35], [39.0, 21.0], [39, 7], 

		[39, 4], [40.0, 3.0], [41, 2], 

		[45, 1], [45.0, 0.5], [45, 0], 

		[36.0, 0.0], [27, 0], [27.0, 0.5], 

		[27, 1], [31, 1], [32.0, 2.5], 

		[33, 4], [33, 8], [33.0, 14.0], 

		[33, 20], [23.0, 20.0], [13, 20], 

		[13.0, 13.5], [13, 7], [13, 4], 

		[14.0, 3.0], [15, 2], [19, 1], 

		[19.0, 0.5], [19, 0], [10.0, 0.0], 

		[1, 0], [1.0, 0.5], [1, 1], 

		[5, 1], [6.0, 2.5], [7, 4], 

		[7, 8], [7.0, 21.5], [7, 35], 

		[7, 39], [6.0, 40.0], [5, 41], 

		[1, 41], [1.0, 41.5], [1, 42], 

		[10.0, 42.0], [19, 42], [19.0, 41.5], 

		[19, 41], [15, 41], [14.0, 40.0], 

		[13, 39], [13, 35], [13.0, 29.0], 

		 ]);

}

module FreeSerif_contour00x48_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([33, 35], [33, 39], [32.0, 40.0],steps,10);

	BezConic([32.0, 40.0], [31, 41], [27, 41],steps,10);

	BezConic([45, 41], [41, 41], [40.0, 40.0],steps,10);

	BezConic([40.0, 40.0], [39, 39], [39, 35],steps,10);

	BezConic([39, 7], [39, 4], [40.0, 3.0],steps,10);

	BezConic([40.0, 3.0], [41, 2], [45, 1],steps,10);

	BezConic([27, 1], [31, 1], [32.0, 2.5],steps,10);

	BezConic([32.0, 2.5], [33, 4], [33, 8],steps,10);

	BezConic([13, 7], [13, 4], [14.0, 3.0],steps,10);

	BezConic([14.0, 3.0], [15, 2], [19, 1],steps,10);

	BezConic([1, 1], [5, 1], [6.0, 2.5],steps,10);

	BezConic([6.0, 2.5], [7, 4], [7, 8],steps,10);

	BezConic([7, 35], [7, 39], [6.0, 40.0],steps,10);

	BezConic([6.0, 40.0], [5, 41], [1, 41],steps,10);

	BezConic([19, 41], [15, 41], [14.0, 40.0],steps,10);

	BezConic([14.0, 40.0], [13, 39], [13, 35],steps,10);

}

}

module FreeSerif_contour00x48_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x48(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x48_skeleton();
			FreeSerif_contour00x48_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x48_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x48(steps=2) {
	difference() {
		FreeSerif_contour00x48(steps);
		
	}
}

FreeSerif_bbox0x48=[[1, 0], [45, 42]];

module FreeSerif_letter0x48(detail=2) {

	FreeSerif_chunk10x48(steps=detail);

} //end skeleton



module FreeSerif_contour00x49_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[7, 7], [7.0, 21.0], [7, 35], 

		[7, 39], [6.0, 40.0], [5, 41], 

		[1, 41], [1.0, 41.5], [1, 42], 

		[10.5, 42.0], [20, 42], [20.0, 41.5], 

		[20, 41], [16, 41], [15.0, 40.0], 

		[14, 39], [14, 35], [14.0, 21.0], 

		[14, 7], [14, 3], [15.0, 2.0], 

		[16, 1], [20, 1], [20.0, 0.5], 

		[20, 0], [10.5, 0.0], [1, 0], 

		[1.0, 0.5], [1, 1], [5, 1], 

		[6.0, 2.0],[7, 3], ]);

}

module FreeSerif_contour00x49_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([7, 35], [7, 39], [6.0, 40.0],steps,10);

	BezConic([6.0, 40.0], [5, 41], [1, 41],steps,10);

	BezConic([20, 41], [16, 41], [15.0, 40.0],steps,10);

	BezConic([15.0, 40.0], [14, 39], [14, 35],steps,10);

	BezConic([14, 7], [14, 3], [15.0, 2.0],steps,10);

	BezConic([15.0, 2.0], [16, 1], [20, 1],steps,10);

	BezConic([1, 1], [5, 1], [6.0, 2.0],steps,10);

	BezConic([6.0, 2.0], [7, 3], [7, 7],steps,10);

}

}

module FreeSerif_contour00x49_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x49(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x49_skeleton();
			FreeSerif_contour00x49_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x49_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x49(steps=2) {
	difference() {
		FreeSerif_contour00x49(steps);
		
	}
}

FreeSerif_bbox0x49=[[1, 0], [20, 42]];

module FreeSerif_letter0x49(detail=2) {

	FreeSerif_chunk10x49(steps=detail);

} //end skeleton



module FreeSerif_contour00x4a_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[4, 7], [5, 7], [6.0, 6.0], 

		[7, 5], [7.0, 4.0], [7, 3], 

		[7.5, 2.5], [8, 2], [9, 2], 

		[11, 2], [11, 6], [11.0, 20.5], 

		[11, 35], [11, 39], [10.0, 40.0], 

		[9, 41], [5, 41], [5.0, 41.5], 

		[5, 42], [14.5, 42.0], [24, 42], 

		[24.0, 41.5], [24, 41], [20, 41], 

		[19.0, 40.0], [18, 39], [18, 35], 

		[18.0, 23.5], [18, 12], [18, 6], 

		[15.0, 2.5], [12, -1], [7, -1], 

		[4, -1], [2.5, 0.5], [1, 2], 

		[1, 4], [1, 5], [1.5, 6.0], 

		[2, 7], ]);

}

module FreeSerif_contour00x4a_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([7.0, 4.0], [7, 3], [7.5, 2.5],steps,10);

	BezConic([7.5, 2.5], [8, 2], [9, 2],steps,10);

	BezConic([9, 2], [11, 2], [11, 6],steps,10);

	BezConic([11, 35], [11, 39], [10.0, 40.0],steps,10);

	BezConic([10.0, 40.0], [9, 41], [5, 41],steps,10);

	BezConic([24, 41], [20, 41], [19.0, 40.0],steps,10);

	BezConic([19.0, 40.0], [18, 39], [18, 35],steps,10);

}

}

module FreeSerif_contour00x4a_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([4, 7], [5, 7], [6.0, 6.0],steps,10);

	BezConic([6.0, 6.0], [7, 5], [7.0, 4.0],steps,10);

	BezConic([18, 12], [18, 6], [15.0, 2.5],steps,10);

	BezConic([15.0, 2.5], [12, -1], [7, -1],steps,10);

	BezConic([7, -1], [4, -1], [2.5, 0.5],steps,10);

	BezConic([2.5, 0.5], [1, 2], [1, 4],steps,10);

	BezConic([1, 4], [1, 5], [1.5, 6.0],steps,10);

	BezConic([1.5, 6.0], [2, 7], [4, 7],steps,10);

}

}

module FreeSerif_contour00x4a(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x4a_skeleton();
			FreeSerif_contour00x4a_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x4a_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x4a(steps=2) {
	difference() {
		FreeSerif_contour00x4a(steps);
		
	}
}

FreeSerif_bbox0x4a=[[1, -1], [24, 42]];

module FreeSerif_letter0x4a(detail=2) {

	FreeSerif_chunk10x4a(steps=detail);

} //end skeleton



module FreeSerif_contour00x4b_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[26, 41], [26.0, 41.5], [26, 42], 

		[34.5, 42.0], [43, 42], [43.0, 41.5], 

		[43, 41], [40, 41], [38.5, 40.0], 

		[37, 39], [33, 36], [27.0, 30.0], 

		[21, 24], [28.5, 16.0], [36, 8], 

		[41, 3], [42.5, 2.0], [44, 1], 

		[46, 1], [46.0, 0.5], [46, 0], 

		[36.5, 0.0], [27, 0], [27.0, 0.5], 

		[27, 1], [28, 1], [29, 1], 

		[31, 1], [31, 3], [31, 4], 

		[29.0, 7.0], [27, 10], [23, 14], 

		[19.5, 17.0], [16, 20], [15.0, 19.5], 

		[14, 19], [14.0, 13.0], [14, 7], 

		[14, 3], [15.5, 2.0], [17, 1], 

		[20, 1], [20.0, 0.5], [20, 0], 

		[11.0, 0.0], [2, 0], [2.0, 0.5], 

		[2, 1], [6, 1], [7.0, 2.5], 

		[8, 4], [8, 8], [8.0, 21.5], 

		[8, 35], [8, 39], [7.0, 40.0], 

		[6, 41], [2, 41], [2.0, 41.5], 

		[2, 42], [11.0, 42.0], [20, 42], 

		[20.0, 41.5], [20, 41], [16, 41], 

		[15.0, 40.0], [14, 39], [14, 35], 

		[14.0, 28.5], [14, 22], [20.0, 27.5], 

		[26, 33], [31, 37], [31, 39], 

		[31, 40], [30.5, 40.5], [30, 41], 

		[28, 41],[27, 41], ]);

}

module FreeSerif_contour00x4b_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([43, 41], [40, 41], [38.5, 40.0],steps,10);

	BezConic([38.5, 40.0], [37, 39], [33, 36],steps,10);

	BezConic([36, 8], [41, 3], [42.5, 2.0],steps,10);

	BezConic([42.5, 2.0], [44, 1], [46, 1],steps,10);

	BezConic([27, 1], [28, 1], [29, 1],steps,10);

	BezConic([29, 1], [31, 1], [31, 3],steps,10);

	BezConic([31, 3], [31, 4], [29.0, 7.0],steps,10);

	BezConic([29.0, 7.0], [27, 10], [23, 14],steps,10);

	BezConic([14, 7], [14, 3], [15.5, 2.0],steps,10);

	BezConic([15.5, 2.0], [17, 1], [20, 1],steps,10);

	BezConic([2, 1], [6, 1], [7.0, 2.5],steps,10);

	BezConic([7.0, 2.5], [8, 4], [8, 8],steps,10);

	BezConic([8, 35], [8, 39], [7.0, 40.0],steps,10);

	BezConic([7.0, 40.0], [6, 41], [2, 41],steps,10);

	BezConic([20, 41], [16, 41], [15.0, 40.0],steps,10);

	BezConic([15.0, 40.0], [14, 39], [14, 35],steps,10);

	BezConic([26, 33], [31, 37], [31, 39],steps,10);

	BezConic([31, 39], [31, 40], [30.5, 40.5],steps,10);

	BezConic([30.5, 40.5], [30, 41], [28, 41],steps,10);

	BezConic([28, 41], [27, 41], [26, 41],steps,10);

}

}

module FreeSerif_contour00x4b_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x4b(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x4b_skeleton();
			FreeSerif_contour00x4b_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x4b_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x4b(steps=2) {
	difference() {
		FreeSerif_contour00x4b(steps);
		
	}
}

FreeSerif_bbox0x4b=[[2, 0], [46, 42]];

module FreeSerif_letter0x4b(detail=2) {

	FreeSerif_chunk10x4b(steps=detail);

} //end skeleton



module FreeSerif_contour00x4c_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[23, 2], [24, 2], [25.5, 2.5], 

		[27, 3], [28.0, 3.0], [29, 3], 

		[30.0, 3.5], [31, 4], [32.0, 4.5], 

		[33, 5], [33.5, 5.5], [34, 6], 

		[34.5, 6.5], [35, 7], [35.5, 8.0], 

		[36, 9], [36.0, 9.0], [36, 9], 

		[36.5, 10.0], [37, 11], [37, 11], 

		[37.5, 11.0], [38, 11], [36.5, 5.5], 

		[35, 0], [18.0, 0.0], [1, 0], 

		[1.0, 0.5], [1, 1], [4, 1], 

		[5.0, 2.5], [6, 4], [6, 7], 

		[6.0, 21.0], [6, 35], [6, 39], 

		[5.0, 40.0], [4, 41], [1, 41], 

		[1.0, 41.5], [1, 42], [10.0, 42.0], 

		[19, 42], [19.0, 41.5], [19, 41], 

		[15, 41], [14.0, 40.0], [13, 39], 

		[13, 35], [13.0, 20.0], [13, 5], 

		[13, 3], [14.0, 2.5], [15, 2], 

		[18, 2],[20.5, 2.0], ]);

}

module FreeSerif_contour00x4c_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([23, 2], [24, 2], [25.5, 2.5],steps,10);

	BezConic([28.0, 3.0], [29, 3], [30.0, 3.5],steps,10);

	BezConic([30.0, 3.5], [31, 4], [32.0, 4.5],steps,10);

	BezConic([32.0, 4.5], [33, 5], [33.5, 5.5],steps,10);

	BezConic([33.5, 5.5], [34, 6], [34.5, 6.5],steps,10);

	BezConic([34.5, 6.5], [35, 7], [35.5, 8.0],steps,10);

	BezConic([35.5, 8.0], [36, 9], [36.0, 9.0],steps,10);

	BezConic([36.0, 9.0], [36, 9], [36.5, 10.0],steps,10);

	BezConic([36.5, 10.0], [37, 11], [37, 11],steps,10);

	BezConic([1, 1], [4, 1], [5.0, 2.5],steps,10);

	BezConic([5.0, 2.5], [6, 4], [6, 7],steps,10);

	BezConic([6, 35], [6, 39], [5.0, 40.0],steps,10);

	BezConic([5.0, 40.0], [4, 41], [1, 41],steps,10);

	BezConic([19, 41], [15, 41], [14.0, 40.0],steps,10);

	BezConic([14.0, 40.0], [13, 39], [13, 35],steps,10);

	BezConic([13, 5], [13, 3], [14.0, 2.5],steps,10);

	BezConic([14.0, 2.5], [15, 2], [18, 2],steps,10);

}

}

module FreeSerif_contour00x4c_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([25.5, 2.5], [27, 3], [28.0, 3.0],steps,10);

}

}

module FreeSerif_contour00x4c(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x4c_skeleton();
			FreeSerif_contour00x4c_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x4c_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x4c(steps=2) {
	difference() {
		FreeSerif_contour00x4c(steps);
		
	}
}

FreeSerif_bbox0x4c=[[1, 0], [38, 42]];

module FreeSerif_letter0x4c(detail=2) {

	FreeSerif_chunk10x4c(steps=detail);

} //end skeleton



module FreeSerif_contour00x4d_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[43, 37], [35.0, 18.5], [27, 0], 

		[26.5, 0.0], [26, 0], [18.0, 17.5], 

		[10, 35], [10.0, 22.0], [10, 9], 

		[10, 5], [11.0, 3.0], [12, 1], 

		[16, 1], [16.0, 0.5], [16, 0], 

		[8.5, 0.0], [1, 0], [1.0, 0.5], 

		[1, 1], [5, 1], [6.0, 2.5], 

		[7, 4], [7, 9], [7.0, 22.0], 

		[7, 35], [7, 39], [6.0, 40.0], 

		[5, 41], [1, 41], [1.0, 41.5], 

		[1, 42], [7.5, 42.0], [14, 42], 

		[21.0, 26.0], [28, 10], [35.0, 26.0], 

		[42, 42], [48.5, 42.0], [55, 42], 

		[55.0, 41.5], [55, 41], [52, 41], 

		[51.0, 40.0], [50, 39], [50, 35], 

		[50.0, 21.0], [50, 7], [50, 4], 

		[51.0, 2.5], [52, 1], [55, 1], 

		[55.0, 0.5], [55, 0], [46.0, 0.0], 

		[37, 0], [37.0, 0.5], [37, 1], 

		[41, 1], [42.0, 2.5], [43, 4], 

		[43, 8],[43.0, 22.5], ]);

}

module FreeSerif_contour00x4d_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([10, 9], [10, 5], [11.0, 3.0],steps,10);

	BezConic([11.0, 3.0], [12, 1], [16, 1],steps,10);

	BezConic([1, 1], [5, 1], [6.0, 2.5],steps,10);

	BezConic([6.0, 2.5], [7, 4], [7, 9],steps,10);

	BezConic([7, 35], [7, 39], [6.0, 40.0],steps,10);

	BezConic([6.0, 40.0], [5, 41], [1, 41],steps,10);

	BezConic([55, 41], [52, 41], [51.0, 40.0],steps,10);

	BezConic([51.0, 40.0], [50, 39], [50, 35],steps,10);

	BezConic([50, 7], [50, 4], [51.0, 2.5],steps,10);

	BezConic([51.0, 2.5], [52, 1], [55, 1],steps,10);

	BezConic([37, 1], [41, 1], [42.0, 2.5],steps,10);

	BezConic([42.0, 2.5], [43, 4], [43, 8],steps,10);

}

}

module FreeSerif_contour00x4d_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x4d(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x4d_skeleton();
			FreeSerif_contour00x4d_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x4d_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x4d(steps=2) {
	difference() {
		FreeSerif_contour00x4d(steps);
		
	}
}

FreeSerif_bbox0x4d=[[1, 0], [55, 42]];

module FreeSerif_letter0x4d(detail=2) {

	FreeSerif_chunk10x4d(steps=detail);

} //end skeleton



module FreeSerif_contour00x4e_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[45, 41], [43, 41], [42.5, 41.0], 

		[42, 41], [41.0, 40.0], [40, 39], 

		[39.5, 37.5], [39, 36], [39, 33], 

		[39.0, 16.0], [39, -1], [38.5, -1.0], 

		[38, -1], [24.0, 16.5], [10, 34], 

		[10.0, 21.5], [10, 9], [10, 5], 

		[11.0, 3.0], [12, 1], [16, 1], 

		[16.0, 0.5], [16, 0], [8.5, 0.0], 

		[1, 0], [1.0, 0.5], [1, 1], 

		[5, 1], [6.0, 2.5], [7, 4], 

		[7, 9], [7.0, 23.5], [7, 38], 

		[5, 40], [4.0, 40.5], [3, 41], 

		[1, 41], [1.0, 41.5], [1, 42], 

		[6.5, 42.0], [12, 42], [24.0, 26.5], 

		[36, 11], [36.0, 22.0], [36, 33], 

		[36, 38], [35.0, 39.5], [34, 41], 

		[30, 41], [30.0, 41.5], [30, 42], 

		[37.5, 42.0], [45, 42], [45.0, 41.5], 

		 ]);

}

module FreeSerif_contour00x4e_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([45, 41], [43, 41], [42.5, 41.0],steps,10);

	BezConic([42.5, 41.0], [42, 41], [41.0, 40.0],steps,10);

	BezConic([41.0, 40.0], [40, 39], [39.5, 37.5],steps,10);

	BezConic([39.5, 37.5], [39, 36], [39, 33],steps,10);

	BezConic([10, 9], [10, 5], [11.0, 3.0],steps,10);

	BezConic([11.0, 3.0], [12, 1], [16, 1],steps,10);

	BezConic([1, 1], [5, 1], [6.0, 2.5],steps,10);

	BezConic([6.0, 2.5], [7, 4], [7, 9],steps,10);

	BezConic([7, 38], [5, 40], [4.0, 40.5],steps,10);

	BezConic([4.0, 40.5], [3, 41], [1, 41],steps,10);

	BezConic([36, 33], [36, 38], [35.0, 39.5],steps,10);

	BezConic([35.0, 39.5], [34, 41], [30, 41],steps,10);

}

}

module FreeSerif_contour00x4e_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x4e(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x4e_skeleton();
			FreeSerif_contour00x4e_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x4e_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x4e(steps=2) {
	difference() {
		FreeSerif_contour00x4e(steps);
		
	}
}

FreeSerif_bbox0x4e=[[1, -1], [45, 42]];

module FreeSerif_letter0x4e(detail=2) {

	FreeSerif_chunk10x4e(steps=detail);

} //end skeleton



module FreeSerif_contour00x4f_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[23, -1], [14, -1], [8.0, 5.0], 

		[2, 11], [2, 21], [2, 31], 

		[8.0, 37.0], [14, 43], [23, 43], 

		[32, 43], [38.0, 37.0], [44, 31], 

		[44, 21], [44, 11], [38.0, 5.0], 

		[32, -1], ]);

}

module FreeSerif_contour00x4f_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x4f_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([23, -1], [14, -1], [8.0, 5.0],steps,10);

	BezConic([8.0, 5.0], [2, 11], [2, 21],steps,10);

	BezConic([2, 21], [2, 31], [8.0, 37.0],steps,10);

	BezConic([8.0, 37.0], [14, 43], [23, 43],steps,10);

	BezConic([23, 43], [32, 43], [38.0, 37.0],steps,10);

	BezConic([38.0, 37.0], [44, 31], [44, 21],steps,10);

	BezConic([44, 21], [44, 11], [38.0, 5.0],steps,10);

	BezConic([38.0, 5.0], [32, -1], [23, -1],steps,10);

}

}

module FreeSerif_contour00x4f(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x4f_skeleton();
			FreeSerif_contour00x4f_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x4f_subtractive_curves(steps);
	}
}

module FreeSerif_contour10x4f_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[37, 21], [37, 26], [36.0, 29.5], 

		[35, 33], [33.5, 35.0], [32, 37], 

		[30.0, 38.5], [28, 40], [26.5, 40.5], 

		[25, 41], [23, 41], [20, 41], 

		[17.5, 39.5], [15, 38], [13.5, 36.0], 

		[12, 34], [11.0, 31.5], [10, 29], 

		[9.5, 26.5], [9, 24], [9, 21], 

		[9, 18], [10.0, 15.0], [11, 12], 

		[12.5, 8.5], [14, 5], [16.5, 3.0], 

		[19, 1], [23, 1], [27, 1], 

		[30.0, 3.0], [33, 5], [34.0, 8.5], 

		[35, 12], [36.0, 15.0], [37, 18], 

		 ]);

}

module FreeSerif_contour10x4f_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([37, 21], [37, 26], [36.0, 29.5],steps,10);

	BezConic([36.0, 29.5], [35, 33], [33.5, 35.0],steps,10);

	BezConic([33.5, 35.0], [32, 37], [30.0, 38.5],steps,10);

	BezConic([30.0, 38.5], [28, 40], [26.5, 40.5],steps,10);

	BezConic([26.5, 40.5], [25, 41], [23, 41],steps,10);

	BezConic([23, 41], [20, 41], [17.5, 39.5],steps,10);

	BezConic([17.5, 39.5], [15, 38], [13.5, 36.0],steps,10);

	BezConic([13.5, 36.0], [12, 34], [11.0, 31.5],steps,10);

	BezConic([11.0, 31.5], [10, 29], [9.5, 26.5],steps,10);

	BezConic([9.5, 26.5], [9, 24], [9, 21],steps,10);

	BezConic([9, 21], [9, 18], [10.0, 15.0],steps,10);

	BezConic([10.0, 15.0], [11, 12], [12.5, 8.5],steps,10);

	BezConic([12.5, 8.5], [14, 5], [16.5, 3.0],steps,10);

	BezConic([16.5, 3.0], [19, 1], [23, 1],steps,10);

	BezConic([23, 1], [27, 1], [30.0, 3.0],steps,10);

	BezConic([30.0, 3.0], [33, 5], [34.0, 8.5],steps,10);

	BezConic([36.0, 15.0], [37, 18], [37, 21],steps,10);

}

}

module FreeSerif_contour10x4f_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([34.0, 8.5], [35, 12], [36.0, 15.0],steps,10);

}

}

module FreeSerif_contour10x4f(steps=2) {
	difference() {
		union() {
			FreeSerif_contour10x4f_skeleton();
			FreeSerif_contour10x4f_subtractive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour10x4f_additive_curves(steps);
	}
}

module FreeSerif_chunk10x4f(steps=2) {
	difference() {
		FreeSerif_contour00x4f(steps);
		scale([1,1,1.1]) FreeSerif_contour10x4f(steps);
	}
}

FreeSerif_bbox0x4f=[[2, -1], [44, 43]];

module FreeSerif_letter0x4f(detail=2) {

	FreeSerif_chunk10x4f(steps=detail);

} //end skeleton



module FreeSerif_contour00x50_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[35, 31], [35, 29], [34.5, 27.5], 

		[34, 26], [33.0, 24.5], [32, 23], 

		[30.0, 21.5], [28, 20], [25.0, 19.0], 

		[22, 18], [17, 18], [15, 18], 

		[13, 19], [13.0, 13.0], [13, 7], 

		[13, 3], [14.0, 2.0], [15, 1], 

		[19, 1], [19.0, 0.5], [19, 0], 

		[10.0, 0.0], [1, 0], [1.0, 0.5], 

		[1, 1], [5, 2], [5.5, 3.0], 

		[6, 4], [6, 8], [6.0, 21.5], 

		[6, 35], [6, 39], [5.5, 40.0], 

		[5, 41], [1, 41], [1.0, 41.5], 

		[1, 42], [9.5, 42.0], [18, 42], 

		[21, 42], [23.5, 41.5], [26, 41], 

		[28.5, 40.0], [31, 39], [33.0, 36.5], 

		[35, 34], ]);

}

module FreeSerif_contour00x50_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([13, 7], [13, 3], [14.0, 2.0],steps,10);

	BezConic([14.0, 2.0], [15, 1], [19, 1],steps,10);

	BezConic([1, 1], [5, 2], [5.5, 3.0],steps,10);

	BezConic([5.5, 3.0], [6, 4], [6, 8],steps,10);

	BezConic([6, 35], [6, 39], [5.5, 40.0],steps,10);

	BezConic([5.5, 40.0], [5, 41], [1, 41],steps,10);

}

}

module FreeSerif_contour00x50_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([35, 31], [35, 29], [34.5, 27.5],steps,10);

	BezConic([34.5, 27.5], [34, 26], [33.0, 24.5],steps,10);

	BezConic([33.0, 24.5], [32, 23], [30.0, 21.5],steps,10);

	BezConic([30.0, 21.5], [28, 20], [25.0, 19.0],steps,10);

	BezConic([25.0, 19.0], [22, 18], [17, 18],steps,10);

	BezConic([17, 18], [15, 18], [13, 19],steps,10);

	BezConic([18, 42], [21, 42], [23.5, 41.5],steps,10);

	BezConic([23.5, 41.5], [26, 41], [28.5, 40.0],steps,10);

	BezConic([28.5, 40.0], [31, 39], [33.0, 36.5],steps,10);

	BezConic([33.0, 36.5], [35, 34], [35, 31],steps,10);

}

}

module FreeSerif_contour00x50(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x50_skeleton();
			FreeSerif_contour00x50_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x50_subtractive_curves(steps);
	}
}

module FreeSerif_contour10x50_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[13, 38], [13.0, 29.5], [13, 21], 

		[15, 21], [17, 21], [28, 21], 

		[28, 30], [28, 35], [25.0, 37.5], 

		[22, 40], [15, 40], [14, 40], 

		[13.5, 39.5],[13, 39], ]);

}

module FreeSerif_contour10x50_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([13, 21], [15, 21], [17, 21],steps,10);

	BezConic([17, 21], [28, 21], [28, 30],steps,10);

	BezConic([28, 30], [28, 35], [25.0, 37.5],steps,10);

	BezConic([25.0, 37.5], [22, 40], [15, 40],steps,10);

	BezConic([15, 40], [14, 40], [13.5, 39.5],steps,10);

	BezConic([13.5, 39.5], [13, 39], [13, 38],steps,10);

}

}

module FreeSerif_contour10x50_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour10x50(steps=2) {
	difference() {
		union() {
			FreeSerif_contour10x50_skeleton();
			FreeSerif_contour10x50_subtractive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour10x50_additive_curves(steps);
	}
}

module FreeSerif_chunk10x50(steps=2) {
	difference() {
		FreeSerif_contour00x50(steps);
		scale([1,1,1.1]) FreeSerif_contour10x50(steps);
	}
}

FreeSerif_bbox0x50=[[1, 0], [35, 42]];

module FreeSerif_letter0x50(detail=2) {

	FreeSerif_chunk10x50(steps=detail);

} //end skeleton



module FreeSerif_contour00x51_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[44, 21], [44, 18], [43.0, 15.0], 

		[42, 12], [41.0, 9.5], [40, 7], 

		[38.5, 5.5], [37, 4], [35.5, 3.0], 

		[34, 2], [32.0, 1.0], [30, 0], 

		[29.0, 0.0], [28, 0], [27, 0], 

		[31, -6], [35.0, -8.0], [39, -10], 

		[45, -10], [45.0, -10.5], [45, -11], 

		[44.5, -11.0], [44, -11], [44, -11], 

		[42, -11], [27, -11], [20, -4], 

		[18.5, -2.0], [17, 0], [11, 2], 

		[6.5, 7.0], [2, 12], [2, 21], 

		[2, 31], [8.0, 37.0], [14, 43], 

		[23.0, 43.0], [32, 43], [38.0, 37.0], 

		[44, 31], ]);

}

module FreeSerif_contour00x51_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([29.0, 0.0], [28, 0], [27, 0],steps,10);

	BezConic([27, 0], [31, -6], [35.0, -8.0],steps,10);

	BezConic([35.0, -8.0], [39, -10], [45, -10],steps,10);

	BezConic([44, -11], [44, -11], [42, -11],steps,10);

}

}

module FreeSerif_contour00x51_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([44, 21], [44, 18], [43.0, 15.0],steps,10);

	BezConic([43.0, 15.0], [42, 12], [41.0, 9.5],steps,10);

	BezConic([41.0, 9.5], [40, 7], [38.5, 5.5],steps,10);

	BezConic([38.5, 5.5], [37, 4], [35.5, 3.0],steps,10);

	BezConic([35.5, 3.0], [34, 2], [32.0, 1.0],steps,10);

	BezConic([32.0, 1.0], [30, 0], [29.0, 0.0],steps,10);

	BezConic([42, -11], [27, -11], [20, -4],steps,10);

	BezConic([17, 0], [11, 2], [6.5, 7.0],steps,10);

	BezConic([6.5, 7.0], [2, 12], [2, 21],steps,10);

	BezConic([2, 21], [2, 31], [8.0, 37.0],steps,10);

	BezConic([8.0, 37.0], [14, 43], [23.0, 43.0],steps,10);

	BezConic([23.0, 43.0], [32, 43], [38.0, 37.0],steps,10);

	BezConic([38.0, 37.0], [44, 31], [44, 21],steps,10);

}

}

module FreeSerif_contour00x51(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x51_skeleton();
			FreeSerif_contour00x51_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x51_subtractive_curves(steps);
	}
}

module FreeSerif_contour10x51_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[37, 21], [37, 30], [33.0, 35.5], 

		[29, 41], [23, 41], [20, 41], 

		[17.5, 39.5], [15, 38], [13.5, 36.0], 

		[12, 34], [11.0, 31.5], [10, 29], 

		[9.5, 26.5], [9, 24], [9, 21], 

		[9, 16], [10.5, 12.0], [12, 8], 

		[14.0, 5.5], [16, 3], [18.5, 2.0], 

		[21, 1], [23, 1], [26, 1], 

		[28.5, 2.5], [31, 4], [32.5, 6.0], 

		[34, 8], [35.0, 11.0], [36, 14], 

		[36.5, 16.5],[37, 19], ]);

}

module FreeSerif_contour10x51_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([37, 21], [37, 30], [33.0, 35.5],steps,10);

	BezConic([33.0, 35.5], [29, 41], [23, 41],steps,10);

	BezConic([23, 41], [20, 41], [17.5, 39.5],steps,10);

	BezConic([17.5, 39.5], [15, 38], [13.5, 36.0],steps,10);

	BezConic([13.5, 36.0], [12, 34], [11.0, 31.5],steps,10);

	BezConic([11.0, 31.5], [10, 29], [9.5, 26.5],steps,10);

	BezConic([9.5, 26.5], [9, 24], [9, 21],steps,10);

	BezConic([9, 21], [9, 16], [10.5, 12.0],steps,10);

	BezConic([10.5, 12.0], [12, 8], [14.0, 5.5],steps,10);

	BezConic([14.0, 5.5], [16, 3], [18.5, 2.0],steps,10);

	BezConic([18.5, 2.0], [21, 1], [23, 1],steps,10);

	BezConic([23, 1], [26, 1], [28.5, 2.5],steps,10);

	BezConic([28.5, 2.5], [31, 4], [32.5, 6.0],steps,10);

	BezConic([32.5, 6.0], [34, 8], [35.0, 11.0],steps,10);

	BezConic([35.0, 11.0], [36, 14], [36.5, 16.5],steps,10);

	BezConic([36.5, 16.5], [37, 19], [37, 21],steps,10);

}

}

module FreeSerif_contour10x51_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour10x51(steps=2) {
	difference() {
		union() {
			FreeSerif_contour10x51_skeleton();
			FreeSerif_contour10x51_subtractive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour10x51_additive_curves(steps);
	}
}

module FreeSerif_chunk10x51(steps=2) {
	difference() {
		FreeSerif_contour00x51(steps);
		scale([1,1,1.1]) FreeSerif_contour10x51(steps);
	}
}

FreeSerif_bbox0x51=[[2, -11], [45, 43]];

module FreeSerif_letter0x51(detail=2) {

	FreeSerif_chunk10x51(steps=detail);

} //end skeleton



module FreeSerif_contour00x52_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[19, 42], [22, 42], [24.0, 41.5], 

		[26, 41], [29.0, 40.0], [32, 39], 

		[33.5, 36.5], [35, 34], [35, 31], 

		[35, 23], [24, 20], [24, 20], 

		[23, 20], [30.0, 12.0], [37, 4], 

		[38, 3], [39.0, 2.0], [40, 1], 

		[42, 1], [42.0, 0.5], [42, 0], 

		[37.0, 0.0], [32, 0], [24.5, 10.0], 

		[17, 20], [15.0, 20.0], [13, 20], 

		[13.0, 13.5], [13, 7], [13, 4], 

		[14.0, 2.5], [15, 1], [19, 1], 

		[19.0, 0.5], [19, 0], [10.0, 0.0], 

		[1, 0], [1.0, 0.5], [1, 1], 

		[5, 1], [6.0, 2.5], [7, 4], 

		[7, 8], [7.0, 21.5], [7, 35], 

		[7, 39], [6.0, 40.0], [5, 41], 

		[1, 41], [1.0, 41.5], [1, 42], 

		[10.0, 42.0], ]);

}

module FreeSerif_contour00x52_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([24, 20], [24, 20], [23, 20],steps,10);

	BezConic([37, 4], [38, 3], [39.0, 2.0],steps,10);

	BezConic([39.0, 2.0], [40, 1], [42, 1],steps,10);

	BezConic([13, 7], [13, 4], [14.0, 2.5],steps,10);

	BezConic([14.0, 2.5], [15, 1], [19, 1],steps,10);

	BezConic([1, 1], [5, 1], [6.0, 2.5],steps,10);

	BezConic([6.0, 2.5], [7, 4], [7, 8],steps,10);

	BezConic([7, 35], [7, 39], [6.0, 40.0],steps,10);

	BezConic([6.0, 40.0], [5, 41], [1, 41],steps,10);

}

}

module FreeSerif_contour00x52_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([19, 42], [22, 42], [24.0, 41.5],steps,10);

	BezConic([24.0, 41.5], [26, 41], [29.0, 40.0],steps,10);

	BezConic([29.0, 40.0], [32, 39], [33.5, 36.5],steps,10);

	BezConic([33.5, 36.5], [35, 34], [35, 31],steps,10);

	BezConic([35, 31], [35, 23], [24, 20],steps,10);

}

}

module FreeSerif_contour00x52(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x52_skeleton();
			FreeSerif_contour00x52_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x52_subtractive_curves(steps);
	}
}

module FreeSerif_contour10x52_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[13, 22], [21, 22], [24.5, 24.0], 

		[28, 26], [28, 31], [28, 36], 

		[25.0, 38.0], [22, 40], [16, 40], 

		[14, 40], [13.5, 39.5], [13, 39], 

		[13, 38],[13.0, 30.0], ]);

}

module FreeSerif_contour10x52_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([13, 22], [21, 22], [24.5, 24.0],steps,10);

	BezConic([24.5, 24.0], [28, 26], [28, 31],steps,10);

	BezConic([28, 31], [28, 36], [25.0, 38.0],steps,10);

	BezConic([25.0, 38.0], [22, 40], [16, 40],steps,10);

	BezConic([16, 40], [14, 40], [13.5, 39.5],steps,10);

	BezConic([13.5, 39.5], [13, 39], [13, 38],steps,10);

}

}

module FreeSerif_contour10x52_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour10x52(steps=2) {
	difference() {
		union() {
			FreeSerif_contour10x52_skeleton();
			FreeSerif_contour10x52_subtractive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour10x52_additive_curves(steps);
	}
}

module FreeSerif_chunk10x52(steps=2) {
	difference() {
		FreeSerif_contour00x52(steps);
		scale([1,1,1.1]) FreeSerif_contour10x52(steps);
	}
}

FreeSerif_bbox0x52=[[1, 0], [42, 42]];

module FreeSerif_letter0x52(detail=2) {

	FreeSerif_chunk10x52(steps=detail);

} //end skeleton



module FreeSerif_contour00x53_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[25, 9], [25, 12], [23.0, 14.0], 

		[21, 16], [18.0, 18.0], [15, 20], 

		[12.0, 21.5], [9, 23], [7.0, 26.0], 

		[5, 29], [5, 32], [5, 37], 

		[8.0, 40.0], [11, 43], [16, 43], 

		[18, 43], [21.5, 42.0], [25, 41], 

		[25, 41], [27, 41], [27, 43], 

		[28.0, 43.0], [29, 43], [29.5, 36.5], 

		[30, 30], [29.0, 30.0], [28, 30], 

		[27, 35], [24.0, 38.0], [21, 41], 

		[17, 41], [14, 41], [12.0, 39.0], 

		[10, 37], [10, 35], [10, 32], 

		[12.0, 30.0], [14, 28], [19, 25], 

		[26, 21], [28.5, 18.0], [31, 15], 

		[31, 11], [31, 6], [27.5, 2.5], 

		[24, -1], [18, -1], [15, -1], 

		[12.0, 0.0], [9, 1], [8, 1], 

		[7, 1], [6.5, 0.5], [6, 0], 

		[6, -1], [5.5, -1.0], [5, -1], 

		[4.0, 6.0], [3, 13], [3.5, 13.0], 

		[4, 13], [7, 7], [10.0, 4.0], 

		[13, 1], [17, 1], [21, 1], 

		[23.0, 3.0],[25, 5], ]);

}

module FreeSerif_contour00x53_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([25, 9], [25, 12], [23.0, 14.0],steps,10);

	BezConic([23.0, 14.0], [21, 16], [18.0, 18.0],steps,10);

	BezConic([18.0, 18.0], [15, 20], [12.0, 21.5],steps,10);

	BezConic([21.5, 42.0], [25, 41], [25, 41],steps,10);

	BezConic([25, 41], [27, 41], [27, 43],steps,10);

	BezConic([28, 30], [27, 35], [24.0, 38.0],steps,10);

	BezConic([24.0, 38.0], [21, 41], [17, 41],steps,10);

	BezConic([17, 41], [14, 41], [12.0, 39.0],steps,10);

	BezConic([12.0, 39.0], [10, 37], [10, 35],steps,10);

	BezConic([10, 35], [10, 32], [12.0, 30.0],steps,10);

	BezConic([12.0, 30.0], [14, 28], [19, 25],steps,10);

	BezConic([12.0, 0.0], [9, 1], [8, 1],steps,10);

	BezConic([8, 1], [7, 1], [6.5, 0.5],steps,10);

	BezConic([6.5, 0.5], [6, 0], [6, -1],steps,10);

	BezConic([4, 13], [7, 7], [10.0, 4.0],steps,10);

	BezConic([10.0, 4.0], [13, 1], [17, 1],steps,10);

	BezConic([17, 1], [21, 1], [23.0, 3.0],steps,10);

	BezConic([23.0, 3.0], [25, 5], [25, 9],steps,10);

}

}

module FreeSerif_contour00x53_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([12.0, 21.5], [9, 23], [7.0, 26.0],steps,10);

	BezConic([7.0, 26.0], [5, 29], [5, 32],steps,10);

	BezConic([5, 32], [5, 37], [8.0, 40.0],steps,10);

	BezConic([8.0, 40.0], [11, 43], [16, 43],steps,10);

	BezConic([16, 43], [18, 43], [21.5, 42.0],steps,10);

	BezConic([19, 25], [26, 21], [28.5, 18.0],steps,10);

	BezConic([28.5, 18.0], [31, 15], [31, 11],steps,10);

	BezConic([31, 11], [31, 6], [27.5, 2.5],steps,10);

	BezConic([27.5, 2.5], [24, -1], [18, -1],steps,10);

	BezConic([18, -1], [15, -1], [12.0, 0.0],steps,10);

}

}

module FreeSerif_contour00x53(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x53_skeleton();
			FreeSerif_contour00x53_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x53_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x53(steps=2) {
	difference() {
		FreeSerif_contour00x53(steps);
		
	}
}

FreeSerif_bbox0x53=[[3, -1], [31, 43]];

module FreeSerif_letter0x53(detail=2) {

	FreeSerif_chunk10x53(steps=detail);

} //end skeleton



module FreeSerif_contour00x54_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[16, 40], [14.5, 40.0], [13, 40], 

		[7, 40], [5.5, 38.5], [4, 37], 

		[3, 31], [2.0, 31.0], [1, 31], 

		[1.0, 36.5], [1, 42], [19.5, 42.0], 

		[38, 42], [38.0, 36.5], [38, 31], 

		[37.0, 31.0], [36, 31], [35, 37], 

		[33.5, 38.5], [32, 40], [26, 40], 

		[24.5, 40.0], [23, 40], [23.0, 23.5], 

		[23, 7], [23, 3], [24.0, 2.0], 

		[25, 1], [29, 1], [29.0, 0.5], 

		[29, 0], [19.5, 0.0], [10, 0], 

		[10.0, 0.5], [10, 1], [14, 1], 

		[15.0, 2.5], [16, 4], [16, 8], 

		[16.0, 24.0], ]);

}

module FreeSerif_contour00x54_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([13, 40], [7, 40], [5.5, 38.5],steps,10);

	BezConic([5.5, 38.5], [4, 37], [3, 31],steps,10);

	BezConic([36, 31], [35, 37], [33.5, 38.5],steps,10);

	BezConic([33.5, 38.5], [32, 40], [26, 40],steps,10);

	BezConic([23, 7], [23, 3], [24.0, 2.0],steps,10);

	BezConic([24.0, 2.0], [25, 1], [29, 1],steps,10);

	BezConic([10, 1], [14, 1], [15.0, 2.5],steps,10);

	BezConic([15.0, 2.5], [16, 4], [16, 8],steps,10);

}

}

module FreeSerif_contour00x54_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x54(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x54_skeleton();
			FreeSerif_contour00x54_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x54_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x54(steps=2) {
	difference() {
		FreeSerif_contour00x54(steps);
		
	}
}

FreeSerif_bbox0x54=[[1, 0], [38, 42]];

module FreeSerif_letter0x54(detail=2) {

	FreeSerif_chunk10x54(steps=detail);

} //end skeleton



module FreeSerif_contour00x55_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[13, 15], [13, 9], [15.5, 5.5], 

		[18, 2], [24, 2], [28, 2], 

		[31.0, 3.5], [34, 5], [35, 7], 

		[36, 10], [36, 16], [36.0, 24.5], 

		[36, 33], [36, 38], [35.0, 39.5], 

		[34, 41], [30, 41], [30.0, 41.5], 

		[30, 42], [37.5, 42.0], [45, 42], 

		[45.0, 41.5], [45, 41], [41, 41], 

		[40.0, 39.5], [39, 38], [39, 33], 

		[39.0, 24.5], [39, 16], [39, 12], 

		[38.5, 9.5], [38, 7], [36.0, 4.5], 

		[34, 2], [31.0, 0.5], [28, -1], 

		[23, -1], [15, -1], [11.0, 3.0], 

		[7, 7], [7, 15], [7.0, 25.0], 

		[7, 35], [7, 39], [6.0, 40.0], 

		[5, 41], [1, 41], [1.0, 41.5], 

		[1, 42], [10.0, 42.0], [19, 42], 

		[19.0, 41.5], [19, 41], [15, 41], 

		[14.0, 40.0], [13, 39], [13, 35], 

		[13.0, 25.0], ]);

}

module FreeSerif_contour00x55_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([13, 15], [13, 9], [15.5, 5.5],steps,10);

	BezConic([15.5, 5.5], [18, 2], [24, 2],steps,10);

	BezConic([24, 2], [28, 2], [31.0, 3.5],steps,10);

	BezConic([31.0, 3.5], [34, 5], [35, 7],steps,10);

	BezConic([35, 7], [36, 10], [36, 16],steps,10);

	BezConic([36, 33], [36, 38], [35.0, 39.5],steps,10);

	BezConic([35.0, 39.5], [34, 41], [30, 41],steps,10);

	BezConic([45, 41], [41, 41], [40.0, 39.5],steps,10);

	BezConic([40.0, 39.5], [39, 38], [39, 33],steps,10);

	BezConic([7, 35], [7, 39], [6.0, 40.0],steps,10);

	BezConic([6.0, 40.0], [5, 41], [1, 41],steps,10);

	BezConic([19, 41], [15, 41], [14.0, 40.0],steps,10);

	BezConic([14.0, 40.0], [13, 39], [13, 35],steps,10);

}

}

module FreeSerif_contour00x55_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([39, 16], [39, 12], [38.5, 9.5],steps,10);

	BezConic([38.5, 9.5], [38, 7], [36.0, 4.5],steps,10);

	BezConic([36.0, 4.5], [34, 2], [31.0, 0.5],steps,10);

	BezConic([31.0, 0.5], [28, -1], [23, -1],steps,10);

	BezConic([23, -1], [15, -1], [11.0, 3.0],steps,10);

	BezConic([11.0, 3.0], [7, 7], [7, 15],steps,10);

}

}

module FreeSerif_contour00x55(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x55_skeleton();
			FreeSerif_contour00x55_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x55_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x55(steps=2) {
	difference() {
		FreeSerif_contour00x55(steps);
		
	}
}

FreeSerif_bbox0x55=[[1, -1], [45, 42]];

module FreeSerif_letter0x55(detail=2) {

	FreeSerif_chunk10x55(steps=detail);

} //end skeleton



module FreeSerif_contour00x56_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[45, 42], [45.0, 41.5], [45, 41], 

		[42, 41], [41.0, 40.0], [40, 39], 

		[39, 35], [32.0, 17.0], [25, -1], 

		[24.5, -1.0], [24, -1], [16.0, 16.5], 

		[8, 34], [6, 39], [4.5, 40.0], 

		[3, 41], [1, 41], [1.0, 41.5], 

		[1, 42], [9.5, 42.0], [18, 42], 

		[18.0, 41.5], [18, 41], [16, 41], 

		[16, 41], [13, 41], [13, 39], 

		[13, 38], [16, 32], [21.0, 21.0], 

		[26, 10], [30.5, 22.0], [35, 34], 

		[36, 37], [36, 38], [36, 40], 

		[35.0, 40.5], [34, 41], [31, 41], 

		[31.0, 41.5], [31, 42], [38.0, 42.0], 

		 ]);

}

module FreeSerif_contour00x56_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([45, 41], [42, 41], [41.0, 40.0],steps,10);

	BezConic([41.0, 40.0], [40, 39], [39, 35],steps,10);

	BezConic([8, 34], [6, 39], [4.5, 40.0],steps,10);

	BezConic([4.5, 40.0], [3, 41], [1, 41],steps,10);

	BezConic([18, 41], [16, 41], [16, 41],steps,10);

	BezConic([16, 41], [13, 41], [13, 39],steps,10);

	BezConic([13, 39], [13, 38], [16, 32],steps,10);

	BezConic([35, 34], [36, 37], [36, 38],steps,10);

	BezConic([36, 38], [36, 40], [35.0, 40.5],steps,10);

	BezConic([35.0, 40.5], [34, 41], [31, 41],steps,10);

}

}

module FreeSerif_contour00x56_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x56(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x56_skeleton();
			FreeSerif_contour00x56_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x56_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x56(steps=2) {
	difference() {
		FreeSerif_contour00x56(steps);
		
	}
}

FreeSerif_bbox0x56=[[1, -1], [45, 42]];

module FreeSerif_letter0x56(detail=2) {

	FreeSerif_chunk10x56(steps=detail);

} //end skeleton



module FreeSerif_contour00x57_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[60, 42], [60.0, 41.5], [60, 41], 

		[57, 41], [56.0, 40.0], [55, 39], 

		[54, 37], [49, 22], [47.0, 17.0], 

		[45, 12], [41, -1], [40.5, -1.0], 

		[40, -1], [35.0, 12.5], [30, 26], 

		[25.0, 12.5], [20, -1], [19.5, -1.0], 

		[19, -1], [13.0, 16.5], [7, 34], 

		[5, 38], [4.0, 39.5], [3, 41], 

		[0, 41], [0.0, 41.5], [0, 42], 

		[8.0, 42.0], [16, 42], [16.0, 41.5], 

		[16, 41], [14, 41], [13.0, 40.5], 

		[12, 40], [12, 39], [12, 38], 

		[13, 36], [17.5, 24.0], [22, 12], 

		[25.5, 21.0], [29, 30], [27.5, 32.5], 

		[26, 35], [25, 39], [24.0, 40.0], 

		[23, 41], [20, 41], [20.0, 41.5], 

		[20, 42], [28.5, 42.0], [37, 42], 

		[37.0, 41.5], [37, 41], [32, 41], 

		[32, 39], [32, 38], [34, 34], 

		[38.0, 23.0], [42, 12], [46.0, 23.0], 

		[50, 34], [51, 36], [51, 38], 

		[51, 40], [50.0, 40.5], [49, 41], 

		[47, 41], [47.0, 41.5], [47, 42], 

		[53.5, 42.0], ]);

}

module FreeSerif_contour00x57_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([60, 41], [57, 41], [56.0, 40.0],steps,10);

	BezConic([56.0, 40.0], [55, 39], [54, 37],steps,10);

	BezConic([47.0, 17.0], [45, 12], [41, -1],steps,10);

	BezConic([7, 34], [5, 38], [4.0, 39.5],steps,10);

	BezConic([4.0, 39.5], [3, 41], [0, 41],steps,10);

	BezConic([16, 41], [14, 41], [13.0, 40.5],steps,10);

	BezConic([13.0, 40.5], [12, 40], [12, 39],steps,10);

	BezConic([12, 39], [12, 38], [13, 36],steps,10);

	BezConic([26, 35], [25, 39], [24.0, 40.0],steps,10);

	BezConic([24.0, 40.0], [23, 41], [20, 41],steps,10);

	BezConic([37, 41], [32, 41], [32, 39],steps,10);

	BezConic([32, 39], [32, 38], [34, 34],steps,10);

	BezConic([50, 34], [51, 36], [51, 38],steps,10);

	BezConic([51, 38], [51, 40], [50.0, 40.5],steps,10);

	BezConic([50.0, 40.5], [49, 41], [47, 41],steps,10);

}

}

module FreeSerif_contour00x57_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([54, 37], [49, 22], [47.0, 17.0],steps,10);

}

}

module FreeSerif_contour00x57(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x57_skeleton();
			FreeSerif_contour00x57_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x57_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x57(steps=2) {
	difference() {
		FreeSerif_contour00x57(steps);
		
	}
}

FreeSerif_bbox0x57=[[0, -1], [60, 42]];

module FreeSerif_letter0x57(detail=2) {

	FreeSerif_chunk10x57(steps=detail);

} //end skeleton



module FreeSerif_contour00x58_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[45, 42], [45.0, 41.5], [45, 41], 

		[41, 41], [39.5, 40.0], [38, 39], 

		[35, 35], [30.5, 29.0], [26, 23], 

		[32.0, 14.5], [38, 6], [40, 3], 

		[41.0, 2.5], [42, 2], [45, 1], 

		[45.0, 0.5], [45, 0], [35.5, 0.0], 

		[26, 0], [26.0, 0.5], [26, 1], 

		[28, 1], [28, 1], [31, 1], 

		[31, 3], [31, 5], [28, 9], 

		[25.0, 13.5], [22, 18], [18.0, 13.5], 

		[14, 9], [11, 5], [11, 3], 

		[11, 2], [12.0, 1.5], [13, 1], 

		[16, 1], [16.0, 0.5], [16, 0], 

		[8.5, 0.0], [1, 0], [1.0, 0.5], 

		[1, 1], [3, 1], [4.5, 2.0], 

		[6, 3], [10, 9], [15.0, 15.0], 

		[20, 21], [16.5, 26.0], [13, 31], 

		[9, 38], [7.0, 39.5], [5, 41], 

		[1, 41], [1.0, 41.5], [1, 42], 

		[11.0, 42.0], [21, 42], [21.0, 41.5], 

		[21, 41], [20.0, 41.0], [19, 41], 

		[16, 41], [16, 39], [16, 37], 

		[21, 30], [22.5, 28.0], [24, 26], 

		[27.5, 30.5], [31, 35], [34, 38], 

		[34, 39], [34, 40], [33.0, 40.5], 

		[32, 41], [29, 41], [29.0, 41.5], 

		[29, 42],[37.0, 42.0], ]);

}

module FreeSerif_contour00x58_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([45, 41], [41, 41], [39.5, 40.0],steps,10);

	BezConic([39.5, 40.0], [38, 39], [35, 35],steps,10);

	BezConic([38, 6], [40, 3], [41.0, 2.5],steps,10);

	BezConic([41.0, 2.5], [42, 2], [45, 1],steps,10);

	BezConic([26, 1], [28, 1], [28, 1],steps,10);

	BezConic([28, 1], [31, 1], [31, 3],steps,10);

	BezConic([31, 3], [31, 5], [28, 9],steps,10);

	BezConic([14, 9], [11, 5], [11, 3],steps,10);

	BezConic([11, 3], [11, 2], [12.0, 1.5],steps,10);

	BezConic([12.0, 1.5], [13, 1], [16, 1],steps,10);

	BezConic([1, 1], [3, 1], [4.5, 2.0],steps,10);

	BezConic([4.5, 2.0], [6, 3], [10, 9],steps,10);

	BezConic([13, 31], [9, 38], [7.0, 39.5],steps,10);

	BezConic([7.0, 39.5], [5, 41], [1, 41],steps,10);

	BezConic([19, 41], [16, 41], [16, 39],steps,10);

	BezConic([16, 39], [16, 37], [21, 30],steps,10);

	BezConic([31, 35], [34, 38], [34, 39],steps,10);

	BezConic([34, 39], [34, 40], [33.0, 40.5],steps,10);

	BezConic([33.0, 40.5], [32, 41], [29, 41],steps,10);

}

}

module FreeSerif_contour00x58_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x58(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x58_skeleton();
			FreeSerif_contour00x58_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x58_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x58(steps=2) {
	difference() {
		FreeSerif_contour00x58(steps);
		
	}
}

FreeSerif_bbox0x58=[[1, 0], [45, 42]];

module FreeSerif_letter0x58(detail=2) {

	FreeSerif_chunk10x58(steps=detail);

} //end skeleton



module FreeSerif_contour00x59_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[45, 42], [45.0, 41.5], [45, 41], 

		[42, 41], [40.5, 39.5], [39, 38], 

		[36, 34], [31.5, 26.5], [27, 19], 

		[27.0, 13.0], [27, 7], [27, 3], 

		[28.0, 2.0], [29, 1], [33, 1], 

		[33.0, 0.5], [33, 0], [23.5, 0.0], 

		[14, 0], [14.0, 0.5], [14, 1], 

		[18, 1], [19.0, 2.5], [20, 4], 

		[20, 8], [20.0, 13.5], [20, 19], 

		[16.0, 25.0], [12, 31], [9, 36], 

		[7.0, 38.0], [5, 40], [4.0, 40.5], 

		[3, 41], [1, 41], [1.0, 41.5], 

		[1, 42], [10.0, 42.0], [19, 42], 

		[19.0, 41.5], [19, 41], [19, 41], 

		[18, 41], [15, 41], [15, 39], 

		[15, 38], [16, 36], [20.5, 29.0], 

		[25, 22], [29.5, 29.5], [34, 37], 

		[35, 38], [35, 39], [35, 40], 

		[34.0, 40.5], [33, 41], [31, 41], 

		[31.0, 41.5], [31, 42], [38.0, 42.0], 

		 ]);

}

module FreeSerif_contour00x59_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([45, 41], [42, 41], [40.5, 39.5],steps,10);

	BezConic([40.5, 39.5], [39, 38], [36, 34],steps,10);

	BezConic([27, 7], [27, 3], [28.0, 2.0],steps,10);

	BezConic([28.0, 2.0], [29, 1], [33, 1],steps,10);

	BezConic([14, 1], [18, 1], [19.0, 2.5],steps,10);

	BezConic([19.0, 2.5], [20, 4], [20, 8],steps,10);

	BezConic([12, 31], [9, 36], [7.0, 38.0],steps,10);

	BezConic([7.0, 38.0], [5, 40], [4.0, 40.5],steps,10);

	BezConic([4.0, 40.5], [3, 41], [1, 41],steps,10);

	BezConic([19, 41], [19, 41], [18, 41],steps,10);

	BezConic([18, 41], [15, 41], [15, 39],steps,10);

	BezConic([15, 39], [15, 38], [16, 36],steps,10);

	BezConic([34, 37], [35, 38], [35, 39],steps,10);

	BezConic([35, 39], [35, 40], [34.0, 40.5],steps,10);

	BezConic([34.0, 40.5], [33, 41], [31, 41],steps,10);

}

}

module FreeSerif_contour00x59_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x59(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x59_skeleton();
			FreeSerif_contour00x59_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x59_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x59(steps=2) {
	difference() {
		FreeSerif_contour00x59(steps);
		
	}
}

FreeSerif_bbox0x59=[[1, 0], [45, 42]];

module FreeSerif_letter0x59(detail=2) {

	FreeSerif_chunk10x59(steps=detail);

} //end skeleton



module FreeSerif_contour00x5a_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[26, 2], [28, 2], [29.0, 2.5], 

		[30, 3], [31.0, 3.5], [32, 4], 

		[33.0, 5.0], [34, 6], [34.5, 6.0], 

		[35, 6], [35.5, 7.5], [36, 9], 

		[36.0, 9.5], [36, 10], [37, 11], 

		[37.5, 11.0], [38, 11], [37.5, 5.5], 

		[37, 0], [19.0, 0.0], [1, 0], 

		[1.0, 0.5], [1, 1], [15.0, 20.5], 

		[29, 40], [21.5, 40.0], [14, 40], 

		[11, 40], [9.0, 39.5], [7, 39], 

		[6.0, 37.5], [5, 36], [4.5, 35.0], 

		[4, 34], [4, 31], [3.0, 31.0], 

		[2, 31], [2.5, 36.5], [3, 42], 

		[20.0, 42.0], [37, 42], [37.0, 41.5], 

		[37, 41], [23.0, 21.5], [9, 2], 

		[17.5, 2.0], ]);

}

module FreeSerif_contour00x5a_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([26, 2], [28, 2], [29.0, 2.5],steps,10);

	BezConic([29.0, 2.5], [30, 3], [31.0, 3.5],steps,10);

	BezConic([31.0, 3.5], [32, 4], [33.0, 5.0],steps,10);

	BezConic([34.5, 6.0], [35, 6], [35.5, 7.5],steps,10);

	BezConic([35.5, 7.5], [36, 9], [36.0, 9.5],steps,10);

	BezConic([14, 40], [11, 40], [9.0, 39.5],steps,10);

	BezConic([9.0, 39.5], [7, 39], [6.0, 37.5],steps,10);

	BezConic([6.0, 37.5], [5, 36], [4.5, 35.0],steps,10);

	BezConic([4.5, 35.0], [4, 34], [4, 31],steps,10);

}

}

module FreeSerif_contour00x5a_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([33.0, 5.0], [34, 6], [34.5, 6.0],steps,10);

	BezConic([36.0, 9.5], [36, 10], [37, 11],steps,10);

}

}

module FreeSerif_contour00x5a(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x5a_skeleton();
			FreeSerif_contour00x5a_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x5a_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x5a(steps=2) {
	difference() {
		FreeSerif_contour00x5a(steps);
		
	}
}

FreeSerif_bbox0x5a=[[1, 0], [38, 42]];

module FreeSerif_letter0x5a(detail=2) {

	FreeSerif_chunk10x5a(steps=detail);

} //end skeleton



module FreeSerif_contour00x5b_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[19, -8], [19.0, -9.0], [19, -10], 

		[12.5, -10.0], [6, -10], [6.0, 16.0], 

		[6, 42], [12.5, 42.0], [19, 42], 

		[19.0, 41.5], [19, 41], [16.0, 41.0], 

		[13, 41], [12, 41], [11.0, 40.0], 

		[10, 39], [10, 38], [10.0, 16.5], 

		[10, -5], [10, -8], [14, -8], 

		[16.5, -8.0], ]);

}

module FreeSerif_contour00x5b_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([13, 41], [12, 41], [11.0, 40.0],steps,10);

	BezConic([11.0, 40.0], [10, 39], [10, 38],steps,10);

	BezConic([10, -5], [10, -8], [14, -8],steps,10);

}

}

module FreeSerif_contour00x5b_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x5b(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x5b_skeleton();
			FreeSerif_contour00x5b_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x5b_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x5b(steps=2) {
	difference() {
		FreeSerif_contour00x5b(steps);
		
	}
}

FreeSerif_bbox0x5b=[[6, -10], [19, 42]];

module FreeSerif_letter0x5b(detail=2) {

	FreeSerif_chunk10x5b(steps=detail);

} //end skeleton



module FreeSerif_contour00x5c_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[-1, 43], [1.5, 43.0], [4, 43], 

		[11.0, 21.0], [18, -1], [16.0, -1.0], 

		[14, -1],[6.5, 21.0], ]);

}

module FreeSerif_contour00x5c_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x5c_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x5c(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x5c_skeleton();
			FreeSerif_contour00x5c_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x5c_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x5c(steps=2) {
	difference() {
		FreeSerif_contour00x5c(steps);
		
	}
}

FreeSerif_bbox0x5c=[[-1, -1], [18, 43]];

module FreeSerif_letter0x5c(detail=2) {

	FreeSerif_chunk10x5c(steps=detail);

} //end skeleton



module FreeSerif_contour00x5d_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[2, -8], [5.0, -8.0], [8, -8], 

		[11, -8], [11, -6], [11.0, 15.5], 

		[11, 37], [11, 41], [8, 41], 

		[5.0, 41.0], [2, 41], [2.0, 41.5], 

		[2, 42], [9.0, 42.0], [16, 42], 

		[16.0, 16.0], [16, -10], [9.0, -10.0], 

		[2, -10],[2.0, -9.0], ]);

}

module FreeSerif_contour00x5d_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([8, -8], [11, -8], [11, -6],steps,10);

	BezConic([11, 37], [11, 41], [8, 41],steps,10);

}

}

module FreeSerif_contour00x5d_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x5d(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x5d_skeleton();
			FreeSerif_contour00x5d_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x5d_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x5d(steps=2) {
	difference() {
		FreeSerif_contour00x5d(steps);
		
	}
}

FreeSerif_bbox0x5d=[[2, -10], [16, 42]];

module FreeSerif_letter0x5d(detail=2) {

	FreeSerif_chunk10x5d(steps=detail);

} //end skeleton



module FreeSerif_contour00x5e_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[6, 19], [4.0, 19.0], [2, 19], 

		[7.5, 30.5], [13, 42], [15.0, 42.0], 

		[17, 42], [23.0, 30.5], [29, 19], 

		[26.5, 19.0], [24, 19], [19.5, 28.5], 

		[15, 38],[10.5, 28.5], ]);

}

module FreeSerif_contour00x5e_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x5e_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x5e(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x5e_skeleton();
			FreeSerif_contour00x5e_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x5e_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x5e(steps=2) {
	difference() {
		FreeSerif_contour00x5e(steps);
		
	}
}

FreeSerif_bbox0x5e=[[2, 19], [29, 42]];

module FreeSerif_letter0x5e(detail=2) {

	FreeSerif_chunk10x5e(steps=detail);

} //end skeleton



module FreeSerif_contour00x5f_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[32, -8], [16.0, -8.0], [0, -8], 

		[0.0, -6.5], [0, -5], [16.0, -5.0], 

		[32, -5],[32.0, -6.5], ]);

}

module FreeSerif_contour00x5f_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x5f_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x5f(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x5f_skeleton();
			FreeSerif_contour00x5f_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x5f_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x5f(steps=2) {
	difference() {
		FreeSerif_contour00x5f(steps);
		
	}
}

FreeSerif_bbox0x5f=[[0, -8], [32, -5]];

module FreeSerif_letter0x5f(detail=2) {

	FreeSerif_chunk10x5f(steps=detail);

} //end skeleton



module FreeSerif_contour00x60_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[15, 32], [14.0, 32.0], [13, 32], 

		[8.0, 35.5], [3, 39], [1, 40], 

		[1, 41], [1, 43], [3, 43], 

		[5, 43], [6, 42], [10.5, 37.0], 

		 ]);

}

module FreeSerif_contour00x60_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x60_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([3, 39], [1, 40], [1, 41],steps,10);

	BezConic([1, 41], [1, 43], [3, 43],steps,10);

	BezConic([3, 43], [5, 43], [6, 42],steps,10);

}

}

module FreeSerif_contour00x60(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x60_skeleton();
			FreeSerif_contour00x60_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x60_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x60(steps=2) {
	difference() {
		FreeSerif_contour00x60(steps);
		
	}
}

FreeSerif_bbox0x60=[[1, 32], [15, 43]];

module FreeSerif_letter0x60(detail=2) {

	FreeSerif_chunk10x60(steps=detail);

} //end skeleton



module FreeSerif_contour00x61_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[2, 6], [2, 7], [2.5, 8.0], 

		[3, 9], [3.5, 10.0], [4, 11], 

		[4.5, 11.5], [5, 12], [6.5, 13.0], 

		[8, 14], [8.5, 14.5], [9, 15], 

		[10.5, 15.5], [12, 16], [13.0, 16.5], 

		[14, 17], [16.0, 17.5], [18, 18], 

		[18, 19], [18.0, 21.0], [18, 23], 

		[18, 28], [14, 28], [12, 28], 

		[10.5, 27.0], [9, 26], [9, 25], 

		[9, 24], [9.0, 23.0], [9, 22], 

		[9, 22], [9, 21], [8.0, 20.5], 

		[7, 20], [6, 20], [5, 20], 

		[4.5, 20.5], [4, 21], [4, 22], 

		[4, 25], [7.0, 27.0], [10, 29], 

		[14, 29], [20, 29], [22.0, 26.5], 

		[24, 24], [24, 19], [24.0, 13.0], 

		[24, 7], [24, 5], [24.0, 4.0], 

		[24, 3], [25, 3], [27, 3], 

		[28, 4], [28.0, 3.5], [28, 3], 

		[27, 1], [25.5, 0.0], [24, -1], 

		[23, -1], [21, -1], [20.0, 0.5], 

		[19, 2], [18, 4], [13, -1], 

		[9, -1], [6, -1], [4.0, 1.0], 

		[2, 3], ]);

}

module FreeSerif_contour00x61_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([2.5, 8.0], [3, 9], [3.5, 10.0],steps,10);

	BezConic([6.5, 13.0], [8, 14], [8.5, 14.5],steps,10);

	BezConic([10.5, 15.5], [12, 16], [13.0, 16.5],steps,10);

	BezConic([16.0, 17.5], [18, 18], [18, 19],steps,10);

	BezConic([18, 23], [18, 28], [14, 28],steps,10);

	BezConic([14, 28], [12, 28], [10.5, 27.0],steps,10);

	BezConic([10.5, 27.0], [9, 26], [9, 25],steps,10);

	BezConic([9, 25], [9, 24], [9.0, 23.0],steps,10);

	BezConic([9.0, 23.0], [9, 22], [9, 22],steps,10);

	BezConic([24, 7], [24, 5], [24.0, 4.0],steps,10);

	BezConic([24.0, 4.0], [24, 3], [25, 3],steps,10);

	BezConic([25, 3], [27, 3], [28, 4],steps,10);

}

}

module FreeSerif_contour00x61_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([2, 6], [2, 7], [2.5, 8.0],steps,10);

	BezConic([3.5, 10.0], [4, 11], [4.5, 11.5],steps,10);

	BezConic([4.5, 11.5], [5, 12], [6.5, 13.0],steps,10);

	BezConic([8.5, 14.5], [9, 15], [10.5, 15.5],steps,10);

	BezConic([13.0, 16.5], [14, 17], [16.0, 17.5],steps,10);

	BezConic([9, 22], [9, 21], [8.0, 20.5],steps,10);

	BezConic([8.0, 20.5], [7, 20], [6, 20],steps,10);

	BezConic([6, 20], [5, 20], [4.5, 20.5],steps,10);

	BezConic([4.5, 20.5], [4, 21], [4, 22],steps,10);

	BezConic([4, 22], [4, 25], [7.0, 27.0],steps,10);

	BezConic([7.0, 27.0], [10, 29], [14, 29],steps,10);

	BezConic([14, 29], [20, 29], [22.0, 26.5],steps,10);

	BezConic([22.0, 26.5], [24, 24], [24, 19],steps,10);

	BezConic([28, 3], [27, 1], [25.5, 0.0],steps,10);

	BezConic([25.5, 0.0], [24, -1], [23, -1],steps,10);

	BezConic([23, -1], [21, -1], [20.0, 0.5],steps,10);

	BezConic([20.0, 0.5], [19, 2], [18, 4],steps,10);

	BezConic([18, 4], [13, -1], [9, -1],steps,10);

	BezConic([9, -1], [6, -1], [4.0, 1.0],steps,10);

	BezConic([4.0, 1.0], [2, 3], [2, 6],steps,10);

}

}

module FreeSerif_contour00x61(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x61_skeleton();
			FreeSerif_contour00x61_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x61_subtractive_curves(steps);
	}
}

module FreeSerif_contour10x61_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[18, 8], [18.0, 12.5], [18, 17], 

		[13, 15], [10.5, 13.0], [8, 11], 

		[8, 8], [8.0, 8.0], [8, 8], 

		[8, 6], [9.0, 4.5], [10, 3], 

		[12, 3], [14, 3], [17, 5], 

		[18, 5], [18.0, 5.5], [18, 6], 

		 ]);

}

module FreeSerif_contour10x61_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([18, 17], [13, 15], [10.5, 13.0],steps,10);

	BezConic([10.5, 13.0], [8, 11], [8, 8],steps,10);

	BezConic([8, 8], [8, 6], [9.0, 4.5],steps,10);

	BezConic([9.0, 4.5], [10, 3], [12, 3],steps,10);

	BezConic([12, 3], [14, 3], [17, 5],steps,10);

	BezConic([17, 5], [18, 5], [18.0, 5.5],steps,10);

	BezConic([18.0, 5.5], [18, 6], [18, 8],steps,10);

}

}

module FreeSerif_contour10x61_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour10x61(steps=2) {
	difference() {
		union() {
			FreeSerif_contour10x61_skeleton();
			FreeSerif_contour10x61_subtractive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour10x61_additive_curves(steps);
	}
}

module FreeSerif_chunk10x61(steps=2) {
	difference() {
		FreeSerif_contour00x61(steps);
		scale([1,1,1.1]) FreeSerif_contour10x61(steps);
	}
}

FreeSerif_bbox0x61=[[2, -1], [28, 29]];

module FreeSerif_letter0x61(detail=2) {

	FreeSerif_chunk10x61(steps=detail);

} //end skeleton



module FreeSerif_contour00x62_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[10, 44], [10.0, 34.0], [10, 24], 

		[11, 26], [13.5, 27.5], [16, 29], 

		[19, 29], [23, 29], [26.5, 25.0], 

		[30, 21], [30, 16], [30, 9], 

		[25.5, 4.0], [21, -1], [15, -1], 

		[11, -1], [7.5, 0.5], [4, 2], 

		[4, 3], [4.0, 20.0], [4, 37], 

		[4, 39], [3.5, 39.5], [3, 40], 

		[1, 40], [1, 40], [0, 40], 

		[0.0, 40.5], [0, 41], [1.0, 41.0], 

		[2, 41], [6, 43], [9, 44], 

		[9.5, 44.0], ]);

}

module FreeSerif_contour00x62_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([4, 37], [4, 39], [3.5, 39.5],steps,10);

	BezConic([3.5, 39.5], [3, 40], [1, 40],steps,10);

	BezConic([1, 40], [1, 40], [0, 40],steps,10);

}

}

module FreeSerif_contour00x62_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([10, 24], [11, 26], [13.5, 27.5],steps,10);

	BezConic([13.5, 27.5], [16, 29], [19, 29],steps,10);

	BezConic([19, 29], [23, 29], [26.5, 25.0],steps,10);

	BezConic([26.5, 25.0], [30, 21], [30, 16],steps,10);

	BezConic([30, 16], [30, 9], [25.5, 4.0],steps,10);

	BezConic([25.5, 4.0], [21, -1], [15, -1],steps,10);

	BezConic([15, -1], [11, -1], [7.5, 0.5],steps,10);

	BezConic([7.5, 0.5], [4, 2], [4, 3],steps,10);

	BezConic([2, 41], [6, 43], [9, 44],steps,10);

}

}

module FreeSerif_contour00x62(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x62_skeleton();
			FreeSerif_contour00x62_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x62_subtractive_curves(steps);
	}
}

module FreeSerif_contour10x62_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[10, 21], [10.0, 12.5], [10, 4], 

		[10, 3], [12.0, 2.0], [14, 1], 

		[16, 1], [20, 1], [22.0, 4.0], 

		[24, 7], [24, 13], [24, 18], 

		[22.0, 21.5], [20, 25], [16, 25], 

		[14, 25], [12.0, 23.5], [10, 22], 

		 ]);

}

module FreeSerif_contour10x62_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([10, 4], [10, 3], [12.0, 2.0],steps,10);

	BezConic([12.0, 2.0], [14, 1], [16, 1],steps,10);

	BezConic([16, 1], [20, 1], [22.0, 4.0],steps,10);

	BezConic([22.0, 4.0], [24, 7], [24, 13],steps,10);

	BezConic([24, 13], [24, 18], [22.0, 21.5],steps,10);

	BezConic([22.0, 21.5], [20, 25], [16, 25],steps,10);

	BezConic([16, 25], [14, 25], [12.0, 23.5],steps,10);

	BezConic([12.0, 23.5], [10, 22], [10, 21],steps,10);

}

}

module FreeSerif_contour10x62_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour10x62(steps=2) {
	difference() {
		union() {
			FreeSerif_contour10x62_skeleton();
			FreeSerif_contour10x62_subtractive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour10x62_additive_curves(steps);
	}
}

module FreeSerif_chunk10x62(steps=2) {
	difference() {
		FreeSerif_contour00x62(steps);
		scale([1,1,1.1]) FreeSerif_contour10x62(steps);
	}
}

FreeSerif_bbox0x62=[[0, -1], [30, 44]];

module FreeSerif_letter0x62(detail=2) {

	FreeSerif_chunk10x62(steps=detail);

} //end skeleton



module FreeSerif_contour00x63_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[2, 14], [2, 21], [6.0, 25.0], 

		[10, 29], [16, 29], [20, 29], 

		[22.5, 27.5], [25, 26], [25, 23], 

		[25, 22], [24.5, 21.0], [24, 20], 

		[22, 20], [20, 20], [19, 23], 

		[19.0, 24.0], [19, 25], [18, 26], 

		[17.5, 27.0], [17, 28], [15, 28], 

		[11, 28], [9.0, 24.5], [7, 21], 

		[7, 16], [7, 11], [9.5, 7.5], 

		[12, 4], [16, 4], [19, 4], 

		[21.0, 5.5], [23, 7], [25, 10], 

		[25.5, 9.5], [26, 9], [26, 8], 

		[25.5, 7.0], [25, 6], [23.5, 4.5], 

		[22, 3], [21.0, 2.0], [20, 1], 

		[18.0, 0.0], [16, -1], [14, -1], 

		[8, -1], [5.0, 3.0], [2, 7], 

		 ]);

}

module FreeSerif_contour00x63_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([17.5, 27.0], [17, 28], [15, 28],steps,10);

	BezConic([15, 28], [11, 28], [9.0, 24.5],steps,10);

	BezConic([9.0, 24.5], [7, 21], [7, 16],steps,10);

	BezConic([7, 16], [7, 11], [9.5, 7.5],steps,10);

	BezConic([9.5, 7.5], [12, 4], [16, 4],steps,10);

	BezConic([16, 4], [19, 4], [21.0, 5.5],steps,10);

	BezConic([21.0, 5.5], [23, 7], [25, 10],steps,10);

	BezConic([23.5, 4.5], [22, 3], [21.0, 2.0],steps,10);

}

}

module FreeSerif_contour00x63_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([2, 14], [2, 21], [6.0, 25.0],steps,10);

	BezConic([6.0, 25.0], [10, 29], [16, 29],steps,10);

	BezConic([16, 29], [20, 29], [22.5, 27.5],steps,10);

	BezConic([22.5, 27.5], [25, 26], [25, 23],steps,10);

	BezConic([25, 23], [25, 22], [24.5, 21.0],steps,10);

	BezConic([24.5, 21.0], [24, 20], [22, 20],steps,10);

	BezConic([22, 20], [20, 20], [19, 23],steps,10);

	BezConic([19, 25], [18, 26], [17.5, 27.0],steps,10);

	BezConic([26, 9], [26, 8], [25.5, 7.0],steps,10);

	BezConic([25.5, 7.0], [25, 6], [23.5, 4.5],steps,10);

	BezConic([21.0, 2.0], [20, 1], [18.0, 0.0],steps,10);

	BezConic([18.0, 0.0], [16, -1], [14, -1],steps,10);

	BezConic([14, -1], [8, -1], [5.0, 3.0],steps,10);

	BezConic([5.0, 3.0], [2, 7], [2, 14],steps,10);

}

}

module FreeSerif_contour00x63(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x63_skeleton();
			FreeSerif_contour00x63_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x63_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x63(steps=2) {
	difference() {
		FreeSerif_contour00x63(steps);
		
	}
}

FreeSerif_bbox0x63=[[2, -1], [26, 29]];

module FreeSerif_letter0x63(detail=2) {

	FreeSerif_chunk10x63(steps=detail);

} //end skeleton



module FreeSerif_contour00x64_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[22, -1], [22.0, -0.5], [22, 0], 

		[22.0, 2.0], [22, 4], [19, -1], 

		[14, -1], [8, -1], [5.0, 3.0], 

		[2, 7], [2, 13], [2, 20], 

		[6.0, 24.5], [10, 29], [15, 29], 

		[18, 29], [22, 27], [22.0, 32.0], 

		[22, 37], [22, 39], [21.5, 39.5], 

		[21, 40], [19, 40], [18, 40], 

		[17, 40], [17.0, 40.5], [17, 41], 

		[23, 42], [27, 44], [27.0, 44.0], 

		[27, 44], [27.0, 25.5], [27, 7], 

		[27, 5], [27.5, 4.5], [28, 4], 

		[30, 4], [30, 4], [31, 4], 

		[31.0, 3.5], [31, 3], [26.5, 1.0], 

		 ]);

}

module FreeSerif_contour00x64_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([22, 37], [22, 39], [21.5, 39.5],steps,10);

	BezConic([21.5, 39.5], [21, 40], [19, 40],steps,10);

	BezConic([19, 40], [18, 40], [17, 40],steps,10);

	BezConic([17, 41], [23, 42], [27, 44],steps,10);

	BezConic([27, 7], [27, 5], [27.5, 4.5],steps,10);

	BezConic([27.5, 4.5], [28, 4], [30, 4],steps,10);

	BezConic([30, 4], [30, 4], [31, 4],steps,10);

}

}

module FreeSerif_contour00x64_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([22, 4], [19, -1], [14, -1],steps,10);

	BezConic([14, -1], [8, -1], [5.0, 3.0],steps,10);

	BezConic([5.0, 3.0], [2, 7], [2, 13],steps,10);

	BezConic([2, 13], [2, 20], [6.0, 24.5],steps,10);

	BezConic([6.0, 24.5], [10, 29], [15, 29],steps,10);

	BezConic([15, 29], [18, 29], [22, 27],steps,10);

}

}

module FreeSerif_contour00x64(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x64_skeleton();
			FreeSerif_contour00x64_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x64_subtractive_curves(steps);
	}
}

module FreeSerif_contour10x64_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[16, 3], [18, 3], [20.0, 4.0], 

		[22, 5], [22, 7], [22.0, 14.0], 

		[22, 21], [22, 24], [20.0, 26.0], 

		[18, 28], [15, 28], [12, 28], 

		[9.5, 24.5], [7, 21], [7, 16], 

		[7, 10], [9.5, 6.5], [12, 3], 

		 ]);

}

module FreeSerif_contour10x64_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([16, 3], [18, 3], [20.0, 4.0],steps,10);

	BezConic([20.0, 4.0], [22, 5], [22, 7],steps,10);

	BezConic([22, 21], [22, 24], [20.0, 26.0],steps,10);

	BezConic([20.0, 26.0], [18, 28], [15, 28],steps,10);

	BezConic([15, 28], [12, 28], [9.5, 24.5],steps,10);

	BezConic([9.5, 24.5], [7, 21], [7, 16],steps,10);

	BezConic([7, 16], [7, 10], [9.5, 6.5],steps,10);

	BezConic([9.5, 6.5], [12, 3], [16, 3],steps,10);

}

}

module FreeSerif_contour10x64_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour10x64(steps=2) {
	difference() {
		union() {
			FreeSerif_contour10x64_skeleton();
			FreeSerif_contour10x64_subtractive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour10x64_additive_curves(steps);
	}
}

module FreeSerif_chunk10x64(steps=2) {
	difference() {
		FreeSerif_contour00x64(steps);
		scale([1,1,1.1]) FreeSerif_contour10x64(steps);
	}
}

FreeSerif_bbox0x64=[[2, -1], [31, 44]];

module FreeSerif_letter0x64(detail=2) {

	FreeSerif_chunk10x64(steps=detail);

} //end skeleton



module FreeSerif_contour00x65_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[6, 18], [6, 14], [7.0, 11.0], 

		[8, 8], [9.5, 6.5], [11, 5], 

		[12.5, 4.5], [14, 4], [16, 4], 

		[19, 4], [21.5, 5.5], [24, 7], 

		[26, 10], [26.5, 10.0], [27, 10], 

		[25, 5], [21.5, 2.0], [18, -1], 

		[14, -1], [8, -1], [5.0, 3.0], 

		[2, 7], [2, 14], [2, 21], 

		[5.5, 25.0], [9, 29], [15, 29], 

		[20, 29], [22.5, 26.5], [25, 24], 

		[26, 18],[16.0, 18.0], ]);

}

module FreeSerif_contour00x65_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([6, 18], [6, 14], [7.0, 11.0],steps,10);

	BezConic([7.0, 11.0], [8, 8], [9.5, 6.5],steps,10);

	BezConic([9.5, 6.5], [11, 5], [12.5, 4.5],steps,10);

	BezConic([12.5, 4.5], [14, 4], [16, 4],steps,10);

	BezConic([16, 4], [19, 4], [21.5, 5.5],steps,10);

	BezConic([21.5, 5.5], [24, 7], [26, 10],steps,10);

}

}

module FreeSerif_contour00x65_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([27, 10], [25, 5], [21.5, 2.0],steps,10);

	BezConic([21.5, 2.0], [18, -1], [14, -1],steps,10);

	BezConic([14, -1], [8, -1], [5.0, 3.0],steps,10);

	BezConic([5.0, 3.0], [2, 7], [2, 14],steps,10);

	BezConic([2, 14], [2, 21], [5.5, 25.0],steps,10);

	BezConic([5.5, 25.0], [9, 29], [15, 29],steps,10);

	BezConic([15, 29], [20, 29], [22.5, 26.5],steps,10);

	BezConic([22.5, 26.5], [25, 24], [26, 18],steps,10);

}

}

module FreeSerif_contour00x65(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x65_skeleton();
			FreeSerif_contour00x65_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x65_subtractive_curves(steps);
	}
}

module FreeSerif_contour10x65_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[6, 20], [12.5, 20.0], [19, 20], 

		[19, 24], [17.5, 25.5], [16, 27], 

		[13, 27],[7, 27], ]);

}

module FreeSerif_contour10x65_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([19, 20], [19, 24], [17.5, 25.5],steps,10);

	BezConic([17.5, 25.5], [16, 27], [13, 27],steps,10);

	BezConic([13, 27], [7, 27], [6, 20],steps,10);

}

}

module FreeSerif_contour10x65_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour10x65(steps=2) {
	difference() {
		union() {
			FreeSerif_contour10x65_skeleton();
			FreeSerif_contour10x65_subtractive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour10x65_additive_curves(steps);
	}
}

module FreeSerif_chunk10x65(steps=2) {
	difference() {
		FreeSerif_contour00x65(steps);
		scale([1,1,1.1]) FreeSerif_contour10x65(steps);
	}
}

FreeSerif_bbox0x65=[[2, -1], [27, 29]];

module FreeSerif_letter0x65(detail=2) {

	FreeSerif_chunk10x65(steps=detail);

} //end skeleton



module FreeSerif_contour00x66_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[22, 37], [21, 37], [20.0, 38.0], 

		[19, 39], [18.5, 39.5], [18, 40], 

		[17.5, 41.0], [17, 42], [16, 42], 

		[12, 42], [12, 36], [12.0, 32.5], 

		[12, 29], [16.0, 29.0], [20, 29], 

		[20.0, 28.0], [20, 27], [16.0, 27.0], 

		[12, 27], [12.0, 17.0], [12, 7], 

		[12, 3], [13.0, 2.0], [14, 1], 

		[18, 1], [18.0, 0.5], [18, 0], 

		[9.5, 0.0], [1, 0], [1.0, 0.5], 

		[1, 1], [5, 1], [6.0, 2.0], 

		[7, 3], [7, 7], [7.0, 17.0], 

		[7, 27], [4.0, 27.0], [1, 27], 

		[1.0, 28.0], [1, 29], [4.0, 29.0], 

		[7, 29], [7, 36], [9.5, 40.0], 

		[12, 44], [18, 44], [21, 44], 

		[23.0, 42.5], [25, 41], [25, 40], 

		[25, 39], [24.0, 38.0], [23, 37], 

		 ]);

}

module FreeSerif_contour00x66_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([20.0, 38.0], [19, 39], [18.5, 39.5],steps,10);

	BezConic([17.5, 41.0], [17, 42], [16, 42],steps,10);

	BezConic([16, 42], [12, 42], [12, 36],steps,10);

	BezConic([12, 7], [12, 3], [13.0, 2.0],steps,10);

	BezConic([13.0, 2.0], [14, 1], [18, 1],steps,10);

	BezConic([1, 1], [5, 1], [6.0, 2.0],steps,10);

	BezConic([6.0, 2.0], [7, 3], [7, 7],steps,10);

}

}

module FreeSerif_contour00x66_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([22, 37], [21, 37], [20.0, 38.0],steps,10);

	BezConic([18.5, 39.5], [18, 40], [17.5, 41.0],steps,10);

	BezConic([7, 29], [7, 36], [9.5, 40.0],steps,10);

	BezConic([9.5, 40.0], [12, 44], [18, 44],steps,10);

	BezConic([18, 44], [21, 44], [23.0, 42.5],steps,10);

	BezConic([23.0, 42.5], [25, 41], [25, 40],steps,10);

	BezConic([25, 40], [25, 39], [24.0, 38.0],steps,10);

	BezConic([24.0, 38.0], [23, 37], [22, 37],steps,10);

}

}

module FreeSerif_contour00x66(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x66_skeleton();
			FreeSerif_contour00x66_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x66_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x66(steps=2) {
	difference() {
		FreeSerif_contour00x66(steps);
		
	}
}

FreeSerif_bbox0x66=[[1, 0], [25, 44]];

module FreeSerif_letter0x66(detail=2) {

	FreeSerif_chunk10x66(steps=detail);

} //end skeleton



module FreeSerif_contour00x67_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[5, 3], [5, 5], [5.5, 6.0], 

		[6, 7], [10, 10], [7, 12], 

		[5.5, 14.0], [4, 16], [4, 19], 

		[4, 23], [7.5, 26.0], [11, 29], 

		[15, 29], [18, 29], [20, 28], 

		[21.0, 28.0], [22, 28], [23, 27], 

		[25, 27], [27.5, 27.0], [30, 27], 

		[30.0, 26.0], [30, 25], [27.5, 25.0], 

		[25, 25], [26, 22], [26, 19], 

		[26, 15], [23.0, 12.5], [20, 10], 

		[16, 10], [15, 10], [14, 10], 

		[14, 10], [12, 10], [11, 9], 

		[10.0, 8.0], [9, 7], [9, 6], 

		[9, 4], [14, 4], [18.0, 4.0], 

		[22, 4], [25, 4], [27.5, 2.0], 

		[30, 0], [30, -3], [30, -7], 

		[26, -10], [21, -14], [13, -14], 

		[8, -14], [5.0, -12.0], [2, -10], 

		[2, -8], [2, -6], [3.5, -4.0], 

		[5, -2], [8, 0], [6, 1], 

		[5.5, 1.5],[5, 2], ]);

}

module FreeSerif_contour00x67_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([22, 28], [23, 27], [25, 27],steps,10);

	BezConic([16, 10], [15, 10], [14, 10],steps,10);

	BezConic([14, 10], [14, 10], [12, 10],steps,10);

	BezConic([12, 10], [11, 9], [10.0, 8.0],steps,10);

	BezConic([10.0, 8.0], [9, 7], [9, 6],steps,10);

	BezConic([9, 6], [9, 4], [14, 4],steps,10);

}

}

module FreeSerif_contour00x67_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([5, 3], [5, 5], [5.5, 6.0],steps,10);

	BezConic([5.5, 6.0], [6, 7], [10, 10],steps,10);

	BezConic([10, 10], [7, 12], [5.5, 14.0],steps,10);

	BezConic([5.5, 14.0], [4, 16], [4, 19],steps,10);

	BezConic([4, 19], [4, 23], [7.5, 26.0],steps,10);

	BezConic([7.5, 26.0], [11, 29], [15, 29],steps,10);

	BezConic([15, 29], [18, 29], [20, 28],steps,10);

	BezConic([25, 25], [26, 22], [26, 19],steps,10);

	BezConic([26, 19], [26, 15], [23.0, 12.5],steps,10);

	BezConic([23.0, 12.5], [20, 10], [16, 10],steps,10);

	BezConic([22, 4], [25, 4], [27.5, 2.0],steps,10);

	BezConic([27.5, 2.0], [30, 0], [30, -3],steps,10);

	BezConic([30, -3], [30, -7], [26, -10],steps,10);

	BezConic([26, -10], [21, -14], [13, -14],steps,10);

	BezConic([13, -14], [8, -14], [5.0, -12.0],steps,10);

	BezConic([5.0, -12.0], [2, -10], [2, -8],steps,10);

	BezConic([2, -8], [2, -6], [3.5, -4.0],steps,10);

	BezConic([3.5, -4.0], [5, -2], [8, 0],steps,10);

	BezConic([8, 0], [6, 1], [5.5, 1.5],steps,10);

	BezConic([5.5, 1.5], [5, 2], [5, 3],steps,10);

}

}

module FreeSerif_contour00x67(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x67_skeleton();
			FreeSerif_contour00x67_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x67_subtractive_curves(steps);
	}
}

module FreeSerif_contour10x67_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[9, 0], [7, -2], [6.5, -3.5], 

		[6, -5], [6, -6], [6, -8], 

		[8.5, -9.0], [11, -10], [16, -10], 

		[21, -10], [24.5, -8.5], [28, -7], 

		[28, -4], [28, -2], [26.0, -1.5], 

		[24, -1], [20, -1], [13, -1], 

		 ]);

}

module FreeSerif_contour10x67_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([9, 0], [7, -2], [6.5, -3.5],steps,10);

	BezConic([6.5, -3.5], [6, -5], [6, -6],steps,10);

	BezConic([6, -6], [6, -8], [8.5, -9.0],steps,10);

	BezConic([8.5, -9.0], [11, -10], [16, -10],steps,10);

	BezConic([16, -10], [21, -10], [24.5, -8.5],steps,10);

	BezConic([24.5, -8.5], [28, -7], [28, -4],steps,10);

	BezConic([28, -4], [28, -2], [26.0, -1.5],steps,10);

	BezConic([26.0, -1.5], [24, -1], [20, -1],steps,10);

}

}

module FreeSerif_contour10x67_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([20, -1], [13, -1], [9, 0],steps,10);

}

}

module FreeSerif_contour10x67(steps=2) {
	difference() {
		union() {
			FreeSerif_contour10x67_skeleton();
			FreeSerif_contour10x67_subtractive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour10x67_additive_curves(steps);
	}
}

module FreeSerif_contour20x67_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[21, 17], [21, 18], [21.0, 19.5], 

		[21, 21], [20.0, 23.0], [19, 25], 

		[17.5, 26.5], [16, 28], [14, 28], 

		[12, 28], [11.0, 26.0], [10, 24], 

		[10, 22], [10.0, 21.5], [10, 21], 

		[10, 17], [11.5, 14.0], [13, 11], 

		[16, 11], [18, 11], [19.5, 12.5], 

		[21, 14], ]);

}

module FreeSerif_contour20x67_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([21, 17], [21, 18], [21.0, 19.5],steps,10);

	BezConic([21.0, 19.5], [21, 21], [20.0, 23.0],steps,10);

	BezConic([20.0, 23.0], [19, 25], [17.5, 26.5],steps,10);

	BezConic([17.5, 26.5], [16, 28], [14, 28],steps,10);

	BezConic([14, 28], [12, 28], [11.0, 26.0],steps,10);

	BezConic([11.0, 26.0], [10, 24], [10, 22],steps,10);

	BezConic([10, 21], [10, 17], [11.5, 14.0],steps,10);

	BezConic([11.5, 14.0], [13, 11], [16, 11],steps,10);

	BezConic([16, 11], [18, 11], [19.5, 12.5],steps,10);

	BezConic([19.5, 12.5], [21, 14], [21, 17],steps,10);

}

}

module FreeSerif_contour20x67_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour20x67(steps=2) {
	difference() {
		union() {
			FreeSerif_contour20x67_skeleton();
			FreeSerif_contour20x67_subtractive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour20x67_additive_curves(steps);
	}
}

module FreeSerif_chunk10x67(steps=2) {
	difference() {
		FreeSerif_contour00x67(steps);
		scale([1,1,1.1]) FreeSerif_contour10x67(steps);
	scale([1,1,1.1]) FreeSerif_contour20x67(steps);
	}
}

FreeSerif_bbox0x67=[[2, -14], [30, 29]];

module FreeSerif_letter0x67(detail=2) {

	FreeSerif_chunk10x67(steps=detail);

} //end skeleton



module FreeSerif_contour00x68_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[10, 22], [10.0, 14.5], [10, 7], 

		[10, 3], [11.0, 2.0], [12, 1], 

		[14, 1], [14.0, 0.5], [14, 0], 

		[7.5, 0.0], [1, 0], [1.0, 0.5], 

		[1, 1], [3, 1], [4.0, 2.0], 

		[5, 3], [5, 7], [5.0, 22.0], 

		[5, 37], [5, 39], [4.0, 39.5], 

		[3, 40], [1, 40], [1, 40], 

		[1, 40], [1.0, 40.5], [1, 41], 

		[1.5, 41.0], [2, 41], [7, 43], 

		[10, 44], [10.0, 44.0], [10, 44], 

		[10.0, 34.0], [10, 24], [12, 27], 

		[14.5, 28.0], [17, 29], [19, 29], 

		[27, 29], [27, 19], [27.0, 13.0], 

		[27, 7], [27, 3], [28.0, 2.0], 

		[29, 1], [31, 1], [31.0, 0.5], 

		[31, 0], [24.5, 0.0], [18, 0], 

		[18.0, 0.5], [18, 1], [20, 1], 

		[21.0, 2.0], [22, 3], [22, 7], 

		[22.0, 13.0], [22, 19], [22, 26], 

		[17, 26], [15, 26], [13.5, 25.0], 

		[12, 24], ]);

}

module FreeSerif_contour00x68_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([10, 7], [10, 3], [11.0, 2.0],steps,10);

	BezConic([11.0, 2.0], [12, 1], [14, 1],steps,10);

	BezConic([1, 1], [3, 1], [4.0, 2.0],steps,10);

	BezConic([4.0, 2.0], [5, 3], [5, 7],steps,10);

	BezConic([5, 37], [5, 39], [4.0, 39.5],steps,10);

	BezConic([4.0, 39.5], [3, 40], [1, 40],steps,10);

	BezConic([1, 40], [1, 40], [1, 40],steps,10);

	BezConic([27, 7], [27, 3], [28.0, 2.0],steps,10);

	BezConic([28.0, 2.0], [29, 1], [31, 1],steps,10);

	BezConic([18, 1], [20, 1], [21.0, 2.0],steps,10);

	BezConic([21.0, 2.0], [22, 3], [22, 7],steps,10);

	BezConic([22, 19], [22, 26], [17, 26],steps,10);

	BezConic([17, 26], [15, 26], [13.5, 25.0],steps,10);

	BezConic([13.5, 25.0], [12, 24], [10, 22],steps,10);

}

}

module FreeSerif_contour00x68_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([2, 41], [7, 43], [10, 44],steps,10);

	BezConic([10, 24], [12, 27], [14.5, 28.0],steps,10);

	BezConic([14.5, 28.0], [17, 29], [19, 29],steps,10);

	BezConic([19, 29], [27, 29], [27, 19],steps,10);

}

}

module FreeSerif_contour00x68(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x68_skeleton();
			FreeSerif_contour00x68_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x68_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x68(steps=2) {
	difference() {
		FreeSerif_contour00x68(steps);
		
	}
}

FreeSerif_bbox0x68=[[1, 0], [31, 44]];

module FreeSerif_letter0x68(detail=2) {

	FreeSerif_chunk10x68(steps=detail);

} //end skeleton



module FreeSerif_contour00x69_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[4, 25], [3, 25], [1, 25], 

		[1.0, 25.5], [1, 26], [6.0, 27.5], 

		[11, 29], [11.0, 29.0], [11, 29], 

		[11.0, 18.0], [11, 7], [11, 3], 

		[12.0, 2.0], [13, 1], [16, 1], 

		[16.0, 0.5], [16, 0], [8.5, 0.0], 

		[1, 0], [1.0, 0.5], [1, 1], 

		[4, 1], [5.0, 2.0], [6, 3], 

		[6, 7], [6.0, 14.0], [6, 21], 

		[6, 23], [5.5, 24.0], [5, 25], 

		 ]);

}

module FreeSerif_contour00x69_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([4, 25], [3, 25], [1, 25],steps,10);

	BezConic([11, 7], [11, 3], [12.0, 2.0],steps,10);

	BezConic([12.0, 2.0], [13, 1], [16, 1],steps,10);

	BezConic([1, 1], [4, 1], [5.0, 2.0],steps,10);

	BezConic([5.0, 2.0], [6, 3], [6, 7],steps,10);

	BezConic([6, 21], [6, 23], [5.5, 24.0],steps,10);

	BezConic([5.5, 24.0], [5, 25], [4, 25],steps,10);

}

}

module FreeSerif_contour00x69_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x69(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x69_skeleton();
			FreeSerif_contour00x69_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x69_subtractive_curves(steps);
	}
}

module FreeSerif_contour10x69_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[8, 44], [10, 44], [11.0, 43.0], 

		[12, 42], [12, 40], [12, 39], 

		[11.0, 38.0], [10, 37], [8, 37], 

		[7, 37], [6.0, 38.0], [5, 39], 

		[5.0, 40.5], [5, 42], [6.0, 43.0], 

		[7, 44], ]);

}

module FreeSerif_contour10x69_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour10x69_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([8, 44], [10, 44], [11.0, 43.0],steps,10);

	BezConic([11.0, 43.0], [12, 42], [12, 40],steps,10);

	BezConic([12, 40], [12, 39], [11.0, 38.0],steps,10);

	BezConic([11.0, 38.0], [10, 37], [8, 37],steps,10);

	BezConic([8, 37], [7, 37], [6.0, 38.0],steps,10);

	BezConic([6.0, 38.0], [5, 39], [5.0, 40.5],steps,10);

	BezConic([5.0, 40.5], [5, 42], [6.0, 43.0],steps,10);

	BezConic([6.0, 43.0], [7, 44], [8, 44],steps,10);

}

}

module FreeSerif_contour10x69(steps=2) {
	difference() {
		union() {
			FreeSerif_contour10x69_skeleton();
			FreeSerif_contour10x69_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour10x69_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x69(steps=2) {
	difference() {
		FreeSerif_contour00x69(steps);
		
	}
}

module FreeSerif_chunk20x69(steps=2) {
	difference() {
		FreeSerif_contour10x69(steps);
		
	}
}

FreeSerif_bbox0x69=[[1, 0], [16, 44]];

module FreeSerif_letter0x69(detail=2) {

	FreeSerif_chunk10x69(steps=detail);

	FreeSerif_chunk20x69(steps=detail);

} //end skeleton



module FreeSerif_contour00x6a_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[5, 25], [5, 25], [2, 25], 

		[2.0, 25.5], [2, 26], [7, 28], 

		[12, 29], [12.0, 29.0], [12, 29], 

		[12.0, 14.5], [12, 0], [12, -7], 

		[9.5, -10.5], [7, -14], [2, -14], 

		[-1, -14], [-2.5, -13.0], [-4, -12], 

		[-4, -10], [-4, -9], [-3.5, -8.5], 

		[-3, -8], [-2, -8], [-1, -8], 

		[1.0, -10.0], [3, -12], [4, -12], 

		[6, -12], [6.5, -10.0], [7, -8], 

		[7, -3], [7.0, 9.0], [7, 21], 

		[7, 25], ]);

}

module FreeSerif_contour00x6a_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([5, 25], [5, 25], [2, 25],steps,10);

	BezConic([1.0, -10.0], [3, -12], [4, -12],steps,10);

	BezConic([4, -12], [6, -12], [6.5, -10.0],steps,10);

	BezConic([6.5, -10.0], [7, -8], [7, -3],steps,10);

	BezConic([7, 21], [7, 25], [5, 25],steps,10);

}

}

module FreeSerif_contour00x6a_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([2, 26], [7, 28], [12, 29],steps,10);

	BezConic([12, 0], [12, -7], [9.5, -10.5],steps,10);

	BezConic([9.5, -10.5], [7, -14], [2, -14],steps,10);

	BezConic([2, -14], [-1, -14], [-2.5, -13.0],steps,10);

	BezConic([-2.5, -13.0], [-4, -12], [-4, -10],steps,10);

	BezConic([-4, -10], [-4, -9], [-3.5, -8.5],steps,10);

	BezConic([-3.5, -8.5], [-3, -8], [-2, -8],steps,10);

	BezConic([-2, -8], [-1, -8], [1.0, -10.0],steps,10);

}

}

module FreeSerif_contour00x6a(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x6a_skeleton();
			FreeSerif_contour00x6a_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x6a_subtractive_curves(steps);
	}
}

module FreeSerif_contour10x6a_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[9, 44], [10, 44], [11.0, 43.0], 

		[12, 42], [12, 40], [12, 39], 

		[11.0, 38.0], [10, 37], [9, 37], 

		[8, 37], [7.0, 38.0], [6, 39], 

		[6.0, 40.5], [6, 42], [7.0, 43.0], 

		[8, 44], ]);

}

module FreeSerif_contour10x6a_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour10x6a_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([9, 44], [10, 44], [11.0, 43.0],steps,10);

	BezConic([11.0, 43.0], [12, 42], [12, 40],steps,10);

	BezConic([12, 40], [12, 39], [11.0, 38.0],steps,10);

	BezConic([11.0, 38.0], [10, 37], [9, 37],steps,10);

	BezConic([9, 37], [8, 37], [7.0, 38.0],steps,10);

	BezConic([7.0, 38.0], [6, 39], [6.0, 40.5],steps,10);

	BezConic([6.0, 40.5], [6, 42], [7.0, 43.0],steps,10);

	BezConic([7.0, 43.0], [8, 44], [9, 44],steps,10);

}

}

module FreeSerif_contour10x6a(steps=2) {
	difference() {
		union() {
			FreeSerif_contour10x6a_skeleton();
			FreeSerif_contour10x6a_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour10x6a_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x6a(steps=2) {
	difference() {
		FreeSerif_contour00x6a(steps);
		
	}
}

module FreeSerif_chunk20x6a(steps=2) {
	difference() {
		FreeSerif_contour10x6a(steps);
		
	}
}

FreeSerif_bbox0x6a=[[-4, -14], [12, 44]];

module FreeSerif_letter0x6a(detail=2) {

	FreeSerif_chunk10x6a(steps=detail);

	FreeSerif_chunk20x6a(steps=detail);

} //end skeleton



module FreeSerif_contour00x6b_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[0, 40], [0.0, 40.5], [0, 41], 

		[1.0, 41.0], [2, 41], [8, 43], 

		[10, 44], [10.5, 44.0], [11, 44], 

		[11.0, 30.5], [11, 17], [15.0, 21.0], 

		[19, 25], [21, 26], [21, 27], 

		[21, 27], [20.5, 27.5], [20, 28], 

		[18, 28], [18.0, 28.5], [18, 29], 

		[24.5, 29.0], [31, 29], [31.0, 28.5], 

		[31, 28], [30.5, 28.0], [30, 28], 

		[29, 28], [27.5, 27.5], [26, 27], 

		[23.5, 25.0], [21, 23], [17, 20], 

		[16.0, 19.0], [15, 18], [20.0, 12.0], 

		[25, 6], [27, 3], [28.5, 2.0], 

		[30, 1], [32, 1], [32.0, 0.5], 

		[32, 0], [25.0, 0.0], [18, 0], 

		[18.0, 0.5], [18, 1], [19.0, 1.0], 

		[20, 1], [21, 1], [21, 2], 

		[21, 2], [21.0, 2.5], [21, 3], 

		[20.5, 3.5], [20, 4], [20, 4], 

		[15.5, 10.0], [11, 16], [11.0, 10.0], 

		[11, 4], [11, 3], [11.5, 2.0], 

		[12, 1], [14, 1], [14.5, 1.0], 

		[15, 1], [15.0, 0.5], [15, 0], 

		[7.5, 0.0], [0, 0], [0.0, 0.5], 

		[0, 1], [4, 2], [4.5, 2.5], 

		[5, 3], [5, 5], [5.0, 20.5], 

		[5, 36], [5, 38], [4.5, 39.0], 

		[4, 40], [2, 40], [2, 40], 

		 ]);

}

module FreeSerif_contour00x6b_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([2, 41], [8, 43], [10, 44],steps,10);

	BezConic([19, 25], [21, 26], [21, 27],steps,10);

	BezConic([21, 27], [21, 27], [20.5, 27.5],steps,10);

	BezConic([20.5, 27.5], [20, 28], [18, 28],steps,10);

	BezConic([30, 28], [29, 28], [27.5, 27.5],steps,10);

	BezConic([27.5, 27.5], [26, 27], [23.5, 25.0],steps,10);

	BezConic([25, 6], [27, 3], [28.5, 2.0],steps,10);

	BezConic([28.5, 2.0], [30, 1], [32, 1],steps,10);

	BezConic([20, 1], [21, 1], [21, 2],steps,10);

	BezConic([21, 2], [21, 2], [21.0, 2.5],steps,10);

	BezConic([21.0, 2.5], [21, 3], [20.5, 3.5],steps,10);

	BezConic([20.5, 3.5], [20, 4], [20, 4],steps,10);

	BezConic([11, 4], [11, 3], [11.5, 2.0],steps,10);

	BezConic([11.5, 2.0], [12, 1], [14, 1],steps,10);

	BezConic([0, 1], [4, 2], [4.5, 2.5],steps,10);

	BezConic([4.5, 2.5], [5, 3], [5, 5],steps,10);

	BezConic([5, 36], [5, 38], [4.5, 39.0],steps,10);

	BezConic([4.5, 39.0], [4, 40], [2, 40],steps,10);

	BezConic([2, 40], [2, 40], [0, 40],steps,10);

}

}

module FreeSerif_contour00x6b_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([23.5, 25.0], [21, 23], [17, 20],steps,10);

}

}

module FreeSerif_contour00x6b(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x6b_skeleton();
			FreeSerif_contour00x6b_subtractive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x6b_additive_curves(steps);
	}
}

module FreeSerif_chunk00x6b(steps=2) {
	difference() {
		
		scale([1,1,1.1]) FreeSerif_contour00x6b(steps);
	}
}

FreeSerif_bbox0x6b=[[0, 0], [32, 44]];

module FreeSerif_letter0x6b(detail=2) {

	FreeSerif_chunk00x6b(steps=detail);

} //end skeleton



module FreeSerif_contour00x6c_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[1, 40], [1.0, 40.5], [1, 41], 

		[8, 42], [11, 44], [11.5, 44.0], 

		[12, 44], [12.0, 24.5], [12, 5], 

		[12, 3], [12.5, 2.0], [13, 1], 

		[16, 1], [16.0, 0.5], [16, 0], 

		[8.5, 0.0], [1, 0], [1.0, 0.5], 

		[1, 1], [4, 1], [5.0, 2.0], 

		[6, 3], [6, 6], [6.0, 21.0], 

		[6, 36], [6, 38], [5.5, 39.0], 

		[5, 40], [4, 40], [3, 40], 

		[2, 40],[1.5, 40.0], ]);

}

module FreeSerif_contour00x6c_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([1, 41], [8, 42], [11, 44],steps,10);

	BezConic([12, 5], [12, 3], [12.5, 2.0],steps,10);

	BezConic([12.5, 2.0], [13, 1], [16, 1],steps,10);

	BezConic([1, 1], [4, 1], [5.0, 2.0],steps,10);

	BezConic([5.0, 2.0], [6, 3], [6, 6],steps,10);

	BezConic([6, 36], [6, 38], [5.5, 39.0],steps,10);

	BezConic([5.5, 39.0], [5, 40], [4, 40],steps,10);

	BezConic([4, 40], [3, 40], [2, 40],steps,10);

}

}

module FreeSerif_contour00x6c_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x6c(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x6c_skeleton();
			FreeSerif_contour00x6c_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x6c_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x6c(steps=2) {
	difference() {
		FreeSerif_contour00x6c(steps);
		
	}
}

FreeSerif_bbox0x6c=[[1, 0], [16, 44]];

module FreeSerif_letter0x6c(detail=2) {

	FreeSerif_chunk10x6c(steps=detail);

} //end skeleton



module FreeSerif_contour00x6d_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[1, 25], [1.0, 26.0], [1, 27], 

		[6, 28], [10, 29], [10.5, 29.0], 

		[11, 29], [11.0, 27.0], [11, 25], 

		[15, 28], [16.5, 28.5], [18, 29], 

		[21, 29], [26, 29], [27, 24], 

		[32, 29], [38, 29], [45, 29], 

		[45, 18], [45.0, 11.5], [45, 5], 

		[45, 1], [48, 1], [49.0, 1.0], 

		[50, 1], [50.0, 0.5], [50, 0], 

		[43.0, 0.0], [36, 0], [36.0, 0.5], 

		[36, 1], [38, 1], [39.0, 2.0], 

		[40, 3], [40, 6], [40.0, 12.5], 

		[40, 19], [40, 23], [39.0, 24.5], 

		[38, 26], [35, 26], [31, 26], 

		[28, 22], [28.0, 14.0], [28, 6], 

		[28, 3], [29.0, 2.0], [30, 1], 

		[33, 1], [33.0, 0.5], [33, 0], 

		[25.5, 0.0], [18, 0], [18.0, 0.5], 

		[18, 1], [21, 1], [22.0, 2.0], 

		[23, 3], [23, 6], [23.0, 12.5], 

		[23, 19], [23, 26], [18, 26], 

		[17, 26], [15.0, 25.5], [13, 25], 

		[12, 24], [11, 23], [11, 22], 

		[11.0, 13.0], [11, 4], [11, 2], 

		[12.0, 1.5], [13, 1], [15, 1], 

		[15.0, 0.5], [15, 0], [8.0, 0.0], 

		[1, 0], [1.0, 0.5], [1, 1], 

		[4, 1], [5.0, 2.0], [6, 3], 

		[6, 5], [6.0, 13.5], [6, 22], 

		[6, 24], [5.5, 25.0], [5, 26], 

		[3, 26],[2, 26], ]);

}

module FreeSerif_contour00x6d_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([1, 27], [6, 28], [10, 29],steps,10);

	BezConic([45, 5], [45, 1], [48, 1],steps,10);

	BezConic([36, 1], [38, 1], [39.0, 2.0],steps,10);

	BezConic([39.0, 2.0], [40, 3], [40, 6],steps,10);

	BezConic([40, 19], [40, 23], [39.0, 24.5],steps,10);

	BezConic([39.0, 24.5], [38, 26], [35, 26],steps,10);

	BezConic([35, 26], [31, 26], [28, 22],steps,10);

	BezConic([28, 6], [28, 3], [29.0, 2.0],steps,10);

	BezConic([29.0, 2.0], [30, 1], [33, 1],steps,10);

	BezConic([18, 1], [21, 1], [22.0, 2.0],steps,10);

	BezConic([22.0, 2.0], [23, 3], [23, 6],steps,10);

	BezConic([23, 19], [23, 26], [18, 26],steps,10);

	BezConic([18, 26], [17, 26], [15.0, 25.5],steps,10);

	BezConic([15.0, 25.5], [13, 25], [12, 24],steps,10);

	BezConic([12, 24], [11, 23], [11, 22],steps,10);

	BezConic([11, 4], [11, 2], [12.0, 1.5],steps,10);

	BezConic([12.0, 1.5], [13, 1], [15, 1],steps,10);

	BezConic([1, 1], [4, 1], [5.0, 2.0],steps,10);

	BezConic([5.0, 2.0], [6, 3], [6, 5],steps,10);

	BezConic([6, 22], [6, 24], [5.5, 25.0],steps,10);

	BezConic([5.5, 25.0], [5, 26], [3, 26],steps,10);

	BezConic([3, 26], [2, 26], [1, 25],steps,10);

}

}

module FreeSerif_contour00x6d_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([11, 25], [15, 28], [16.5, 28.5],steps,10);

	BezConic([16.5, 28.5], [18, 29], [21, 29],steps,10);

	BezConic([21, 29], [26, 29], [27, 24],steps,10);

	BezConic([27, 24], [32, 29], [38, 29],steps,10);

	BezConic([38, 29], [45, 29], [45, 18],steps,10);

}

}

module FreeSerif_contour00x6d(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x6d_skeleton();
			FreeSerif_contour00x6d_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x6d_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x6d(steps=2) {
	difference() {
		FreeSerif_contour00x6d(steps);
		
	}
}

FreeSerif_bbox0x6d=[[1, 0], [50, 29]];

module FreeSerif_letter0x6d(detail=2) {

	FreeSerif_chunk10x6d(steps=detail);

} //end skeleton



module FreeSerif_contour00x6e_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[1, 25], [1.0, 26.0], [1, 27], 

		[6, 28], [10, 29], [10.0, 29.0], 

		[10, 29], [10.0, 26.5], [10, 24], 

		[14, 27], [15.5, 28.0], [17, 29], 

		[20, 29], [23, 29], [25.0, 26.5], 

		[27, 24], [27, 20], [27.0, 12.5], 

		[27, 5], [27, 3], [28.0, 2.0], 

		[29, 1], [31, 1], [31.0, 0.5], 

		[31, 0], [24.5, 0.0], [18, 0], 

		[18.0, 0.5], [18, 1], [20, 1], 

		[21.0, 2.0], [22, 3], [22, 6], 

		[22.0, 13.0], [22, 20], [22, 26], 

		[17, 26], [15, 26], [14.0, 25.0], 

		[13, 24], [10, 22], [10.0, 13.0], 

		[10, 4], [10, 3], [11.0, 2.0], 

		[12, 1], [15, 1], [15.0, 0.5], 

		[15, 0], [8.0, 0.0], [1, 0], 

		[1.0, 0.5], [1, 1], [4, 1], 

		[4.5, 2.0], [5, 3], [5, 6], 

		[5.0, 14.0], [5, 22], [5, 24], 

		[4.5, 25.0], [4, 26], [3, 26], 

		[2, 26], ]);

}

module FreeSerif_contour00x6e_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([1, 27], [6, 28], [10, 29],steps,10);

	BezConic([27, 5], [27, 3], [28.0, 2.0],steps,10);

	BezConic([28.0, 2.0], [29, 1], [31, 1],steps,10);

	BezConic([18, 1], [20, 1], [21.0, 2.0],steps,10);

	BezConic([21.0, 2.0], [22, 3], [22, 6],steps,10);

	BezConic([22, 20], [22, 26], [17, 26],steps,10);

	BezConic([17, 26], [15, 26], [14.0, 25.0],steps,10);

	BezConic([10, 4], [10, 3], [11.0, 2.0],steps,10);

	BezConic([11.0, 2.0], [12, 1], [15, 1],steps,10);

	BezConic([1, 1], [4, 1], [4.5, 2.0],steps,10);

	BezConic([4.5, 2.0], [5, 3], [5, 6],steps,10);

	BezConic([5, 22], [5, 24], [4.5, 25.0],steps,10);

	BezConic([4.5, 25.0], [4, 26], [3, 26],steps,10);

	BezConic([3, 26], [2, 26], [1, 25],steps,10);

}

}

module FreeSerif_contour00x6e_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([10, 24], [14, 27], [15.5, 28.0],steps,10);

	BezConic([15.5, 28.0], [17, 29], [20, 29],steps,10);

	BezConic([20, 29], [23, 29], [25.0, 26.5],steps,10);

	BezConic([25.0, 26.5], [27, 24], [27, 20],steps,10);

	BezConic([14.0, 25.0], [13, 24], [10, 22],steps,10);

}

}

module FreeSerif_contour00x6e(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x6e_skeleton();
			FreeSerif_contour00x6e_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x6e_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x6e(steps=2) {
	difference() {
		FreeSerif_contour00x6e(steps);
		
	}
}

FreeSerif_bbox0x6e=[[1, 0], [31, 29]];

module FreeSerif_letter0x6e(detail=2) {

	FreeSerif_chunk10x6e(steps=detail);

} //end skeleton



module FreeSerif_contour00x6f_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[16, 29], [22, 29], [26.0, 25.0], 

		[30, 21], [30, 15], [30, 8], 

		[26.0, 3.5], [22, -1], [16.0, -1.0], 

		[10, -1], [6.0, 3.5], [2, 8], 

		[2, 14], [2, 21], [6.0, 25.0], 

		[10, 29], ]);

}

module FreeSerif_contour00x6f_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x6f_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([16, 29], [22, 29], [26.0, 25.0],steps,10);

	BezConic([26.0, 25.0], [30, 21], [30, 15],steps,10);

	BezConic([30, 15], [30, 8], [26.0, 3.5],steps,10);

	BezConic([26.0, 3.5], [22, -1], [16.0, -1.0],steps,10);

	BezConic([16.0, -1.0], [10, -1], [6.0, 3.5],steps,10);

	BezConic([6.0, 3.5], [2, 8], [2, 14],steps,10);

	BezConic([2, 14], [2, 21], [6.0, 25.0],steps,10);

	BezConic([6.0, 25.0], [10, 29], [16, 29],steps,10);

}

}

module FreeSerif_contour00x6f(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x6f_skeleton();
			FreeSerif_contour00x6f_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x6f_subtractive_curves(steps);
	}
}

module FreeSerif_contour10x6f_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[8, 18], [8, 11], [10.5, 6.0], 

		[13, 1], [17, 1], [20, 1], 

		[22.0, 4.0], [24, 7], [24, 13], 

		[24, 19], [21.5, 23.5], [19, 28], 

		[15, 28], [12, 28], [10.0, 25.0], 

		[8, 22], ]);

}

module FreeSerif_contour10x6f_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([8, 18], [8, 11], [10.5, 6.0],steps,10);

	BezConic([10.5, 6.0], [13, 1], [17, 1],steps,10);

	BezConic([17, 1], [20, 1], [22.0, 4.0],steps,10);

	BezConic([22.0, 4.0], [24, 7], [24, 13],steps,10);

	BezConic([24, 13], [24, 19], [21.5, 23.5],steps,10);

	BezConic([21.5, 23.5], [19, 28], [15, 28],steps,10);

	BezConic([15, 28], [12, 28], [10.0, 25.0],steps,10);

	BezConic([10.0, 25.0], [8, 22], [8, 18],steps,10);

}

}

module FreeSerif_contour10x6f_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour10x6f(steps=2) {
	difference() {
		union() {
			FreeSerif_contour10x6f_skeleton();
			FreeSerif_contour10x6f_subtractive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour10x6f_additive_curves(steps);
	}
}

module FreeSerif_chunk10x6f(steps=2) {
	difference() {
		FreeSerif_contour00x6f(steps);
		scale([1,1,1.1]) FreeSerif_contour10x6f(steps);
	}
}

FreeSerif_bbox0x6f=[[2, -1], [30, 29]];

module FreeSerif_letter0x6f(detail=2) {

	FreeSerif_chunk10x6f(steps=detail);

} //end skeleton



module FreeSerif_contour00x70_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[1, 25], [1.0, 25.5], [1, 26], 

		[5, 27], [10, 29], [10.0, 29.0], 

		[10, 29], [10.0, 26.5], [10, 24], 

		[14, 29], [19, 29], [24, 29], 

		[27.0, 25.5], [30, 22], [30, 16], 

		[30, 9], [26.0, 4.0], [22, -1], 

		[17, -1], [15, -1], [13.5, 0.0], 

		[12, 1], [10, 2], [10.0, -3.0], 

		[10, -8], [10, -11], [11.0, -12.0], 

		[12, -13], [16, -13], [16.0, -13.5], 

		[16, -14], [8.0, -14.0], [0, -14], 

		[0.0, -13.5], [0, -13], [3, -13], 

		[4.0, -12.0], [5, -11], [5, -8], 

		[5.0, 7.0], [5, 22], [5, 24], 

		[4.5, 24.5], [4, 25], [2, 25], 

		[1, 25], ]);

}

module FreeSerif_contour00x70_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([1, 26], [5, 27], [10, 29],steps,10);

	BezConic([13.5, 0.0], [12, 1], [10, 2],steps,10);

	BezConic([10, -8], [10, -11], [11.0, -12.0],steps,10);

	BezConic([11.0, -12.0], [12, -13], [16, -13],steps,10);

	BezConic([0, -13], [3, -13], [4.0, -12.0],steps,10);

	BezConic([4.0, -12.0], [5, -11], [5, -8],steps,10);

	BezConic([5, 22], [5, 24], [4.5, 24.5],steps,10);

	BezConic([4.5, 24.5], [4, 25], [2, 25],steps,10);

	BezConic([2, 25], [1, 25], [1, 25],steps,10);

}

}

module FreeSerif_contour00x70_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([10, 24], [14, 29], [19, 29],steps,10);

	BezConic([19, 29], [24, 29], [27.0, 25.5],steps,10);

	BezConic([27.0, 25.5], [30, 22], [30, 16],steps,10);

	BezConic([30, 16], [30, 9], [26.0, 4.0],steps,10);

	BezConic([26.0, 4.0], [22, -1], [17, -1],steps,10);

	BezConic([17, -1], [15, -1], [13.5, 0.0],steps,10);

}

}

module FreeSerif_contour00x70(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x70_skeleton();
			FreeSerif_contour00x70_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x70_subtractive_curves(steps);
	}
}

module FreeSerif_contour10x70_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[10, 21], [10.0, 13.5], [10, 6], 

		[10, 4], [12.5, 2.5], [15, 1], 

		[17, 1], [20, 1], [22.5, 4.5], 

		[25, 8], [25, 13], [25, 19], 

		[22.5, 22.5], [20, 26], [17, 26], 

		[14, 26], [12.0, 24.5], [10, 23], 

		 ]);

}

module FreeSerif_contour10x70_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([10, 6], [10, 4], [12.5, 2.5],steps,10);

	BezConic([12.5, 2.5], [15, 1], [17, 1],steps,10);

	BezConic([17, 1], [20, 1], [22.5, 4.5],steps,10);

	BezConic([22.5, 4.5], [25, 8], [25, 13],steps,10);

	BezConic([25, 13], [25, 19], [22.5, 22.5],steps,10);

	BezConic([22.5, 22.5], [20, 26], [17, 26],steps,10);

	BezConic([17, 26], [14, 26], [12.0, 24.5],steps,10);

	BezConic([12.0, 24.5], [10, 23], [10, 21],steps,10);

}

}

module FreeSerif_contour10x70_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour10x70(steps=2) {
	difference() {
		union() {
			FreeSerif_contour10x70_skeleton();
			FreeSerif_contour10x70_subtractive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour10x70_additive_curves(steps);
	}
}

module FreeSerif_chunk10x70(steps=2) {
	difference() {
		FreeSerif_contour00x70(steps);
		scale([1,1,1.1]) FreeSerif_contour10x70(steps);
	}
}

FreeSerif_bbox0x70=[[0, -14], [30, 29]];

module FreeSerif_letter0x70(detail=2) {

	FreeSerif_chunk10x70(steps=detail);

} //end skeleton



module FreeSerif_contour00x71_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[23, 27], [24.5, 28.0], [26, 29], 

		[26.5, 29.0], [27, 29], [27.0, 10.0], 

		[27, -9], [27, -11], [28.0, -11.5], 

		[29, -12], [31, -13], [31.0, -13.5], 

		[31, -14], [23.5, -14.0], [16, -14], 

		[16.0, -13.5], [16, -13], [20, -13], 

		[21.0, -12.0], [22, -11], [22, -8], 

		[22.0, -2.0], [22, 4], [17, -1], 

		[12, -1], [7, -1], [4.5, 3.0], 

		[2, 7], [2, 13], [2, 20], 

		[6.0, 25.0], [10, 30], [16, 30], 

		[19, 30], ]);

}

module FreeSerif_contour00x71_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([27, -9], [27, -11], [28.0, -11.5],steps,10);

	BezConic([28.0, -11.5], [29, -12], [31, -13],steps,10);

	BezConic([16, -13], [20, -13], [21.0, -12.0],steps,10);

	BezConic([21.0, -12.0], [22, -11], [22, -8],steps,10);

}

}

module FreeSerif_contour00x71_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([22, 4], [17, -1], [12, -1],steps,10);

	BezConic([12, -1], [7, -1], [4.5, 3.0],steps,10);

	BezConic([4.5, 3.0], [2, 7], [2, 13],steps,10);

	BezConic([2, 13], [2, 20], [6.0, 25.0],steps,10);

	BezConic([6.0, 25.0], [10, 30], [16, 30],steps,10);

	BezConic([16, 30], [19, 30], [23, 27],steps,10);

}

}

module FreeSerif_contour00x71(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x71_skeleton();
			FreeSerif_contour00x71_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x71_subtractive_curves(steps);
	}
}

module FreeSerif_contour10x71_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[7, 15], [7, 13], [7.5, 10.5], 

		[8, 8], [10.0, 5.5], [12, 3], 

		[15, 3], [19, 3], [21, 5], 

		[22, 6], [22, 8], [22.0, 14.5], 

		[22, 21], [22, 28], [16, 28], 

		[12, 28], [9.5, 24.5], [7, 21], 

		 ]);

}

module FreeSerif_contour10x71_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([7, 15], [7, 13], [7.5, 10.5],steps,10);

	BezConic([7.5, 10.5], [8, 8], [10.0, 5.5],steps,10);

	BezConic([10.0, 5.5], [12, 3], [15, 3],steps,10);

	BezConic([15, 3], [19, 3], [21, 5],steps,10);

	BezConic([21, 5], [22, 6], [22, 8],steps,10);

	BezConic([22, 21], [22, 28], [16, 28],steps,10);

	BezConic([16, 28], [12, 28], [9.5, 24.5],steps,10);

	BezConic([9.5, 24.5], [7, 21], [7, 15],steps,10);

}

}

module FreeSerif_contour10x71_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour10x71(steps=2) {
	difference() {
		union() {
			FreeSerif_contour10x71_skeleton();
			FreeSerif_contour10x71_subtractive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour10x71_additive_curves(steps);
	}
}

module FreeSerif_chunk10x71(steps=2) {
	difference() {
		FreeSerif_contour00x71(steps);
		scale([1,1,1.1]) FreeSerif_contour10x71(steps);
	}
}

FreeSerif_bbox0x71=[[2, -14], [31, 30]];

module FreeSerif_letter0x71(detail=2) {

	FreeSerif_chunk10x71(steps=detail);

} //end skeleton



module FreeSerif_contour00x72_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[19, 23], [18, 23], [16.5, 24.0], 

		[15, 25], [15, 25], [13, 25], 

		[11.5, 23.5], [10, 22], [10, 20], 

		[10.0, 13.0], [10, 6], [10, 3], 

		[11.0, 2.0], [12, 1], [16, 1], 

		[16.0, 0.5], [16, 0], [8.0, 0.0], 

		[0, 0], [0.0, 0.5], [0, 1], 

		[3, 2], [4.0, 2.5], [5, 3], 

		[5, 5], [5.0, 13.0], [5, 21], 

		[5, 23], [4.5, 24.0], [4, 25], 

		[3, 25], [2, 25], [0, 25], 

		[0.0, 25.5], [0, 26], [6, 28], 

		[10, 29], [10.0, 29.0], [10, 29], 

		[10.0, 26.0], [10, 23], [13, 27], 

		[14.5, 28.0], [16, 29], [18, 29], 

		[20, 29], [20.5, 28.5], [21, 28], 

		[21, 26], [21, 25], [20.5, 24.0], 

		[20, 23], ]);

}

module FreeSerif_contour00x72_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([16.5, 24.0], [15, 25], [15, 25],steps,10);

	BezConic([15, 25], [13, 25], [11.5, 23.5],steps,10);

	BezConic([11.5, 23.5], [10, 22], [10, 20],steps,10);

	BezConic([10, 6], [10, 3], [11.0, 2.0],steps,10);

	BezConic([11.0, 2.0], [12, 1], [16, 1],steps,10);

	BezConic([0, 1], [3, 2], [4.0, 2.5],steps,10);

	BezConic([4.0, 2.5], [5, 3], [5, 5],steps,10);

	BezConic([5, 21], [5, 23], [4.5, 24.0],steps,10);

	BezConic([4.5, 24.0], [4, 25], [3, 25],steps,10);

	BezConic([3, 25], [2, 25], [0, 25],steps,10);

}

}

module FreeSerif_contour00x72_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([19, 23], [18, 23], [16.5, 24.0],steps,10);

	BezConic([0, 26], [6, 28], [10, 29],steps,10);

	BezConic([10, 23], [13, 27], [14.5, 28.0],steps,10);

	BezConic([14.5, 28.0], [16, 29], [18, 29],steps,10);

	BezConic([18, 29], [20, 29], [20.5, 28.5],steps,10);

	BezConic([20.5, 28.5], [21, 28], [21, 26],steps,10);

	BezConic([21, 26], [21, 25], [20.5, 24.0],steps,10);

	BezConic([20.5, 24.0], [20, 23], [19, 23],steps,10);

}

}

module FreeSerif_contour00x72(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x72_skeleton();
			FreeSerif_contour00x72_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x72_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x72(steps=2) {
	difference() {
		FreeSerif_contour00x72(steps);
		
	}
}

FreeSerif_bbox0x72=[[0, 0], [21, 29]];

module FreeSerif_letter0x72(detail=2) {

	FreeSerif_chunk10x72(steps=detail);

} //end skeleton



module FreeSerif_contour00x73_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[18, 28], [18, 28], [19, 29], 

		[19.5, 29.0], [20, 29], [20.0, 24.5], 

		[20, 20], [19.5, 20.0], [19, 20], 

		[18, 24], [16.5, 26.0], [15, 28], 

		[12, 28], [10, 28], [8.5, 27.0], 

		[7, 26], [7, 24], [7, 21], 

		[10, 19], [13.5, 17.0], [17, 15], 

		[20, 13], [21.0, 11.5], [22, 10], 

		[22, 8], [22, 4], [19.5, 1.5], 

		[17, -1], [13, -1], [12, -1], 

		[9.0, 0.0], [6, 1], [6, 1], 

		[5, 1], [4, 0], [3.5, 0.0], 

		[3, 0], [3.0, 5.0], [3, 10], 

		[3.5, 10.0], [4, 10], [5, 5], 

		[7, 3], [9, 1], [12, 1], 

		[15, 1], [16.5, 2.0], [18, 3], 

		[18, 5], [18, 8], [14, 10], 

		[12.5, 11.0], [11, 12], [7, 15], 

		[5.0, 17.0], [3, 19], [3, 22], 

		[3, 25], [5.5, 27.0], [8, 29], 

		[12, 29], [14, 29], [16.0, 28.5], 

		[18, 28], ]);

}

module FreeSerif_contour00x73_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([18, 28], [18, 28], [19, 29],steps,10);

	BezConic([19, 20], [18, 24], [16.5, 26.0],steps,10);

	BezConic([16.5, 26.0], [15, 28], [12, 28],steps,10);

	BezConic([12, 28], [10, 28], [8.5, 27.0],steps,10);

	BezConic([8.5, 27.0], [7, 26], [7, 24],steps,10);

	BezConic([7, 24], [7, 21], [10, 19],steps,10);

	BezConic([9.0, 0.0], [6, 1], [6, 1],steps,10);

	BezConic([6, 1], [5, 1], [4, 0],steps,10);

	BezConic([4, 10], [5, 5], [7, 3],steps,10);

	BezConic([7, 3], [9, 1], [12, 1],steps,10);

	BezConic([12, 1], [15, 1], [16.5, 2.0],steps,10);

	BezConic([16.5, 2.0], [18, 3], [18, 5],steps,10);

	BezConic([18, 5], [18, 8], [14, 10],steps,10);

	BezConic([16.0, 28.5], [18, 28], [18, 28],steps,10);

}

}

module FreeSerif_contour00x73_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([17, 15], [20, 13], [21.0, 11.5],steps,10);

	BezConic([21.0, 11.5], [22, 10], [22, 8],steps,10);

	BezConic([22, 8], [22, 4], [19.5, 1.5],steps,10);

	BezConic([19.5, 1.5], [17, -1], [13, -1],steps,10);

	BezConic([13, -1], [12, -1], [9.0, 0.0],steps,10);

	BezConic([11, 12], [7, 15], [5.0, 17.0],steps,10);

	BezConic([5.0, 17.0], [3, 19], [3, 22],steps,10);

	BezConic([3, 22], [3, 25], [5.5, 27.0],steps,10);

	BezConic([5.5, 27.0], [8, 29], [12, 29],steps,10);

	BezConic([12, 29], [14, 29], [16.0, 28.5],steps,10);

}

}

module FreeSerif_contour00x73(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x73_skeleton();
			FreeSerif_contour00x73_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x73_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x73(steps=2) {
	difference() {
		FreeSerif_contour00x73(steps);
		
	}
}

FreeSerif_bbox0x73=[[3, -1], [22, 29]];

module FreeSerif_letter0x73(detail=2) {

	FreeSerif_chunk10x73(steps=detail);

} //end skeleton



module FreeSerif_contour00x74_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[16, 29], [16.0, 28.0], [16, 27], 

		[13.0, 27.0], [10, 27], [10.0, 17.5], 

		[10, 8], [10, 5], [10.5, 4.0], 

		[11, 3], [13, 3], [15, 3], 

		[17, 5], [17.5, 4.5], [18, 4], 

		[15, -1], [10, -1], [4, -1], 

		[4, 7], [4.0, 17.0], [4, 27], 

		[2.5, 27.0], [1, 27], [1, 27], 

		[1, 27], [1, 28], [1.0, 28.0], 

		[1, 28], [1.5, 28.5], [2, 29], 

		[3.0, 29.5], [4, 30], [5.5, 31.5], 

		[7, 33], [8, 35], [9, 37], 

		[9, 37], [10, 37], [10, 36], 

		[10.0, 32.5], [10, 29], [13.0, 29.0], 

		 ]);

}

module FreeSerif_contour00x74_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([10, 8], [10, 5], [10.5, 4.0],steps,10);

	BezConic([10.5, 4.0], [11, 3], [13, 3],steps,10);

	BezConic([13, 3], [15, 3], [17, 5],steps,10);

	BezConic([1, 27], [1, 27], [1, 27],steps,10);

	BezConic([1, 27], [1, 28], [1.0, 28.0],steps,10);

	BezConic([1.0, 28.0], [1, 28], [1.5, 28.5],steps,10);

	BezConic([3.0, 29.5], [4, 30], [5.5, 31.5],steps,10);

	BezConic([5.5, 31.5], [7, 33], [8, 35],steps,10);

	BezConic([8, 35], [9, 37], [9, 37],steps,10);

}

}

module FreeSerif_contour00x74_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([18, 4], [15, -1], [10, -1],steps,10);

	BezConic([10, -1], [4, -1], [4, 7],steps,10);

	BezConic([1.5, 28.5], [2, 29], [3.0, 29.5],steps,10);

	BezConic([9, 37], [10, 37], [10, 36],steps,10);

}

}

module FreeSerif_contour00x74(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x74_skeleton();
			FreeSerif_contour00x74_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x74_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x74(steps=2) {
	difference() {
		FreeSerif_contour00x74(steps);
		
	}
}

FreeSerif_bbox0x74=[[1, -1], [18, 37]];

module FreeSerif_letter0x74(detail=2) {

	FreeSerif_chunk10x74(steps=detail);

} //end skeleton



module FreeSerif_contour00x75_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[31, 3], [31.0, 2.5], [31, 2], 

		[26, 1], [22, -1], [22.0, -0.5], 

		[22, 0], [22.0, 2.5], [22, 5], 

		[20.5, 3.5], [19, 2], [16, -1], 

		[12, -1], [9, -1], [7.0, 1.5], 

		[5, 4], [5, 8], [5.0, 16.0], 

		[5, 24], [5, 26], [4.0, 27.0], 

		[3, 28], [1, 28], [1.0, 28.5], 

		[1, 29], [5.5, 29.0], [10, 29], 

		[10.0, 18.5], [10, 8], [10, 6], 

		[11.5, 4.5], [13, 3], [14, 3], 

		[17, 3], [20, 5], [21, 6], 

		[21, 9], [21.0, 16.5], [21, 24], 

		[21, 26], [20.5, 27.0], [20, 28], 

		[17, 28], [17.0, 28.5], [17, 29], 

		[22.0, 29.0], [27, 29], [27.0, 18.0], 

		[27, 7], [27, 5], [27.5, 4.0], 

		[28, 3], [30, 3], [30.5, 3.0], 

		 ]);

}

module FreeSerif_contour00x75_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([31, 2], [26, 1], [22, -1],steps,10);

	BezConic([5, 24], [5, 26], [4.0, 27.0],steps,10);

	BezConic([4.0, 27.0], [3, 28], [1, 28],steps,10);

	BezConic([10, 8], [10, 6], [11.5, 4.5],steps,10);

	BezConic([11.5, 4.5], [13, 3], [14, 3],steps,10);

	BezConic([14, 3], [17, 3], [20, 5],steps,10);

	BezConic([20, 5], [21, 6], [21, 9],steps,10);

	BezConic([21, 24], [21, 26], [20.5, 27.0],steps,10);

	BezConic([20.5, 27.0], [20, 28], [17, 28],steps,10);

	BezConic([27, 7], [27, 5], [27.5, 4.0],steps,10);

	BezConic([27.5, 4.0], [28, 3], [30, 3],steps,10);

}

}

module FreeSerif_contour00x75_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([19, 2], [16, -1], [12, -1],steps,10);

	BezConic([12, -1], [9, -1], [7.0, 1.5],steps,10);

	BezConic([7.0, 1.5], [5, 4], [5, 8],steps,10);

}

}

module FreeSerif_contour00x75(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x75_skeleton();
			FreeSerif_contour00x75_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x75_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x75(steps=2) {
	difference() {
		FreeSerif_contour00x75(steps);
		
	}
}

FreeSerif_bbox0x75=[[1, -1], [31, 29]];

module FreeSerif_letter0x75(detail=2) {

	FreeSerif_chunk10x75(steps=detail);

} //end skeleton



module FreeSerif_contour00x76_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[31, 29], [31.0, 28.5], [31, 28], 

		[29, 28], [28.5, 27.0], [28, 26], 

		[26, 23], [22.0, 12.5], [18, 2], 

		[17, -1], [16, -1], [16, -1], 

		[15, 2], [11.0, 11.0], [7, 20], 

		[5, 25], [4.0, 26.5], [3, 28], 

		[1, 28], [1.0, 28.5], [1, 29], 

		[7.5, 29.0], [14, 29], [14.0, 28.5], 

		[14, 28], [12, 28], [11.5, 27.5], 

		[11, 27], [11, 26], [11, 25], 

		[11, 24], [14.5, 15.5], [18, 7], 

		[21.0, 15.5], [24, 24], [25, 25], 

		[25, 26], [25, 28], [22, 28], 

		[22.0, 28.5], [22, 29], [26.5, 29.0], 

		 ]);

}

module FreeSerif_contour00x76_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([31, 28], [29, 28], [28.5, 27.0],steps,10);

	BezConic([16, -1], [16, -1], [15, 2],steps,10);

	BezConic([7, 20], [5, 25], [4.0, 26.5],steps,10);

	BezConic([4.0, 26.5], [3, 28], [1, 28],steps,10);

	BezConic([14, 28], [12, 28], [11.5, 27.5],steps,10);

	BezConic([11.5, 27.5], [11, 27], [11, 26],steps,10);

	BezConic([11, 26], [11, 25], [11, 24],steps,10);

	BezConic([24, 24], [25, 25], [25, 26],steps,10);

	BezConic([25, 26], [25, 28], [22, 28],steps,10);

}

}

module FreeSerif_contour00x76_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([28.5, 27.0], [28, 26], [26, 23],steps,10);

	BezConic([18, 2], [17, -1], [16, -1],steps,10);

}

}

module FreeSerif_contour00x76(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x76_skeleton();
			FreeSerif_contour00x76_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x76_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x76(steps=2) {
	difference() {
		FreeSerif_contour00x76(steps);
		
	}
}

FreeSerif_bbox0x76=[[1, -1], [31, 29]];

module FreeSerif_letter0x76(detail=2) {

	FreeSerif_chunk10x76(steps=detail);

} //end skeleton



module FreeSerif_contour00x77_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[22, 20], [21, 25], [20.0, 26.5], 

		[19, 28], [17, 28], [17.0, 28.5], 

		[17, 29], [23.5, 29.0], [30, 29], 

		[30.0, 28.5], [30, 28], [28, 28], 

		[27.0, 27.5], [26, 27], [26, 26], 

		[26, 25], [27, 22], [30.0, 14.5], 

		[33, 7], [35.5, 14.5], [38, 22], 

		[39, 24], [39, 26], [39, 27], 

		[38.5, 27.5], [38, 28], [37, 28], 

		[37.0, 28.5], [37, 29], [40.5, 29.0], 

		[44, 29], [44.0, 28.5], [44, 28], 

		[43, 28], [43.0, 27.0], [43, 26], 

		[42, 24], [37.5, 13.0], [33, 2], 

		[32, -1], [31.5, -1.0], [31, -1], 

		[30, 2], [27.0, 9.5], [24, 17], 

		[20.5, 9.5], [17, 2], [15, -1], 

		[15, -1], [15, -1], [13, 2], 

		[9.0, 13.0], [5, 24], [4, 26], 

		[3.0, 27.0], [2, 28], [1, 28], 

		[1.0, 28.5], [1, 29], [7.0, 29.0], 

		[13, 29], [13.0, 28.5], [13, 28], 

		[11, 28], [10.5, 27.5], [10, 27], 

		[10, 26], [10, 25], [10, 24], 

		[13.5, 15.5], [17, 7], [19.5, 13.5], 

		 ]);

}

module FreeSerif_contour00x77_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([22, 20], [21, 25], [20.0, 26.5],steps,10);

	BezConic([20.0, 26.5], [19, 28], [17, 28],steps,10);

	BezConic([30, 28], [28, 28], [27.0, 27.5],steps,10);

	BezConic([27.0, 27.5], [26, 27], [26, 26],steps,10);

	BezConic([26, 26], [26, 25], [27, 22],steps,10);

	BezConic([38, 22], [39, 24], [39, 26],steps,10);

	BezConic([39, 26], [39, 27], [38.5, 27.5],steps,10);

	BezConic([38.5, 27.5], [38, 28], [37, 28],steps,10);

	BezConic([44, 28], [43, 28], [43.0, 27.0],steps,10);

	BezConic([17, 2], [15, -1], [15, -1],steps,10);

	BezConic([15, -1], [15, -1], [13, 2],steps,10);

	BezConic([5, 24], [4, 26], [3.0, 27.0],steps,10);

	BezConic([3.0, 27.0], [2, 28], [1, 28],steps,10);

	BezConic([13, 28], [11, 28], [10.5, 27.5],steps,10);

	BezConic([10.5, 27.5], [10, 27], [10, 26],steps,10);

	BezConic([10, 26], [10, 25], [10, 24],steps,10);

}

}

module FreeSerif_contour00x77_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([43.0, 27.0], [43, 26], [42, 24],steps,10);

	BezConic([33, 2], [32, -1], [31.5, -1.0],steps,10);

	BezConic([31.5, -1.0], [31, -1], [30, 2],steps,10);

}

}

module FreeSerif_contour00x77(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x77_skeleton();
			FreeSerif_contour00x77_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x77_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x77(steps=2) {
	difference() {
		FreeSerif_contour00x77(steps);
		
	}
}

FreeSerif_bbox0x77=[[1, -1], [44, 29]];

module FreeSerif_letter0x77(detail=2) {

	FreeSerif_chunk10x77(steps=detail);

} //end skeleton



module FreeSerif_contour00x78_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[16, 19], [17, 21], [17.5, 22.0], 

		[18, 23], [18.5, 24.0], [19, 25], 

		[19.5, 25.5], [20, 26], [20, 26], 

		[20, 28], [18, 28], [18.0, 28.5], 

		[18, 29], [23.0, 29.0], [28, 29], 

		[28.0, 28.5], [28, 28], [24, 28], 

		[23, 25], [20.0, 21.0], [17, 17], 

		[21.0, 11.0], [25, 5], [27, 3], 

		[28.0, 2.0], [29, 1], [31, 1], 

		[31.0, 0.5], [31, 0], [24.5, 0.0], 

		[18, 0], [18.0, 0.5], [18, 1], 

		[19, 1], [19.5, 1.5], [20, 2], 

		[20, 2], [20, 3], [20, 4], 

		[17.0, 8.5], [14, 13], [11.5, 9.0], 

		[9, 5], [8, 3], [8, 2], 

		[8, 1], [10, 1], [10.0, 0.5], 

		[10, 0], [5.5, 0.0], [1, 0], 

		[1.0, 0.5], [1, 1], [3, 1], 

		[3.5, 1.5], [4, 2], [6, 4], 

		[9.5, 9.5], [13, 15], [10.0, 19.5], 

		[7, 24], [6, 26], [5.0, 27.0], 

		[4, 28], [2, 28], [2.0, 28.0], 

		[2, 28], [2.0, 28.5], [2, 29], 

		[8.5, 29.0], [15, 29], [15.0, 28.5], 

		[15, 28], [12, 28], [12, 26], 

		[12, 25], [15, 21], [15.5, 20.0], 

		 ]);

}

module FreeSerif_contour00x78_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([16, 19], [17, 21], [17.5, 22.0],steps,10);

	BezConic([17.5, 22.0], [18, 23], [18.5, 24.0],steps,10);

	BezConic([19.5, 25.5], [20, 26], [20, 26],steps,10);

	BezConic([20, 26], [20, 28], [18, 28],steps,10);

	BezConic([28, 28], [24, 28], [23, 25],steps,10);

	BezConic([25, 5], [27, 3], [28.0, 2.0],steps,10);

	BezConic([28.0, 2.0], [29, 1], [31, 1],steps,10);

	BezConic([18, 1], [19, 1], [19.5, 1.5],steps,10);

	BezConic([19.5, 1.5], [20, 2], [20, 2],steps,10);

	BezConic([20, 2], [20, 3], [20, 4],steps,10);

	BezConic([9, 5], [8, 3], [8, 2],steps,10);

	BezConic([8, 2], [8, 1], [10, 1],steps,10);

	BezConic([1, 1], [3, 1], [3.5, 1.5],steps,10);

	BezConic([3.5, 1.5], [4, 2], [6, 4],steps,10);

	BezConic([7, 24], [6, 26], [5.0, 27.0],steps,10);

	BezConic([5.0, 27.0], [4, 28], [2, 28],steps,10);

	BezConic([15, 28], [12, 28], [12, 26],steps,10);

	BezConic([12, 26], [12, 25], [15, 21],steps,10);

}

}

module FreeSerif_contour00x78_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([18.5, 24.0], [19, 25], [19.5, 25.5],steps,10);

}

}

module FreeSerif_contour00x78(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x78_skeleton();
			FreeSerif_contour00x78_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x78_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x78(steps=2) {
	difference() {
		FreeSerif_contour00x78(steps);
		
	}
}

FreeSerif_bbox0x78=[[1, 0], [31, 29]];

module FreeSerif_letter0x78(detail=2) {

	FreeSerif_chunk10x78(steps=detail);

} //end skeleton



module FreeSerif_contour00x79_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[10, -9], [11, -9], [13.0, -5.0], 

		[15, -1], [15, 1], [15, 3], 

		[13, 8], [12.5, 9.0], [12, 10], 

		[8.0, 18.0], [4, 26], [3, 28], 

		[1, 28], [1.0, 28.5], [1, 29], 

		[7.5, 29.0], [14, 29], [14.0, 28.5], 

		[14, 28], [12, 28], [11.0, 27.5], 

		[10, 27], [10, 26], [10, 25], 

		[11, 24], [14.5, 15.5], [18, 7], 

		[21.5, 16.0], [25, 25], [25, 26], 

		[25, 26], [25, 28], [22, 28], 

		[22.0, 28.5], [22, 29], [26.0, 29.0], 

		[30, 29], [30.0, 28.5], [30, 28], 

		[29, 28], [28.5, 27.0], [28, 26], 

		[27, 25], [22.0, 12.0], [17, -1], 

		[15, -8], [12.5, -11.0], [10, -14], 

		[7, -14], [5, -14], [3.5, -13.0], 

		[2, -12], [2, -10], [2, -9], 

		[3.0, -8.0], [4, -7], [5, -7], 

		[6, -7], [7.5, -8.0], [9, -9], 

		 ]);

}

module FreeSerif_contour00x79_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([10, -9], [11, -9], [13.0, -5.0],steps,10);

	BezConic([13.0, -5.0], [15, -1], [15, 1],steps,10);

	BezConic([15, 1], [15, 3], [13, 8],steps,10);

	BezConic([4, 26], [3, 28], [1, 28],steps,10);

	BezConic([14, 28], [12, 28], [11.0, 27.5],steps,10);

	BezConic([11.0, 27.5], [10, 27], [10, 26],steps,10);

	BezConic([10, 26], [10, 25], [11, 24],steps,10);

	BezConic([25, 25], [25, 26], [25, 26],steps,10);

	BezConic([25, 26], [25, 28], [22, 28],steps,10);

	BezConic([30, 28], [29, 28], [28.5, 27.0],steps,10);

	BezConic([7.5, -8.0], [9, -9], [10, -9],steps,10);

}

}

module FreeSerif_contour00x79_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([28.5, 27.0], [28, 26], [27, 25],steps,10);

	BezConic([17, -1], [15, -8], [12.5, -11.0],steps,10);

	BezConic([12.5, -11.0], [10, -14], [7, -14],steps,10);

	BezConic([7, -14], [5, -14], [3.5, -13.0],steps,10);

	BezConic([3.5, -13.0], [2, -12], [2, -10],steps,10);

	BezConic([2, -10], [2, -9], [3.0, -8.0],steps,10);

	BezConic([3.0, -8.0], [4, -7], [5, -7],steps,10);

	BezConic([5, -7], [6, -7], [7.5, -8.0],steps,10);

}

}

module FreeSerif_contour00x79(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x79_skeleton();
			FreeSerif_contour00x79_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x79_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x79(steps=2) {
	difference() {
		FreeSerif_contour00x79(steps);
		
	}
}

FreeSerif_bbox0x79=[[1, -14], [30, 29]];

module FreeSerif_letter0x79(detail=2) {

	FreeSerif_chunk10x79(steps=detail);

} //end skeleton



module FreeSerif_contour00x7a_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[17, 2], [20, 2], [21.5, 2.5], 

		[23, 3], [24.0, 4.0], [25, 5], 

		[25.0, 6.0], [25, 7], [26, 9], 

		[26.5, 9.0], [27, 9], [26.5, 4.5], 

		[26, 0], [14.0, 0.0], [2, 0], 

		[2.0, 0.5], [2, 1], [10.5, 14.0], 

		[19, 27], [14.5, 27.0], [10, 27], 

		[7, 27], [6.0, 26.0], [5, 25], 

		[5, 21], [4.0, 21.0], [3, 21], 

		[3.5, 25.0], [4, 29], [15.0, 29.0], 

		[26, 29], [26.0, 28.5], [26, 28], 

		[17.5, 15.0], [9, 2], [13.0, 2.0], 

		 ]);

}

module FreeSerif_contour00x7a_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([17, 2], [20, 2], [21.5, 2.5],steps,10);

	BezConic([21.5, 2.5], [23, 3], [24.0, 4.0],steps,10);

	BezConic([24.0, 4.0], [25, 5], [25.0, 6.0],steps,10);

	BezConic([10, 27], [7, 27], [6.0, 26.0],steps,10);

	BezConic([6.0, 26.0], [5, 25], [5, 21],steps,10);

}

}

module FreeSerif_contour00x7a_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([25.0, 6.0], [25, 7], [26, 9],steps,10);

}

}

module FreeSerif_contour00x7a(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x7a_skeleton();
			FreeSerif_contour00x7a_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x7a_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x7a(steps=2) {
	difference() {
		FreeSerif_contour00x7a(steps);
		
	}
}

FreeSerif_bbox0x7a=[[2, 0], [27, 29]];

module FreeSerif_letter0x7a(detail=2) {

	FreeSerif_chunk10x7a(steps=detail);

} //end skeleton



module FreeSerif_contour00x7b_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[22, -12], [17, -11], [14.5, -9.5], 

		[12, -8], [12, -3], [12.0, 3.0], 

		[12, 9], [12, 12], [11.0, 13.5], 

		[10, 15], [6, 16], [10, 17], 

		[11.0, 18.5], [12, 20], [12, 23], 

		[12.0, 29.0], [12, 35], [12, 37], 

		[12.5, 39.0], [13, 41], [14.5, 42.0], 

		[16, 43], [18.0, 43.0], [20, 43], 

		[22, 44], [22.0, 43.5], [22, 43], 

		[19, 42], [18.0, 40.5], [17, 39], 

		[17, 35], [17.0, 29.5], [17, 24], 

		[17, 20], [15.5, 18.5], [14, 17], 

		[11, 16], [14, 15], [15.5, 13.5], 

		[17, 12], [17, 8], [17.0, 2.5], 

		[17, -3], [17, -7], [18.0, -8.5], 

		[19, -10], [22, -11], [22.0, -11.5], 

		 ]);

}

module FreeSerif_contour00x7b_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([12, 9], [12, 12], [11.0, 13.5],steps,10);

	BezConic([11.0, 13.5], [10, 15], [6, 16],steps,10);

	BezConic([6, 16], [10, 17], [11.0, 18.5],steps,10);

	BezConic([11.0, 18.5], [12, 20], [12, 23],steps,10);

	BezConic([18.0, 43.0], [20, 43], [22, 44],steps,10);

	BezConic([22, 43], [19, 42], [18.0, 40.5],steps,10);

	BezConic([18.0, 40.5], [17, 39], [17, 35],steps,10);

	BezConic([17, -3], [17, -7], [18.0, -8.5],steps,10);

	BezConic([18.0, -8.5], [19, -10], [22, -11],steps,10);

}

}

module FreeSerif_contour00x7b_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([22, -12], [17, -11], [14.5, -9.5],steps,10);

	BezConic([14.5, -9.5], [12, -8], [12, -3],steps,10);

	BezConic([12, 35], [12, 37], [12.5, 39.0],steps,10);

	BezConic([12.5, 39.0], [13, 41], [14.5, 42.0],steps,10);

	BezConic([14.5, 42.0], [16, 43], [18.0, 43.0],steps,10);

	BezConic([17, 24], [17, 20], [15.5, 18.5],steps,10);

	BezConic([15.5, 18.5], [14, 17], [11, 16],steps,10);

	BezConic([11, 16], [14, 15], [15.5, 13.5],steps,10);

	BezConic([15.5, 13.5], [17, 12], [17, 8],steps,10);

}

}

module FreeSerif_contour00x7b(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x7b_skeleton();
			FreeSerif_contour00x7b_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x7b_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x7b(steps=2) {
	difference() {
		FreeSerif_contour00x7b(steps);
		
	}
}

FreeSerif_bbox0x7b=[[6, -12], [22, 44]];

module FreeSerif_letter0x7b(detail=2) {

	FreeSerif_chunk10x7b(steps=detail);

} //end skeleton



module FreeSerif_contour00x7c_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[4, -1], [4.0, 21.0], [4, 43], 

		[6.5, 43.0], [9, 43], [9.0, 21.0], 

		[9, -1],[6.5, -1.0], ]);

}

module FreeSerif_contour00x7c_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x7c_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

}

}

module FreeSerif_contour00x7c(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x7c_skeleton();
			FreeSerif_contour00x7c_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x7c_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x7c(steps=2) {
	difference() {
		FreeSerif_contour00x7c(steps);
		
	}
}

FreeSerif_bbox0x7c=[[4, -1], [9, 43]];

module FreeSerif_letter0x7c(detail=2) {

	FreeSerif_chunk10x7c(steps=detail);

} //end skeleton



module FreeSerif_contour00x7d_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[8, 44], [10, 44], [11.5, 43.5], 

		[13, 43], [14.5, 42.5], [16, 42], 

		[17.0, 41.0], [18, 40], [18.5, 38.5], 

		[19, 37], [19, 35], [19.0, 29.0], 

		[19, 23], [19, 20], [20.0, 18.5], 

		[21, 17], [24, 16], [21, 15], 

		[20.0, 13.5], [19, 12], [19, 9], 

		[19.0, 3.0], [19, -3], [19, -6], 

		[18.5, -7.5], [18, -9], [16.5, -10.0], 

		[15, -11], [13.0, -11.5], [11, -12], 

		[8, -12], [8.0, -11.5], [8, -11], 

		[12, -10], [13.0, -8.5], [14, -7], 

		[14, -3], [14.0, 2.5], [14, 8], 

		[14, 12], [15.5, 13.5], [17, 15], 

		[20, 16], [17, 17], [15.5, 18.5], 

		[14, 20], [14, 24], [14.0, 29.5], 

		[14, 35], [14, 39], [13.0, 40.5], 

		[12, 42], [8, 43], [8.0, 43.5], 

		 ]);

}

module FreeSerif_contour00x7d_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([11.5, 43.5], [13, 43], [14.5, 42.5],steps,10);

	BezConic([19, 23], [19, 20], [20.0, 18.5],steps,10);

	BezConic([20.0, 18.5], [21, 17], [24, 16],steps,10);

	BezConic([24, 16], [21, 15], [20.0, 13.5],steps,10);

	BezConic([20.0, 13.5], [19, 12], [19, 9],steps,10);

	BezConic([8, -11], [12, -10], [13.0, -8.5],steps,10);

	BezConic([13.0, -8.5], [14, -7], [14, -3],steps,10);

	BezConic([14, 35], [14, 39], [13.0, 40.5],steps,10);

	BezConic([13.0, 40.5], [12, 42], [8, 43],steps,10);

}

}

module FreeSerif_contour00x7d_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([8, 44], [10, 44], [11.5, 43.5],steps,10);

	BezConic([14.5, 42.5], [16, 42], [17.0, 41.0],steps,10);

	BezConic([17.0, 41.0], [18, 40], [18.5, 38.5],steps,10);

	BezConic([18.5, 38.5], [19, 37], [19, 35],steps,10);

	BezConic([19, -3], [19, -6], [18.5, -7.5],steps,10);

	BezConic([18.5, -7.5], [18, -9], [16.5, -10.0],steps,10);

	BezConic([16.5, -10.0], [15, -11], [13.0, -11.5],steps,10);

	BezConic([13.0, -11.5], [11, -12], [8, -12],steps,10);

	BezConic([14, 8], [14, 12], [15.5, 13.5],steps,10);

	BezConic([15.5, 13.5], [17, 15], [20, 16],steps,10);

	BezConic([20, 16], [17, 17], [15.5, 18.5],steps,10);

	BezConic([15.5, 18.5], [14, 20], [14, 24],steps,10);

}

}

module FreeSerif_contour00x7d(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x7d_skeleton();
			FreeSerif_contour00x7d_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x7d_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x7d(steps=2) {
	difference() {
		FreeSerif_contour00x7d(steps);
		
	}
}

FreeSerif_bbox0x7d=[[8, -12], [24, 44]];

module FreeSerif_letter0x7d(detail=2) {

	FreeSerif_chunk10x7d(steps=detail);

} //end skeleton



module FreeSerif_contour00x7e_skeleton() {
translate([0,0,-10/2]) 	linear_extrude(height=10) polygon( points=[

		[10, 20], [14, 20], [18.0, 18.0], 

		[22, 16], [24, 16], [25, 16], 

		[26.0, 17.0], [27, 18], [29, 19], 

		[30.5, 18.0], [32, 17], [30, 14], 

		[28.0, 13.0], [26, 12], [24, 12], 

		[21, 12], [17.0, 14.0], [13, 16], 

		[11, 16], [9, 16], [8.0, 15.5], 

		[7, 15], [6, 13], [4.5, 14.0], 

		[3, 15], [5, 18], [6.5, 19.0], 

		[8, 20], ]);

}

module FreeSerif_contour00x7e_additive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([18.0, 18.0], [22, 16], [24, 16],steps,10);

	BezConic([24, 16], [25, 16], [26.0, 17.0],steps,10);

	BezConic([17.0, 14.0], [13, 16], [11, 16],steps,10);

	BezConic([11, 16], [9, 16], [8.0, 15.5],steps,10);

	BezConic([8.0, 15.5], [7, 15], [6, 13],steps,10);

}

}

module FreeSerif_contour00x7e_subtractive_curves(steps=2) {
translate([0,0,-10/2]){ 

	BezConic([10, 20], [14, 20], [18.0, 18.0],steps,10);

	BezConic([26.0, 17.0], [27, 18], [29, 19],steps,10);

	BezConic([32, 17], [30, 14], [28.0, 13.0],steps,10);

	BezConic([28.0, 13.0], [26, 12], [24, 12],steps,10);

	BezConic([24, 12], [21, 12], [17.0, 14.0],steps,10);

	BezConic([3, 15], [5, 18], [6.5, 19.0],steps,10);

	BezConic([6.5, 19.0], [8, 20], [10, 20],steps,10);

}

}

module FreeSerif_contour00x7e(steps=2) {
	difference() {
		union() {
			FreeSerif_contour00x7e_skeleton();
			FreeSerif_contour00x7e_additive_curves(steps);
		}
		scale([1,1,1.1]) FreeSerif_contour00x7e_subtractive_curves(steps);
	}
}

module FreeSerif_chunk10x7e(steps=2) {
	difference() {
		FreeSerif_contour00x7e(steps);
		
	}
}

FreeSerif_bbox0x7e=[[3, 12], [32, 20]];

module FreeSerif_letter0x7e(detail=2) {

	FreeSerif_chunk10x7e(steps=detail);

} //end skeleton







module FreeSerif(charcode,center=true, steps=2){

    if (charcode == "0x21" || charcode == 33 || charcode=="!"){

        if(center==true){

            translate([-FreeSerif_bbox0x21[1][0]/2,0,0]) FreeSerif_letter0x21(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x21(steps);

        }

    }

    if (charcode == "0x22" || charcode == 34 || charcode=="\""){

        if(center==true){

            translate([-FreeSerif_bbox0x22[1][0]/2,0,0]) FreeSerif_letter0x22(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x22(steps);

        }

    }

    if (charcode == "0x23" || charcode == 35 || charcode=="#"){

        if(center==true){

            translate([-FreeSerif_bbox0x23[1][0]/2,0,0]) FreeSerif_letter0x23(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x23(steps);

        }

    }

    if (charcode == "0x24" || charcode == 36 || charcode=="$"){

        if(center==true){

            translate([-FreeSerif_bbox0x24[1][0]/2,0,0]) FreeSerif_letter0x24(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x24(steps);

        }

    }

    if (charcode == "0x25" || charcode == 37 || charcode=="%"){

        if(center==true){

            translate([-FreeSerif_bbox0x25[1][0]/2,0,0]) FreeSerif_letter0x25(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x25(steps);

        }

    }

    if (charcode == "0x26" || charcode == 38 || charcode=="&"){

        if(center==true){

            translate([-FreeSerif_bbox0x26[1][0]/2,0,0]) FreeSerif_letter0x26(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x26(steps);

        }

    }

    if (charcode == "0x27" || charcode == 39 || charcode=="'"){

        if(center==true){

            translate([-FreeSerif_bbox0x27[1][0]/2,0,0]) FreeSerif_letter0x27(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x27(steps);

        }

    }

    if (charcode == "0x28" || charcode == 40 || charcode=="("){

        if(center==true){

            translate([-FreeSerif_bbox0x28[1][0]/2,0,0]) FreeSerif_letter0x28(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x28(steps);

        }

    }

    if (charcode == "0x29" || charcode == 41 || charcode==")"){

        if(center==true){

            translate([-FreeSerif_bbox0x29[1][0]/2,0,0]) FreeSerif_letter0x29(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x29(steps);

        }

    }

    if (charcode == "0x2a" || charcode == 42 || charcode=="*"){

        if(center==true){

            translate([-FreeSerif_bbox0x2a[1][0]/2,0,0]) FreeSerif_letter0x2a(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x2a(steps);

        }

    }

    if (charcode == "0x2b" || charcode == 43 || charcode=="+"){

        if(center==true){

            translate([-FreeSerif_bbox0x2b[1][0]/2,0,0]) FreeSerif_letter0x2b(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x2b(steps);

        }

    }

    if (charcode == "0x2c" || charcode == 44 || charcode==","){

        if(center==true){

            translate([-FreeSerif_bbox0x2c[1][0]/2,0,0]) FreeSerif_letter0x2c(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x2c(steps);

        }

    }

    if (charcode == "0x2d" || charcode == 45 || charcode=="-"){

        if(center==true){

            translate([-FreeSerif_bbox0x2d[1][0]/2,0,0]) FreeSerif_letter0x2d(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x2d(steps);

        }

    }

    if (charcode == "0x2e" || charcode == 46 || charcode=="."){

        if(center==true){

            translate([-FreeSerif_bbox0x2e[1][0]/2,0,0]) FreeSerif_letter0x2e(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x2e(steps);

        }

    }

    if (charcode == "0x2f" || charcode == 47 || charcode=="/"){

        if(center==true){

            translate([-FreeSerif_bbox0x2f[1][0]/2,0,0]) FreeSerif_letter0x2f(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x2f(steps);

        }

    }

    if (charcode == "0x30" || charcode == 48 || charcode=="0"){

        if(center==true){

            translate([-FreeSerif_bbox0x30[1][0]/2,0,0]) FreeSerif_letter0x30(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x30(steps);

        }

    }

    if (charcode == "0x31" || charcode == 49 || charcode=="1"){

        if(center==true){

            translate([-FreeSerif_bbox0x31[1][0]/2,0,0]) FreeSerif_letter0x31(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x31(steps);

        }

    }

    if (charcode == "0x32" || charcode == 50 || charcode=="2"){

        if(center==true){

            translate([-FreeSerif_bbox0x32[1][0]/2,0,0]) FreeSerif_letter0x32(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x32(steps);

        }

    }

    if (charcode == "0x33" || charcode == 51 || charcode=="3"){

        if(center==true){

            translate([-FreeSerif_bbox0x33[1][0]/2,0,0]) FreeSerif_letter0x33(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x33(steps);

        }

    }

    if (charcode == "0x34" || charcode == 52 || charcode=="4"){

        if(center==true){

            translate([-FreeSerif_bbox0x34[1][0]/2,0,0]) FreeSerif_letter0x34(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x34(steps);

        }

    }

    if (charcode == "0x35" || charcode == 53 || charcode=="5"){

        if(center==true){

            translate([-FreeSerif_bbox0x35[1][0]/2,0,0]) FreeSerif_letter0x35(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x35(steps);

        }

    }

    if (charcode == "0x36" || charcode == 54 || charcode=="6"){

        if(center==true){

            translate([-FreeSerif_bbox0x36[1][0]/2,0,0]) FreeSerif_letter0x36(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x36(steps);

        }

    }

    if (charcode == "0x37" || charcode == 55 || charcode=="7"){

        if(center==true){

            translate([-FreeSerif_bbox0x37[1][0]/2,0,0]) FreeSerif_letter0x37(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x37(steps);

        }

    }

    if (charcode == "0x38" || charcode == 56 || charcode=="8"){

        if(center==true){

            translate([-FreeSerif_bbox0x38[1][0]/2,0,0]) FreeSerif_letter0x38(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x38(steps);

        }

    }

    if (charcode == "0x39" || charcode == 57 || charcode=="9"){

        if(center==true){

            translate([-FreeSerif_bbox0x39[1][0]/2,0,0]) FreeSerif_letter0x39(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x39(steps);

        }

    }

    if (charcode == "0x3a" || charcode == 58 || charcode==":"){

        if(center==true){

            translate([-FreeSerif_bbox0x3a[1][0]/2,0,0]) FreeSerif_letter0x3a(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x3a(steps);

        }

    }

    if (charcode == "0x3b" || charcode == 59 || charcode==";"){

        if(center==true){

            translate([-FreeSerif_bbox0x3b[1][0]/2,0,0]) FreeSerif_letter0x3b(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x3b(steps);

        }

    }

    if (charcode == "0x3c" || charcode == 60 || charcode=="<"){

        if(center==true){

            translate([-FreeSerif_bbox0x3c[1][0]/2,0,0]) FreeSerif_letter0x3c(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x3c(steps);

        }

    }

    if (charcode == "0x3d" || charcode == 61 || charcode=="="){

        if(center==true){

            translate([-FreeSerif_bbox0x3d[1][0]/2,0,0]) FreeSerif_letter0x3d(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x3d(steps);

        }

    }

    if (charcode == "0x3e" || charcode == 62 || charcode==">"){

        if(center==true){

            translate([-FreeSerif_bbox0x3e[1][0]/2,0,0]) FreeSerif_letter0x3e(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x3e(steps);

        }

    }

    if (charcode == "0x3f" || charcode == 63 || charcode=="?"){

        if(center==true){

            translate([-FreeSerif_bbox0x3f[1][0]/2,0,0]) FreeSerif_letter0x3f(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x3f(steps);

        }

    }

    if (charcode == "0x40" || charcode == 64 || charcode=="@"){

        if(center==true){

            translate([-FreeSerif_bbox0x40[1][0]/2,0,0]) FreeSerif_letter0x40(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x40(steps);

        }

    }

    if (charcode == "0x41" || charcode == 65 || charcode=="A"){

        if(center==true){

            translate([-FreeSerif_bbox0x41[1][0]/2,0,0]) FreeSerif_letter0x41(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x41(steps);

        }

    }

    if (charcode == "0x42" || charcode == 66 || charcode=="B"){

        if(center==true){

            translate([-FreeSerif_bbox0x42[1][0]/2,0,0]) FreeSerif_letter0x42(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x42(steps);

        }

    }

    if (charcode == "0x43" || charcode == 67 || charcode=="C"){

        if(center==true){

            translate([-FreeSerif_bbox0x43[1][0]/2,0,0]) FreeSerif_letter0x43(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x43(steps);

        }

    }

    if (charcode == "0x44" || charcode == 68 || charcode=="D"){

        if(center==true){

            translate([-FreeSerif_bbox0x44[1][0]/2,0,0]) FreeSerif_letter0x44(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x44(steps);

        }

    }

    if (charcode == "0x45" || charcode == 69 || charcode=="E"){

        if(center==true){

            translate([-FreeSerif_bbox0x45[1][0]/2,0,0]) FreeSerif_letter0x45(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x45(steps);

        }

    }

    if (charcode == "0x46" || charcode == 70 || charcode=="F"){

        if(center==true){

            translate([-FreeSerif_bbox0x46[1][0]/2,0,0]) FreeSerif_letter0x46(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x46(steps);

        }

    }

    if (charcode == "0x47" || charcode == 71 || charcode=="G"){

        if(center==true){

            translate([-FreeSerif_bbox0x47[1][0]/2,0,0]) FreeSerif_letter0x47(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x47(steps);

        }

    }

    if (charcode == "0x48" || charcode == 72 || charcode=="H"){

        if(center==true){

            translate([-FreeSerif_bbox0x48[1][0]/2,0,0]) FreeSerif_letter0x48(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x48(steps);

        }

    }

    if (charcode == "0x49" || charcode == 73 || charcode=="I"){

        if(center==true){

            translate([-FreeSerif_bbox0x49[1][0]/2,0,0]) FreeSerif_letter0x49(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x49(steps);

        }

    }

    if (charcode == "0x4a" || charcode == 74 || charcode=="J"){

        if(center==true){

            translate([-FreeSerif_bbox0x4a[1][0]/2,0,0]) FreeSerif_letter0x4a(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x4a(steps);

        }

    }

    if (charcode == "0x4b" || charcode == 75 || charcode=="K"){

        if(center==true){

            translate([-FreeSerif_bbox0x4b[1][0]/2,0,0]) FreeSerif_letter0x4b(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x4b(steps);

        }

    }

    if (charcode == "0x4c" || charcode == 76 || charcode=="L"){

        if(center==true){

            translate([-FreeSerif_bbox0x4c[1][0]/2,0,0]) FreeSerif_letter0x4c(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x4c(steps);

        }

    }

    if (charcode == "0x4d" || charcode == 77 || charcode=="M"){

        if(center==true){

            translate([-FreeSerif_bbox0x4d[1][0]/2,0,0]) FreeSerif_letter0x4d(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x4d(steps);

        }

    }

    if (charcode == "0x4e" || charcode == 78 || charcode=="N"){

        if(center==true){

            translate([-FreeSerif_bbox0x4e[1][0]/2,0,0]) FreeSerif_letter0x4e(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x4e(steps);

        }

    }

    if (charcode == "0x4f" || charcode == 79 || charcode=="O"){

        if(center==true){

            translate([-FreeSerif_bbox0x4f[1][0]/2,0,0]) FreeSerif_letter0x4f(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x4f(steps);

        }

    }

    if (charcode == "0x50" || charcode == 80 || charcode=="P"){

        if(center==true){

            translate([-FreeSerif_bbox0x50[1][0]/2,0,0]) FreeSerif_letter0x50(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x50(steps);

        }

    }

    if (charcode == "0x51" || charcode == 81 || charcode=="Q"){

        if(center==true){

            translate([-FreeSerif_bbox0x51[1][0]/2,0,0]) FreeSerif_letter0x51(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x51(steps);

        }

    }

    if (charcode == "0x52" || charcode == 82 || charcode=="R"){

        if(center==true){

            translate([-FreeSerif_bbox0x52[1][0]/2,0,0]) FreeSerif_letter0x52(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x52(steps);

        }

    }

    if (charcode == "0x53" || charcode == 83 || charcode=="S"){

        if(center==true){

            translate([-FreeSerif_bbox0x53[1][0]/2,0,0]) FreeSerif_letter0x53(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x53(steps);

        }

    }

    if (charcode == "0x54" || charcode == 84 || charcode=="T"){

        if(center==true){

            translate([-FreeSerif_bbox0x54[1][0]/2,0,0]) FreeSerif_letter0x54(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x54(steps);

        }

    }

    if (charcode == "0x55" || charcode == 85 || charcode=="U"){

        if(center==true){

            translate([-FreeSerif_bbox0x55[1][0]/2,0,0]) FreeSerif_letter0x55(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x55(steps);

        }

    }

    if (charcode == "0x56" || charcode == 86 || charcode=="V"){

        if(center==true){

            translate([-FreeSerif_bbox0x56[1][0]/2,0,0]) FreeSerif_letter0x56(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x56(steps);

        }

    }

    if (charcode == "0x57" || charcode == 87 || charcode=="W"){

        if(center==true){

            translate([-FreeSerif_bbox0x57[1][0]/2,0,0]) FreeSerif_letter0x57(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x57(steps);

        }

    }

    if (charcode == "0x58" || charcode == 88 || charcode=="X"){

        if(center==true){

            translate([-FreeSerif_bbox0x58[1][0]/2,0,0]) FreeSerif_letter0x58(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x58(steps);

        }

    }

    if (charcode == "0x59" || charcode == 89 || charcode=="Y"){

        if(center==true){

            translate([-FreeSerif_bbox0x59[1][0]/2,0,0]) FreeSerif_letter0x59(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x59(steps);

        }

    }

    if (charcode == "0x5a" || charcode == 90 || charcode=="Z"){

        if(center==true){

            translate([-FreeSerif_bbox0x5a[1][0]/2,0,0]) FreeSerif_letter0x5a(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x5a(steps);

        }

    }

    if (charcode == "0x5b" || charcode == 91 || charcode=="["){

        if(center==true){

            translate([-FreeSerif_bbox0x5b[1][0]/2,0,0]) FreeSerif_letter0x5b(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x5b(steps);

        }

    }

    if (charcode == "0x5c" || charcode == 92 || charcode=="\\"){

        if(center==true){

            translate([-FreeSerif_bbox0x5c[1][0]/2,0,0]) FreeSerif_letter0x5c(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x5c(steps);

        }

    }

    if (charcode == "0x5d" || charcode == 93 || charcode=="]"){

        if(center==true){

            translate([-FreeSerif_bbox0x5d[1][0]/2,0,0]) FreeSerif_letter0x5d(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x5d(steps);

        }

    }

    if (charcode == "0x5e" || charcode == 94 || charcode=="^"){

        if(center==true){

            translate([-FreeSerif_bbox0x5e[1][0]/2,0,0]) FreeSerif_letter0x5e(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x5e(steps);

        }

    }

    if (charcode == "0x5f" || charcode == 95 || charcode=="_"){

        if(center==true){

            translate([-FreeSerif_bbox0x5f[1][0]/2,0,0]) FreeSerif_letter0x5f(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x5f(steps);

        }

    }

    if (charcode == "0x60" || charcode == 96 || charcode=="`"){

        if(center==true){

            translate([-FreeSerif_bbox0x60[1][0]/2,0,0]) FreeSerif_letter0x60(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x60(steps);

        }

    }

    if (charcode == "0x61" || charcode == 97 || charcode=="a"){

        if(center==true){

            translate([-FreeSerif_bbox0x61[1][0]/2,0,0]) FreeSerif_letter0x61(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x61(steps);

        }

    }

    if (charcode == "0x62" || charcode == 98 || charcode=="b"){

        if(center==true){

            translate([-FreeSerif_bbox0x62[1][0]/2,0,0]) FreeSerif_letter0x62(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x62(steps);

        }

    }

    if (charcode == "0x63" || charcode == 99 || charcode=="c"){

        if(center==true){

            translate([-FreeSerif_bbox0x63[1][0]/2,0,0]) FreeSerif_letter0x63(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x63(steps);

        }

    }

    if (charcode == "0x64" || charcode == 100 || charcode=="d"){

        if(center==true){

            translate([-FreeSerif_bbox0x64[1][0]/2,0,0]) FreeSerif_letter0x64(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x64(steps);

        }

    }

    if (charcode == "0x65" || charcode == 101 || charcode=="e"){

        if(center==true){

            translate([-FreeSerif_bbox0x65[1][0]/2,0,0]) FreeSerif_letter0x65(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x65(steps);

        }

    }

    if (charcode == "0x66" || charcode == 102 || charcode=="f"){

        if(center==true){

            translate([-FreeSerif_bbox0x66[1][0]/2,0,0]) FreeSerif_letter0x66(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x66(steps);

        }

    }

    if (charcode == "0x67" || charcode == 103 || charcode=="g"){

        if(center==true){

            translate([-FreeSerif_bbox0x67[1][0]/2,0,0]) FreeSerif_letter0x67(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x67(steps);

        }

    }

    if (charcode == "0x68" || charcode == 104 || charcode=="h"){

        if(center==true){

            translate([-FreeSerif_bbox0x68[1][0]/2,0,0]) FreeSerif_letter0x68(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x68(steps);

        }

    }

    if (charcode == "0x69" || charcode == 105 || charcode=="i"){

        if(center==true){

            translate([-FreeSerif_bbox0x69[1][0]/2,0,0]) FreeSerif_letter0x69(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x69(steps);

        }

    }

    if (charcode == "0x6a" || charcode == 106 || charcode=="j"){

        if(center==true){

            translate([-FreeSerif_bbox0x6a[1][0]/2,0,0]) FreeSerif_letter0x6a(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x6a(steps);

        }

    }

    if (charcode == "0x6b" || charcode == 107 || charcode=="k"){

        if(center==true){

            translate([-FreeSerif_bbox0x6b[1][0]/2,0,0]) FreeSerif_letter0x6b(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x6b(steps);

        }

    }

    if (charcode == "0x6c" || charcode == 108 || charcode=="l"){

        if(center==true){

            translate([-FreeSerif_bbox0x6c[1][0]/2,0,0]) FreeSerif_letter0x6c(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x6c(steps);

        }

    }

    if (charcode == "0x6d" || charcode == 109 || charcode=="m"){

        if(center==true){

            translate([-FreeSerif_bbox0x6d[1][0]/2,0,0]) FreeSerif_letter0x6d(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x6d(steps);

        }

    }

    if (charcode == "0x6e" || charcode == 110 || charcode=="n"){

        if(center==true){

            translate([-FreeSerif_bbox0x6e[1][0]/2,0,0]) FreeSerif_letter0x6e(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x6e(steps);

        }

    }

    if (charcode == "0x6f" || charcode == 111 || charcode=="o"){

        if(center==true){

            translate([-FreeSerif_bbox0x6f[1][0]/2,0,0]) FreeSerif_letter0x6f(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x6f(steps);

        }

    }

    if (charcode == "0x70" || charcode == 112 || charcode=="p"){

        if(center==true){

            translate([-FreeSerif_bbox0x70[1][0]/2,0,0]) FreeSerif_letter0x70(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x70(steps);

        }

    }

    if (charcode == "0x71" || charcode == 113 || charcode=="q"){

        if(center==true){

            translate([-FreeSerif_bbox0x71[1][0]/2,0,0]) FreeSerif_letter0x71(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x71(steps);

        }

    }

    if (charcode == "0x72" || charcode == 114 || charcode=="r"){

        if(center==true){

            translate([-FreeSerif_bbox0x72[1][0]/2,0,0]) FreeSerif_letter0x72(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x72(steps);

        }

    }

    if (charcode == "0x73" || charcode == 115 || charcode=="s"){

        if(center==true){

            translate([-FreeSerif_bbox0x73[1][0]/2,0,0]) FreeSerif_letter0x73(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x73(steps);

        }

    }

    if (charcode == "0x74" || charcode == 116 || charcode=="t"){

        if(center==true){

            translate([-FreeSerif_bbox0x74[1][0]/2,0,0]) FreeSerif_letter0x74(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x74(steps);

        }

    }

    if (charcode == "0x75" || charcode == 117 || charcode=="u"){

        if(center==true){

            translate([-FreeSerif_bbox0x75[1][0]/2,0,0]) FreeSerif_letter0x75(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x75(steps);

        }

    }

    if (charcode == "0x76" || charcode == 118 || charcode=="v"){

        if(center==true){

            translate([-FreeSerif_bbox0x76[1][0]/2,0,0]) FreeSerif_letter0x76(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x76(steps);

        }

    }

    if (charcode == "0x77" || charcode == 119 || charcode=="w"){

        if(center==true){

            translate([-FreeSerif_bbox0x77[1][0]/2,0,0]) FreeSerif_letter0x77(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x77(steps);

        }

    }

    if (charcode == "0x78" || charcode == 120 || charcode=="x"){

        if(center==true){

            translate([-FreeSerif_bbox0x78[1][0]/2,0,0]) FreeSerif_letter0x78(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x78(steps);

        }

    }

    if (charcode == "0x79" || charcode == 121 || charcode=="y"){

        if(center==true){

            translate([-FreeSerif_bbox0x79[1][0]/2,0,0]) FreeSerif_letter0x79(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x79(steps);

        }

    }

    if (charcode == "0x7a" || charcode == 122 || charcode=="z"){

        if(center==true){

            translate([-FreeSerif_bbox0x7a[1][0]/2,0,0]) FreeSerif_letter0x7a(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x7a(steps);

        }

    }

    if (charcode == "0x7b" || charcode == 123 || charcode=="{"){

        if(center==true){

            translate([-FreeSerif_bbox0x7b[1][0]/2,0,0]) FreeSerif_letter0x7b(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x7b(steps);

        }

    }

    if (charcode == "0x7c" || charcode == 124 || charcode=="|"){

        if(center==true){

            translate([-FreeSerif_bbox0x7c[1][0]/2,0,0]) FreeSerif_letter0x7c(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x7c(steps);

        }

    }

    if (charcode == "0x7d" || charcode == 125 || charcode=="}"){

        if(center==true){

            translate([-FreeSerif_bbox0x7d[1][0]/2,0,0]) FreeSerif_letter0x7d(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x7d(steps);

        }

    }

    if (charcode == "0x7e" || charcode == 126 || charcode=="~"){

        if(center==true){

            translate([-FreeSerif_bbox0x7e[1][0]/2,0,0]) FreeSerif_letter0x7e(steps);

        }else{

            translate([0,0,10/2]) FreeSerif_letter0x7e(steps);

        }

    }

    if(charcode == "FONTZ!"){

        if(center==true){

            translate([-215/2,0,0]){

                translate([0,0,0]) FreeSerif_letter0x46(steps);

                translate([35,0,0]) FreeSerif_letter0x4f(steps);

                translate([79,0,0]) FreeSerif_letter0x4e(steps);

                translate([124,0,0]) FreeSerif_letter0x54(steps);

                translate([162,0,0]) FreeSerif_letter0x5a(steps);

                translate([200,0,0]) FreeSerif_letter0x21(steps);

            }

        }else{

            translate([0,0,10/2]){

                translate([0,0,0]) FreeSerif_letter0x46(steps);

                translate([35,0,0]) FreeSerif_letter0x4f(steps);

                translate([79,0,0]) FreeSerif_letter0x4e(steps);

                translate([124,0,0]) FreeSerif_letter0x54(steps);

                translate([162,0,0]) FreeSerif_letter0x5a(steps);

                translate([200,0,0]) FreeSerif_letter0x21(steps);

            }

        }

    }

    if(charcode == "This is a test string."){

        if(center==true){

            translate([-532/2,0,0]){

                translate([0,0,0]) FreeSerif_letter0x54(steps);

                translate([38,0,0]) FreeSerif_letter0x68(steps);

                translate([69,0,0]) FreeSerif_letter0x69(steps);

                translate([85,0,0]) FreeSerif_letter0x73(steps);

                translate([138,0,0]) FreeSerif_letter0x69(steps);

                translate([154,0,0]) FreeSerif_letter0x73(steps);

                translate([207,0,0]) FreeSerif_letter0x61(steps);

                translate([266,0,0]) FreeSerif_letter0x74(steps);

                translate([284,0,0]) FreeSerif_letter0x65(steps);

                translate([311,0,0]) FreeSerif_letter0x73(steps);

                translate([333,0,0]) FreeSerif_letter0x74(steps);

                translate([382,0,0]) FreeSerif_letter0x73(steps);

                translate([404,0,0]) FreeSerif_letter0x74(steps);

                translate([422,0,0]) FreeSerif_letter0x72(steps);

                translate([443,0,0]) FreeSerif_letter0x69(steps);

                translate([459,0,0]) FreeSerif_letter0x6e(steps);

                translate([490,0,0]) FreeSerif_letter0x67(steps);

                translate([520,0,0]) FreeSerif_letter0x2e(steps);

            }

        }else{

            translate([0,0,10/2]){

                translate([0,0,0]) FreeSerif_letter0x54(steps);

                translate([38,0,0]) FreeSerif_letter0x68(steps);

                translate([69,0,0]) FreeSerif_letter0x69(steps);

                translate([85,0,0]) FreeSerif_letter0x73(steps);

                translate([138,0,0]) FreeSerif_letter0x69(steps);

                translate([154,0,0]) FreeSerif_letter0x73(steps);

                translate([207,0,0]) FreeSerif_letter0x61(steps);

                translate([266,0,0]) FreeSerif_letter0x74(steps);

                translate([284,0,0]) FreeSerif_letter0x65(steps);

                translate([311,0,0]) FreeSerif_letter0x73(steps);

                translate([333,0,0]) FreeSerif_letter0x74(steps);

                translate([382,0,0]) FreeSerif_letter0x73(steps);

                translate([404,0,0]) FreeSerif_letter0x74(steps);

                translate([422,0,0]) FreeSerif_letter0x72(steps);

                translate([443,0,0]) FreeSerif_letter0x69(steps);

                translate([459,0,0]) FreeSerif_letter0x6e(steps);

                translate([490,0,0]) FreeSerif_letter0x67(steps);

                translate([520,0,0]) FreeSerif_letter0x2e(steps);

            }

        }

    }

    if(charcode == "Foo"){

        if(center==true){

            translate([-95/2,0,0]){

                translate([0,0,0]) FreeSerif_letter0x46(steps);

                translate([35,0,0]) FreeSerif_letter0x6f(steps);

                translate([65,0,0]) FreeSerif_letter0x6f(steps);

            }

        }else{

            translate([0,0,10/2]){

                translate([0,0,0]) FreeSerif_letter0x46(steps);

                translate([35,0,0]) FreeSerif_letter0x6f(steps);

                translate([65,0,0]) FreeSerif_letter0x6f(steps);

            }

        }

    }

    if(charcode == "Bar"){

        if(center==true){

            translate([-87/2,0,0]){

                translate([0,0,0]) FreeSerif_letter0x42(steps);

                translate([38,0,0]) FreeSerif_letter0x61(steps);

                translate([66,0,0]) FreeSerif_letter0x72(steps);

            }

        }else{

            translate([0,0,10/2]){

                translate([0,0,0]) FreeSerif_letter0x42(steps);

                translate([38,0,0]) FreeSerif_letter0x61(steps);

                translate([66,0,0]) FreeSerif_letter0x72(steps);

            }

        }

    }

    if(charcode == "The quick brown fox jumps over the lazy dog."){

        if(center==true){

            translate([-1256/2,0,0]){

                translate([0,0,0]) FreeSerif_letter0x54(steps);

                translate([38,0,0]) FreeSerif_letter0x68(steps);

                translate([69,0,0]) FreeSerif_letter0x65(steps);

                translate([127,0,0]) FreeSerif_letter0x71(steps);

                translate([158,0,0]) FreeSerif_letter0x75(steps);

                translate([189,0,0]) FreeSerif_letter0x69(steps);

                translate([205,0,0]) FreeSerif_letter0x63(steps);

                translate([231,0,0]) FreeSerif_letter0x6b(steps);

                translate([294,0,0]) FreeSerif_letter0x62(steps);

                translate([324,0,0]) FreeSerif_letter0x72(steps);

                translate([345,0,0]) FreeSerif_letter0x6f(steps);

                translate([375,0,0]) FreeSerif_letter0x77(steps);

                translate([419,0,0]) FreeSerif_letter0x6e(steps);

                translate([481,0,0]) FreeSerif_letter0x66(steps);

                translate([506,0,0]) FreeSerif_letter0x6f(steps);

                translate([536,0,0]) FreeSerif_letter0x78(steps);

                translate([598,0,0]) FreeSerif_letter0x6a(steps);

                translate([610,0,0]) FreeSerif_letter0x75(steps);

                translate([641,0,0]) FreeSerif_letter0x6d(steps);

                translate([691,0,0]) FreeSerif_letter0x70(steps);

                translate([721,0,0]) FreeSerif_letter0x73(steps);

                translate([774,0,0]) FreeSerif_letter0x6f(steps);

                translate([804,0,0]) FreeSerif_letter0x76(steps);

                translate([835,0,0]) FreeSerif_letter0x65(steps);

                translate([862,0,0]) FreeSerif_letter0x72(steps);

                translate([914,0,0]) FreeSerif_letter0x74(steps);

                translate([932,0,0]) FreeSerif_letter0x68(steps);

                translate([963,0,0]) FreeSerif_letter0x65(steps);

                translate([1021,0,0]) FreeSerif_letter0x6c(steps);

                translate([1037,0,0]) FreeSerif_letter0x61(steps);

                translate([1065,0,0]) FreeSerif_letter0x7a(steps);

                translate([1092,0,0]) FreeSerif_letter0x79(steps);

                translate([1153,0,0]) FreeSerif_letter0x64(steps);

                translate([1184,0,0]) FreeSerif_letter0x6f(steps);

                translate([1214,0,0]) FreeSerif_letter0x67(steps);

                translate([1244,0,0]) FreeSerif_letter0x2e(steps);

            }

        }else{

            translate([0,0,10/2]){

                translate([0,0,0]) FreeSerif_letter0x54(steps);

                translate([38,0,0]) FreeSerif_letter0x68(steps);

                translate([69,0,0]) FreeSerif_letter0x65(steps);

                translate([127,0,0]) FreeSerif_letter0x71(steps);

                translate([158,0,0]) FreeSerif_letter0x75(steps);

                translate([189,0,0]) FreeSerif_letter0x69(steps);

                translate([205,0,0]) FreeSerif_letter0x63(steps);

                translate([231,0,0]) FreeSerif_letter0x6b(steps);

                translate([294,0,0]) FreeSerif_letter0x62(steps);

                translate([324,0,0]) FreeSerif_letter0x72(steps);

                translate([345,0,0]) FreeSerif_letter0x6f(steps);

                translate([375,0,0]) FreeSerif_letter0x77(steps);

                translate([419,0,0]) FreeSerif_letter0x6e(steps);

                translate([481,0,0]) FreeSerif_letter0x66(steps);

                translate([506,0,0]) FreeSerif_letter0x6f(steps);

                translate([536,0,0]) FreeSerif_letter0x78(steps);

                translate([598,0,0]) FreeSerif_letter0x6a(steps);

                translate([610,0,0]) FreeSerif_letter0x75(steps);

                translate([641,0,0]) FreeSerif_letter0x6d(steps);

                translate([691,0,0]) FreeSerif_letter0x70(steps);

                translate([721,0,0]) FreeSerif_letter0x73(steps);

                translate([774,0,0]) FreeSerif_letter0x6f(steps);

                translate([804,0,0]) FreeSerif_letter0x76(steps);

                translate([835,0,0]) FreeSerif_letter0x65(steps);

                translate([862,0,0]) FreeSerif_letter0x72(steps);

                translate([914,0,0]) FreeSerif_letter0x74(steps);

                translate([932,0,0]) FreeSerif_letter0x68(steps);

                translate([963,0,0]) FreeSerif_letter0x65(steps);

                translate([1021,0,0]) FreeSerif_letter0x6c(steps);

                translate([1037,0,0]) FreeSerif_letter0x61(steps);

                translate([1065,0,0]) FreeSerif_letter0x7a(steps);

                translate([1092,0,0]) FreeSerif_letter0x79(steps);

                translate([1153,0,0]) FreeSerif_letter0x64(steps);

                translate([1184,0,0]) FreeSerif_letter0x6f(steps);

                translate([1214,0,0]) FreeSerif_letter0x67(steps);

                translate([1244,0,0]) FreeSerif_letter0x2e(steps);

            }

        }

    }

}

module BezConic(p0,p1,p2,steps=5,h=10) {

	stepsize1 = (p1-p0)/steps;
	stepsize2 = (p2-p1)/steps;

	for (i=[0:steps-1]) {
		assign(point1 = p0+stepsize1*i) 
		assign(point2 = p1+stepsize2*i) 
		assign(point3 = p0+stepsize1*(i+1))
		assign(point4 = p1+stepsize2*(i+1))  {
			assign(bpoint1 = point1+(point2-point1)*(i/steps))
			assign(bpoint2 = point3+(point4-point3)*((i+1)/steps)) {
				//polygon(points=[bpoint1,bpoint2,p1]);
				linear_extrude(height=h) polygon(points=[bpoint1,bpoint2,p1]);
			}
		}
	}
}