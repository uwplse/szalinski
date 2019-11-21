/*
 * Customizable Origami - Elephant - https://www.thingiverse.com/thing:2629988
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-11-06
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
A1 = [38, 652];
A2 = [150, 342];
A3 = [372, 264];
A4 = [458, 222];
A5 = [914, 220];
A6 = [1132, 218];
A7 = [1140, 86];
A8 = [1418, 212];
A9 = [1730, 484];
A10 = [1638, 984];
A11 = [1800, 994];
A12 = [1860, 1042];
A13 = [1868, 1204];
A14 = [1816, 1070];
A15 = [1586, 1120];
A16 = [1476, 1024];
A17 = [1472, 1324];
A18 = [1414, 1316];
A19 = [1408, 1348];
A20 = [954, 1348];
A21 = [856, 1264];
A22 = [814, 1306];
A23 = [762, 1314];
A24 = [714, 1348];
A25 = [422, 1348];
A26 = [134, 790];
A27 = [164, 544];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27];

// Inner Points
B1 = [184, 378];
B2 = [832, 1232];
B3 = [908, 1152];
B4 = [1012, 628];
B5 = [1016, 406];
B6 = [1412, 790];
B7 = [1456, 790];
B8 = [1584, 724];
B9 = [1690, 466];
B10 = [1602, 996];

// Polygons
C1 = [A1, A2, A3, B1];
C2 = [A1, A27, B1];
C3 = [A26, A27, B1, A3, A4, A5, B3, B2, A23, A24, A25];
C4 = [A23, A22, A21, B2];
C5 = [A5, A6, A8, B5, B4, B6, A18, A19, A20, A21, B2, B3];
C6 = [B5, A8, B9, B8, B7, B6, B4];
C7 = [A6, A7, A8];
C8 = [B9, A9, A10, B10];
C9 = [B10, A10, A11, A12, A14, A15];
C10 = [A14, A12, A13];
C11 = [A17, A18, B6, B7, A16];
C12 = [B7, B8, B9, B10, A15, A16];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12];

min_x = A1[0];
min_y = A7[1];
max_x = A13[0];
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
