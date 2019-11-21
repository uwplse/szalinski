/*
 * Customizable Origami - Chameleon - https://www.thingiverse.com/thing:2780697
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2018-02-03
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
outline_size_in_millimeter = 1; //[0.5:0.1:20]

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
A1 = [224, 639];
A2 = [349, 535];
A3 = [439, 508];
A4 = [587, 322];
A5 = [682, 334];
A6 = [743, 450];
A7 = [731, 519];
A8 = [925, 341];
A9 = [1208, 270];
A10 = [1467, 384];
A11 = [1641, 612];
A12 = [1686, 867];
A13 = [1711, 1042];
A14 = [1714, 1082];
A15 = [1874, 1135];
A16 = [1874, 1566];
A17 = [1714, 1395];
A18 = [1713, 1413];
A19 = [1637, 1565];
A20 = [1561, 1642];
A21 = [1380, 1740];
A22 = [1071, 1741];
A23 = [937, 1601];
A24 = [895, 1458];
A25 = [888, 1367];
A26 = [936, 1266];
A27 = [1025, 1215];
A28 = [1130, 1191];
A29 = [1252, 1240];
A30 = [1321, 1317];
A31 = [1321, 1418];
A32 = [1225, 1515];
A33 = [1071, 1476];
A34 = [1072, 1385];
A35 = [1120, 1369];
A36 = [1101, 1411];
A37 = [1163, 1449];
A38 = [1236, 1390];
A39 = [1175, 1289];
A40 = [1049, 1305];
A41 = [1012, 1421];
A42 = [1053, 1547];
A43 = [1186, 1628];
A44 = [1422, 1566];
A45 = [1467, 1446];
A46 = [1505, 1286];
A47 = [1472, 1226];
A48 = [1333, 1163];
A49 = [1235, 1152];
A50 = [1164, 1156];
A51 = [1162, 1148];
A52 = [1027, 1136];
A53 = [582, 1283];
A54 = [208, 1106];
A55 = [459, 1168];
A56 = [430, 974];
A57 = [569, 1166];
A58 = [755, 1089];
A59 = [749, 1055];
A60 = [862, 995];
A61 = [804, 908];
A62 = [626, 862];
A63 = [524, 863];
A64 = [429, 817];
A65 = [318, 760];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38, A39, A40, A41, A42, A43, A44, A45, A46, A47, A48, A49, A50, A51, A52, A53, A54, A55, A56, A57, A58, A59, A60, A61, A62, A63, A64, A65];

// Inner Points
B1 = [955, 1043];
B2 = [964, 932];
B3 = [1011, 937];
B4 = [1006, 1029];
B5 = [1133, 962];
B6 = [1299, 1010];
B7 = [1168, 987];
B8 = [1134, 995];
B9 = [1133, 1045];
B10 = [895, 1092];
B11 = [1138, 1095];
B12 = [1263, 1069];
B13 = [1379, 1092];
B14 = [1407, 1091];
B15 = [1005, 1135];
B16 = [1332, 1147];
B17 = [385, 549];
B18 = [391, 574];
B19 = [414, 583];
B20 = [425, 556];
B21 = [413, 538];
B22 = [720, 581];
B23 = [332, 627];
B24 = [364, 618];
B25 = [439, 638];
B26 = [495, 554];
B27 = [413, 694];
B28 = [534, 781];
B29 = [605, 747];
B32 = [1068, 410];
B34 = [1486, 612];
B35 = [1601, 822];
B37 = [1401, 803];
B39 = [1725, 1227];
B40 = [558, 538];
B41 = [824, 669];
B42 = [732, 757];
B43 = [1010, 832];
B45 = [1104, 687];
B50 = [1130, 936];
B52 = [1428, 1024];
B53 = [793, 1082];
B58 = [1006, 1046];

// Polygons
C1 = [B2, B3, B4, B1];
C2 = [B5, B8, B7, B6];
C3 = [B24, B18, B17, A2];
C4 = [A2, B17, B21, A3];
C5 = [B21, A3, B26, B20];
C6 = [B26, B25, B19, B20];
C7 = [B25, B24, B18, B19];
C8 = [B11, A51, A50, B12];
C9 = [B10, B58, B15];
C10 = [B15, B58, B4, B3, B43, B9];
C11 = [B9, B43, B42, B45, B50, B5, B8];
C12 = [A1, B23, B27, B28, A64, A65];
C13 = [A64, B28, B29, A62, A63];
C14 = [A1, A2, B24, B23];
C15 = [B23, B27, B28, B29, B22, B25, B24];
C16 = [A3, B40, A5, A4];
C17 = [B40, B22, A7, A6, A5];
C18 = [A3, B40, B22, B25, B26];
C19 = [A62, B42, B41, B32, A9, A8, A7, B22, B29];
C20 = [B32, B34, B35, A13, A12, A11, A10, A9];
C21 = [A61, B2, B1, B53, A60];
C22 = [A60, A59, A58, B53];
C23 = [B42, B45, B34, B32, B41];
C24 = [A62, B42, B43, B3, B2, A61];
C25 = [B45, B34, B35, B37, B6, B5, B50];
C26 = [B37, B52, B39, A14, A13, B35];
C27 = [B37, B6, B12, A50, A49, B16, B13, B52];
C28 = [B52, B39, A17, A18, A19, A46, A47, B14, B13];
C29 = [A46, A19, A20, A21, A44, A45];
C30 = [A44, A22, A21];
C31 = [A22, A43, A44];
C32 = [A43, A23, A22];
C33 = [A43, A23, A24, A42];
C34 = [A42, A24, A25];
C35 = [A25, A42, A41];
C36 = [A41, A26, A25];
C37 = [A41, A40, A28, A27, A26];
C38 = [A40, A39, A30, A29, A28];
C39 = [A39, A38, A31, A30];
C40 = [A38, A32, A31];
C41 = [A33, A37, A38, A32];
C42 = [A33, A36, A37];
C43 = [A36, A35, A34, A33];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, C26, C27, C28, C29, C30, C31, C32, C33, C34, C35, C36, C37, C38, C39, C40, C41, C42, C43];

min_x = A54[0];
min_y = A9[1];
max_x = A16[0];
max_y = A22[1];

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
