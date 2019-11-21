/*
 * Customizable Origami - Duck - https://www.thingiverse.com/thing:2657390
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-11-19
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
A1 = [63, 262];
A2 = [157, 147];
A3 = [175, 98];
A4 = [231, 63];
A5 = [334, 63];
A6 = [425, 118];
A7 = [473, 226];
A8 = [448, 367];
A9 = [586, 378];
A10 = [995, 603];
A11 = [1121, 601];
A12 = [960, 681];
A13 = [858, 785];
A14 = [623, 822];
A15 = [572, 920];
A16 = [345, 920];
A17 = [517, 886];
A18 = [456, 771];
A19 = [266, 670];
A20 = [166, 518];
A21 = [207, 377];
A22 = [311, 247];
A23 = [298, 223];
A24 = [221, 204];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24];

// Inner Points
B1 = [226, 140];
B2 = [502, 546];
B3 = [743, 675];

// Polygons
C1 = [A1, A2, B1, A24];
//C1 = [A1, B1, A24];
C2 = [B1, A1, A2];
C3 = [A2, A3, A4, A5, A6, A23, A24, B1];
C4 = [A6, A7, A22, A23];
C5 = [A22, A21, A7];
C6 = [A7, A8, A21];
C7 = [A8, B2, A10, A9];
C8 = [A21, A20, A19, A18, B2, A8];
C9 = [B2, A10, A12, B3];
C10 = [A18, A14, A13, B3, B2];
C11 = [A13, A12, B3];
C12 = [A12, A11, A10];
C13 = [A18, A17, A15, A14];
C14 = [A17, A16, A15];

cut_polygons = [C1, /*C2,*/ C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14];

min_x = A1[0];
min_y = A4[1];
max_x = A11[0];
max_y = A15[1];

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
