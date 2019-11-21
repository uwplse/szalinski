/*
 * Customizable Origami - Rooster - https://www.thingiverse.com/thing:2770373
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2018-01-26
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
outline_size_in_millimeter = 1.7; //[0.5:0.1:20]

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
A1 = [250, 811];
A2 = [397, 714];
A3 = [394, 649];
A4 = [605, 570];
A5 = [681, 721];
A6 = [567, 817];
A7 = [932, 1104];
A8 = [1708, 160];
A9 = [1880, 273];
A10 = [1934, 437];
A11 = [1958, 658];
A12 = [1939, 679];
A13 = [1928, 861];
A14 = [1723, 1151];
A15 = [1657, 1419];
A16 = [1489, 1693];
A17 = [665, 1693];
A18 = [347, 1026];
A19 = [388, 787];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19];

// Inner Points
B1 = [416, 680];
B2 = [598, 607];
B3 = [910, 1146];
B4 = [1799, 308];
B5 = [1834, 368];
B6 = [1850, 550];

// Polygons
C1 = [A8, B4, A9];
C2 = [B4, A9, A10, A11, A12, B6, B5];
C3 = [A7, A8, B4, B5];
C4 = [A7, B5, B6];
C5 = [B6, A12, A13, A7];
C6 = [A7, A13, A14];
C7 = [A14, A15, A7];
C8 = [A7, B3, A16, A15];
C9 = [A7, A6, B3];
C10 = [B1, B2, A5, A6];
C11 = [A2, A3, A4, A5, B2, B1];
C12 = [A2, A1, A19];
C13 = [A2, B1, A6, B3, A16, A17, A18, A19];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13];

min_x = A1[0];
min_y = A8[1];
max_x = A11[0];
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
