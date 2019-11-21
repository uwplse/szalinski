/*
 * Customizable Geometry - Two Boxes https://www.thingiverse.com/thing:2776180
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2018-01-31
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
inline_edge_radius_in_millimeter = 0.9; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [599, 580];
A2 = [598, 342];
A3 = [1293, 51];
A4 = [1755, 339];
A5 = [1758, 1058];
A6 = [1295, 1247];
A7 = [1296, 1483];
A8 = [601, 1762];
A9 = [142, 1483];
A10 = [141, 773];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10];

// Inner Points
B1 = [600, 1056];
B2 = [825, 1194];
B3 = [822, 490];
B4 = [1064, 628];
B5 = [1293, 771];
B6 = [1062, 1335];
B7 = [1293, 533];
B8 = [824, 962];
B9 = [1069, 858];
B10 = [600, 1286];

// Polygons
C1 = [A1, A2, A3, A4, B7, B4, B3];
C2 = [B4, B7, B5, B9];
C3 = [B7, A4, A5, B5];
C4 = [B5, A5, A6, B6, B9];
C5 = [B3, B4, B9, B6, B2, B8];
C6 = [B8, B1, B10, B2];
C7 = [B8, B3, A1, A10, B1];
C8 = [A10, A9, B10, B1];
C9 = [B2, B6, A6, A7, A8, A9];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9];

min_x = A10[0];
min_y = A3[1];
max_x = A5[0];
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
