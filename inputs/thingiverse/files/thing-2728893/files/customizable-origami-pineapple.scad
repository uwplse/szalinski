/*
 * Customizable Origami - Pineapple - https://www.thingiverse.com/thing:2728893
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-12-24
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
A1 = [665, 694];
A2 = [768, 803];
A3 = [871, 637];
A4 = [849, 833];
A5 = [899, 798];
A6 = [858, 906];
A7 = [972, 853];
A8 = [879, 988];
A9 = [936, 959];
A10 = [922, 1030];
A11 = [975, 1009];
A12 = [854, 1144];
A13 = [893, 1153];
A14 = [968, 1306];
A15 = [974, 1464];
A16 = [888, 1663];
A17 = [678, 1677];
A18 = [614, 1559];
A19 = [564, 1394];
A20 = [618, 1217];
A21 = [680, 1145];
A22 = [698, 1139];
A23 = [586, 974];
A24 = [686, 1029];
A25 = [630, 943];
A26 = [693, 942];
A27 = [648, 838];
A28 = [736, 893];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28];

// Inner Points
B1 = [818, 859];
B2 = [803, 943];
B3 = [756, 1071];
B4 = [798, 1100];
B5 = [803, 1519];
B6 = [728, 1389];
B7 = [736, 1264];
B8 = [857, 1283];
B9 = [799, 1199];
B10 = [762, 908];
B11 = [761, 1129];

// Polygons
C1 = [A2, A3, A4, B1];
C2 = [A5, A6, B2, B10, B1, A4];
C3 = [B1, A2, A1, A28, B10];
C4 = [A27, A28, B10, B2, A26];
C5 = [B2, A6, A7, A8, B3];
C6 = [A9, A10, B4, B3, A8];
C7 = [A11, A12, B11, B4, A10];
C8 = [B4, B3, A24, A23, A22, B11];
C9 = [A21, B9, A13, A12, B11];
C10 = [A13, B8, B7, B9];
C11 = [B9, A21, B7];
C12 = [A21, A20, B7];
C13 = [A20, A19, B7];
C14 = [B7, A19, B6];
C15 = [B6, B7, B8];
C16 = [A13, A14, B8];
C17 = [A14, A15, B8];
C18 = [A15, B5, B8];
C19 = [B8, B5, B6];
C20 = [B6, A18, B5];
C21 = [B5, A17, A18];
C22 = [B6, A19, A18];
C23 = [A17, B5, A16];
C24 = [A16, A15, B5];
C25 = [A24, A25, A26, B2, B3];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25];

min_x = A19[0];
min_y = A3[1];
max_x = A11[0];
max_y = A17[1];

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
