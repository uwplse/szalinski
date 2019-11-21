/*
 * Customizable Origami - Cute Fox - https://www.thingiverse.com/thing:2616323
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-10-31
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
inline_size_in_millimeter = 0.7; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 0.9; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [238, 114];
A2 = [332, 136];
A3 = [432, 117];
A4 = [423, 178];
A5 = [440, 219];
A6 = [504, 265];
A7 = [505, 329];
A8 = [451, 391];
A9 = [413, 402];
A10 = [377, 415];
A11 = [336, 400];
A12 = [334, 376];
A13 = [347, 364];
A14 = [300, 265];
A15 = [280, 240];
A16 = [228, 220];
A17 = [249, 167];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17];

// Inner Points
B1 = [315, 281];
B2 = [335, 264];
B3 = [355, 281];
B4 = [335, 303];
B5 = [343, 295];
B6 = [382, 253];
B7 = [396, 244];
B8 = [372, 316];
B9 = [357, 358];
B10 = [394, 335];

// Polygons
C1 = [A16, A17, A1, A2];
C2 = [A2, A3, A4, A5];
C3 = [A16, A2, B2, B1, A15];
C4 = [B2, A2, A5, B7, B6, B3];
C5 = [B1, B2, B3, B5, B4];
C6 = [A14, A13, B5, B4, B1];
C7 = [A13, B9, B8, B7, B6, B3, B5];
C8 = [B7, A5, A6, B10, B8];
C9 = [A6, A10, A9, A8, A7];
C10 = [A6, A10, A11, A12, A13, B9, B10];
C11 = [B9, B10, B8];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11];

min_x = A16[0];
min_y = A1[1];
max_x = A7[0];
max_y = A10[1];

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
