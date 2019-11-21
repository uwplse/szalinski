/*
 * Customizable Origami - Meerkat - https://www.thingiverse.com/thing:2738092
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-12-30
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
inline_size_in_millimeter = 0.8; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 0.4; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [688, 424];
A2 = [738, 407];
A3 = [897, 310];
A4 = [1022, 320];
A5 = [1043, 350];
A6 = [1064, 482];
A7 = [1087, 657];
A8 = [1113, 784];
A9 = [1122, 963];
A10 = [1205, 1146];
A11 = [1268, 1449];
A12 = [1323, 1551];
A13 = [1367, 1597];
A14 = [1540, 1593];
A15 = [1358, 1641];
A16 = [1217, 1545];
A17 = [1110, 1358];
A18 = [1093, 1390];
A19 = [1087, 1515];
A20 = [1048, 1641];
A21 = [848, 1641];
A22 = [1023, 1579];
A23 = [927, 1222];
A24 = [853, 1103];
A25 = [876, 982];
A26 = [843, 998];
A27 = [846, 1018];
A28 = [797, 1061];
A29 = [811, 1008];
A30 = [835, 962];
A31 = [931, 822];
A32 = [867, 709];
A33 = [921, 564];
A34 = [922, 510];
A35 = [861, 508];
A36 = [830, 491];
A37 = [740, 473];
A38 = [692, 445];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38];

// Inner Points
B1 = [1017, 524];
B2 = [848, 459];
B3 = [973, 684];
B4 = [1036, 901];
B5 = [959, 960];
B6 = [921, 963];
B7 = [965, 1170];
B8 = [1188, 1341];

// Polygons
C1 = [A1, A2, A37, A38];
C2 = [A2, A3, A4, B2, A37];
C3 = [A37, B2, A35, A36];
C4 = [A4, A5, A6, B2];
C5 = [B2, A35, A34, B1, A6];
C6 = [A6, A7, B1];
C7 = [B1, B3, A7];
C8 = [B1, A33, A34];
C9 = [B1, B3, A33];
C10 = [A33, A32];
C11 = [A7, A8, B4, A32, B3];
C12 = [A33, B3, A32];
C13 = [B4, A9, A8];
C14 = [A32, B4, B5, B6, A30, A31];
C15 = [A30, A29, A26, A25, B6];
C16 = [A29, A28, A27, A26];
C17 = [A24, A25, B6, B5, B4, A9];
C18 = [A24, A9, A10];
C19 = [A24, A23, B7, A10];
C20 = [B7, A10, A17, A18];
C21 = [B7, A18, A19, A20, A22, A23];
C22 = [A22, A20, A21];
C23 = [A10, A11, A16, A17];
C24 = [A11, A16, A15, A13, A12];
C25 = [A13, A15, A14];

cut_polygons = [/*C1,*/ C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25];

min_x = A1[0];
min_y = A3[1];
max_x = A14[0];
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
