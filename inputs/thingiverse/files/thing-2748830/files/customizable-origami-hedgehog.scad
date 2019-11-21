/*
 * Customizable Origami - Hedgehog - https://www.thingiverse.com/thing:2748830
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2018-01-07
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
outline_size_in_millimeter = 1.9; //[0.5:0.1:20]

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
A1 = [285, 1093];
A2 = [342, 983];
A3 = [214, 712];
A4 = [460, 770];
A5 = [482, 738];
A6 = [381, 421];
A7 = [606, 525];
A8 = [702, 502];
A9 = [665, 225];
A10 = [963, 437];
A11 = [1032, 485];
A12 = [1134, 232];
A13 = [1343, 485];
A14 = [1386, 412];
A15 = [1525, 637];
A16 = [1417, 826];
A17 = [1441, 861];
A18 = [1435, 892];
A19 = [1722, 1344];
A20 = [1797, 1322];
A21 = [1828, 1342];
A22 = [1776, 1433];
A23 = [1227, 1446];
A24 = [1229, 1467];
A25 = [1211, 1472];
A26 = [1195, 1639];
A27 = [1077, 1472];
A28 = [749, 1484];
A29 = [774, 1639];
A30 = [374, 1343];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30];

// Inner Points
B1 = [668, 988];
B2 = [927, 924];
B3 = [1192, 870];
B4 = [1249, 641];

// Polygons
C1 = [A3, A2, A4];
C2 = [A6, A7, A5];
C3 = [A9, A10, A8];
C4 = [A12, A13, B4, A11];
C5 = [A14, A15, B4, A13];
C6 = [A15, A16, B3, B4];
C7 = [A10, A11, B4, B3, B2];
C8 = [A7, A8, A10, B2, B1];
C9 = [A7, B1, A28, A29, A30, A1, A2, A4, A5];
C10 = [B1, B2, B3, A16, A28];
C11 = [A16, A17, A18, A23, A24, A25, A27, A28];
C12 = [A18, A19, A22, A23];
C13 = [A19, A20, A21, A22];
C14 = [A27, A26, A25];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14];

min_x = A3[0];
min_y = A9[1];
max_x = A21[0];
max_y = A26[1];

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
