/*
 * Customizable Origami - Pac-Man - https://www.thingiverse.com/thing:2674461
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-11-28
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
outline_size_in_millimeter = 1.2; //[0.5:0.1:20]

// Thickness of the inner outline.
inline_size_in_millimeter = 0.7; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 0.3; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

// Fill Mode
fill_mode = "solid"; //[solid,hollow]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [0, 4];
A2 = [0, 2];
A3 = [1, 2];
A4 = [1, 1];
A5 = [3, 1];
A6 = [3, 0];
A7 = [8, 0];
A8 = [8, 1];
A9 = [10, 1];
A10 = [10, 2];
A11 = [11, 2];
A12 = [11, 4];
A13 = [12, 4];
A14 = [12, 9];
A15 = [11, 9];
A16 = [11, 11];
A17 = [10, 11];
A18 = [10, 12];
A19 = [8, 12];
A20 = [8, 13];
A21 = [3, 13];
A22 = [3, 12];
A23 = [1, 12];
A24 = [1, 11];
A25 = [0, 11];
A26 = [0, 9];
A27 = [2, 9];
A28 = [2, 8];
A29 = [5, 8];
A30 = [5, 7];
A31 = [7, 7];
A32 = [7, 6];
A33 = [5, 6];
A34 = [5, 5];
A35 = [2, 5];
A36 = [2, 4];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36];

// Inner Points

// Polygons
C1 = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36];

cut_polygons = [C1];

min_x = A2[0];
min_y = A6[1];
max_x = A14[0];
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
            if(fill_mode == "hollow") {
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
}
