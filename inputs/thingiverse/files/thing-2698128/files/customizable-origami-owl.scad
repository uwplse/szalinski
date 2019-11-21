/*
 * Customizable Origami - Owl - https://www.thingiverse.com/thing:2698128
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-12-07
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
inline_edge_radius_in_millimeter = 0.2; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [1609, 769];
A2 = [1994, 914];
A3 = [2231, 865];
A4 = [2335, 706];
A5 = [2704, 998];
A6 = [2764, 1354];
A7 = [2745, 1471];
A8 = [2783, 1677];
A9 = [2720, 1653];
A10 = [2635, 1738];
A11 = [2836, 2309];
A12 = [2733, 3012];
A13 = [2368, 3496];
A14 = [2607, 3620];
A15 = [2547, 3667];
A16 = [2646, 3747];
A17 = [2486, 3825];
A18 = [1982, 3775];
A19 = [1747, 3781];
A20 = [1415, 4178];
A21 = [1552, 1471];
A22 = [1764, 1041];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22];

// Inner Points
B1 = [2326, 1031];
B2 = [2311, 1293];
B3 = [2647, 1365];
B4 = [2567, 1524];
B5 = [2680, 1576];
B6 = [2731, 1476];
B7 = [2663, 1306];
B8 = [2150, 1448];
B9 = [2233, 1736];
B11 = [2018, 1941];
B12 = [1710, 2108];
B14 = [2359, 2391];
B15 = [2235, 2801];
B16 = [2413, 2405];
B17 = [2311, 2823];
B18 = [2590, 2977];
B19 = [2701, 2385];
B20 = [2614, 1622];
B21 = [2591, 1695];
B22 = [2203, 3417];
B23 = [2084, 3223];
B24 = [2043, 3164];
B25 = [1694, 3535];
B26 = [1732, 3571];
B27 = [1687, 2975];
B28 = [2268, 3552];
B29 = [2693, 1601];

// Polygons
C1 = [A1, A2, B1, A22];
C2 = [A2, A3, A5, B1];
C3 = [A3, B1, A5];
C4 = [A4, A3, A5];
C5 = [B1, B3, B7, A5];
C6 = [B1, B2, B3];
C7 = [B7, A6, A5];
C8 = [B3, B2, B4];
C9 = [B2, B9, B4];
C10 = [B2, B8, B1];
C11 = [A22, B1, B8, B9, B16, B17, B23, B26, B25, B24, B15, B14, B11, B12, A21];
C12 = [B8, B9, B2];
C13 = [B12, B11, B14, B15, B24, B25, B27];
C14 = [A21, B12, B27, A20];
C15 = [B27, A20, B26, B25];
C16 = [B26, A20, A19];
C17 = [B19, B21, B20, B4, B9, B16, B17, B23, B26, A19, B22, B18];
C18 = [B22, B18, B19, B21, B20, B29, A9, A10, A11, A12, A13, B28, A18, A19];
C19 = [B28, A18, A17, A16, A15, A13];
C20 = [A13, A14, A15];
C21 = [B20, B4, B5, B29];
C22 = [B4, B3, B6, A7, A8, A9, B29, B5];
C23 = [B3, B7, A6, A7, B6];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, /*C21, C22,*/ C23];

min_x = A20[0];
min_y = A4[1];
max_x = A11[0];
max_y = A20[1];

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
