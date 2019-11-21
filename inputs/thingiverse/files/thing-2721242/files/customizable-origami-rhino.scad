/*
 * Customizable Origami - Rhino - https://www.thingiverse.com/thing:2721242
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-12-18
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
inline_size_in_millimeter = 0.8; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 0.8; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [5, 194];
A2 = [195, 0];
A3 = [396, 0];
A4 = [397, 16];
A5 = [1145, 14];
A6 = [1145, 4];
A7 = [1242, 4];
A8 = [1337, 98];
A9 = [1337, 137];
A10 = [1529, 261];
A11 = [1698, 219];
A12 = [1630, 329];
A13 = [1823, 455];
A14 = [1860, 138];
A15 = [1996, 566];
A16 = [1795, 735];
A17 = [1346, 659];
A18 = [1347, 781];
A19 = [1337, 963];
A20 = [1251, 963];
A21 = [1205, 914];
A22 = [634, 692];
A23 = [398, 814];
A24 = [394, 963];
A25 = [115, 963];
A26 = [3, 443];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26];

// Inner Points
B1 = [398, 595];
B2 = [1144, 829];
B3 = [1341, 563];

// Polygons
C1 = [A25, A26, A1, A2, A3, A4, B1, A23, A24];
C2 = [B1, A22, A23];
C3 = [A4, A5, B2, A21, A22, B1];
C4 = [A6, A7, A8, A9, B3, B2, A5];
C5 = [A9, A10, A12, A13, A16, A17, B3];
C6 = [A10, A11, A12];
C7 = [A14, A15, A16, A13];
C8 = [B3, B2, A21, A20, A18, A17];
C9 = [A18, A20, A19];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9];

min_x = A26[0];
min_y = A2[1];
max_x = A15[0];
max_y = A24[1];

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
