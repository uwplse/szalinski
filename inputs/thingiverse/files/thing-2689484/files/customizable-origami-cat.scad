/*
 * Customizable Origami - Fox - https://www.thingiverse.com/thing:2689484
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-12-04
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
A1 = [54, 77];
A2 = [345, 325];
A3 = [371, 303];
A4 = [703, 304];
A5 = [765, 40];
A6 = [883, 218];
A7 = [962, 216];
A8 = [1030, 255];
A9 = [1224, 183];
A10 = [1120, 405];
A11 = [970, 512];
A12 = [923, 500];
A13 = [870, 531];
A14 = [973, 733];
A15 = [916, 717];
A16 = [931, 755];
A17 = [620, 632];
A18 = [476, 565];
A19 = [440, 725];
A20 = [393, 644];
A21 = [363, 755];
A22 = [220, 450];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22];

// Inner Points
B1 = [430, 543];
B2 = [850, 549];
B3 = [810, 465];
B4 = [892, 490];
B5 = [871, 487];

// Polygons
C1 = [A22, A1, A2, A18, B1];
C2 = [A22, A21, A20, B1];
C3 = [B1, A18, A19, A20];
C4 = [A2, A18, A17];
C5 = [A3, A4, B3, B2, A17, A2];
C6 = [A4, A5, A6];
C7 = [A8, A9, A10];
C8 = [A7, A8, A10, A11, A12, B4];
C9 = [A7, B4, B3, A4, A6];
C10 = [B3, B2, B5];
C11 = [B2, B5, B4, A12, A13, A14, A15];
C12 = [A16, A15, B2, A17];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12];

min_x = A1[0];
min_y = A5[1];
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
