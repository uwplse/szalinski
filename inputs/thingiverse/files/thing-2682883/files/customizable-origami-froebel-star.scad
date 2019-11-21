/*
 * Customizable Origami - Froebel star - https://www.thingiverse.com/thing:2682883
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-12-01
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
outline_size_in_millimeter = 2.8; //[0.5:0.1:20]

// Thickness of the inner outline.
inline_size_in_millimeter = 1.1; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 1.3; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [2, 0];
A2 = [3, 1];
A3 = [4, 0];
A4 = [4, 2];
A5 = [6, 2];
A6 = [5, 3];
A7 = [6, 4];
A8 = [4, 4];
A9 = [4, 6];
A10 = [3, 5];
A11 = [2, 6];
A12 = [2, 4];
A13 = [0, 4];
A14 = [1, 3];
A15 = [0, 2];
A16 = [2, 2];


outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16];

// Inner Points
B1 = [3, 3];

// Polygons
C1 = [A1, A2, A16];
C2 = [A2, A4, A16];
C3 = [A3, A4, A2];
C4 = [A4, A5, A6];
C5 = [A4, A6, A8];
C6 = [A8, A6, A7];
C7 = [A8, A9, A10];
C8 = [A12, A8, A10];
C9 = [A12, A10, A11];
C10 = [A13, A14, A12];
C11 = [A14, A16, A12];
C12 = [A15, A16, A14];
C13 = [A16, A4, B1];
C14 = [A4, A8, B1];
C15 = [A8, A12, B1];
C16 = [A12, A16, B1];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16];

min_x = A13[0];
min_y = A1[1];
max_x = A5[0];
max_y = A11[1];

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
