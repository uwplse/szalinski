/*
 * Customizable Origami - Penrose Triangle - https://www.thingiverse.com/thing:2784682
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2018-02-07
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
outline_size_in_millimeter = 1.0; //[0.5:0.1:20]

// Thickness of the inner outline.
inline_size_in_millimeter = 1.0; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 0.6; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [69, 511];
A2 = [219, 423];
A3 = [295, 467];
A4 = [296, 380];
A5 = [449, 291];
A6 = [524, 336];
A7 = [524, 249];
A8 = [676, 161];
A9 = [750, 204];
A10 = [752, 117];
A11 = [902, 29];
A12 = [1055, 116];
A13 = [1057, 292];
A14 = [979, 336];
A15 = [1055, 379];
A16 = [1056, 555];
A17 = [981, 599];
A18 = [1055, 643];
A19 = [1056, 819];
A20 = [981, 863];
A21 = [1056, 906];
A22 = [1056, 1082];
A23 = [904, 1169];
A24 = [751, 1081];
A25 = [751, 996];
A26 = [676, 1038];
A27 = [522, 951];
A28 = [524, 864];
A29 = [446, 906];
A30 = [295, 819];
A31 = [296, 734];
A32 = [220, 775];
A33 = [67, 689];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33];

// Inner Points
B1 = [219, 599];
B2 = [373, 512];
B3 = [448, 469];
B4 = [599, 379];
B5 = [674, 337];
B6 = [827, 247];
B7 = [904, 204];
B8 = [829, 337];
B9 = [601, 469];
B10 = [446, 556];
B11 = [374, 598];
B12 = [524, 601];
B13 = [601, 554];
B14 = [675, 511];
B15 = [829, 424];
B16 = [902, 379];
B17 = [902, 466];
B18 = [751, 469];
B19 = [751, 555];
B20 = [903, 644];
B21 = [826, 598];
B22 = [751, 644];
B23 = [904, 731];
B24 = [904, 909];
B25 = [904, 994];
B26 = [751, 909];
B27 = [829, 864];
B28 = [751, 819];
B29 = [524, 776];
B30 = [601, 731];
B31 = [675, 687];
B32 = [751, 731];
B33 = [599, 643];
B34 = [447, 731];
B35 = [296, 644];
B36 = [676, 864];

// Polygons
C1 = [A1, B1, B2, A3, A2];
C2 = [A4, B3, B4, A6, A5];
C3 = [A7, B5, B6, A9, A8];
C4 = [B7, A12, A11, A10];
C5 = [A15, A14, B16, B8, B15, B17];
C6 = [A17, A18, B23, B22, B21, B20];
C7 = [A20, A21, B25, B26, B27, B24];
C8 = [B32, B28, B36, B29, B30, B31];
C9 = [B33, B34, B35, B11, B10, B12];
C10 = [B12, B13, B9, B14, B18, B19, B21, B22, B32, B31, B30, B33];
C11 = [B2, B11, B35, A31, A32, B1];
C12 = [B3, B4, B9, B13, B12, B10];
C13 = [B5, B6, B8, B15, B18, B14];
C14 = [B7, A12, A13, A14, B16];
C15 = [A15, A16, A17, B20, B17];
C16 = [A18, A19, A20, B24, B23];
C17 = [A21, A22, A23, B25];
C18 = [B27, B26, A25, A26, B36, B28];
C19 = [A28, B29, B30, B33, B34, A29];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19];

min_x = A33[0];
min_y = A11[1];
max_x = A13[0];
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
