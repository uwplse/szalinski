/*
 * Customizable Origami - Heart - https://www.thingiverse.com/thing:2719432
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-12-17
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
outline_size_in_millimeter = 2.4; //[0.5:0.1:20]

// Thickness of the inner outline.
inline_size_in_millimeter = 0.8; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 1; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [1107, 310];
A2 = [1206, 189];
A3 = [1461, 189];
A4 = [1601, 308];
A5 = [1601, 585];
A6 = [1402, 767];
A7 = [1253, 910];
A8 = [1109, 1037];
A9 = [968, 909];
A10 = [819, 774];
A11 = [616, 583];
A12 = [616, 308];
A13 = [756, 189];
A14 = [996, 189];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14];

// Inner Points
B1 = [779, 408];
B2 = [768, 285];
B3 = [855, 447];
B4 = [741, 520];
B5 = [979, 524];
B6 = [888, 232];
B7 = [1322, 233];
B8 = [1447, 280];
B9 = [1359, 446];
B10 = [1437, 404];
B11 = [1472, 519];
B12 = [1238, 525];
B13 = [1304, 634];
B14 = [1111, 760];
B15 = [915, 633];

// Polygons
C1 = [A11, A12, B1];
C2 = [B1, B2, A13, A12];
C3 = [A13, A14, B6, B2];
C4 = [B6, B3, B2];
C5 = [B1, B2, B3];
C6 = [B3, B6, A1];
C7 = [A14, A1, B6];
C8 = [A2, B7, A1];
C9 = [A2, B7, B8, A3];
C10 = [A3, A4, B10, B8];
C11 = [A4, A5, B10];
C12 = [B10, B9, B11, A5];
C13 = [B10, B8, B9];
C14 = [B9, B7, B8];
C15 = [B7, A1, B9];
C16 = [B9, B12, A1];
C17 = [B9, A6, B13, B12];
C18 = [B9, B11, A6];
C19 = [B11, A5, A6];
C20 = [A6, B13, B14];
C21 = [B14, A6, A7];
C22 = [A7, A8, A9, B14];
C23 = [B14, B12, B13];
C24 = [A1, B5, B14, B12];
C25 = [B14, A9, A10];
C26 = [A10, B15, B14];
C27 = [B14, B5, B15];
C28 = [B5, A1, B3];
C29 = [B3, B5, B15, A10];
C30 = [B3, A10, B4];
C31 = [B4, A10, A11];
C32 = [B4, B3, B1, A11];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, C26, C27, C28, C29, C30, C31, C32];

min_x = A11[0];
min_y = A14[1];
max_x = A4[0];
max_y = A8[1];

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
