/*
 * Customizable Origami - Flamingo - https://www.thingiverse.com/thing:2635776
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-11-09
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
inline_edge_radius_in_millimeter = 0.4; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [252, 247];
A2 = [203, 149];
A3 = [236, 119];
A4 = [234, 93];
A5 = [278, 37];
A6 = [311, 21];
A7 = [391, 66];
A8 = [429, 167];
A9 = [363, 390];
A10 = [388, 406];
A11 = [413, 366];
A12 = [529, 324];
A13 = [639, 324];
A14 = [799, 489];
A15 = [757, 524];
A16 = [732, 487];
A17 = [643, 499];
A18 = [629, 520];
A19 = [692, 661];
A20 = [667, 691];
A21 = [576, 687];
A22 = [521, 949];
A23 = [521, 687];
A24 = [411, 684];
A25 = [340, 707];
A26 = [400, 665];
A27 = [521, 663];
A28 = [527, 545];
A29 = [545, 527];
A30 = [537, 510];
A31 = [432, 517];
A32 = [285, 434];
A33 = [281, 398];
A34 = [399, 173];
A35 = [329, 104];
A36 = [312, 159];
A37 = [249, 169];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37];

// Inner Points
B1 = [656, 659];
B2 = [590, 578];
B3 = [580, 659];
B4 = [617, 501];

// Polygons
C1 = [A1, A2, A37];
C2 = [A2, A3, A36, A37];
C3 = [A3, A36, A35];
C4 = [A3, A35, A4];
C5 = [A4, A5, A35];
C6 = [A5, A6, A35];
C7 = [A6, A35, A7];
C8 = [A35, A7, A8, A34];
C9 = [A8, A9, A33, A34];
C10 = [A9, A33, A32];
C11 = [A32, A31, A10, A9];
C12 = [A10, A31, A11];
C13 = [A11, A12, A31];
C14 = [A31, A30, B4, A17, A16, A12];
C15 = [A12, A13, A16];
C16 = [A13, A16, A15, A14];
C17 = [A17, A18, B4];
C18 = [A30, A29, B2, B1, A19, A18, B4];
C19 = [A29, A28, B2];
C20 = [A28, A27, B3, B2];
C21 = [A23, A21, A22];
C22 = [A19, B1, B3, A27, A26, A24, A23, A21, A20];
C23 = [A26, A25, A24];
C24 = [B2, B3, B1];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24];

min_x = A2[0];
min_y = A6[1];
max_x = A14[0];
max_y = A22[1];

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
