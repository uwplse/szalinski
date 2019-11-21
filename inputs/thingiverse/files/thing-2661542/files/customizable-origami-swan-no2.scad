/*
 * Customizable Origami - Swan - https://www.thingiverse.com/thing:2661542
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
A1 = [142, 399];
A2 = [133, 369];
A3 = [173, 311];
A4 = [115, 174];
A5 = [276, 20];
A6 = [435, 45];
A7 = [489, 273];
A8 = [224, 819];
A9 = [328, 718];
A10 = [576, 669];
A11 = [914, 798];
A12 = [1041, 910];
A13 = [950, 987];
A14 = [1019, 1033];
A15 = [705, 1235];
A16 = [226, 1235];
A17 = [12, 1022];
A18 = [31, 775];
A19 = [424, 276];
A20 = [402, 103];
A21 = [290, 81];
A22 = [229, 301];
A23 = [177, 390];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23];

// Inner Points
B1 = [166, 370];
B2 = [196, 305];
B3 = [183, 177];
B4 = [69, 855];
B5 = [119, 1080];
B6 = [209, 847];
B7 = [325, 821];
B8 = [531, 947];
B9 = [593, 1134];
B10 = [894, 1025];

// Polygons
C1 = [A2, B1, A23, A1];
C2 = [B1, B2, A22, A23];
C3 = [B1, A2, A3, B2];
C4 = [A3, A4, B3, B2];
C5 = [A4, A5, B3];
C6 = [A5, A21, A22, B2, B3];
C7 = [A5, A20, A21];
C8 = [A5, A20, A6];
C9 = [A20, A19, A7, A6];
C10 = [A19, A18, B4, A7];
C11 = [A7, A8, B6, B4];
C12 = [A18, A17, B4];
C13 = [B4, B6, B5, A17];
C14 = [A8, A9, B7, B5, B6];
C15 = [A9, A10, B7];
C16 = [A10, A11, A12];
C17 = [A10, A12, B8, B7];
C18 = [A12, A13, B10, A15, B9, B8];
C19 = [A13, A14, B10];
C20 = [A14, A15, B10];
C21 = [B9, B5, A16, A15];
C22 = [B5, A17, A16];
C23 = [B5, B7, B8, B9];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23];

min_x = A17[0];
min_y = A5[1];
max_x = A12[0];
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
