/*
 * Customizable Origami - Crane - https://www.thingiverse.com/thing:2685084
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-12-02
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
A1 = [367, 189];
A2 = [813, 916];
A3 = [924, 879];
A4 = [926, 856];
A5 = [933, 857];
A6 = [1026, 654];
A7 = [1864, 264];
A8 = [1569, 949];
A9 = [1632, 955];
A10 = [1802, 1222];
A11 = [1571, 1026];
A12 = [1225, 1441];
A13 = [1202, 1420];
A14 = [1162, 1471];
A15 = [1052, 1323];
A16 = [159, 1121];
A17 = [621, 875];
A18 = [671, 893];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18];

// Inner Points
B1 = [1014, 1146];
B2 = [1076, 828];
B3 = [1172, 1165];
B4 = [1259, 1110];
B5 = [1192, 994];
B6 = [1521, 943];
B7 = [1550, 972];
B8 = [1204, 1292];
B9 = [1094, 1330];
B10 = [794, 929];

// Polygons
C1 = [A4, A5, B2, B5, A7, A6];
C2 = [B5, B4, B6, A8, A7];
C3 = [B6, A8, A9, A10, B7];
C4 = [B7, A10, A11];
C5 = [B7, A13, A12, A11];
C6 = [B7, A13, A14, B8, B3, B4, B6];
C7 = [A14, B8, B9, A15];
C8 = [B8, B1, A16, A15, B9];
C9 = [B1, B10, A18, A17, A16];
C10 = [B10, A2, A3, B2, B1];
C11 = [B2, B3, B8, B1];
C12 = [B2, B3, B4, B5];
C13 = [A2, A1, A18, B10];
C14 = [A3, B2, A5, A4];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14];

min_x = A16[0];
min_y = A1[1];
max_x = A7[0];
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
