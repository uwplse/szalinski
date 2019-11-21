/*
 * Customizable Bunny - https://www.thingiverse.com/thing:2788367
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * remix from Stanford Bunny (CC BY 3.0) - https://www.thingiverse.com/thing:88208
 * created 2018-02-09
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
inline_edge_radius_in_millimeter = 0.6; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [48, 934];
A2 = [108, 688];
A3 = [286, 481];
A4 = [535, 384];
A5 = [760, 397];
A6 = [891, 269];
A7 = [1272, 43];
A8 = [1529, 67];
A9 = [1558, 173];
A10 = [1464, 388];
A11 = [1157, 601];
A12 = [922, 663];
A13 = [963, 804];
A14 = [1037, 819];
A15 = [1170, 747];
A16 = [1327, 694];
A17 = [1624, 805];
A18 = [1872, 1084];
A19 = [1941, 1362];
A20 = [1882, 1554];
A21 = [1907, 1553];
A22 = [1931, 1751];
A23 = [1746, 2080];
A24 = [1689, 2089];
A25 = [1467, 2093];
A26 = [1042, 2088];
A27 = [554, 2067];
A28 = [328, 2055];
A29 = [363, 2012];
A30 = [512, 1868];
A31 = [566, 1776];
A32 = [409, 1701];
A33 = [294, 1563];
A34 = [235, 1369];
A35 = [262, 1110];
A36 = [115, 1060];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36];

// Inner Points
B1 = [202, 953];
B2 = [89, 801];
B3 = [270, 567];
B4 = [524, 461];
B5 = [574, 622];
B6 = [412, 910];
B7 = [700, 901];
B8 = [806, 453];
B9 = [1065, 314];
B10 = [1395, 350];
B11 = [896, 608];
B12 = [874, 908];
B13 = [993, 897];
B14 = [1542, 891];
B15 = [1353, 974];
B16 = [1543, 1149];
B17 = [999, 1343];
B18 = [834, 1262];
B19 = [1293, 1439];
B20 = [1699, 1382];
B21 = [1823, 1551];
B22 = [1660, 1580];
B23 = [1373, 1853];
B24 = [1167, 1759];
B25 = [1226, 1901];
B26 = [1030, 1987];
B27 = [872, 1580];
B28 = [688, 1644];
B29 = [646, 1352];
B30 = [680, 1234];
B31 = [562, 1149];
B32 = [331, 1097];
B33 = [308, 1304];
B34 = [331, 1471];
B35 = [579, 1609];
B36 = [767, 1880];
B37 = [613, 1839];
B38 = [557, 2040];
B39 = [1756, 1680];
B40 = [1919, 1727];
B41 = [903, 793];

// Polygons
C1 = [A1, A2, B2];
C2 = [A2, A3, B3, B2];
C3 = [A3, B4, B3];
C4 = [A3, A4, B4];
C5 = [A4, B8, B4];
C6 = [A4, B8, A5];
C7 = [A5, A6, A7];
C8 = [A5, B8, B9, A7];
C9 = [B9, A8, A7];
C10 = [B9, B10, A8];
C11 = [B10, A10, A8];
C12 = [A10, A9, A8];
C13 = [B9, B11, B10];
C14 = [B9, B8, B11];
C15 = [B10, A10, B11];
C16 = [B11, A12, A10];
C17 = [A12, A11, A10];
C18 = [B8, B7, B11];
C19 = [B7, B11, B41];
C20 = [B11, B41, A13, A12];
C21 = [B8, B7, B5];
C22 = [B4, B5, B8];
C23 = [B3, B5, B4];
C24 = [B3, B1, B6, B5];
C25 = [B3, B1, B2];
C26 = [A1, B2, B1, A36];
C27 = [B1, B32, A35, A36];
C28 = [B1, B6, B32];
C29 = [B6, B7, B32];
C30 = [B6, B5, B7];
C31 = [A35, B32, B33, A34];
C32 = [B32, B7, B31];
C33 = [B32, B33, B35, B31];
C34 = [B31, B12, B7];
C35 = [B7, B41, B12];
C36 = [B12, B31, B30];
C37 = [B41, A13, A14, A15, B13, B29, B30, B12];
C38 = [B31, B30, B29, B35];
C39 = [B33, B34, B35];
C40 = [B34, B35, A31, A33];
C41 = [A33, A31, A32];
C42 = [A33, B34, B33, A34];
C43 = [A28, A27, A29];
C44 = [A29, A30, A27];
C45 = [A30, A31, B37, B38, A27];
C46 = [B37, B36, B38];
C47 = [B38, A26, A27];
C48 = [B38, B36, A26];
C49 = [B36, A26, B26];
C50 = [B26, B25, A26];
C51 = [A26, A25, B25];
C52 = [B25, B23, A25];
C53 = [A25, B39, A24];
C54 = [A24, B39, B40];
C55 = [A21, A22, A23, A24, B40];
C56 = [B39, A21, B40];
C57 = [A20, A21, B39, A25, B23, B22];
C58 = [B22, B21, A20];
C59 = [A20, A19, A18, B21];
C60 = [B21, A18, B20];
C61 = [B20, B22, B21];
C62 = [A18, A17, B14];
C63 = [B14, A18, B20, B16];
C64 = [B14, A15, A16, A17];
C65 = [A15, B15, B14];
C66 = [B14, B16, B15];
C67 = [B15, B17, B18, B13];
C68 = [B13, A15, B15];
C69 = [B15, B16, B19, B17];
C70 = [B16, B20, B19];
C71 = [B19, B27, B18, B17];
C72 = [B18, B13, B29, B28, B27];
C73 = [B27, B19, B20, B22, B23, B24];
C74 = [B24, B25, B23];
C75 = [B24, B25, B26];
C76 = [B26, B27, B24];
C77 = [B27, B26, B28];
C78 = [B28, B36, B26];
C79 = [B28, B37, B36];
C80 = [B28, B29, B35, B37];
C81 = [B35, B37, A31];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, C26, C27, C28, C29, C30, C31, C32, C33, C34, C35, C36, C37, C38, C39, C40, C41, C42, C43, C44, C45, C46, C47, C48, C49, C50, C51, C52, C53, C54, C55, C56, C57, C58, C59, C60, C61, C62, C63, C64, C65, C66, C67, C68, C69, C70, C71, C72, C73, C74, C75, C76, C77, C78, C79, C80, C81];

min_x = A1[0];
min_y = A7[1];
max_x = A19[0];
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
