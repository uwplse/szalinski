/*
 * Customizable Origami - Sausage Dog - https://www.thingiverse.com/thing:2618266
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-10-30
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
outline_size_in_millimeter = 1.5; //[0.5:0.1:20]

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
A1 = [14, 148];
A2 = [146, 134];
A3 = [232, 54];
A4 = [232, 35];
A5 = [452, 7];
A6 = [435, 32];
A7 = [526, 186];
A8 = [1355, 230];
A9 = [1503, 218];
A10 = [1691, 101];
A11 = [1775, 83];
A12 = [1526, 252];
A13 = [1543, 292];
A14 = [1549, 476];
A15 = [1532, 575];
A16 = [1518, 580];
A17 = [1467, 704];
A18 = [1449, 778];
A19 = [1335, 778];
A20 = [1440, 715];
A21 = [1430, 609];
A22 = [1393, 618];
A23 = [1335, 407];
A24 = [760, 522];
A25 = [703, 523];
A26 = [500, 648];
A27 = [495, 712];
A28 = [491, 778];
A29 = [379, 778];
A30 = [455, 735];
A31 = [454, 675];
A32 = [312, 510];
A33 = [300, 508];
A34 = [305, 270];
A35 = [258, 350];
A36 = [248, 242];
A37 = [58, 225];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37];

// Polygons
C1 = [A1, A37, A2];
C2 = [A3, A2, A37, A36];
C3 = [A35, A36, A3, A4, A5, A6, A34];
C4 = [A34, A6, A7];
C5 = [A34, A33, A7];
C6 = [A32, A33, A7, A24, A25];
C7 = [A32, A31, A26, A25];
C8 = [A31, A30, A27, A26];
C9 = [A28, A29, A30, A27];
C10 = [A24, A7, A8, A23];
C11 = [A8, A9, A23];
C12 = [A9, A10, A11, A12];
C13 = [A12, A13, A23, A9];
C14 = [A13, A14, A23];
C15 = [A23, A22, A14];
C16 = [A14, A22, A21, A16, A15];
C17 = [A16, A17, A20, A21];
C18 = [A17, A18, A19, A20];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18];

min_x = A1[0];
min_y = A5[1];
max_x = A11[0];
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
