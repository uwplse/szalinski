/*
 * Customizable Origami - Monstera Leaf - https://www.thingiverse.com/thing:2757358
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2018-01-14
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
outline_size_in_millimeter = 3.4; //[0.5:0.1:20]

// Thickness of the inner outline.
inline_size_in_millimeter = 0.9; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 1.9; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [220, 694];
A2 = [275, 583];
A3 = [652, 533];
A4 = [794, 202];
A5 = [899, 174];
A6 = [988, 131];
A7 = [1119, 170];
A8 = [1237, 178];
A9 = [1339, 257];
A10 = [1453, 311];
A11 = [1528, 443];
A12 = [1650, 555];
A13 = [1692, 654];
A14 = [1652, 697];
A15 = [1738, 820];
A16 = [1774, 980];
A17 = [1705, 1001];
A18 = [1765, 1174];
A19 = [1742, 1350];
A20 = [1656, 1340];
A21 = [1678, 1528];
A22 = [1615, 1733];
A23 = [1544, 1716];
A24 = [1540, 1785];
A25 = [1307, 1811];
A26 = [1148, 1752];
A27 = [1115, 1808];
A28 = [963, 1780];
A29 = [815, 1693];
A30 = [781, 1749];
A31 = [645, 1689];
A32 = [534, 1569];
A33 = [479, 1595];
A34 = [381, 1507];
A35 = [309, 1366];
A36 = [274, 1372];
A37 = [216, 1281];
A38 = [194, 1132];
A39 = [145, 1016];
A40 = [172, 888];
A41 = [167, 782];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38, A39, A40, A41];

// Inner Points
B1 = [643, 888];
B2 = [621, 754];
B3 = [569, 823];
B4 = [668, 764];
B5 = [739, 912];
B6 = [720, 708];
B7 = [835, 865];
B8 = [788, 668];
B9 = [920, 818];
B10 = [858, 638];
B11 = [1001, 732];
B12 = [905, 607];
B13 = [1003, 636];
B14 = [882, 562];
B15 = [983, 537];
B16 = [868, 485];
B17 = [936, 462];
B18 = [832, 433];
B19 = [890, 401];
B20 = [780, 376];
B21 = [835, 316];
B22 = [554, 700];
B23 = [501, 797];
B24 = [515, 675];
B25 = [435, 747];
B26 = [382, 684];
B27 = [359, 654];
B28 = [452, 608];
B29 = [464, 633];
B30 = [499, 647];
B31 = [328, 1255];
B32 = [361, 1270];
B33 = [517, 1457];
B34 = [548, 1459];
B35 = [770, 1607];
B36 = [815, 1599];
B37 = [1086, 1689];
B38 = [1128, 1669];
B39 = [1450, 1635];
B40 = [1475, 1613];
B41 = [1604, 1314];
B42 = [1625, 1284];
B43 = [1640, 980];
B44 = [1652, 950];
B45 = [1572, 699];
B46 = [1569, 667];
B47 = [1432, 460];
B48 = [1431, 433];
B49 = [1270, 305];
B50 = [1256, 284];
B51 = [1058, 250];
B52 = [1034, 234];
B53 = [757, 681];
B54 = [835, 470];
B55 = [802, 429];
B56 = [734, 370];
B57 = [895, 314];

// Polygons
C1 = [A1, A2, A3, B28, B27];
C2 = [A1, B27, B28, B29, B26, A40, A41];
C3 = [A38, A39, A40, B25];
C4 = [A40, B26, B29, B30, B24, B25];
C5 = [A38, B25, B24, B22, B23];
C6 = [A38, B23, B31, A35, A36, A37];
C7 = [B22, B23, B31, A35, B32, B3];
C8 = [B3, B32, A35, A34, A33, A32, B33];
C9 = [B2, B3, B33, A32, B34, B1];
C10 = [B4, B5, B36, A29, B35, B1];
C11 = [B1, B35, A29, A30, A31, A32];
C12 = [B6, B5, B37, A26, B38, B7];
C13 = [A29, B36, B5, B37, A26, A27, A28];
C14 = [B7, B39, A23, A24, A25, A26, B38];
C15 = [B53, B7, B39, A23, B40, B9];
C16 = [B9, B40, A23, A22, A21, A20, B41];
C17 = [B8, B9, B41, A20, B42, B11];
C18 = [B11, B43, A17, A18, A19, A20, B42];
C19 = [B12, B11, B43, A17, B44, B13];
C20 = [B13, B45, A14, A15, A16, A17, B44];
C21 = [B14, B13, B45, A14, B46, B15];
C22 = [B15, B46, A14, A13, A12, A11, B47];
C23 = [B16, B17, B48, A11, B47, B15];
C24 = [B17, B49, A9, A10, A11, B48];
C25 = [B54, B19, B50, A9, B49, B17];
C26 = [B19, B51, A7, A8, A9, B50];
C27 = [A7, B51, B19, B55, B52];
C28 = [B57, A5, A6, A7, B52];
C29 = [B56, A4, A5];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, C26, C27, C28, C29];

min_x = A39[0];
min_y = A6[1];
max_x = A16[0];
max_y = A25[1];

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
