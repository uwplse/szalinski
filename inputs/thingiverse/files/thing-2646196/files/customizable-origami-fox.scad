/*
 * Customizable Origami - Fox - https://www.thingiverse.com/thing:2646196
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-11-15
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
inline_edge_radius_in_millimeter = 0.3; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [17, 367];
A2 = [149, 378];
A3 = [488, 325];
A4 = [555, 294];
A5 = [715, 318];
A6 = [976, 295];
A7 = [1187, 301];
A8 = [1378, 223];
A9 = [1644, 45];
A10 = [1615, 187];
A11 = [1663, 213];
A12 = [1688, 300];
A13 = [1799, 346];
A14 = [1770, 377];
A15 = [1660, 377];
A16 = [1573, 389];
A17 = [1387, 562];
A18 = [1410, 886];
A19 = [1481, 908];
A20 = [1499, 951];
A21 = [1414, 952];
A22 = [1292, 661];
A23 = [1215, 779];
A24 = [1212, 904];
A25 = [1272, 941];
A26 = [1275, 983];
A27 = [1212, 983];
A28 = [1147, 932];
A29 = [1146, 815];
A30 = [1098, 631];
A31 = [1051, 606];
A32 = [891, 751];
A33 = [880, 851];
A34 = [940, 874];
A35 = [964, 919];
A36 = [868, 917];
A37 = [802, 729];
A38 = [843, 635];
A39 = [811, 642];
A40 = [800, 672];
A41 = [611, 764];
A42 = [548, 872];
A43 = [583, 917];
A44 = [582, 955];
A45 = [503, 942];
A46 = [523, 747];
A47 = [638, 639];
A48 = [686, 441];
A49 = [396, 576];
A50 = [94, 507];
A51 = [32, 403];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38, A39, A40, A41, A42, A43, A44, A45, A46, A47, A48, A49, A50, A51];

// Inner Points
B1 = [874, 515];
B2 = [977, 571];

// Polygons
C1 = [A1, A51, A2];
C2 = [A51, A50, A3, A2];
C3 = [A4, A5, A48, A49, A50, A3];
C4 = [A5, A6, B1, A39, A40, A41, A47, A48];
C5 = [A6, A7, A30, A31, B2, B1];
C6 = [A7, A8, A16];
C7 = [A8, A10, A16];
C8 = [A8, A9, A10];
C9 = [A10, A11, A12, A16];
C10 = [A12, A15, A16];
C11 = [A12, A13, A14, A15];
C12 = [A7, A16, A17, A22, A23, A30];
C13 = [A17, A22, A21, A18];
C14 = [A18, A19, A20, A21];
C15 = [A24, A25, A26, A27];
C16 = [A27, A28, A29, A30, A23, A24];
C17 = [B1, B2, A38, A39];
C18 = [B2, A31, A32, A37, A38];
C19 = [A37, A32, A33, A36];
C20 = [A33, A34, A35, A36];
C21 = [A47, A41, A42, A45, A46];
C22 = [A42, A43, A44, A45];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22];

min_x = A1[0];
min_y = A9[1];
max_x = A13[0];
max_y = A26[1];

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
