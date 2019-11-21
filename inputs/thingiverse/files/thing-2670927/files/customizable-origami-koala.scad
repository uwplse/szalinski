/*
 * Customizable Origami - Koala - https://www.thingiverse.com/thing:2670927
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-11-27
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
inline_edge_radius_in_millimeter = 1.0; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [179, 612];
A2 = [227, 584];
A3 = [251, 568];
A4 = [254, 493];
A5 = [212, 492];
A6 = [173, 490];
A7 = [183, 444];
A8 = [214, 435];
A9 = [253, 418];
A10 = [238, 338];
A11 = [219, 324];
A12 = [149, 274];
A13 = [147, 217];
A14 = [162, 196];
A15 = [137, 142];
A16 = [178, 97];
A17 = [242, 110];
A18 = [253, 102];
A19 = [365, 119];
A20 = [373, 135];
A21 = [439, 143];
A22 = [471, 198];
A23 = [426, 244];
A24 = [567, 392];
A25 = [536, 596];
A26 = [457, 653];
A27 = [241, 653];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27];

// Inner Points
B1 = [297, 503];
B2 = [305, 381];
B3 = [282, 268];
B4 = [320, 318];
B5 = [222, 289];
B6 = [398, 323];
B7 = [300, 347];

// Polygons
C1 = [A15, A16, A17, A14];
C2 = [A18, A19, A20, A23, B6, B7, B4, B3, B5, A11, A12, A13, A14, A17];
C3 = [B3, B4, B7, A10, A11, B5];
C4 = [B7, B2, A9, A10];
C5 = [A23, A22, A21, A20];
C6 = [A23, A24, B1, B2, B7, B6];
C7 = [A9, B2, B1, A4, A5, A8];
C8 = [A8, A7, A6, A5];
C9 = [A4, A3, B1];
C10 = [A2, A1, A27];
C11 = [A2, A27, A26, A25, B1, A3];
C12 = [B1, A24, A25];

cut_polygons = [C1, C2, /*C3,*/ C4, C5, C6, C7, C8, C9, C10, C11, C12];

min_x = A15[0];
min_y = A16[1];
max_x = A24[0];
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
