/*
 * Customizable Origami - Lighthouse - https://www.thingiverse.com/thing:2723778
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-12-21
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
A1 = [449, 155];
A2 = [474, 367];
A3 = [609, 430];
A4 = [590, 430];
A5 = [572, 568];
A6 = [616, 568];
A7 = [616, 659];
A8 = [616, 723];
A9 = [584, 811];
A10 = [559, 811];
A11 = [561, 855];
A12 = [565, 964];
A13 = [577, 1164];
A14 = [582, 1276];
A15 = [595, 1479];
A16 = [600, 1589];
A17 = [601, 1629];
A18 = [975, 1629];
A19 = [1062, 1759];
A20 = [1062, 1907];
A21 = [904, 1907];
A22 = [831, 1907];
A23 = [694, 1907];
A24 = [500, 1907];
A25 = [195, 1907];
A26 = [247, 1818];
A27 = [288, 1818];
A28 = [297, 1681];
A29 = [305, 1567];
A30 = [313, 1357];
A31 = [319, 1243];
A32 = [330, 1037];
A33 = [336, 924];
A34 = [338, 811];
A35 = [315, 811];
A36 = [283, 723];
A37 = [283, 659];
A38 = [283, 568];
A39 = [328, 568];
A40 = [312, 430];
A41 = [290, 430];
A42 = [427, 367];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38, A39, A40, A41, A42];

// Inner Points
B1 = [500, 1759];
B2 = [694, 1759];
B3 = [831, 1786];
B4 = [904, 1786];
B5 = [500, 1818];
B6 = [451, 568];
B7 = [451, 659];
B8 = [368, 659];
B9 = [368, 568];
B10 = [532, 568];
B11 = [532, 659];

// Polygons
C1 = [A1, A2, A42];
C2 = [A2, A3, A4, A40, A41, A42];
C3 = [A4, A5, B10, B6, B9, A39, A40];
C4 = [A38, A37, B8, B9];
C5 = [B9, B6, B7, B8];
C6 = [B6, B10, B11, B7];
C7 = [B10, A5, A6, A7, B11];
C8 = [A7, A8, A36, A37, B8, B7, B11];
C9 = [A36, A35, A34, A10, A9, A8];
C10 = [A10, A34, A33, A11];
C11 = [A11, A33, A32, A12];
C12 = [A32, A31, A13, A12];
C13 = [A13, A31, A30, A14];
C14 = [A14, A15, A29, A30];
C15 = [A15, A16, A28, A29];
C16 = [A16, A17, B1, B5, A27, A28];
C17 = [A26, A25, A24, B5, A27];
C18 = [B1, A17, B2, A23, A24, B5];
C19 = [A17, A18, A19, B2];
C20 = [B2, A19, A20, A21, B4, B3, A22, A23];
C21 = [B3, B4, A21, A22];

cut_polygons = [/*C1,*/ C2, C3, C4, C5, C6, C7, C8, C9, C10, /*C11,*/ C12, /*C13,*/ C14, /*C15,*/ C16, C17, C18, C19, C20, C21];

min_x = A25[0];
min_y = A1[1];
max_x = A19[0];
max_y = A20[1];

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
