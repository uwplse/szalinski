/*
 * Customizable Origami - Corgi - https://www.thingiverse.com/thing:2665323
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-11-23
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
A1 = [18, 582];
A2 = [16, 522];
A3 = [170, 468];
A4 = [521, 491];
A5 = [883, 476];
A6 = [1136, 22];
A7 = [1234, 171];
A8 = [1328, 197];
A9 = [1381, 254];
A10 = [1565, 295];
A11 = [1540, 365];
A12 = [1404, 450];
A13 = [1311, 484];
A14 = [1346, 560];
A15 = [1334, 734];
A16 = [1270, 798];
A17 = [1152, 928];
A18 = [1149, 1004];
A19 = [1107, 1071];
A20 = [1183, 1138];
A21 = [1059, 1138];
A22 = [1006, 1076];
A23 = [968, 932];
A24 = [492, 906];
A25 = [317, 1070];
A26 = [394, 1138];
A27 = [253, 1138];
A28 = [122, 836];
A29 = [86, 622];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29];

// Inner Points
B1 = [885, 583];
B2 = [1138, 489];
B3 = [1068, 320];

// Polygons
C1 = [A1, A2, A3, A29];
C2 = [A3, A4, A28, A29];
C3 = [A4, A24, A25, A27, A28];
C4 = [A27, A26, A25];
C5 = [A4, A5, B1, A17, A23, A24];
C6 = [A23, A22, A21, A19, A18, A17];
C7 = [A21, A19, A20];
C8 = [A17, A16, A5, B1];
C9 = [A5, A16, A15, A14, A13, B3, A6];
C10 = [B3, A7, A6];
C11 = [A7, A8, A9, A10, A11, A12, A13, B3];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11];

min_x = A2[0];
min_y = A6[1];
max_x = A10[0];
max_y = A21[1];

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
