/*
 * Customizable Origami - Deer - https://www.thingiverse.com/thing:2670305
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-11-26
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
outline_size_in_millimeter = 1.5; //[0.5:0.1:20]

// Thickness of the inner outline.
inline_size_in_millimeter = 0.7; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 1.2; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [677, 768];
A2 = [666, 696];
A3 = [880, 652];
A4 = [936, 534];
A5 = [900, 455];
A6 = [917, 446];
A7 = [961, 541];
A8 = [915, 643];
A9 = [965, 619];
A10 = [999, 539];
A11 = [977, 473];
A12 = [994, 462];
A13 = [1019, 541];
A14 = [997, 605];
A15 = [1021, 598];
A16 = [1006, 694];
A17 = [927, 744];
A18 = [944, 921];
A19 = [1011, 1047];
A20 = [1097, 1048];
A21 = [1253, 1051];
A22 = [1299, 1026];
A23 = [1334, 1081];
A24 = [1293, 1115];
A25 = [1199, 1381];
A26 = [1184, 1610];
A27 = [1154, 1610];
A28 = [1156, 1460];
A29 = [1117, 1285];
A30 = [998, 1289];
A31 = [961, 1610];
A32 = [933, 1610];
A33 = [935, 1457];
A34 = [767, 1056];
A35 = [787, 800];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35];

// Inner Points
B1 = [873, 707];
B2 = [889, 742];
B3 = [908, 747];
B4 = [880, 815];
B5 = [892, 673];

// Polygons
C1 = [A2, A3, A8, B5, B1, B2, B3, B4, A35, A1];
C2 = [A3, A4, A5, A6, A7, A8];
C3 = [A11, A12, A13, A14, A9, A10];
C4 = [A8, A9, A14, A15, A16, A17, B3, B2, B1, B5];
C5 = [B3, A17, A18, A34, A35, B4];
C6 = [A18, A19, A30, A31, A32, A33, A34];
C7 = [A19, A20, A29, A30];
C8 = [A20, A21, A24, A25, A26, A27, A28, A29];
C9 = [A21, A24, A23, A22];

cut_polygons = [C1, /*C2, C3,*/ C4, C5, C6, C7, C8, C9];

min_x = A2[0];
min_y = A6[1];
max_x = A23[0];
max_y = A26[1];

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
