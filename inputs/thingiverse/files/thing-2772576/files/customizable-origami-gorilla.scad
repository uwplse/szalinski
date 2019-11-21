/*
 * Customizable Origami - Gorilla - https://www.thingiverse.com/thing:2772576
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2018-01-28
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
outline_size_in_millimeter = 1.7; //[0.5:0.1:20]

// Thickness of the inner outline.
inline_size_in_millimeter = 0.8; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 0.9; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [138, 366];
A2 = [272, 252];
A3 = [244, 236];
A4 = [339, 190];
A5 = [349, 213];
A6 = [536, 70];
A7 = [598, 89];
A8 = [678, 42];
A9 = [1038, 189];
A10 = [1514, 1023];
A11 = [1598, 1029];
A12 = [1626, 972];
A13 = [2065, 1024];
A14 = [2397, 1327];
A15 = [2366, 1864];
A16 = [2042, 2479];
A17 = [1573, 2427];
A18 = [1866, 2202];
A19 = [1705, 1941];
A20 = [1532, 2063];
A21 = [1314, 2147];
A22 = [1503, 2006];
A23 = [1434, 1848];
A24 = [1107, 1883];
A25 = [984, 1933];
A26 = [811, 2374];
A27 = [995, 2389];
A28 = [702, 2637];
A29 = [78, 2311];
A30 = [216, 1992];
A31 = [58, 1926];
A32 = [540, 985];
A33 = [623, 831];
A34 = [417, 795];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34];

// Inner Points
B1 = [412, 320];
B2 = [868, 478];
B3 = [721, 120];
B4 = [1623, 1032];
B5 = [1620, 1184];
B6 = [1613, 1304];
B7 = [1601, 1770];
B8 = [1637, 1832];
B9 = [635, 1004];
B10 = [621, 1040];
B11 = [706, 847];

// Polygons
C1 = [A7, A8, B3];
C2 = [A8, A9, B3];
C3 = [A6, B2, B11, A33, A34, B1, A5];
C4 = [A5, A4, A3, A2, B1];
C5 = [A1, A2, B1, A34];
C6 = [A6, A7, B3, A9, B2];
C7 = [A32, B9, B11, A33];
C8 = [A31, A30, B10, B9, A32];
C9 = [A9, A24, B10, B9, B11, B2];
C10 = [A29, A30, B10, A24, A25];
C11 = [A29, A25, A26];
C12 = [A29, A28, A27, A26];
C13 = [A21, A22, A20];
C14 = [A22, A23, B8, A19, A20];
C15 = [A24, B6, B7, B8, A23];
C16 = [A10, A11, B4, B5];
C17 = [A11, A12, B4];
C18 = [A9, A10, B5, B6, A24];
C19 = [A12, A13, A14, B7, B6, B5, B4];
C20 = [A14, A15, B7];
C21 = [B7, B8, A19, A18, A16, A15];
C22 = [A18, A17, A16];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22];

min_x = A31[0];
min_y = A8[1];
max_x = A14[0];
max_y = A28[1];

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
