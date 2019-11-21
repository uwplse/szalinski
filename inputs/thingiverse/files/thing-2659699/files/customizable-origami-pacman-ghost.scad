/*
 * Customizable Origami - Pacman Ghost - https://www.thingiverse.com/thing:2659699
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-11-21
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
A1 = [64, 928];
A2 = [64, 448];
A3 = [128, 448];
A4 = [128, 256];
A5 = [192, 256];
A6 = [192, 192];
A7 = [256, 192];
A8 = [256, 128];
A9 = [384, 128];
A10 = [384, 64];
A11 = [640, 64];
A12 = [640, 128];
A13 = [736, 128];
A14 = [736, 192];
A15 = [800, 192];
A16 = [800, 256];
A17 = [864, 256];
A18 = [864, 320];
A19 = [864, 384];
A20 = [864, 448];
A21 = [928, 448];
A22 = [928, 928];
A23 = [864, 928];
A24 = [864, 864];
A25 = [800, 864];
A26 = [800, 800];
A27 = [736, 800];
A28 = [736, 864];
A29 = [672, 864];
A30 = [672, 928];
A31 = [576, 928];
A32 = [576, 800];
A33 = [448, 800];
A34 = [448, 928];
A35 = [320, 928];
A36 = [320, 864];
A37 = [256, 864];
A38 = [256, 800];
A39 = [192, 800];
A40 = [192, 864];
A41 = [128, 864];
A42 = [128, 928];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38, A39, A40, A41, A42];

// Inner Points
B1 = [256, 320];
B2 = [320, 320];
B3 = [320, 256];
B4 = [448, 256];
B5 = [448, 320];
B6 = [512, 320];
B7 = [512, 384];
B8 = [512, 512];
B9 = [448, 512];
B10 = [448, 576];
B11 = [320, 576];
B12 = [320, 512];
B13 = [256, 512];
B14 = [384, 384];
B15 = [384, 512];
B16 = [672, 256];
B17 = [672, 320];
B18 = [608, 320];
B19 = [608, 512];
B20 = [672, 512];
B21 = [672, 576];
B22 = [800, 576];
B23 = [800, 512];
B24 = [800, 320];
B25 = [736, 384];
B26 = [736, 512];
B27 = [864, 512];

// Polygons
C1 = [B15, B14, B7, B6, B5, B4, B3, B2, B1, B13, B12, B11, B10, B9];
C2 = [B24, A16, B16, B17, B18, B19, B20, B21, B22, B23, B26, B25, A19, A18];

cut_polygons = [C1, C2];

min_x = A2[0];
min_y = A11[1];
max_x = A21[0];
max_y = A1[1];

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
