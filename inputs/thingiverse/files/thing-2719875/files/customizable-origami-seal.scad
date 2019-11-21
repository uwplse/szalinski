/*
 * Customizable Origami - Seal - https://www.thingiverse.com/thing:2719875
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-12-17
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
outline_size_in_millimeter = 1.5; //[0.5:0.1:20]

// Thickness of the inner outline.
inline_size_in_millimeter = 0.7; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 0.1; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [122, 1052];
A2 = [299, 988];
A3 = [451, 931];
A4 = [512, 890];
A5 = [1130, 715];
A6 = [1192, 537];
A7 = [1293, 370];
A8 = [1389, 299];
A9 = [1500, 289];
A10 = [1673, 327];
A11 = [1636, 429];
A12 = [1537, 482];
A13 = [1519, 527];
A14 = [1521, 753];
A15 = [1544, 840];
A16 = [1545, 870];
A17 = [1599, 1032];
A18 = [1618, 1050];
A19 = [1634, 1043];
A20 = [1671, 1059];
A21 = [1663, 1080];
A22 = [1573, 1102];
A23 = [1440, 1087];
A24 = [1392, 1016];
A25 = [1235, 1097];
A26 = [1217, 1128];
A27 = [1190, 1140];
A28 = [855, 1158];
A29 = [811, 1148];
A30 = [1060, 1111];
A31 = [1075, 1099];
A32 = [456, 1018];
A33 = [187, 1062];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33];

// Inner Points
B1 = [388, 1002];
B2 = [451, 965];
B3 = [1125, 765];
B4 = [1080, 979];
B5 = [1227, 910];
B6 = [1228, 584];
B7 = [1482, 596];
B8 = [1494, 897];
B9 = [1229, 1080];
B10 = [1088, 1085];
B11 = [1205, 1110];
B12 = [1195, 1125];
B13 = [1634, 1069];
B14 = [1486, 355];

// Polygons
C1 = [A8, B14, A9];
C2 = [A9, A10, B14];
C3 = [A10, A11, B14];
C4 = [A11, A12, B14];
C5 = [A12, A13, B7, B14];
C6 = [B14, B6, B7];
C7 = [B14, A7, A8];
C8 = [A7, A6, B6, B14];
C9 = [A6, A5, B3, B6];
C10 = [B6, B5, B3];
C11 = [B3, B4, B5];
C12 = [A4, A5, B3, A3];
C13 = [A2, A3, B3, B4, B2];
C14 = [A2, B1, A32, A31, B10, B4, B2];
C15 = [A32, A33, B1];
C16 = [A2, A1, A33, B1];
C17 = [A29, A30, B11, B12, A28];
C18 = [A28, B12, B11, B9, A25, A26, A27];
C19 = [B10, B9, B11, A30, A31];
C20 = [B4, B5, B9, B10];
C21 = [B5, B8, A25, B9];
C22 = [B8, A15, A16, A24, A25];
C23 = [A16, A24, A23, A17];
C24 = [A23, A22, A21, B13, A18, A17];
C25 = [A18, A19, A20, A21, B13];
C26 = [B8, A14, A15];
C27 = [B7, A14, B8];
C28 = [B7, A13, A14, A15, B8];
C29 = [B6, B5, B7];
C30 = [B7, B5, B8];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, /*C15,*/ C16, C17, /*C18,*/ C19, C20, C21, C22, C23, C24, C25, /*C26, C27,*/ C28, C29, C30];

min_x = A1[0];
min_y = A9[1];
max_x = A10[0];
max_y = A28[1];

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
