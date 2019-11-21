/*
 * Customizable Origami - Chrome T-Rex - https://www.thingiverse.com/thing:2700244
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-12-08
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
outline_size_in_millimeter = 0.0; //[0.5:0.1:20]

// Thickness of the inner outline.
inline_size_in_millimeter = 0.0; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 0.0; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [0, 15];
A2 = [2, 15];
A3 = [2, 19];
A4 = [4, 19];
A5 = [4, 21];
A6 = [6, 21];
A7 = [6, 23];
A8 = [10, 23];
A9 = [10, 21];
A10 = [12, 21];
A11 = [12, 19];
A12 = [15, 19];
A13 = [15, 17];
A14 = [18, 17];
A15 = [18, 15];
A16 = [20, 15];
A17 = [20, 2];
A18 = [22, 2];
A19 = [22, 0];
A20 = [38, 0];
A21 = [38, 2];
A22 = [40, 2];
A23 = [40, 4];
A24 = [40, 11];
A25 = [30, 11];
A26 = [30, 13];
A27 = [36, 13];
A28 = [36, 15];
A29 = [28, 15];
A30 = [28, 19];
A31 = [32, 19];
A32 = [32, 23];
A33 = [30, 23];
A34 = [30, 21];
A35 = [28, 21];
A36 = [28, 28];
A37 = [26, 28];
A38 = [26, 31];
A39 = [24, 31];
A40 = [24, 33];
A41 = [22, 33];
A42 = [22, 41];
A43 = [24, 41];
A44 = [24, 43];
A45 = [20, 43];
A46 = [20, 37];
A47 = [18, 37];
A48 = [18, 35];
A49 = [16, 35];
A50 = [16, 37];
A51 = [14, 37];
A52 = [14, 39];
A53 = [12, 39];
A54 = [12, 41];
A55 = [14, 41];
A56 = [14, 43];
A57 = [10, 43];
A58 = [10, 35];
A59 = [8, 35];
A60 = [8, 33];
A61 = [6, 33];
A62 = [6, 31];
A63 = [4, 31];
A64 = [4, 29];
A65 = [2, 29];
A66 = [2, 27];
A67 = [0, 27];


outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38, A39, A40, A41, A42, A43, A44, A45, A46, A47, A48, A49, A50, A51, A52, A53, A54, A55, A56, A57, A58, A59, A60, A61, A62, A63, A64, A65, A66, A67];

// Inner Points
B1 = [28, 3];
B2 = [26, 3];
B3 = [26, 5];
B4 = [28, 5];

// Polygons
C1 = [B1, B2, B3, B4];

cut_polygons = [C1];

min_x = A67[0];
min_y = A19[1];
max_x = A22[0];
max_y = A45[1];

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
