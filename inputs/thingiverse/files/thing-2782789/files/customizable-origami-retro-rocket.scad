/*
 * Customizable Origami - Retro Rocket - https://www.thingiverse.com/thing:2782789
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2018-02-05
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
inline_edge_radius_in_millimeter = 0.6; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [663, 15];
A2 = [799, 426];
A3 = [851, 615];
A4 = [883, 824];
A5 = [882, 1027];
A6 = [864, 1251];
A7 = [1258, 1514];
A8 = [1312, 1951];
A9 = [1027, 1742];
A10 = [794, 1724];
A11 = [765, 1800];
A12 = [712, 1813];
A13 = [651, 1817];
A14 = [600, 1812];
A15 = [555, 1800];
A16 = [525, 1725];
A17 = [278, 1748];
A18 = [39, 1951];
A19 = [78, 1517];
A20 = [438, 1250];
A21 = [426, 1030];
A22 = [435, 828];
A23 = [469, 624];
A24 = [521, 434];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24];

// Inner Points
B1 = [656, 421];
B2 = [655, 613];
B3 = [541, 618];
B4 = [572, 427];
B5 = [747, 422];
B6 = [788, 612];
B7 = [809, 826];
B8 = [820, 1027];
B9 = [655, 1026];
B10 = [653, 824];
B11 = [514, 827];
B12 = [511, 1028];
B13 = [515, 1252];
B14 = [809, 1251];
B15 = [660, 1255];
B16 = [655, 1727];
B17 = [131, 1525];
B18 = [1214, 1524];
B19 = [759, 1719];
B20 = [563, 1717];

// Polygons
C1 = [A24, A1, B4];
C2 = [B4, A1, B1];
C3 = [B1, A1, B5];
C4 = [B5, A1, A2];
C5 = [A24, A23, B3, B4];
C6 = [B1, B2, B6, B5];
C7 = [A3, A4, B7, B6];
C8 = [B2, B10, B11, B3];
C9 = [B11, B12, A21, A22];
C10 = [B10, B9, B8, B7];
C11 = [B9, B15, B13, B12];
C12 = [B8, B14, A6, A5];
C13 = [B15, B16, B20, B13];
C14 = [B15, B16, B19, B14];
C15 = [B13, B17, A19, A20];
C16 = [A19, A18, B17];
C17 = [B17, A17, A18];
C18 = [B17, B13, B20, A16, A17];
C19 = [B14, B18, A9, A10, B19];
C20 = [B14, A6, A7, B18];
C21 = [A7, A8, B18];
C22 = [B18, A8, A9];
C23 = [A16, A15, A14, B20];
C24 = [B20, B16, A13, A14];
C25 = [B16, B19, A12, A13];
C26 = [B19, A10, A11, A12];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, /*C15, C16,*/ C17, C18, C19, /*C20, C21,*/ C22, C23, C24, C25, C26];

min_x = A18[0];
min_y = A1[1];
max_x = A8[0];
max_y = A8[1];

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
