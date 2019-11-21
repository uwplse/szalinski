/*
 * Customizable Origami - Panther Head - https://www.thingiverse.com/thing:2626257
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-11-04
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
inline_size_in_millimeter = 0.7; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 0.4; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [400, 35];
A2 = [526, 73];
A3 = [581, 42];
A4 = [622, 9];
A5 = [671, 32];
A6 = [681, 77];
A7 = [615, 225];
A8 = [641, 371];
A9 = [595, 481];
A10 = [543, 526];
A11 = [498, 586];
A12 = [455, 648];
A13 = [352, 648];
A14 = [303, 588];
A15 = [257, 529];
A16 = [205, 481];
A17 = [159, 369];
A18 = [186, 224];
A19 = [117, 75];
A20 = [127, 32];
A21 = [175, 9];
A22 = [217, 44];
A23 = [273, 74];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23];

// Inner Points
B1 = [248, 493];
B2 = [269, 435];
B3 = [295, 404];
B4 = [552, 493];
B5 = [505, 404];
B6 = [527, 432];
B7 = [274, 266];
B8 = [273, 291];
B9 = [308, 303];
B10 = [324, 290];
B11 = [399, 315];
B12 = [476, 291];
B13 = [527, 266];
B14 = [526, 291];
B15 = [495, 303];
B16 = [333, 455];
B17 = [363, 450];
B18 = [436, 449];
B19 = [465, 456];
B20 = [378, 499];
B21 = [400, 558];
B22 = [421, 499];
B23 = [342, 584];
B24 = [456, 583];
B25 = [229, 305];
B26 = [570, 302];

// Polygons
C1 = [A18, A23, A22, A21, A20, A19];
C2 = [A2, A3, A4, A5, A6, A7];
C3 = [A23, A1, A2, B12, B11, B10];
C4 = [B12, A2, A7, B13];
C5 = [A23, B10, B7, A18];
C6 = [A18, B25, B7];
C7 = [A18, B25, A17];
C8 = [B25, B2, A17];
C9 = [B11, B17, B18];
C10 = [B18, B19, B12, B11];
C11 = [B11, B17, B16, B10];
C12 = [B20, B22, B21];
C13 = [B16, B17, B18, B19, B22, B20];
C14 = [A14, B23, B21, B24, A11, A12, A13];
C15 = [B24, A11, A10, B4, B6, B5, B12, B19, B22, B21];
C16 = [B10, B3, B2, B1, A15, A14, B23, B21, B20, B16];
C17 = [B2, B3, B10, B9, B8, B7, B25];
C18 = [B12, B5, B6, B26, B13, B14, B15];
C19 = [B13, B26, A7];
C20 = [B26, A7, A8];
C21 = [A8, B26, B6];
C22 = [B12, B15, B14, B13];
C23 = [B7, B8, B9, B10];
C24 = [A8, B4, A10, A9];
C25 = [B4, B6, A8];
C26 = [A15, B1, A17, A16];
C27 = [A17, B1, B2];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, /*C13,*/ C14, C15, C16, C17, C18, C19, C20, C21, /*C22, C23, */C24, C25, C26, C27];

min_x = A19[0];
min_y = A4[1];
max_x = A6[0];
max_y = A13[1];

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
