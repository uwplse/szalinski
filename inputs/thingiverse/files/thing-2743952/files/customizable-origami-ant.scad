/*
 * Customizable Origami - Ant - https://www.thingiverse.com/thing:2743952
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2018-01-03
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
outline_size_in_millimeter = 1.0; //[0.5:0.1:20]

// Thickness of the inner outline.
inline_size_in_millimeter = 0.7; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 0.0; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [39, 2355];
A2 = [402, 1780];
A3 = [371, 1596];
A4 = [815, 902];
A5 = [967, 891];
A6 = [1174, 567];
A7 = [1341, 870];
A8 = [1377, 864];
A9 = [1649, 458];
A10 = [1819, 1167];
A11 = [1847, 1149];
A12 = [1900, 826];
A13 = [2026, 842];
A14 = [2042, 1026];
A15 = [2141, 1025];
A16 = [2215, 682];
A17 = [2273, 681];
A18 = [2276, 1026];
A19 = [2295, 1026];
A20 = [2315, 850];
A21 = [2573, 602];
A22 = [3062, 688];
A23 = [3085, 713];
A24 = [3487, 447];
A25 = [3736, 608];
A26 = [4062, 458];
A27 = [4268, 366];
A28 = [4651, 314];
A29 = [4927, 378];
A30 = [4501, 350];
A31 = [4231, 418];
A32 = [3779, 634];
A33 = [3823, 665];
A34 = [4231, 580];
A35 = [4512, 518];
A36 = [5156, 562];
A37 = [5359, 717];
A38 = [4991, 564];
A39 = [4526, 576];
A40 = [3889, 701];
A41 = [3931, 734];
A42 = [4076, 946];
A43 = [4246, 1241];
A44 = [4247, 1376];
A45 = [3995, 1189];
A46 = [3839, 1160];
A47 = [3574, 1189];
A48 = [3146, 965];
A49 = [3680, 2087];
A50 = [3059, 1058];
A51 = [2621, 1260];
A52 = [2568, 1416];
A53 = [3013, 1122];
A54 = [3326, 2349];
A55 = [2927, 1208];
A56 = [2502, 1624];
A57 = [2415, 1519];
A58 = [2531, 1211];
A59 = [2380, 1125];
A60 = [2494, 1278];
A61 = [2263, 1555];
A62 = [2068, 1593];
A63 = [2075, 1714];
A64 = [2010, 1711];
A65 = [1997, 1608];
A66 = [1831, 1640];
A67 = [1656, 2339];
A68 = [1766, 1653];
A69 = [1608, 1583];
A70 = [1577, 1705];
A71 = [727, 2055];
A72 = [431, 1953];
A73 = [414, 1852];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38, A39, A40, A41, A42, A43, A44, A45, A46, A47, A48, A49, A50, A51, A52, A53, A54, A55, A56, A57, A58, A59, A60, A61, A62, A63, A64, A65, A66, A67, A68, A69, A70, A71, A72, A73];

// Inner Points
B1 = [452, 1700];
B2 = [490, 1749];
B3 = [900, 994];
B4 = [987, 1085];
B5 = [1235, 746];
B6 = [1138, 881];
B7 = [1281, 873];
B8 = [1083, 952];
B9 = [941, 928];
B10 = [1328, 1002];
B11 = [1423, 1018];
B12 = [1718, 1072];
B13 = [1671, 1038];
B14 = [1658, 600];
B15 = [1433, 873];
B16 = [1414, 861];
B17 = [1673, 1261];
B18 = [1665, 1300];
B19 = [1640, 1417];
B20 = [1678, 1483];
B21 = [1558, 1650];
B22 = [1836, 1205];
B23 = [1944, 1177];
B24 = [2044, 1133];
B25 = [2180, 1029];
B26 = [2654, 890];
B27 = [2732, 916];
B28 = [2609, 1007];
B29 = [3119, 1021];
B30 = [3191, 854];
B31 = [3722, 686];
B32 = [3781, 724];
B33 = [2310, 1032];

// Polygons
C1 = [A2, A3, B1];
C2 = [B2, A71, A72, A73];
C3 = [A1, A73, B2, B4, B8, B6, B5, A6, A5, B9, B3, B1, A2];
C4 = [A3, A4, B3, B1];
C5 = [A4, B3, B9];
C6 = [A4, A5, B9];
C7 = [B6, B7, B10, B8];
C8 = [B6, B5, B7];
C9 = [A6, A7, B11, B19, B20, A69, B21, B10, B7, B5];
C10 = [A69, A70, B4, B8, B10, B21];
C11 = [B11, B12, B17, B18, B19];
C12 = [A7, A8, B16, B15, B13, B12, B11];
C13 = [B2, B4, A70, A71];
C14 = [A69, A68, B18, B19, B20];
C15 = [B17, B22, A68, B18];
C16 = [B17, A10, A11, B22];
C17 = [B17, B12, B13, B14, A9, A10];
C18 = [B14, B15, B16, A8, A9];
C19 = [A67, A68, B22, A11, A12, A13, B23, A66];
C20 = [B23, A65, A66];
C21 = [A64, A63, A62, B24, A14, A13, B23, A65];
C22 = [B24, B33, A61, A62];
C23 = [B24, A14, A15, B25, A18, A19, B33];
C24 = [A15, A16, B25];
C25 = [A16, A17, A18, B25];
C26 = [A19, A20, A21, B33];
C27 = [A21, B28, A58, A59, B33];
C28 = [B33, A59, A60, A61];
C29 = [B26, B27, A51, A52, A57, A58, B28];
C30 = [A21, A22, B29, A50, A51, B27, B26, B28];
C31 = [A22, A23, B30, A48, B29];
C32 = [A57, A56, A55, A53, A52];
C33 = [A55, A54, A53];
C34 = [A50, A49, A48, B29];
C35 = [A23, A24, A25, A32, A33, B31, B32, A40, A41, B30];
C36 = [A25, A26, A31, A32];
C37 = [A26, A27, A28, A30, A31];
C38 = [B31, B32, A40, A39, A34];
C39 = [B30, A41, A42, A46, A47, A48];
C40 = [A42, A43, A45, A46];
C41 = [A43, A44, A45];
C42 = [A34, A35, A36, A38, A39];
C43 = [A30, A28, A29];
C44 = [A36, A37, A38];
C45 = [B14, B13, B15];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, C26, C27, C28, C29, C30, C31, C32, C33, C34, C35, C36, C37, C38, C39, C40, C41, C42, C43, C44, C45];

min_x = A1[0];
min_y = A28[1];
max_x = A37[0];
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
