/*
 * Customizable Origami - Snail - https://www.thingiverse.com/thing:2667432
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-11-25
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
inline_size_in_millimeter = 0.8; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 0.1; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [345, 760];
A2 = [697, 983];
A3 = [763, 917];
A4 = [605, 759];
A5 = [604, 446];
A6 = [919, 126];
A7 = [1234, 126];
A8 = [1550, 448];
A9 = [1553, 759];
A10 = [1396, 925];
A11 = [1758, 1083];
A12 = [1235, 1083];
A13 = [898, 1083];
A14 = [604, 1083];
A15 = [275, 777];
A16 = [284, 445];
A17 = [122, 286];
A18 = [303, 420];
A19 = [441, 286];
A20 = [326, 444];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20];

// Inner Points
B1 = [1076, 925];
B2 = [916, 768];
B3 = [918, 448];
B4 = [1070, 291];
B5 = [1234, 290];
B6 = [1390, 447];
B7 = [1383, 604];
B8 = [1232, 754];
B9 = [1079, 606];
B10 = [1139, 507];
B11 = [1232, 509];
B12 = [1284, 589];
B13 = [1280, 600];
B14 = [1225, 519];
B15 = [1142, 520];
B16 = [1093, 604];
B17 = [1228, 737];
B18 = [1366, 599];
B19 = [1370, 451];
B20 = [1227, 311];
B21 = [1081, 316];
B22 = [947, 447];
B23 = [942, 758];
B24 = [1085, 888];
B25 = [1391, 889];
B26 = [1115, 726];
B27 = [1123, 714];

// Polygons
C1 = [A17, A16, A18];
C2 = [A16, A18, A19, A20];
C3 = [A16, A15, A1, A20];
C4 = [A15, A14, A2, A1];
C5 = [A14, A13, A3, A2];
C6 = [A12, A10, A11];
C7 = [B13, B14, B15, B16, B27, B17, B18, B19, B20, B21, B22, B23, B24, B25, A9, A8, A7, A6, A5, A4, A3, A13, A12, A10, B1, B2, B3, B4, B5, B6, B7, B8, B26, B9, B10, B11, B12];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7];

min_x = A17[0];
min_y = A6[1];
max_x = A11[0];
max_y = A11[1];

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
