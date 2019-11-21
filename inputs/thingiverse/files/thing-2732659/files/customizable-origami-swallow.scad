/*
 * Customizable Origami - Swallow - https://www.thingiverse.com/thing:2732659
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-12-26
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
inline_edge_radius_in_millimeter = 0.3; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [399, 1666];
A2 = [354, 1199];
A3 = [365, 1105];
A4 = [438, 1000];
A5 = [662, 765];
A6 = [577, 649];
A7 = [595, 615];
A8 = [559, 553];
A9 = [625, 571];
A10 = [645, 540];
A11 = [815, 606];
A12 = [1058, 361];
A13 = [1225, 278];
A14 = [1334, 273];
A15 = [1667, 305];
A16 = [1319, 564];
A17 = [1338, 578];
A18 = [1254, 768];
A19 = [1166, 811];
A20 = [1112, 817];
A21 = [1186, 931];
A22 = [1758, 1221];
A23 = [1265, 1077];
A24 = [1450, 1598];
A25 = [1114, 1057];
A26 = [950, 1010];
A27 = [916, 1146];
A28 = [700, 1300];
A29 = [681, 1282];
A30 = [650, 1298];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30];

// Inner Points
B1 = [900, 785];
B2 = [986, 744];
B3 = [1083, 770];
B4 = [876, 971];
B5 = [838, 888];
B6 = [550, 1123];
B7 = [685, 933];
B8 = [405, 1087];
B9 = [1152, 451];
B10 = [1052, 545];
B11 = [1114, 415];
B12 = [950, 874];
B13 = [1019, 835];
B14 = [900, 822];
B15 = [942, 784];
B16 = [1188, 321];
//B17 = [698, 1255];
B18 = [494, 1035];

// Polygons
C1 = [A1, B6, A30];
C2 = [B6, A30, A29];
C3 = [B6, B18, B8, A2, A1];
C4 = [A2, A3, B8];
C5 = [B6, B7, B18];
C6 = [A3, A4, A5, B5, B7, B18, B8];
C7 = [B6, B18, B7, B5, B4, A27, A28, A29];
C8 = [A30, A29, A28];
C9 = [B4, A26, A27];
C10 = [B5, B1, B14, B12, A25, A26, B4];
C11 = [B1, B2, B3, A20, A21, B13, B15];
C12 = [B3, A18, A19, A20];
C13 = [B2, B10, B11, B9, A16, A17, A18, B3];
C14 = [A5, B1, A11, A10, A9, A7, A6];
C15 = [A8, A7, A9];
C16 = [A5, B5, B1];
C17 = [A11, B2, B1];
C18 = [A11, A12, A13, B16, B11, B10, B2];
C19 = [B16, A14, A13];
C20 = [B10, B11, B9];
C21 = [B11, B16, A14, A15, B9];
C22 = [B9, A16, A15];
C23 = [B1, A23, A24, A25, B12, B14];
C24 = [B1, B15, B13, A21, A22, A23];

cut_polygons = [C1, C2, C3, C4, /*C5,*/ C6, C7, /*C8,*/ C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, /*C20,*/ C21, C22, C23, C24];

min_x = A2[0];
min_y = A14[1];
max_x = A22[0];
max_y = A1[1];

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
