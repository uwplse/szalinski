/*
 * Customizable Origami - Panda Head - https://www.thingiverse.com/thing:2643016
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-11-13
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
outline_size_in_millimeter = 2.0; //[0.5:0.1:20]

// Thickness of the inner outline.
inline_size_in_millimeter = 0.7; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 0.7; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [135, 173];
A2 = [139, 133];
A3 = [160, 106];
A4 = [189, 102];
A5 = [218, 125];
A6 = [271, 108];
A7 = [299, 108];
A8 = [352, 124];
A9 = [383, 102];
A10 = [409, 106];
A11 = [431, 132];
A12 = [434, 173];
A13 = [419, 193];
A14 = [425, 199];
A15 = [441, 271];
A16 = [426, 335];
A17 = [355, 387];
A18 = [316, 389];
A19 = [254, 389];
A20 = [215, 388];
A21 = [145, 336];
A22 = [129, 272];
A23 = [144, 199];
A24 = [151, 192];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24];

// Inner Points
B1 = [233, 204];
B2 = [251, 216];
B3 = [254, 236];
B4 = [220, 323];
B5 = [189, 305];
B6 = [181, 257];
B7 = [215, 228];
B8 = [336, 205];
B9 = [351, 212];
B10 = [354, 227];
B11 = [389, 257];
B12 = [382, 305];
B13 = [350, 323];
B14 = [336, 288];
B15 = [316, 239];
B16 = [320, 216];
B17 = [264, 324];
B18 = [307, 324];
B19 = [314, 333];
B20 = [286, 358];
B21 = [256, 333];
B22 = [248, 376];
B23 = [323, 376];
B24 = [219, 350];
B25 = [351, 351];
B26 = [219, 213];
B27 = [226, 158];
B28 = [343, 158];
B29 = [234, 287];

// Polygons
C1 = [B26, B27, A5, A6, A7, A8, B28, B9, B8, B16, B2, B1];
C2 = [B17, B3, B2, B16, B15, B18];
C3 = [B17, B3, B29, B21];
C4 = [B18, B15, B14, B19];
C5 = [B19, B14, B13, B25];
C6 = [B19, B25, B23, B20];
C7 = [B20, B21, B24, B22];
C8 = [B21, B29, B4, B24];
C9 = [A20, B22, B23, A17, A18, A19];
C10 = [B4, B5, A21, A20, B22, B24];
C11 = [A17, B23, B25, B13, B12, A16];
C12 = [A21, B5, B6, A23, A22];
C13 = [B6, B7, B26, B27, A5, A24, A23];
C14 = [A8, A13, A14, B11, B10, B9, B28];
C15 = [B12, B11, A14, A15, A16];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15];

min_x = A22[0];
min_y = A4[1];
max_x = A15[0];
max_y = A18[1];

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
