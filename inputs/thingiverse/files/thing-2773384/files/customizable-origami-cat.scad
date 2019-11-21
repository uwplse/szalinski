/*
 * Customizable Origami - Cat - https://www.thingiverse.com/thing:2773384
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2018-01-28
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
A1 = [68, 207];
A2 = [78, 167];
A3 = [109, 164];
A4 = [260, 305];
A5 = [415, 507];
A6 = [565, 759];
A7 = [639, 940];
A8 = [703, 849];
A9 = [739, 833];
A10 = [1187, 803];
A11 = [1229, 835];
A12 = [1339, 851];
A13 = [1589, 444];
A14 = [1623, 437];
A15 = [1643, 455];
A16 = [1632, 543];
A17 = [1864, 642];
A18 = [1907, 734];
A19 = [1890, 763];
A20 = [1706, 831];
A21 = [1539, 1272];
A22 = [1494, 1390];
A23 = [1468, 1446];
A24 = [1488, 1489];
A25 = [1563, 1525];
A26 = [1578, 1561];
A27 = [1555, 1590];
A28 = [1602, 1611];
A29 = [1612, 1641];
A30 = [1587, 1664];
A31 = [1454, 1683];
A32 = [1410, 1652];
A33 = [1257, 1395];
A34 = [1151, 1183];
A35 = [786, 1415];
A36 = [764, 1464];
A37 = [604, 1595];
A38 = [634, 1672];
A39 = [631, 1701];
A40 = [596, 1711];
A41 = [538, 1696];
A42 = [511, 1626];
A43 = [480, 1595];
A44 = [441, 1523];
A45 = [435, 1463];
A46 = [525, 1383];
A47 = [534, 1334];
A48 = [506, 1110];
A49 = [445, 852];
A50 = [376, 654];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38, A39, A40, A41, A42, A43, A44, A45, A46, A47, A48, A49, A50];

// Inner Points
B1 = [1201, 846];
B2 = [637, 1381];
B3 = [1445, 716];
B4 = [1360, 840];
B5 = [1591, 849];
B6 = [1493, 644];
B7 = [1469, 684];
B8 = [1601, 607];
B9 = [1611, 482];
B10 = [1543, 563];
B11 = [1634, 488];
B12 = [1514, 1588];

// Polygons
C1 = [B6, B10, B9, B11, A16, B8];
C2 = [A16, A17, A18, A19, A20, B5, B7, B6, B8];
C3 = [B7, B3, A21, A20, B5];
C4 = [B3, B4, A22, A21];
C5 = [B1, A11, A12, B4, A22, A33, A34];
C6 = [A33, A32, A31, A30, A29, A28, A27, B12, A24, A23, A22];
C7 = [A24, A25, A26, A27, B12];
C8 = [A36, B2, A43, A42, A41, A40, A39, A38, A37];
C9 = [B2, A47, A46, A45, A44, A43];
C10 = [A36, A35, A9, A8, A7, A48, A47, B2];
C11 = [A10, B1, A11];
C12 = [A10, B1, A34, A35, A9];
C13 = [A12, A13, A14, A15, B11, B9, B10, B6, B7, B3, B4];
C14 = [A7, A6, A5, A49, A48];
C15 = [A49, A5, A4, A3, A2, A1, A50];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15];

min_x = A1[0];
min_y = A3[1];
max_x = A18[0];
max_y = A40[1];

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
