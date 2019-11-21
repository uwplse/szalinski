/*
 * Customizable Origami - Bear - https://www.thingiverse.com/thing:2632984
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-11-10
 * version v1.1
 *
 * Changelog
 * --------------
 * v1.1:
 *      - set feet to the same origin
 *
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
outline_size_in_millimeter = 1.7; //[0.5:0.1:20]

// Thickness of the inner outline.
inline_size_in_millimeter = 0.7; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 0.7; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [281, 1136];
A2 = [130, 1136];
A3 = [30, 1007];
A4 = [167, 758];
A5 = [269, 340];
A6 = [655, 82];
A7 = [1192, 106];
A8 = [1329, 90];
A9 = [1688, 226];
A10 = [1769, 243];
A11 = [1795, 160];
A12 = [1893, 161];
A13 = [1878, 262];
A14 = [1956, 398];
A15 = [1938, 430];
A16 = [2088, 531];
A17 = [2021, 607];
A18 = [1850, 564];
A19 = [1837, 583];
A20 = [1502, 520];
A21 = [1426, 713];
A22 = [1591, 905];
A23 = [1579, 1048];
A24 = [1515, 1101];
A25 = [1463, 954];
A26 = [1346, 907];
A27 = [1305, 886];
A28 = [1336, 1069];
A29 = [1439, 1136];
A30 = [1268, 1136];
A31 = [1164, 963];
A32 = [1160, 777];
A33 = [1159, 665];
A34 = [768, 787];
A35 = [795, 1032];
A36 = [948, 1136];
A37 = [654, 1136];
A38 = [415, 790];
A39 = [175, 1024];
A40 = [181, 1075];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, /*A23,*/ A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38, A39, A40];

// Inner Points
B1 = [387, 753];
B2 = [254, 555];

// Polygons
C1 = [A1, A2, A40];
C2 = [A40, A39, A3, A2];
C3 = [A3, A39, A38, B1, A4];
C4 = [A4, B1, B2, A5];
C5 = [A5, A6, A34, A35, A37, A38, B1, B2];
C6 = [A6, A7, A33, A34];
C7 = [A35, A36, A37];
C8 = [A7, A8, A20, A21, A26, A27, A32, A33];
C9 = [A32, A31, A30, A28, A27];
C10 = [A28, A30, A29];
C11 = [A24, /*A23,*/ A22, A25];
C12 = [A22, A21, A26, A25];
C13 = [A20, A9, A8];
C14 = [A20, A19, A18, A15, A14, A13, A10, A9];
C15 = [A10, A11, A12, A13];
C16 = [A15, A16, A17, A18];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16];

min_x = A3[0];
min_y = A8[1];
max_x = A16[0];
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
