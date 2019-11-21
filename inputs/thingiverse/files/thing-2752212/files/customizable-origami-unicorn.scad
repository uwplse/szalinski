/*
 * Customizable Origami - Unicorn - https://www.thingiverse.com/thing:2752212
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2018-01-10
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
inline_edge_radius_in_millimeter = 0.4; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [306, 392];
A2 = [374, 419];
A3 = [687, 642];
A4 = [676, 559];
A5 = [732, 468];
A6 = [757, 509];
A7 = [790, 565];
A8 = [782, 638];
A9 = [863, 581];
A10 = [862, 521];
A11 = [897, 574];
A12 = [1029, 549];
A13 = [1011, 592];
A14 = [1142, 641];
A15 = [1129, 690];
A16 = [1225, 703];
A17 = [1212, 732];
A18 = [1309, 802];
A19 = [1289, 829];
A20 = [1379, 894];
A21 = [1350, 928];
A22 = [1480, 1011];
A23 = [1446, 1061];
A24 = [1534, 1172];
A25 = [1432, 1205];
A26 = [1323, 1235];
A27 = [1142, 1500];
A28 = [908, 1558];
A29 = [954, 1460];
A30 = [952, 1270];
A31 = [805, 1074];
A32 = [738, 1125];
A33 = [649, 1128];
A34 = [561, 1170];
A35 = [500, 1233];
A36 = [416, 1232];
A37 = [349, 1149];
A38 = [365, 1079];
A39 = [565, 825];
A40 = [517, 815];
A41 = [532, 764];
A42 = [598, 698];
A43 = [337, 448];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38, A39, A40, A41, A42, A43];

// Inner Points
B1 = [682, 705];
B2 = [940, 668];
B3 = [1133, 795];
B4 = [884, 854];
B5 = [753, 811];
B6 = [680, 904];
B7 = [586, 890];
B8 = [637, 828];
B9 = [461, 1108];
B10 = [750, 670];
B11 = [377, 453];

// Polygons
C1 = [A43, A1, B11];
C2 = [A1, A2, B11];
C3 = [B11, A2, A3, B1];
C4 = [B1, B11, A43, A42];
C5 = [A4, A5, A6];
C6 = [A6, A7, B10, A4];
C7 = [A7, A8, B10];
C8 = [A4, B10, B1, A3];
C9 = [A8, A9, A10, A11, A12];
C10 = [A8, A12, A13];
C11 = [A8, A13, A14];
C12 = [A8, A14, A15, B2];
C13 = [B2, A15, A16, A17];
C14 = [B2, A17, A18, A19];
C15 = [B2, A19, A20, A21, B3];
C16 = [B3, A21, A22, A23];
C17 = [B3, A23, A24];
C18 = [B3, A24, A25];
C19 = [B3, A25, A26];
C20 = [B3, A26, A27];
C21 = [A28, A29, A27];
C22 = [A29, A30, A27];
C23 = [A30, B4, A27];
C24 = [B4, B3, A27];
C25 = [B4, A8, B2, B3];
C26 = [B10, A8, B4];
C27 = [B4, A30, A31];
C28 = [A31, B5, B4];
C29 = [B5, B10, B4];
C30 = [B1, B10, B5];
C31 = [B1, B5, B8];
C32 = [B8, B5, B6, B7];
C33 = [A39, B8, B7];
C34 = [A39, B1, B8];
C35 = [A39, A40, B1];
C36 = [A40, A41, B1];
C37 = [A41, A42, B1];
C38 = [A39, B7, A38];
C39 = [B7, B6, B9, A38];
C40 = [A38, B9, A37];
C41 = [B9, A36, A37];
C42 = [B9, A35, A36];
C43 = [A35, A34, B9];
C44 = [B9, A33, A34];
C45 = [B9, B6, A33];
C46 = [B6, A32, A33];
C47 = [A32, A31, B6];
C48 = [B6, B5, A31];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, C26, C27, C28, C29, C30, C31, C32, C33, C34, C35, C36, C37, C38, C39, C40, C41, C42, C43, C44, C45, C46, C47, C48];

min_x = A1[0];
min_y = A1[1];
max_x = A24[0];
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
