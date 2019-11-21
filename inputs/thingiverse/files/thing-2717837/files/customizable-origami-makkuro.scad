/*
 * Customizable Origami - Makkuro - https://www.thingiverse.com/thing:2717837
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-12-16
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
outline_size_in_millimeter = 0.4; //[0.5:0.1:20]

// Thickness of the inner outline.
inline_size_in_millimeter = 0.7; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 0.9; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [990, 625];
A2 = [1049, 539];
A3 = [1071, 630];
A4 = [1163, 555];
A5 = [1164, 645];
A6 = [1235, 595];
A7 = [1239, 669];
A8 = [1299, 646];
A9 = [1286, 701];
A10 = [1353, 684];
A11 = [1299, 749];
A12 = [1424, 763];
A13 = [1368, 813];
A14 = [1467, 851];
A15 = [1446, 906];
A16 = [1505, 941];
A17 = [1455, 1002];
A18 = [1495, 1049];
A19 = [1460, 1102];
A20 = [1505, 1143];
A21 = [1490, 1166];
A22 = [1444, 1192];
A23 = [1466, 1228];
A24 = [1421, 1225];
A25 = [1427, 1284];
A26 = [1365, 1314];
A27 = [1369, 1367];
A28 = [1335, 1355];
A29 = [1308, 1401];
A30 = [1294, 1375];
A31 = [1237, 1430];
A32 = [1215, 1409];
A33 = [1180, 1442];
A34 = [1131, 1429];
A35 = [1085, 1465];
A36 = [1035, 1431];
A37 = [1008, 1501];
A38 = [986, 1436];
A39 = [901, 1494];
A40 = [881, 1446];
A41 = [795, 1495];
A42 = [787, 1437];
A43 = [686, 1453];
A44 = [689, 1415];
A45 = [595, 1404];
A46 = [608, 1320];
A47 = [536, 1330];
A48 = [580, 1274];
A49 = [499, 1258];
A50 = [548, 1203];
A51 = [478, 1132];
A52 = [518, 1081];
A53 = [488, 1023];
A54 = [534, 1005];
A55 = [499, 901];
A56 = [555, 910];
A57 = [528, 833];
A58 = [600, 812];
A59 = [581, 748];
A60 = [607, 725];
A61 = [662, 746];
A62 = [668, 677];
A63 = [726, 699];
A64 = [743, 606];
A65 = [813, 665];
A66 = [839, 576];
A67 = [885, 649];
A68 = [921, 558];
A69 = [958, 558];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38, A39, A40, A41, A42, A43, A44, A45, A46, A47, A48, A49, A50, A51, A52, A53, A54, A55, A56, A57, A58, A59, A60, A61, A62, A63, A64, A65, A66, A67, A68, A69];

// Inner Points
B1 = [893, 914];
B2 = [946, 926];
B3 = [979, 971];
B4 = [993, 1037];
B5 = [974, 1092];
B6 = [945, 1130];
B7 = [886, 1155];
B8 = [829, 1142];
B9 = [801, 1111];
B10 = [784, 1063];
B11 = [787, 1008];
B12 = [813, 964];
B13 = [850, 931];
B14 = [1114, 914];
B15 = [1158, 914];
B16 = [1198, 934];
B17 = [1224, 961];
B18 = [1240, 991];
B19 = [1246, 1025];
B20 = [1247, 1072];
B21 = [1224, 1110];
B22 = [1197, 1134];
B23 = [1142, 1145];
B24 = [1104, 1127];
B25 = [1060, 1085];
B26 = [1041, 1034];
B27 = [1042, 989];
B28 = [1059, 947];
B29 = [1081, 922];
B30 = [989, 1005];
B31 = [970, 989];
B32 = [949, 981];
B33 = [927, 996];
B34 = [923, 1022];
B35 = [934, 1038];
B36 = [954, 1035];
B37 = [964, 1019];
B38 = [1057, 980];
B39 = [1075, 968];
B40 = [1094, 968];
B41 = [1105, 984];
B42 = [1099, 1007];
B43 = [1077, 1010];
B44 = [1064, 1000];
B45 = [991, 1017];
B46 = [1040, 1000];

// Polygons
C1 = [B30, B31, B32, B33, B34, B35, B36, B37, B45, B4, B5, B6, B7, B8, B9, B10, B11, B12, B13, B1, B2, B3];
C2 = [B27, B38, B39, B40, B41, B42, B43, B44, B46, B26, B25, B24, B23, B22, B21, B20, B19, B18, B17, B16, B15, B14, B29, B28];

cut_polygons = [C1, C2];

min_x = A51[0];
min_y = A2[1];
max_x = A16[0];
max_y = A37[1];

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
