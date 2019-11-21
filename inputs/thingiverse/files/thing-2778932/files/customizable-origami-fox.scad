/*
 * Customizable Origami - Fox - https://www.thingiverse.com/thing:2778932
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2018-02-02
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
outline_size_in_millimeter = 1.6; //[0.5:0.1:20]

// Thickness of the inner outline.
inline_size_in_millimeter = 0.8; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 0.7; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [46, 1089];
A2 = [741, 815];
A3 = [765, 780];
A4 = [1332, 613];
A5 = [1306, 590];
A6 = [1385, 422];
A7 = [1540, 34];
A8 = [1552, 63];
A9 = [1571, 34];
A10 = [1575, 153];
A11 = [1864, 309];
A12 = [1862, 342];
A13 = [1653, 379];
A14 = [1915, 589];
A15 = [1796, 983];
A16 = [1496, 1416];
A17 = [1400, 1139];
A18 = [1032, 1111];
A19 = [1039, 1133];
A20 = [693, 1210];
A21 = [621, 1416];
A22 = [584, 1131];
A23 = [611, 1074];
A24 = [550, 1067];
A25 = [526, 1094];
A26 = [293, 1193];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26];

// Inner Points
B1 = [1010, 978];
B2 = [1400, 742];
B3 = [1423, 690];
B4 = [1453, 1138];

// Polygons
C1 = [A1, A2, A24, A25, A26];
C2 = [A24, A2, A23];
C3 = [A2, A3, B1, A18, A19, A20, A22, A23];
C4 = [A22, A21, A20];
C5 = [A3, A4, B3, B2, B4, A17, A18, B1];
C6 = [B3, B2, B4, A16, A15];
C7 = [A17, B4, A16];
C8 = [A4, A5, A6, A13, A14, A15, B3];
C9 = [A6, A10, A11, A12, A13];
C10 = [A6, A7, A8, A10];
C11 = [A8, A9, A10];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11];

min_x = A1[0];
min_y = A7[1];
max_x = A14[0];
max_y = A16[1];

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
