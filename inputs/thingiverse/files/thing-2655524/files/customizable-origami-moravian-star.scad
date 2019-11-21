/*
 * Customizable Origami - Moravian Star - https://www.thingiverse.com/thing:2655524
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-11-19
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
A1 = [136, 161];
A2 = [325, 307];
A3 = [280, 211];
A4 = [458, 405];
A5 = [496, 15];
A6 = [535, 390];
A7 = [712, 197];
A8 = [660, 309];
A9 = [855, 154];
A10 = [675, 376];
A11 = [786, 336];
A12 = [641, 459];
A13 = [783, 453];
A14 = [732, 472];
A15 = [983, 499];
A16 = [735, 534];
A17 = [828, 569];
A18 = [627, 554];
A19 = [708, 632];
A20 = [659, 619];
A21 = [831, 824];
A22 = [685, 718];
A23 = [770, 871];
A24 = [533, 610];
A25 = [496, 949];
A26 = [459, 610];
A27 = [227, 867];
A28 = [311, 716];
A29 = [165, 824];
A30 = [329, 626];
A31 = [282, 644];
A32 = [369, 555];
A33 = [163, 575];
A34 = [251, 539];
A35 = [11, 518];
A36 = [276, 475];
A37 = [214, 454];
A38 = [357, 460];
A39 = [217, 331];
A40 = [306, 366];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38, A39, A40];

// Inner Points
B1 = [496, 244];
B2 = [496, 476];
B3 = [559, 536];
B4 = [434, 536];
B5 = [388, 487];
B6 = [454, 419];
B7 = [540, 419];
B8 = [591, 553];
B9 = [401, 554];
B10 = [496, 710];
B11 = [496, 873];
B12 = [609, 488];

// Polygons
C1 = [A5, A6, B7, B1, B6, A4];
C2 = [A24, A25, A26, B10];
C3 = [A26, B11, B10];
C4 = [A24, B11, B10];
C5 = [B10, A26, B4, B2];
C6 = [A24, B3, B2, B10];
C7 = [B1, B7, B2];
C8 = [B2, B6, B1];
C9 = [A6, A7, A8];
C10 = [A6, A8, A9, B7];
C11 = [A9, A10, B7];
C12 = [B7, A10, A11, B2];
C13 = [B2, A11, A12, B12, B3];
C14 = [A12, A13, A14];
C15 = [A12, A14, A15, B12];
C16 = [B12, A15, A16];
C17 = [B12, A16, A17, B3];
C18 = [B3, A17, A18, B8];
C19 = [A18, A19, A20, B8];
C20 = [B8, A20, A21];
C21 = [B8, A22, A21];
C22 = [A22, A23, B3, B8];
C23 = [B3, A23, A24];
C24 = [A26, A27, B4];
C25 = [A27, A28, B9, B4];
C26 = [B9, A28, A29];
C27 = [A29, A30, B9];
C28 = [A30, A31, A32, B9];
C29 = [B4, B9, A32, A33];
C30 = [A33, A34, B5, B4];
C31 = [A34, A35, B5];
C32 = [A35, A36, A38, B5];
C33 = [A36, A37, A38];
C34 = [A39, A38, B5, B4, B2];
C35 = [A39, A40, B6, B2];
C36 = [A40, A1, B6];
C37 = [A1, A2, B6];
C38 = [A3, A2, B6, A4];

cut_polygons = [C1, C2, /*C3, C4,*/ C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, C26, C27, C28, C29, C30, C31, C32, C33, C34, C35, C36, C37, C38];

min_x = A35[0];
min_y = A5[1];
max_x = A15[0];
max_y = A25[1];

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
