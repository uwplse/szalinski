/*
 * Customizable Origami - Lama - https://www.thingiverse.com/thing:2621180
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-11-02
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
inline_size_in_millimeter = 0.7; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 0.4; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [30, 1074];
A2 = [56, 805];
A3 = [231, 683];
A4 = [1203, 738];
A5 = [1283, 109];
A6 = [1286, 9];
A7 = [1373, 68];
A8 = [1388, 55];
A9 = [1471, 55];
A10 = [1675, 228];
A11 = [1684, 289];
A12 = [1451, 296];
A13 = [1453, 1063];
A14 = [1029, 1420];
A15 = [1020, 1481];
A16 = [1096, 1539];
A17 = [963, 1539];
A18 = [959, 1388];
A19 = [538, 1151];
A20 = [188, 1349];
A21 = [193, 1481];
A22 = [261, 1539];
A23 = [140, 1539];
A24 = [134, 1216];
A25 = [69, 999];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25];

// Inner Points
B1 = [166, 1359];
B2 = [1403, 165];
B3 = [69, 974];

// Polygons
C1 = [A5, A6, A7];
C2 = [A8, A9, B2, A12, A4, A5, A7];
C3 = [A9, A10, A11, A12, B2];
C4 = [A12, A13, A4];
C5 = [A13, A14, A4];
C6 = [A14, A15, A16, A17, A18];
C7 = [A14, A4, A19];
C8 = [A19, A4, A3];
C9 = [A3, A19, B3];
C10 = [A3, A2, A1, A25, B3];
C11 = [A25, B3, A19, A20, B1, A24];
C12 = [A24, B1, A20, A21, A22, A23];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12];

min_x = A1[0];
min_y = A6[1];
max_x = A11[0];
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
