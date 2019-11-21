/*
 * Customizable Origami - Snowman - https://www.thingiverse.com/thing:2759937
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2018-01-17
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
inline_size_in_millimeter = 0.9; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 0.5; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [714, 1322];
A2 = [663, 1284];
A3 = [570, 1125];
A4 = [557, 1057];
A5 = [654, 884];
A6 = [583, 756];
A7 = [585, 644];
A8 = [348, 570];
A9 = [356, 538];
A10 = [603, 613];
A11 = [661, 511];
A12 = [686, 509];
A13 = [620, 391];
A14 = [650, 294];
A15 = [700, 202];
A16 = [717, 199];
A17 = [854, 197];
A18 = [909, 197];
A19 = [981, 316];
A20 = [970, 385];
A21 = [906, 506];
A22 = [926, 504];
A23 = [980, 593];
A24 = [1278, 501];
A25 = [1296, 518];
A26 = [1002, 622];
A27 = [1012, 646];
A28 = [1017, 747];
A29 = [949, 883];
A30 = [1048, 1051];
A31 = [1050, 1117];
A32 = [967, 1274];
A33 = [903, 1321];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33];

// Inner Points
B1 = [798, 904];
B2 = [792, 772];
B3 = [930, 673];
B4 = [654, 676];
B5 = [622, 652];
B6 = [640, 622];
B7 = [961, 635];
B8 = [950, 602];
B9 = [957, 1183];
B10 = [644, 1182];
B11 = [795, 1093];
B12 = [779, 514];
B13 = [707, 525];
B14 = [880, 524];
B15 = [772, 396];
B16 = [888, 322];
B17 = [665, 320];

// Polygons
C1 = [A13, A14, A15, A16, B17];
C2 = [A16, A17, B16, B15, B17];
C3 = [A17, A18, A19, A20, B16];
C4 = [B16, A20, A21, B12, B15];
C5 = [B17, B15, B12, A12, A13];
C6 = [A11, A12, B12, A21, A22, B14, B13];
C7 = [A11, A10, B6, B5, A7, A6, B4, B13];
C8 = [B13, B14, B3, B2, B4];
C9 = [B14, A22, A23, B8, B7, A26, A27, A28, B3];
C10 = [B3, A28, A29, B1, B2];
C11 = [B4, B2, B1, A5, A6];
C12 = [B1, B11, B9, A30, A29];
C13 = [A30, A31, A32, A33, B9];
C14 = [B11, B9, A33, A1, B10];
C15 = [B10, A1, A2, A3, A4];
C16 = [A4, A5, B1, B11, B10];
C17 = [B8, A23, A24, A25, A26, B7];
C18 = [A9, A10, B6, B5, A7, A8];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18];

min_x = A8[0];
min_y = A17[1];
max_x = A25[0];
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
