/*
 * Customizable Origami - Heavy Rain - The Bird - https://www.thingiverse.com/thing:2677493
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-11-29
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
inline_edge_radius_in_millimeter = 0.5; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [323, 179];
A2 = [482, 110];
A3 = [609, 55];
A4 = [664, 189];
A5 = [732, 358];
A6 = [716, 399];
A7 = [841, 477];
A8 = [1018, 588];
A9 = [884, 629];
A10 = [740, 677];
A11 = [623, 604];
A12 = [546, 753];
A13 = [481, 622];
A14 = [461, 572];
A15 = [419, 637];
A16 = [405, 570];
A17 = [387, 457];
A18 = [502, 245];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18];

// Inner Points
B1 = [536, 239];
B2 = [585, 417];
B3 = [640, 562];
B4 = [422, 477];
B5 = [456, 557];
B6 = [441, 436];
B7 = [524, 237];
B8 = [523, 249];
B9 = [694, 515];
B10 = [684, 464];
B11 = [659, 525];

// Polygons
C1 = [A1, A2, B1];
C2 = [A2, A3, B1];
C3 = [A3, A4, B1];
C4 = [A4, A5, B1];
C5 = [B8, B2, A5];
C6 = [A5, B2, B3, B11, B10, A6];
C7 = [B3, A11, A12, A13];
C8 = [B4, B3, A13, A14, B5];
C9 = [B4, B2, B3];
C10 = [B4, B6, B8, B2];
C11 = [A15, A14, B5, A16];
C12 = [A16, A17, B4, B5];
C13 = [A17, B4, B6];
C14 = [A1, B1, A5, B8, B6, A17, A18];
C15 = [A6, A7, B9, B10];
C16 = [B11, B9, B10];
C17 = [A11, B3, B11, B9, A10];
C18 = [B9, A7, A10];
C19 = [A7, A9, A10];
C20 = [A7, A9, A8];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20];

min_x = A1[0];
min_y = A3[1];
max_x = A8[0];
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
