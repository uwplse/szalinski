/*
 * Customizable Origami - Goat - https://www.thingiverse.com/thing:2730789
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-12-25
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
A1 = [373, 618];
A3 = [634, 351];
A4 = [713, 353];
A5 = [838, 293];
A6 = [975, 290];
A7 = [829, 350];
A8 = [997, 349];
A9 = [828, 402];
A10 = [1017, 628];
A11 = [1085, 637];
A12 = [1353, 635];
A13 = [1522, 757];
A14 = [1542, 907];
A15 = [1450, 783];
A16 = [1391, 804];
A17 = [1493, 1236];
A18 = [1388, 1236];
A19 = [1413, 1189];
A20 = [1056, 950];
A21 = [688, 1236];
A22 = [642, 1236];
A23 = [548, 1236];
A24 = [629, 1192];
A25 = [681, 618];
A26 = [660, 618];
A27 = [495, 780];
A28 = [493, 618];

outline = [A1, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28];

// Inner Points
B2 = [718, 434];
B3 = [549, 618];
B4 = [976, 672];
B5 = [715, 618];
B6 = [787, 410];

// Polygons
C1 = [A5, A6, A7, A4];
C2 = [A3, B2, B6, A9, A8, A7, A4];
C3 = [A3, A1, B2];
C5 = [A1, B2, B5, A25, A26, B3, A28];
C6 = [A28, A27, B3];
C7 = [B3, A26, A27];
C8 = [B2, B6, B4, A22, A24, A25, B5];
C9 = [A24, A22, A23];
C10 = [A22, B4, A10, A11, A20, A21];
C11 = [A9, A10, B4, B6];
C12 = [A11, A12, A16, A17, A19, A20];
C13 = [A12, A13, A15, A16];
C14 = [A15, A13, A14];
C15 = [A19, A18, A17];

cut_polygons = [C1, C2, C3, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15];

min_x = A1[0];
min_y = A6[1];
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
