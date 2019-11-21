/*
 * Customizable Origami - Camel - https://www.thingiverse.com/thing:2734204
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-12-27
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
inline_edge_radius_in_millimeter = 0.4; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [430, 222];
A2 = [459, 156];
A3 = [560, 101];
A4 = [672, 97];
A5 = [757, 209];
A6 = [790, 480];
A7 = [1169, 94];
A8 = [1540, 480];
A9 = [1542, 533];
A10 = [1673, 854];
A11 = [1567, 1004];
A12 = [1543, 591];
A13 = [1529, 1200];
A14 = [1165, 825];
A15 = [810, 1200];
A16 = [800, 857];
A17 = [593, 866];
A18 = [429, 733];
A19 = [406, 509];
A20 = [586, 281];
A21 = [499, 202];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21];

// Inner Points
B1 = [666, 181];
B2 = [1176, 480];

// Polygons
C1 = [A1, A2, A3];
C2 = [A1, A3, A4, B1, A20, A21];
C3 = [A4, A5, B1];
C4 = [B1, A5, A6, A18, A19, A20];
C5 = [A18, A6, A16, A17];
C6 = [A6, B2, A7];
C7 = [A7, A8, B2];
C8 = [A6, A14, A15, A16];
C9 = [A6, B2, A8, A14];
C10 = [A14, A8, A9, A12, A13];
C11 = [A9, A10, A11, A12];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11];

min_x = A19[0];
min_y = A7[1];
max_x = A10[0];
max_y = A15[1];

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
