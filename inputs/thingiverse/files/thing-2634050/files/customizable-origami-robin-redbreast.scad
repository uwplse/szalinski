/*
 * Customizable Origami - Robin Redbreast - https://www.thingiverse.com/thing:2634050
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-11-08
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
outline_size_in_millimeter = 1.4; //[0.5:0.1:20]

// Thickness of the inner outline.
inline_size_in_millimeter = 0.7; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 0.1; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [1, 2300];
A2 = [37, 2220];
A3 = [669, 1687];
A4 = [654, 1670];
A5 = [557, 1680];
A6 = [1653, 614];
A7 = [2154, 84];
A8 = [2439, 84];
A9 = [2689, 289];
A10 = [2717, 306];
A11 = [2959, 430];
A12 = [2657, 539];
A13 = [2596, 963];
A14 = [2410, 1674];
A15 = [2187, 1979];
A16 = [1597, 1956];
A17 = [1434, 2019];
A18 = [1583, 2403];
A19 = [1364, 2039];
A20 = [1404, 1950];
A21 = [1323, 1946];
A22 = [1051, 2051];
A23 = [1283, 2629];
A24 = [957, 2084];
A25 = [1019, 1939];
A26 = [876, 1926];
A27 = [713, 1729];
A28 = [40, 2626];
A29 = [69, 2490];
A30 = [0, 2579];
A31 = [120, 2203];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31];

// Inner Points
B1 = [687, 1709];
B2 = [2280, 1143];
B3 = [2087, 709];
B4 = [2519, 241];
B5 = [2563, 394];
B6 = [2100, 1471];

// Polygons
C1 = [A5, A6, B3];
C2 = [A5, B3, B2];
C3 = [B2, B6, A4, A5];
C4 = [A6, A7, A8, A9, B4, B3];
C5 = [B4, A9, A10, B5, A12, A13, B2, B3];
C6 = [A10, A11, A12, B5];
C7 = [A13, A14, A15, B6, B2];
C8 = [B6, A15, A16, A20, A21, A25, A26, A27, B1, A3, A4];
C9 = [A20, A16, A17, A19];
C10 = [A17, A18, A19];
C11 = [A21, A25, A24, A22];
C12 = [A22, A23, A24];
C13 = [A3, A2, A1, A31, B1];
C14 = [B1, A31, A30, A29];
C15 = [B1, A27, A28, A29];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15];

min_x = A30[0];
min_y = A7[1];
max_x = A11[0];
max_y = A23[1];

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
