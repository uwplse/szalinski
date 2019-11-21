/*
 * Customizable Origami - Monkey - https://www.thingiverse.com/thing:2745944
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2018-01-04
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
A1 = [608, 299];
A2 = [618, 317];
A3 = [454, 553];
A4 = [461, 765];
A5 = [597, 1034];
A6 = [600, 1116];
A7 = [713, 1060];
A8 = [897, 964];
A9 = [1118, 1015];
A10 = [1135, 953];
A11 = [1178, 837];
A12 = [1205, 779];
A13 = [1317, 747];
A14 = [1414, 829];
A15 = [1497, 886];
A16 = [1496, 903];
A17 = [1556, 923];
A18 = [1546, 941];
A19 = [1564, 970];
A20 = [1514, 1021];
A21 = [1424, 1052];
A22 = [1363, 1182];
A23 = [1365, 1334];
A24 = [1298, 1499];
A25 = [1471, 1776];
A26 = [1515, 1755];
A27 = [1643, 1849];
A28 = [1512, 1849];
A29 = [1392, 1837];
A30 = [1213, 1700];
A31 = [1139, 1557];
A32 = [1127, 1441];
A33 = [930, 1524];
A34 = [721, 1464];
A35 = [672, 1600];
A36 = [580, 1645];
A37 = [534, 1701];
A38 = [532, 1729];
A39 = [573, 1774];
A40 = [676, 1849];
A41 = [549, 1849];
A42 = [406, 1730];
A43 = [387, 1657];
A44 = [422, 1447];
A45 = [409, 1392];
A46 = [458, 1219];
A47 = [547, 1150];
A48 = [450, 1062];
A49 = [356, 789];
A50 = [383, 528];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38, A39, A40, A41, A42, A43, A44, A45, A46, /*A47,*/ A48, A49, A50];

// Inner Points
B1 = [725, 1156];
B2 = [1111, 1333];
B3 = [1213, 1036];
B4 = [751, 1387];
B5 = [548, 1257];
B6 = [499, 1555];
B7 = [1365, 1067];
B8 = [1449, 980];
B9 = [1464, 936];
B10 = [1461, 896];
B11 = [1370, 855];
B12 = [1262, 834];
B13 = [1198, 881];
B14 = [1226, 881];
B15 = [1264, 871];
B16 = [1205, 963];
B17 = [1225, 1020];
B18 = [1410, 887];
B19 = [1396, 902];
B20 = [1316, 857];

// Polygons
C1 = [A1, A2, A3, A50];
C2 = [A3, A4, A49, A50];
C3 = [A4, A5, A48, A49];
C4 = [A5, A6, A47, A46, A48];
C5 = [A7, B5, A46, A47, A6];
C6 = [A7, B1, B4, B5];
C7 = [B4, A34, A35, B6, B5];
C8 = [B5, B6, A45, A46];
C9 = [A45, B6, A44];
C10 = [B6, A35, A36];
C11 = [A44, B6, A36, A37, A43];
C12 = [A37, A38, A42, A43];
C13 = [A38, A39, A41, A42];
C14 = [A39, A40, A41];
C15 = [A7, A8, B1];
C16 = [A8, B4, B1];
C17 = [A8, A33, A34];
C18 = [A8, B2, A32, A33];
C19 = [A8, B2, B3, A9];
C20 = [A10, B13, B14, B16, B17, B3, A9];
C21 = [A10, A11, B12, B14, B13];
C22 = [B12, B15, B14];
C23 = [A11, A12, B12];
C24 = [A12, A13, B12];
C25 = [A13, A14, B12];
C26 = [B12, A14, B20];
C27 = [B20, A14, B11, B18];
C28 = [A14, A15, B10, B18, B11];
C29 = [B20, B18, B10, B9, B19, B8];
C30 = [B10, A15, A16, B9];
C31 = [A16, A17, A18, A20, B9];
C32 = [A18, A19, A20];
C33 = [B19, B9, A20, B8];
C34 = [B8, A20, A21, B7];
C35 = [B7, B12, B20, B8];
C36 = [B16, B14, B15, B12, B7, B17];
C37 = [B17, B7, A21, A22, B3];
C38 = [B3, A22, A23];
C39 = [B3, A23, A24, A30, A31, A32, B2];
C40 = [A24, A25, A28, A29, A30];
C41 = [A25, A26, A28];
C42 = [A26, A27, A28];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, /*C26,*/ C27, C28, /*C29,*/ /*C30,*/ C31, /*C32,*/ C33, /*C34,*/ C35, C36, C37, C38, C39, C40, C41, C42];

min_x = A49[0];
min_y = A1[1];
max_x = A27[0];
max_y = A41[1];

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
