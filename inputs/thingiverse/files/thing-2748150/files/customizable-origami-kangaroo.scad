/*
 * Customizable Origami - Kangaroo - https://www.thingiverse.com/thing:2748150
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2018-01-06
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
outline_size_in_millimeter = 1.8; //[0.5:0.1:20]

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
A1 = [164, 1805];
A2 = [1168, 1736];
A3 = [1600, 796];
A4 = [1667, 721];
A5 = [2115, 609];
A6 = [2347, 359];
A7 = [2336, 261];
A8 = [2542, 58];
A9 = [2589, 227];
A10 = [2557, 260];
A11 = [2777, 409];
A12 = [2787, 467];
A13 = [2483, 485];
A14 = [2469, 1020];
A15 = [2356, 1226];
A16 = [2527, 1309];
A17 = [2351, 1330];
A18 = [2184, 1216];
A19 = [1958, 1355];
A20 = [1900, 1726];
A21 = [2397, 1928];
A22 = [1871, 1928];
A23 = [1691, 1489];
A24 = [1319, 1928];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24];

// Inner Points
B1 = [2003, 1074];
B2 = [1564, 1191];
B3 = [2341, 1107];
B4 = [2354, 447];
B5 = [2486, 333];

// Polygons
C1 = [A7, A8, A9, A10, B5, B4, A6];
C2 = [B5, A13, A12, A11, A10];
C3 = [B5, A13, A14, B4];
C4 = [A6, B4, A14, A15, B3, A5];
C5 = [A15, A17, A16];
C6 = [A15, B3, A18, A17];
C7 = [A4, A5, B3, A18, A19, B1];
C8 = [A4, B1, A19, A20, A22, A23, B2];
C9 = [A20, A21, A22];
C10 = [A4, A3, A2, A24, A23, B2];
C11 = [A1, A2, A24];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11];

min_x = A1[0];
min_y = A8[1];
max_x = A12[0];
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
