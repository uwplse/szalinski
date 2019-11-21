/*
 * Customizable Origami - Lion - https://www.thingiverse.com/thing:2753473
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2018-01-11
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
inline_edge_radius_in_millimeter = 0.7; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [327, 438];
A2 = [479, 345];
A3 = [498, 281];
A4 = [731, 237];
A5 = [711, 290];
A6 = [938, 343];
A7 = [905, 379];
A8 = [1199, 487];
A9 = [1340, 454];
A10 = [1453, 427];
A11 = [1588, 510];
A12 = [1569, 518];
A13 = [1585, 575];
A14 = [1675, 556];
A15 = [1661, 630];
A16 = [1555, 642];
A17 = [1479, 531];
A18 = [1446, 539];
A19 = [1455, 595];
A20 = [1434, 803];
A21 = [1322, 965];
A22 = [1249, 965];
A23 = [1248, 935];
A24 = [1286, 915];
A25 = [1309, 821];
A26 = [1262, 738];
A27 = [813, 768];
A28 = [804, 849];
A29 = [736, 965];
A30 = [635, 965];
A31 = [632, 950];
A32 = [682, 922];
A33 = [699, 784];
A34 = [644, 706];
A35 = [488, 658];
A36 = [452, 504];
A37 = [368, 523];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37];

// Inner Points
B1 = [560, 586];
B2 = [687, 620];
B3 = [760, 604];
B4 = [940, 496];
B5 = [810, 410];
B6 = [677, 452];
B7 = [721, 504];
B8 = [627, 414];

// Polygons
C1 = [A3, A4, A5, B8];
C2 = [A3, B8, B1, A2];
C3 = [A2, B1, A35, A36];
C4 = [A1, A2, A36, A37];
C5 = [B8, B6, B7, B2, A34, B1];
C6 = [B1, A34, A35];
C7 = [A34, B2, B3, A27, A28, A33];
C8 = [A28, A29, A32, A33];
C9 = [B2, B3, B4, B5, B6, B7];
C10 = [B8, A5, A6, A7, B5, B6];
C11 = [A7, A8, A26, A27, B3, B4, B5];
C12 = [A8, A9, A19, A20, A25, A26];
C13 = [A20, A21, A24, A25];
C14 = [A9, A10, A11, A12, A13, A16, A17, A18];
C15 = [A13, A14, A15, A16];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15];

min_x = A1[0];
min_y = A4[1];
max_x = A14[0];
max_y = A22[1];

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
