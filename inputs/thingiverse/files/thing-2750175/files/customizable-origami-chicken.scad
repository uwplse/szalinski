/*
 * Customizable Origami - Chicken - https://www.thingiverse.com/thing:2750175
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2018-01-08
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
inline_edge_radius_in_millimeter = 0.5; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [233, 648];
A2 = [283, 534];
A3 = [244, 488];
A4 = [462, 269];
A5 = [587, 325];
A6 = [570, 440];
A7 = [884, 772];
A8 = [903, 751];
A9 = [935, 776];
A10 = [1423, 424];
A11 = [1687, 437];
A12 = [1792, 210];
A13 = [1826, 442];
A14 = [1841, 557];
A15 = [1505, 757];
A16 = [1603, 1207];
A17 = [1323, 1468];
A18 = [1254, 1704];
A19 = [1154, 1663];
A20 = [840, 1806];
A21 = [255, 1231];
A22 = [427, 704];
A23 = [323, 586];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23];

// Inner Points
B1 = [524, 398];
B2 = [852, 1543];
B3 = [1363, 1327];
B4 = [1146, 1422];

// Polygons
C1 = [A1, A2, A23];
C2 = [A2, A3, B1, A22, A23];
C3 = [A3, A4, A5, A6, B1];
C4 = [B1, A6, A7, A21];
C5 = [A7, A21, A20, B2];
C6 = [A7, A8, B4, B2];
C7 = [A8, B4, B3, A17, A16, A9];
C8 = [B4, B3, A17, A18, A19, B2];
C9 = [B2, A20, A19];
C10 = [A9, A10, A15, A16];
C11 = [A10, A11, A13, A14, A15];
C12 = [A11, A12, A13];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12];

min_x = A1[0];
min_y = A12[1];
max_x = A14[0];
max_y = A20[1];

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
