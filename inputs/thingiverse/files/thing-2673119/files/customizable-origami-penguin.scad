/*
 * Customizable Origami - Penguin - https://www.thingiverse.com/thing:2673119
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-11-27
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
inline_edge_radius_in_millimeter = 1.3; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [132, 684];
A2 = [90, 482];
A3 = [118, 301];
A4 = [193, 105];
A5 = [298, 79];
A6 = [329, 127];
A7 = [409, 165];
A8 = [335, 200];
A9 = [397, 347];
A10 = [415, 470];
A11 = [404, 624];
A12 = [366, 640];
A13 = [415, 684];
A14 = [329, 684];
A15 = [251, 684];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15];

// Inner Points
B1 = [180, 486];
B2 = [240, 431];
B3 = [280, 560];
B4 = [210, 619];
B5 = [334, 603];
B6 = [188, 274];
B7 = [306, 214];
B8 = [229, 522];

// Polygons
C1 = [A6, B7, A8, A7];
C2 = [B7, A6, A5, A4, A3, B6];
C3 = [B7, A8, A9, A10, B5, A15, A1, B4, B3, B8, B2, B6];
C4 = [A13, A12, A14];
C5 = [A15, A14, A12, A11, A10, B5];
C6 = [B4, B3, B8, B1];
C7 = [B8, B2, B1];
C8 = [B4, A1, A2, A3, B6, B2, B1];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8];

min_x = A2[0];
min_y = A5[1];
max_x = A10[0];
max_y = A1[1];

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
