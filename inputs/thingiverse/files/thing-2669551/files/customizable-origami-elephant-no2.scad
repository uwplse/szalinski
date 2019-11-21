/*
 * Customizable Origami - Elephant No. 2 - https://www.thingiverse.com/thing:2669551
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-11-26
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
inline_size_in_millimeter = 0.9; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 0.9; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [421, 965];
A2 = [478, 793];
A3 = [839, 563];
A4 = [1343, 570];
A5 = [1442, 639];
A6 = [1526, 783];
A7 = [1521, 1136];
A8 = [1620, 1135];
A9 = [1621, 1194];
A10 = [1378, 1192];
A11 = [1388, 1028];
A12 = [1336, 978];
A13 = [1267, 1386];
A14 = [1169, 1386];
A15 = [1098, 1243];
A16 = [877, 1234];
A17 = [804, 1386];
A18 = [662, 1386];
A19 = [616, 1229];
A20 = [519, 941];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20];

// Inner Points
B1 = [992, 695];
B2 = [1127, 939];

// Polygons
C1 = [A1, A20, A2];
C2 = [A20, A2, A3, A16, A19];
C3 = [A19, A16, A17, A18];
C4 = [A3, A4, B1, B2, A12, A15, A16];
C5 = [A12, A13, A14, A15];
C6 = [B1, A4, A5, A12, B2];
C7 = [A5, A6, A11, A12];
C8 = [A6, A7, A11];
C9 = [A11, A7, A8, A9, A10];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9];

min_x = A1[0];
min_y = A3[1];
max_x = A9[0];
max_y = A13[1];

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
