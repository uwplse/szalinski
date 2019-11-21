/*
 * Customizable Origami - Dolphin - https://www.thingiverse.com/thing:2664065
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
outline_size_in_millimeter = 2.1; //[0.5:0.1:20]

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
A1 = [60, 524];
A2 = [169, 481];
A3 = [229, 348];
A4 = [598, 171];
A5 = [757, 15];
A6 = [755, 182];
A7 = [955, 198];
A8 = [1186, 329];
A9 = [1335, 518];
A10 = [1357, 579];
A11 = [1561, 702];
A12 = [1383, 659];
A13 = [1245, 692];
A14 = [1285, 598];
A15 = [1151, 511];
A16 = [992, 466];
A17 = [909, 471];
A18 = [984, 635];
A19 = [832, 545];
A20 = [737, 479];
A21 = [626, 502];
A22 = [620, 610];
A23 = [527, 523];
A24 = [438, 541];
A25 = [178, 564];
A26 = [60, 553];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26];

// Inner Points
B1 = [652, 418];
B2 = [728, 387];
B3 = [895, 444];
B4 = [695, 451];
B5 = [903, 460];
B6 = [1337, 568];
B7 = [562, 444];
B8 = [271, 524];

// Polygons
C1 = [A4, A5, A6];
C2 = [B1, B4, A20, A19, A18, A17, B5, B3, B2];
C3 = [A21, A22, A23];
C4 = [A14, A13, A12];
C5 = [B6, A12, A11, A10];
C6 = [A25, B8, B7, B4, A20, A21, A23, A24];
C7 = [B5, A16, A17];
C8 = [A26, A1, A2, B8, A25];
C9 = [A2, A3, A4, A6, A7, A8, A9, A10, B6, A12, A14, A15, A16, B5, B3, B2, B1, B4, B7, B8];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9];

min_x = A1[0];
min_y = A5[1];
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
