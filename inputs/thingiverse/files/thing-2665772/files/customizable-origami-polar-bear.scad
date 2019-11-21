/*
 * Customizable Origami - Polar Bear - https://www.thingiverse.com/thing:
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-11-24
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
inline_size_in_millimeter = 0.9; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 0.7; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [176, 905];
A2 = [215, 860];
A3 = [164, 674];
A4 = [223, 497];
A5 = [290, 393];
A6 = [426, 208];
A7 = [460, 165];
A8 = [454, 115];
A9 = [497, 117];
A10 = [595, 121];
A11 = [673, 209];
A12 = [661, 224];
A13 = [692, 271];
A14 = [721, 311];
A15 = [680, 330];
A16 = [657, 338];
A17 = [588, 311];
A18 = [572, 330];
A19 = [625, 470];
A20 = [683, 522];
A21 = [725, 553];
A22 = [705, 598];
A23 = [683, 588];
A24 = [660, 585];
A25 = [653, 779];
A26 = [741, 845];
A27 = [787, 829];
A28 = [789, 882];
A29 = [786, 931];
A30 = [519, 931];
A31 = [242, 931];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31];

// Inner Points
B1 = [447, 703];
B2 = [431, 515];
B3 = [546, 424];
B4 = [495, 312];
B5 = [503, 544];

// Polygons
C1 = [A7, A8, A9];
C2 = [A9, A10, A11, A12, A17, A18, B4, A6, A7];
C3 = [A12, A13, A15, A16, A17];
C4 = [A13, A15, A14];
C5 = [A18, A19, B3];
C6 = [B3, A19, A20, A23, A24, B5, B2];
C7 = [A20, A21, A22, A23];
C8 = [B5, A24, A25, B1];
C9 = [B5, B1, A3, A4, A5, B2];
C10 = [A5, B2, B3, A18, B4, A6];
C11 = [A27, A28, A26];
C12 = [A25, A26, A28, A29, A30];
C13 = [A25, B1, A3, A2, A31, A30];
C14 = [A2, A31, A1];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14];

min_x = A3[0];
min_y = A8[1];
max_x = A28[0];
max_y = A29[1];

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
