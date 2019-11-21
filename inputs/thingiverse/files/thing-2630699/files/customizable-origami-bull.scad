/*
 * Customizable Origami - Bull - https://www.thingiverse.com/thing:2630699
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-11-07
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
inline_size_in_millimeter = 0.7; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 0.7; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [149, 69];
A2 = [246, 127];
A3 = [240, 244];
A4 = [374, 423];
A5 = [550, 277];
A6 = [965, 335];
A7 = [1335, 161];
A8 = [1474, 117];
A9 = [1717, 384];
A10 = [1776, 606];
A11 = [1835, 709];
A12 = [2104, 696];
A13 = [1866, 825];
A14 = [1800, 783];
A15 = [1737, 736];
A16 = [1659, 991];
A17 = [1542, 1018];
A18 = [1304, 783];
A19 = [1303, 1216];
A20 = [1058, 938];
A21 = [543, 822];
A22 = [59, 1216];
A23 = [274, 518];
A24 = [196, 315];
A25 = [105, 186];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25];

// Inner Points
B1 = [695, 708];
B2 = [930, 753];

// Polygons
C1 = [A24, A25, A1, A2, A3];
C2 = [A24, A3, A4, A23];
C3 = [A4, A5, B1, A21, A22, A23];
C4 = [A21, A20, B2, B1];
C5 = [B1, A5, A6, B2];
C6 = [A6, A7, A18, A19, A20, B2];
C7 = [A7, A8, A9, A18];
C8 = [A9, A10, A15, A16, A17, A18];
C9 = [A10, A11, A14, A15];
C10 = [A11, A12, A13, A14];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10];

min_x = A22[0];
min_y = A1[1];
max_x = A12[0];
max_y = A19[1];


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
