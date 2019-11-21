/*
 * Customizable Origami - Dragon - https://www.thingiverse.com/thing:2771446
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2018-01-27
 * version v1.0
 *
 * Changelog
 * --------------
 * v1.0:
 *      - final design
 * --------------
 * 
 * This work is licensed under the Creative Commons - Attribution - NonCommercial - ShareAlike license.
 * https://creativecommons.org/licenses/by-nc-sa/3.0/
 */


 // Parameter Section //
//-------------------//

// preview[view:north, tilt:top]

// The maximum size of the longest side. The shorter side will be automatically resized in same ratio.
max_size_in_millimeter = 120; //[20:300]

// The height of the model.
model_height_in_millimeter = 5; //[0.2:0.2:100]

// Thickness of the outer outline.
outline_size_in_millimeter = 1.7; //[0.5:0.1:20]

// Thickness of the inner outline.
inline_size_in_millimeter = 0.8; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 0.6; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [68, 282];
A2 = [699, 497];
A3 = [681, 289];
A4 = [926, 494];
A5 = [1037, 165];
A6 = [1452, 755];
A7 = [1502, 730];
A8 = [1498, 359];
A9 = [1616, 241];
A10 = [1406, 109];
A11 = [1461, 104];
A12 = [1598, 169];
A13 = [1663, 172];
A14 = [1928, 243];
A15 = [1918, 346];
A16 = [1700, 373];
A17 = [1868, 1187];
A18 = [1658, 1579];
A19 = [1601, 1413];
A20 = [1418, 1482];
A21 = [1345, 1484];
A22 = [1144, 1440];
A23 = [1049, 1579];
A24 = [972, 1238];
A25 = [1020, 1075];
A26 = [778, 857];
A27 = [747, 706];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27];

// Inner Points
B1 = [1690, 215];
B2 = [1661, 231];
B3 = [1492, 1115];
B4 = [1469, 849];
B5 = [1441, 806];
B6 = [1087, 1156];
B7 = [1213, 1310];
B8 = [721, 603];
B9 = [925, 967];

// Polygons
C1 = [A1, A2, B8, A27];
C2 = [A3, A4, B5, B8, A2];
C3 = [B8, A27, A26, B5];
C4 = [A26, B9, B5];
C5 = [B9, A25, B5];
C6 = [A25, B6, B4, B5];
C7 = [A4, A6, B5];
C8 = [A6, A7, B5];
C9 = [A6, A5, A4];
C10 = [A10, A11, A12, A13, A14, B1, B2, A9];
C11 = [B2, B1, A14, A15, A16];
C12 = [A9, A8, A7, B3, A19, A18, A17, A16, B2];
C13 = [B5, B4, A20, A19, B3, A7];
C14 = [B4, B6, B7, A21, A20];
C15 = [A25, A24, A23, A22, B7];
C16 = [B7, A21, A22];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16];

min_x = A1[0];
min_y = A11[1];
max_x = A14[0];
max_y = A18[1];

x_size = max_x - min_x;
y_size = max_y - min_y;

x_factor = max_size / x_size;
y_factor = max_size / y_size;

inline_size = x_size > y_size ? inline_size_in_millimeter / x_factor / 2: inline_size_in_millimeter / y_factor / 2;
inline_edge_radius = x_size > y_size ? inline_edge_radius_in_millimeter / x_factor: inline_edge_radius_in_millimeter / y_factor;
outline_size = x_size > y_size ? outline_size_in_millimeter / x_factor - inline_size: outline_size_in_millimeter / y_factor - inline_size;


 // Program Section //
//-----------------//

if(x_size > y_size) {
    resize(newsize=[max_size, x_factor * y_size, model_height]){
        if(flip_model == "yes") {
            mirror([0,1,0]) {
                rotate([180,180,0]) {    
                    create(outline, cut_polygons);
                }
            }
        } else {
            create(outline, cut_polygons);
        }
    }
} else {
    resize(newsize=[y_factor * x_size, max_size, model_height]){
        if(flip_model == "yes") {
            mirror([0,1,0]) {
                rotate([180,180,0]) {    
                    create(outline, cut_polygons);
                }
            }
        } else {
            create(outline, cut_polygons);
        }
    }
}


 // Module Section //
//----------------//

module create() {
    linear_extrude(height=1) {
        difference() {
            offset(r = -0) {
                offset(r = +outline_size) {
                    polygon(points = outline, convexity = 10);
                }
            }
            
            for(cut_polygon = [0:len(cut_polygons)]) {
                offset(r = +inline_edge_radius) {
                    offset(r = -inline_size - inline_edge_radius) {
                        polygon(points = cut_polygons[cut_polygon], convexity = 10);
                    }
                }
            }
        }
    }
}
