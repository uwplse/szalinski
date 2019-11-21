/*
 * Customizable Origami - Swan - https://www.thingiverse.com/thing:2627896
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-11-06
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
inline_size_in_millimeter = 0.7; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 0.6; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [143, 117];
A2 = [164, 65];
A3 = [204, 58];
A4 = [219, 76];
A5 = [236, 94];
A6 = [199, 186];
A7 = [254, 162];
A8 = [286, 186];
A9 = [363, 182];
A10 = [332, 218];
A11 = [350, 233];
A12 = [317, 235];
A13 = [311, 243];
A14 = [334, 276];
A15 = [281, 273];
A16 = [257, 299];
A17 = [169, 262];
A18 = [137, 182];
A19 = [193, 107];
A20 = [185, 78];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20];

// Inner Points
B1 = [272, 187];

// Polygons
C1 = [A1, A2, A3, A20];
C2 = [A20, A3, A4, A19];
C3 = [A5, A6, A17, A18, A19, A4];
C4 = [A6, A17, A15, A14, A13, B1, A7];
C5 = [A7, B1, A8];
C6 = [B1, A8, A9, A10, A12, A13];
C7 = [A10, A11, A12];
C8 = [A15, A16, A17];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8];

min_x = A18[0];
min_y = A3[1];
max_x = A9[0];
max_y = A16[1];

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
