/*
 * Customizable Origami - Turkey - https://www.thingiverse.com/thing:2741043
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2018-01-01
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
outline_size_in_millimeter = 1.6; //[0.5:0.1:20]

// Thickness of the inner outline.
inline_size_in_millimeter = 0.8; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 0.5; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [474, 282];
A2 = [602, 191];
A3 = [605, 349];
A4 = [777, 452];
A5 = [793, 343];
A6 = [927, 236];
A7 = [1027, 282];
A8 = [1088, 325];
A9 = [1076, 455];
A10 = [1040, 351];
A11 = [955, 349];
A12 = [1011, 588];
A13 = [786, 756];
A14 = [776, 802];
A15 = [846, 905];
A16 = [729, 878];
A17 = [721, 894];
A18 = [497, 764];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18];

// Inner Points
B1 = [557, 325];
B2 = [1067, 351];
B3 = [722, 802];
B4 = [753, 779];

// Polygons
C1 = [A2, B1, A18, A1];
C2 = [A2, A3, B1];
C3 = [B1, A18, B3, A4, A3];
C4 = [A18, A17, A16, B4, B3];
C5 = [A16, A15, A14, B4];
C6 = [B4, A14, A13];
C7 = [B3, A4, A5, A11, A12, A13, B4];
C8 = [A5, A6, A7, B2, A10, A11];
C9 = [A10, A9, B2];
C10 = [A7, A8, A9, B2];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10];

min_x = A1[0];
min_y = A2[1];
max_x = A8[0];
max_y = A15[1];

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
