/*
 * Customizable Origami - Light Bulb - https://www.thingiverse.com/thing:2738377
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-12-30
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
A1 = [483, 386];
A2 = [581, 220];
A3 = [734, 171];
A4 = [887, 223];
A5 = [988, 389];
A6 = [859, 650];
A7 = [849, 737];
A8 = [849, 785];
A9 = [849, 834];
A10 = [849, 879];
A11 = [791, 940];
A12 = [677, 940];
A13 = [619, 879];
A14 = [619, 834];
A15 = [619, 785];
A16 = [619, 737];
A17 = [607, 647];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17];

// Inner Points
B1 = [590, 344];
B2 = [879, 340];
B3 = [811, 450];
B4 = [657, 450];
B5 = [690, 580];
B6 = [774, 580];
B7 = [774, 737];
B8 = [690, 737];
B9 = [740, 282];

// Polygons
C1 = [A2, A3, A4];
C2 = [A2, B9, A4];
C3 = [B9, B1, A2];
C4 = [B9, B2, A4];
C5 = [A2, B1, A1];
C6 = [A1, A17, B1];
C7 = [A4, A5, B2];
C8 = [A5, A6, B2];
C9 = [B1, B9, B2, A6, A7, B7, B6, B3, B4, B5, B8, A16, A17];
C10 = [B5, B6, B7, B8];
C11 = [B4, B3, B6, B5];
C12 = [A16, B8, B7, A7, A8, A15];
C13 = [A15, A8, A9, A14];
C14 = [A14, A9, A10, A13];
C15 = [A13, A10, A11, A12];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, /*C11,*/ C12, C13, C14, C15];

min_x = A1[0];
min_y = A3[1];
max_x = A5[0];
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
