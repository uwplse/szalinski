/*
 * Customizable Origami - Howling Wolf - https://www.thingiverse.com/thing:2650270
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-11-16
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
A1 = [268, 265];
A2 = [274, 254];
A3 = [293, 280];
A4 = [287, 244];
A5 = [290, 235];
A6 = [294, 226];
A7 = [306, 222];
A8 = [311, 231];
A9 = [350, 305];
A10 = [405, 345];
A11 = [372, 345];
A12 = [378, 356];
A13 = [406, 431];
A14 = [639, 497];
A15 = [729, 595];
A16 = [732, 689];
A17 = [684, 664];
A18 = [658, 602];
A19 = [643, 635];
A20 = [657, 668];
A21 = [646, 765];
A22 = [608, 765];
A23 = [623, 735];
A24 = [622, 679];
A25 = [561, 585];
A26 = [444, 600];
A27 = [440, 642];
A28 = [421, 765];
A29 = [384, 765];
A30 = [402, 736];
A31 = [389, 660];
A32 = [330, 577];
A33 = [298, 438];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33];

// Inner Points
B1 = [620, 523];

// Polygons
C1 = [A6, A7, A8, A5];
C2 = [A33, A1, A2, A3, A4, A5, A8, A9, A11, A12];
C3 = [A9, A10, A11];
C4 = [A33, A12, A13, A32];
C5 = [A13, A26, A32];
C6 = [A13, A14, B1, A25, A26];
C7 = [A14, A15, A17, A18, B1];
C8 = [A15, A16, A17];
C9 = [B1, A18, A19, A25];
C10 = [A19, A20, A24, A25];
C11 = [A24, A20, A21, A23];
C12 = [A21, A22, A23];
C13 = [A26, A27, A31, A32];
C14 = [A31, A27, A28, A30];
C15 = [A28, A29, A30];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15];

min_x = A1[0];
min_y = A7[1];
max_x = A16[0];
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
