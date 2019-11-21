/*
 * Customizable Origami - Bison - https://www.thingiverse.com/thing:2755003
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2018-01-12
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
inline_size_in_millimeter = 0.8; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 0.4; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [622, 1050];
A2 = [546, 946];
A3 = [500, 970];
A4 = [263, 743];
A5 = [337, 536];
A6 = [461, 498];
A7 = [479, 548];
A8 = [528, 453];
A9 = [516, 411];
A10 = [697, 235];
A11 = [914, 261];
A12 = [1319, 369];
A13 = [1504, 408];
A14 = [1674, 547];
A15 = [1630, 655];
A16 = [1654, 666];
A17 = [1680, 1003];
A18 = [1604, 719];
A19 = [1593, 744];
A20 = [1500, 825];
A21 = [1570, 908];
A22 = [1550, 1200];
A23 = [1523, 1262];
A24 = [1450, 1262];
A25 = [1513, 1211];
A26 = [1490, 956];
A27 = [1490, 886];
A28 = [1443, 867];
A29 = [1347, 784];
A30 = [905, 879];
A31 = [903, 986];
A32 = [878, 994];
A33 = [904, 1138];
A34 = [855, 1217];
A35 = [839, 1262];
A36 = [766, 1262];
A37 = [753, 1251];
A38 = [816, 1197];
A39 = [772, 967];
A40 = [707, 950];
A41 = [625, 727];
A42 = [566, 728];
A43 = [639, 895];
A44 = [606, 918];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38, A39, A40, A41, A42, A43, A44];

// Inner Points
B1 = [741, 422];
B2 = [918, 719];
B3 = [1321, 728];
B4 = [444, 726];
B5 = [520, 675];
B6 = [447, 621];
B7 = [572, 566];
B8 = [784, 493];
B9 = [815, 547];

// Polygons
C1 = [A5, A6, B6, A4];
C2 = [B6, B4, A4];
C3 = [B4, A42, A43, A44, A2, A3, A4];
C4 = [A44, A1, A2];
C5 = [B4, B6, A6, A7, B5];
C6 = [A7, A8, B7, A41, A42, B4, B5];
C7 = [A9, A10, A11, B2, B9, B8, B1];
C8 = [A9, B1, B8, B7, A8];
C9 = [B8, B9, A41, B7];
C10 = [B9, B2, A41];
C11 = [B2, A30, A31, A32, A39, A40, A41];
C12 = [A32, A33, A34, A37, A38, A39];
C13 = [A34, A35, A36, A37];
C14 = [A11, A12, B3, B2];
C15 = [B2, B3, A29, A30];
C16 = [A12, A13, A14, A15, A18, A19, B3];
C17 = [A15, A16, A17, A18];
C18 = [A19, A20, A28, A29, B3];
C19 = [A28, A20, A21, A27];
C20 = [A27, A21, A22, A25, A26];
C21 = [A22, A23, A24, A25];

cut_polygons = [C1, C2, C3, C4, /*C5,*/ C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21];

min_x = A4[0];
min_y = A10[1];
max_x = A17[0];
max_y = A36[1];

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
