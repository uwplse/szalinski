/*
 * Customizable Origami - Butterfly - https://www.thingiverse.com/thing:2692040
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-12-05
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
outline_size_in_millimeter = 1.8; //[0.5:0.1:20]

// Thickness of the inner outline.
inline_size_in_millimeter = 0.7; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 0.2; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [393, 40];
A2 = [922, 382];
A3 = [1011, 407];
A4 = [1108, 383];
A5 = [1632, 40];
A6 = [1915, 211];
A7 = [1725, 648];
A8 = [1618, 690];
A9 = [1688, 897];
A10 = [1564, 1116];
A11 = [1270, 1216];
A12 = [1115, 827];
A13 = [1079, 873];
A14 = [1014, 954];
A15 = [947, 871];
A16 = [915, 830];
A17 = [760, 1216];
A18 = [467, 1119];
A19 = [339, 892];
A20 = [410, 690];
A21 = [301, 647];
A22 = [112, 207];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22];

// Inner Points
B1 = [1014, 447];
B2 = [1016, 477];
B3 = [1545, 720];
B4 = [482, 718];

// Polygons
C1 = [A22, A1, A2, B1];
C2 = [A2, A3, A4, B1];
C3 = [A4, A5, A6, B1];
C4 = [A6, A7, A8, B3, B2, B1];
C5 = [B1, A22, A21, A20, B4, B2];
C6 = [A20, A19, A18, B2, B4];
C7 = [B2, B3, A8, A9, A10];
C8 = [B2, A10, A11, A12];
C9 = [B2, A18, A17, A16];
C10 = [A16, B2, A15];
C11 = [B2, A14, A15];
C12 = [B2, A14, A13];
C13 = [A13, A12, B2];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13];

min_x = A22[0];
min_y = A1[1];
max_x = A6[0];
max_y = A11[1];

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
