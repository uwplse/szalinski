/*
 * Customizable Origami - Steamboat - https://www.thingiverse.com/thing:2730388
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-12-25
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
outline_size_in_millimeter = 1.6; //[0.5:0.1:20]

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
A1 = [494, 707];
A2 = [579, 512];
A3 = [643, 504];
A4 = [658, 432];
A5 = [780, 426];
A6 = [779, 486];
A7 = [892, 470];
A8 = [913, 217];
A9 = [1014, 215];
A10 = [1103, 442];
A11 = [1214, 431];
A12 = [1353, 632];
A13 = [1784, 619];
A14 = [1752, 722];
A15 = [1425, 1040];
A16 = [1348, 1052];
A17 = [532, 1052];
A18 = [371, 1052];
A19 = [211, 728];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19];

// Inner Points
B1 = [702, 695];
B2 = [1172, 662];

// Polygons
C1 = [A8, A9, A10, A7];
C2 = [A4, A5, A6, A3];
C3 = [A2, A3, A6, A7, A10, A11, A12, B2, B1, A1];
C4 = [A19, A18, A17, B1, A1];
C5 = [B1, B2, A16, A17];
C6 = [B2, A12, A13, A14, A15, A16];

cut_polygons = [C1, C2, C3, C4, C5, C6];

min_x = A19[0];
min_y = A9[1];
max_x = A13[0];
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
