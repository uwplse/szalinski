/*
 * Customizable Origami - Seahorse - https://www.thingiverse.com/thing:2704265
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-12-10
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
A1 = [630, 499];
A2 = [778, 466];
A3 = [788, 393];
A4 = [985, 323];
A5 = [1112, 530];
A6 = [1060, 654];
A7 = [1070, 686];
A8 = [1134, 669];
A9 = [1242, 773];
A10 = [1187, 900];
A11 = [1124, 918];
A12 = [1133, 958];
A13 = [1134, 1165];
A14 = [988, 1274];
A15 = [892, 1277];
A16 = [837, 1190];
A17 = [890, 1233];
A18 = [986, 1220];
A19 = [1049, 1133];
A20 = [1046, 1060];
A21 = [859, 742];
A22 = [859, 606];
A23 = [901, 532];
A24 = [770, 532];
A25 = [630, 532];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25];

// Polygons
C1 = [A25, A2, A24];
C2 = [A1, A25, A2];
C3 = [A3, A4, A5, A23, A24, A2];
C4 = [A5, A6, A21, A22, A23];
C5 = [A6, A7, A11, A12, A20, A21];
C6 = [A7, A8, A9, A10, A11];
C7 = [A12, A13, A19, A20];
C8 = [A19, A13, A14, A18];
C9 = [A17, A18, A14, A15];
C10 = [A16, A17, A15];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10];

min_x = A1[0];
min_y = A4[1];
max_x = A9[0];
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
