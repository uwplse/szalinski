/*
 * Customizable Origami - Mouse - https://www.thingiverse.com/thing:2742618
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2018-01-02
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
A1 = [78, 198];
A2 = [234, 257];
A3 = [608, 401];
A4 = [652, 340];
A5 = [704, 323];
A6 = [763, 243];
A7 = [997, 228];
A8 = [973, 284];
A9 = [964, 342];
A10 = [887, 519];
A11 = [1109, 607];
A12 = [1258, 956];
A13 = [1957, 868];
A14 = [1307, 1102];
A15 = [1313, 1147];
A16 = [1082, 1213];
A17 = [451, 1213];
A18 = [132, 343];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18];

// Inner Points
B1 = [442, 651];
B2 = [728, 585];
B3 = [660, 475];

// Polygons
C1 = [A6, A7, A8, A5];
C2 = [A4, A5, A8, A9, A10, B3];
C3 = [A4, A3, B1, B2, B3];
C4 = [B2, A10, B3];
C5 = [A2, A18, A17, B1, A3];
C6 = [B1, A17, A16, A15, A14, A12, A11, A10, B2];
C7 = [A12, A13, A14];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7];

min_x = A1[0];
min_y = A1[1];
max_x = A13[0];
max_y = A17[1];

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
