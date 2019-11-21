/*
 * Customizable Origami - Cross - https://www.thingiverse.com/thing:2706565
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-12-11
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
outline_size_in_millimeter = 2.4; //[0.5:0.1:20]

// Thickness of the inner outline.
inline_size_in_millimeter = 0.8; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 0.9; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [4, 0];
A2 = [6, 0];
A3 = [6, 4];
A4 = [10, 4];
A5 = [10, 6];
A6 = [6, 6];
A7 = [6, 15];
A8 = [4, 15];
A9 = [4, 6];
A10 = [0, 6];
A11 = [0, 4];
A12 = [4, 4];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12];

// Inner Points
B1 = [1, 5];
B2 = [3, 5];
B3 = [5, 5];
B4 = [7, 5];
B5 = [9, 5];
B6 = [5, 1];
B7 = [5, 3];
B8 = [5, 7];
B9 = [5, 14];

// Polygons
C1 = [A1, B6, A2];
C2 = [B6, B7, A3, A2];
C3 = [B6, B7, A12, A1];
C4 = [A3, A4, B5, B4];
C5 = [A4, B5, A5];
C6 = [B5, A5, A6, B4];
C7 = [A6, B3, A3, B4];
C8 = [B7, A3, B3, A12];
C9 = [A12, A11, B1, B2];
C10 = [A12, B3, A9, B2];
C11 = [B2, A9, A10, B1];
C12 = [A11, B1, A10];
C13 = [B3, A6, B8, A9];
C14 = [A6, A7, B9, B8];
C15 = [B8, B9, A8, A9];
C16 = [B9, A7, A8];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16];

min_x = A10[0];
min_y = A2[1];
max_x = A5[0];
max_y = A8[1];

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
