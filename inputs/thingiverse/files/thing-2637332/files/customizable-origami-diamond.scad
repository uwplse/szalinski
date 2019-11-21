/*
 * Customizable Origami - Diamond - https://www.thingiverse.com/thing:2637332
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-11-10
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
outline_size_in_millimeter = 2.1; //[0.5:0.1:20]

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
A1 = [371, 251];
A2 = [419, 251];
A3 = [477, 251];
A4 = [526, 251];
A5 = [564, 305];
A6 = [448, 463];
A7 = [333, 305];

outline = [A1, A2, A3, A4, A5, A6, A7];

// Inner Points
B1 = [391, 305];
B2 = [449, 305];
B3 = [507, 305];

// Polygons
C1 = [A7, A1, B1];
C2 = [B1, A1, A2];
C3 = [A2, B2, B1];
C4 = [A2, A3, B2];
C5 = [A3, A4, B3];
C6 = [A3, B3, B2];
C7 = [A4, A5, B3];
C8 = [A5, A6, B3];
C9 = [B3, A6, B2];
C10 = [B2, B1, A6];
C11 = [B1, A7, A6];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11];

min_x = A7[0];
min_y = A1[1];
max_x = A5[0];
max_y = A6[1];

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
