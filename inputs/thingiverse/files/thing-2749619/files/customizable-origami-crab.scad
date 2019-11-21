/*
 * Customizable Origami - Crab - https://www.thingiverse.com/thing:2749619
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2018-01-07
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
inline_size_in_millimeter = 0.9; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 0.8; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [665, 99];
A2 = [728, 455];
A3 = [969, 440];
A4 = [1222, 457];
A5 = [1279, 89];
A6 = [1510, 474];
A7 = [1432, 948];
A8 = [1676, 1151];
A9 = [1598, 1551];
A10 = [1360, 1333];
A11 = [970, 1374];
A12 = [586, 1332];
A13 = [345, 1550];
A14 = [274, 1147];
A15 = [522, 937];
A16 = [431, 474];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16];

// Inner Points

// Polygons
C1 = [A16, A1, A2];
C2 = [A5, A6, A4];
C3 = [A16, A2, A3, A11];
C4 = [A16, A15, A12, A11];
C5 = [A15, A14, A12];
C6 = [A14, A13, A12];
C7 = [A3, A4, A6, A11];
C8 = [A6, A7, A10, A11];
C9 = [A7, A8, A10];
C10 = [A10, A9, A8];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10];

min_x = A14[0];
min_y = A5[1];
max_x = A8[0];
max_y = A9[1];

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
