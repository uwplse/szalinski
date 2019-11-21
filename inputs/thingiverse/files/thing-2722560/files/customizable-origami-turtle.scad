/*
 * Customizable Origami - Turtle - https://www.thingiverse.com/thing:2722560
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-12-20
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
A1 = [464, 46];
A2 = [496, 47];
A3 = [532, 48];
A4 = [595, 194];
A5 = [575, 259];
A6 = [622, 260];
A7 = [698, 214];
A8 = [934, 409];
A9 = [975, 668];
A10 = [818, 532];
A11 = [818, 675];
A12 = [698, 842];
A13 = [766, 889];
A14 = [819, 1112];
A15 = [549, 971];
A16 = [501, 1008];
A17 = [448, 971];
A18 = [180, 1111];
A19 = [232, 887];
A20 = [300, 842];
A21 = [179, 679];
A22 = [181, 534];
A23 = [25, 666];
A24 = [65, 409];
A25 = [302, 218];
A26 = [378, 261];
A27 = [416, 258];
A28 = [400, 192];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28];

// Inner Points
B1 = [498, 259];
B2 = [648, 263];
B3 = [674, 279];
B4 = [757, 332];
B5 = [820, 409];
B6 = [348, 263];
B7 = [324, 279];
B8 = [250, 324];
B9 = [180, 408];

// Polygons
C1 = [A1, A2, A3, A4, A5, B1, A27, A28];
C2 = [A2, B1, A27, A28, A1];
C3 = [A6, A7, B3, B2];
C4 = [A7, A8, A9, A10, B5, B4, B3];
C5 = [B5, A10, A11, A12, A15, A16, B1, A5, A6, B2, B3, B4];
C6 = [A26, A25, B7, B6];
C7 = [A25, A24, A23, A22, B9, B8, B7];
C8 = [B1, A16, A17, A20, A21, A22, B9, B8, B7, B6, A26, A27];
C9 = [A20, A19, A18, A17];
C10 = [A12, A13, A14, A15];

cut_polygons = [C1, /*C2,*/ C3, C4, C5, C6, C7, C8, C9, C10];

min_x = A23[0];
min_y = A1[1];
max_x = A9[0];
max_y = A14[1];

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
