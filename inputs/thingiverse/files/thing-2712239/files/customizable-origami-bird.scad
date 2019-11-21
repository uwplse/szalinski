/*
 * Customizable Origami - Bird - https://www.thingiverse.com/thing:2712239
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-12-13
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
inline_size_in_millimeter = 0.7; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 0.7; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [972, 861];
A2 = [1037, 845];
A3 = [1106, 789];
A4 = [1138, 781];
A5 = [1205, 816];
A6 = [1297, 897];
A7 = [1350, 968];
A8 = [1448, 950];
A9 = [1710, 784];
A10 = [1621, 929];
A11 = [1472, 1177];
A12 = [1552, 1300];
A13 = [1258, 1271];
A14 = [1241, 1262];
A15 = [1184, 1295];
A16 = [1198, 1227];
A17 = [1134, 1173];
A18 = [1085, 1138];
A19 = [1068, 1042];
A20 = [1050, 973];
A21 = [1033, 906];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21];

// Inner Points
B1 = [1140, 912];
B2 = [1141, 874];
B3 = [1184, 895];
B4 = [1176, 1047];

// Polygons
C1 = [A1, A2, A21];
C2 = [A2, A3, A4, B2, B1, A20, A21];
C3 = [A4, A5, A6, A7, B4, A17, A18, A19, B3, B2];
C4 = [B2, B3, A19, A20, B1];
C5 = [A16, A15, A14];
C6 = [A17, B4, A7, A11, A12, A13, A14, A16];
C7 = [A7, A8, A11];
C8 = [A8, A10, A11];
C9 = [A10, A9, A8];

cut_polygons = [/*C1,*/ C2, C3, C4, C5, C6, C7, C8, C9];

min_x = A1[0];
min_y = A4[1];
max_x = A9[0];
max_y = A12[1];

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
