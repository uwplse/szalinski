/*
 * Customizable Origami - Bat - https://www.thingiverse.com/thing:2686150
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-12-03
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
inline_size_in_millimeter = 0.8; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 0.0; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [48, 432];
A2 = [36, 387];
A3 = [73, 339];
A4 = [276, 78];
A5 = [457, 181];
A6 = [493, 102];
A7 = [513, 197];
A8 = [545, 187];
A9 = [577, 197];
A10 = [595, 106];
A11 = [628, 177];
A12 = [816, 68];
A13 = [1000, 359];
A14 = [1028, 403];
A15 = [1015, 443];
A16 = [1004, 390];
A17 = [913, 341];
A18 = [819, 409];
A19 = [746, 323];
A20 = [623, 457];
A21 = [600, 538];
A22 = [550, 595];
A23 = [503, 546];
A24 = [473, 460];
A25 = [334, 324];
A26 = [253, 402];
A27 = [158, 335];
A28 = [64, 374];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28];

// Inner Points
B1 = [531, 262];
B2 = [545, 267];
B3 = [561, 261];
B4 = [546, 324];
B5 = [449, 281];
B6 = [432, 235];
B7 = [450, 237];
B8 = [636, 234];
B9 = [648, 229];
B10 = [640, 280];
B11 = [456, 406];
B12 = [505, 451];
B13 = [592, 455];
B14 = [641, 403];
B15 = [642, 367];
B16 = [454, 380];

// Polygons
C1 = [A1, A2, A3, A28];
C2 = [A3, A4, A27, A28];
C3 = [A4, A26, A27];
C4 = [A4, A25, A26];
C5 = [A4, A25, A24, B11, B16];
C6 = [B16, B5, B6, A4];
C7 = [A4, B6, A5];
C8 = [A6, B7, B5, B6, A5];
C9 = [A6, A7, B1, B7];
C10 = [A7, A8, B2, B1];
C11 = [A8, A9, B3, B2];
C12 = [A10, B8, B3, A9];
C13 = [A10, A11, B9, B10, B8];
C14 = [A11, A12, B9];
C15 = [A12, B15, B10, B9];
C16 = [A12, A19, A20, B14, B15];
C17 = [A12, A18, A19];
C18 = [A12, A17, A18];
C19 = [A12, A13, A16, A17];
C20 = [A13, A16, A15, A14];
C21 = [B11, B12, A23, A24];
C22 = [B13, B14, A20, A21];
C23 = [B2, B3, B8, B10, B15, B14, B13, A21, A22];
C24 = [A22, A23, B12, B11, B16, B5, B7, B1, B2];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, /*C8,*/ C9, C10, C11, C12, /*C13,*/ C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24];

min_x = A2[0];
min_y = A12[1];
max_x = A14[0];
max_y = A22[1];

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
