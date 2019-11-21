/*
 * Customizable Origami - Optical Illusion Triangle - https://www.thingiverse.com/thing:2780187
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2018-02-02
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
inline_edge_radius_in_millimeter = 0.4; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [40, 214];
A2 = [141, 42];
A3 = [1817, 43];
A4 = [1923, 216];
A5 = [1079, 1674];
A6 = [878, 1673];

outline = [A1, A2, A3, A4, A5, A6];

// Inner Points
B1 = [777, 214];
B2 = [985, 213];
B3 = [1518, 216];
B4 = [1421, 385];
B5 = [1084, 387];
B6 = [682, 387];
B7 = [535, 386];
B8 = [333, 385];
B9 = [605, 506];
B10 = [1350, 504];
B11 = [982, 562];
B12 = [707, 685];
B13 = [911, 685];
B14 = [1050, 685];
B15 = [1451, 676];
B16 = [1349, 858];
B17 = [1149, 857];
B18 = [604, 857];
B19 = [1051, 1029];
B20 = [911, 1031];
B21 = [708, 1031];
B22 = [978, 1149];
B23 = [1077, 1327];
B24 = [1286, 387];

// Polygons
C1 = [A1, A2, A3, B15, B10, B4, B3, B2, B12, B9, B6, B1];
C2 = [B2, B3, B4, B24, B5];
C3 = [B2, B12, B13, B11, B5];
C4 = [B24, B10, B4];
C5 = [B5, B16, B23, B22, B20, B21, A5, A4, A3, B15, B10, B24];
C6 = [B11, B5, B16, B17, B14];
C7 = [B16, B23, B22, B19, B17];
C8 = [B11, B13, B14];
C9 = [B12, B18, B17, B14, B13];
C10 = [B18, B8, B7, B9, B12];
C11 = [B7, B6, B9];
C12 = [B20, B19, B22];
C13 = [B1, A1, A6, A5, B21, B20, B19, B17, B18, B8, B7, B6];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13];

min_x = A1[0];
min_y = A2[1];
max_x = A4[0];
max_y = A5[1];

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
