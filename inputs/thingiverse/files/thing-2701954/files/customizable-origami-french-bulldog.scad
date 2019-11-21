/*
 * Customizable Origami - French Bulldog - https://www.thingiverse.com/thing:2701954
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-12-09
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
outline_size_in_millimeter = 2.2; //[0.5:0.1:20]

// Thickness of the inner outline.
inline_size_in_millimeter = 0.8; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 1.7; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [1015, 153];
A2 = [1062, 212];
A3 = [1109, 153];
A4 = [1167, 275];
A5 = [1334, 335];
A6 = [1360, 485];
A7 = [1387, 519];
A8 = [1387, 565];
A9 = [1385, 645];
A10 = [1268, 686];
A11 = [1204, 919];
A12 = [1094, 1088];
A13 = [1055, 1195];
A14 = [1116, 1311];
A15 = [943, 1311];
A16 = [896, 1050];
A17 = [878, 961];
A18 = [566, 964];
A19 = [436, 1068];
A20 = [424, 1186];
A21 = [486, 1311];
A22 = [304, 1311];
A23 = [251, 1025];
A24 = [249, 793];
A25 = [290, 651];
A26 = [235, 587];
A27 = [230, 515];
A28 = [307, 490];
A29 = [357, 534];
A30 = [908, 534];
A31 = [986, 301];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31];

// Inner Points
B1 = [1101, 273];
B2 = [1240, 548];
B3 = [1321, 508];
B4 = [1025, 634];
B5 = [863, 726];
B6 = [367, 790];

// Polygons
C1 = [A31, A1, A2, B1];
C2 = [A2, A3, A4, B1];
C3 = [A31, B1, A4, A5, A6, B3, B2, A10, B4, A30];
C4 = [B2, A10, A9, A8, B3];
C5 = [B3, A6, A7, A8];
C6 = [A30, B4, A10, A11, A17, B5];
C7 = [A17, A11, A12, A16];
C8 = [A12, A13, A15, A16];
C9 = [A13, A14, A15];
C10 = [A17, B5, A30, A29, A25, B6, A18];
C11 = [A29, A28, A27, A26, A25];
C12 = [A25, B6, A18, A19, A23, A24];
C13 = [A19, A20, A22, A23];
C14 = [A20, A21, A22];

cut_polygons = [C1, C2, C3, C4, /*C5,*/ C6, C7, C8, C9, C10, C11, C12, C13, C14];

min_x = A27[0];
min_y = A1[1];
max_x = A7[0];
max_y = A21[1];

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
