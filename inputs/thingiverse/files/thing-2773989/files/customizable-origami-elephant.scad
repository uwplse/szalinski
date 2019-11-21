/*
 * Customizable Origami - Elephant - https://www.thingiverse.com/thing:2773989
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2018-01-29
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
outline_size_in_millimeter = 1.7; //[0.5:0.1:20]

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
A1 = [184, 1322];
A2 = [181, 1283];
A3 = [165, 1263];
A4 = [179, 1238];
A5 = [173, 947];
A6 = [195, 797];
A7 = [202, 777];
A8 = [283, 588];
A9 = [443, 507];
A10 = [487, 519];
A11 = [516, 503];
A12 = [590, 427];
A13 = [660, 439];
A14 = [786, 386];
A15 = [1048, 397];
A16 = [1363, 349];
A17 = [1620, 418];
A18 = [1666, 435];
A19 = [1818, 578];
A20 = [1881, 887];
A21 = [1854, 1034];
A22 = [1787, 1106];
A23 = [1762, 1108];
A24 = [1743, 1331];
A25 = [1769, 1428];
A26 = [1770, 1508];
A27 = [1802, 1565];
A28 = [1805, 1590];
A29 = [1807, 1628];
A30 = [1793, 1647];
A31 = [1584, 1652];
A32 = [1587, 1667];
A33 = [1562, 1678];
A34 = [1351, 1687];
A35 = [1276, 1679];
A36 = [1270, 1668];
A37 = [1259, 1622];
A38 = [1315, 1562];
A39 = [1308, 1456];
A40 = [1308, 1371];
A41 = [1330, 1272];
A42 = [1168, 1278];
A43 = [993, 1222];
A44 = [963, 1315];
A45 = [946, 1563];
A46 = [979, 1630];
A47 = [982, 1654];
A48 = [958, 1681];
A49 = [868, 1688];
A50 = [781, 1692];
A51 = [693, 1690];
A52 = [656, 1672];
A53 = [644, 1629];
A54 = [705, 1565];
A55 = [662, 1336];
A56 = [653, 1083];
A57 = [588, 1055];
A58 = [383, 1162];
A59 = [358, 1273];
A60 = [363, 1324];
A61 = [406, 1455];
A62 = [476, 1462];
A63 = [535, 1367];
A64 = [558, 1390];
A65 = [571, 1403];
A66 = [601, 1414];
A67 = [579, 1485];
A68 = [548, 1533];
A69 = [507, 1562];
A70 = [343, 1567];
A71 = [214, 1387];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38, A39, A40, A41, A42, A43, A44, A45, A46, A47, A48, A49, A50, A51, A52, A53, A54, A55, A56, A57, A58, A59, A60, A61, A62, A63, A64, A65, A66, A67, A68, A69, A70, A71];

// Inner Points
B1 = [307, 882];
B2 = [238, 779];
B3 = [313, 697];
B4 = [396, 724];
B5 = [387, 631];
B6 = [366, 610];
B7 = [429, 708];
B8 = [507, 701];
B9 = [535, 1035];
B10 = [550, 1038];
B11 = [730, 897];
B12 = [776, 663];
B13 = [628, 847];
B14 = [492, 883];
B15 = [457, 959];
B16 = [422, 951];
B17 = [333, 1094];
B18 = [296, 1072];
B19 = [274, 1059];
B20 = [338, 1158];
B21 = [360, 1130];
B22 = [521, 979];
B23 = [800, 1047];
B24 = [1104, 1024];
B25 = [917, 989];
B26 = [902, 1248];
B27 = [830, 1266];
B28 = [678, 1313];
B29 = [807, 1579];
B30 = [782, 1644];
B31 = [1457, 1618];
B32 = [1343, 1647];
B33 = [1368, 1565];
B34 = [1463, 1562];
B35 = [1565, 1533];
B36 = [1632, 1124];
B37 = [1416, 1132];
B38 = [1337, 1158];
B39 = [1302, 1020];
B40 = [1351, 1000];
B41 = [1639, 807];
B42 = [1401, 730];
B43 = [1103, 716];
B44 = [885, 710];
B45 = [845, 695];
B46 = [952, 960];
B47 = [1024, 482];
B48 = [1261, 428];
B49 = [1540, 442];
B50 = [869, 473];
B51 = [790, 422];
B52 = [489, 574];
B53 = [537, 492];
B54 = [583, 443];
B55 = [649, 450];
B56 = [623, 443];
B57 = [783, 662];
B58 = [739, 906];
B59 = [624, 1019];
B60 = [640, 1005];
B61 = [477, 807];
B62 = [1082, 1190];
B63 = [1622, 1542];
B64 = [1669, 1533];
B65 = [1670, 1604];
B66 = [1597, 1599];
B67 = [1621, 1337];
B68 = [1653, 1209];
B69 = [1727, 1096];
B70 = [1781, 920];
B71 = [1811, 731];
B72 = [1812, 648];
B73 = [1778, 571];
B74 = [1739, 639];
B75 = [1798, 1007];
B76 = [955, 1173];
B77 = [1339, 1205];
B78 = [945, 1212];
B79 = [477, 1502];
B80 = [354, 1490];
B81 = [260, 1412];
B82 = [235, 1265];
B83 = [323, 1266];
B84 = [321, 1366];
B85 = [469, 552];
B86 = [213, 1216];
B87 = [252, 1228];
B88 = [378, 1457];
B89 = [688, 963];
B90 = [934, 1308];
B91 = [1765, 1078];
B92 = [1831, 1034];
B93 = [1858, 869];
B94 = [1767, 1001];
B95 = [1822, 658];
B96 = [1748, 1068];
B97 = [1586, 1630];

// Polygons
C1 = [B85, B6, A8, A9];
C2 = [A9, B85, A11, A10];
C3 = [B6, B5, B85];
C4 = [B4, B5, B85, A11, A12, B54, B53, B52, B7];
C5 = [B4, B61, B7];
C6 = [B3, B6, B5, B4];
C7 = [B6, A8, A7, A6, B2, B3];
C8 = [A6, B1, B2];
C9 = [B2, B3, B4, B61, B14, B1];
C10 = [A12, A13, B55, B56, B54];
C11 = [B55, B12, B57, A13];
C12 = [B12, B11, B58, B57];
C13 = [B11, B10, A57, B59, B60, B58];
C14 = [B9, B13, B11, B10];
C15 = [B13, B12, B11];
C16 = [B8, B12, B13];
C17 = [B8, B13, B9, B22, B14, B61];
C18 = [B7, B8, B61];
C19 = [B7, B52, B53, B54, B56, B8];
C20 = [B8, B56, B55, B12];
C21 = [B1, B18, B17, B16, B14];
C22 = [B1, B19, B86, A3, A2, B87, B17, B18];
C23 = [B17, B21, B20, B82, A2, B87];
C24 = [B17, B21, A58, B15, B14, B16];
C25 = [A58, B15, B14, B22];
C26 = [A58, A57, B10, B9, B22];
C27 = [A57, B59, B60, A56];
C28 = [B20, B21, A58, A59, A60, A61, B88, B80, B84, B83];
C29 = [B80, B79, A62, A61, B88];
C30 = [A62, A63, A64, B79];
C31 = [A64, A65, A66, A67, A68, A69, A70, A71, B81, B80, B79];
C32 = [B80, B84, B83, B20, B82, B81];
C33 = [A71, A1, A2, B82, B81];
C34 = [A4, A5, A6, B1, B19, B86];
C35 = [A3, A4, B86];
C36 = [A13, A14, B51];
C37 = [A14, B50, B51];
C38 = [B50, B47, A15, A14];
C39 = [A15, A16, B49, B48, B47];
C40 = [A16, B49, A17];
C41 = [A13, B51, B50, B47, B45, B23, B89, B58, B57];
C42 = [B23, B28, A55, A56, B60, B89];
C43 = [B28, B27, B23];
C44 = [B27, B26, B25, B23];
C45 = [B25, B46, B76, B78, B26];
C46 = [B78, A43, A44, A45, B90];
C47 = [B26, A45, B90, B78];
C48 = [B26, A45, B29, B27];
C49 = [B27, B29, A54, A55, B28];
C50 = [A54, A53, B30, B29];
C51 = [B29, A45, A46, B30];
C52 = [A53, A52, A51, A50, B30];
C53 = [A50, A49, A48, A47, A46, B30];
C54 = [B23, B45, B25];
C55 = [B25, B45, B44, B46];
C56 = [B45, B47, B44];
C57 = [B44, B43, B47];
C58 = [B47, B48, B42, B43];
C59 = [B42, B49, B48];
C60 = [B49, B74, B41, B42];
C61 = [B49, A17, A18, B73, B72, B74];
C62 = [B72, B71, B70, B69, B36, B41, B74];
C63 = [A18, A19, B73];
C64 = [B73, B95, B93, B92, B75, B72];
C65 = [B73, A19, A20, B93, B95];
C66 = [A20, A21, B92, B93];
C67 = [A21, A22, B91, B92];
C68 = [B71, B70, B94, B69, B96, B75];
C69 = [B96, B75, B92, B91];
C70 = [B69, B96, B91, A22, A23];
C71 = [B70, B94, B69];
C72 = [B69, B68, B67, B35, B34, B36];
C73 = [B36, B37, B41];
C74 = [B41, B42, B40, B37];
C75 = [B40, B39, B38, B37];
C76 = [B39, B42, B40];
C77 = [B42, B24, B38, B39];
C78 = [B38, B77, B62, B24];
C79 = [B78, A43, A42, A41, B77, B62, B76];
C80 = [B76, B46, B24, B62];
C81 = [B46, B44, B43, B24];
C82 = [B43, B42, B24];
C83 = [B33, B37, B36, B34];
C84 = [B37, B38, B77, A41, A40, A39, A38, B33];
C85 = [A38, A37, B32, B33];
C86 = [B33, B34, B31, B32];
C87 = [B31, B34, B35, B66];
C88 = [B66, B97, A31, A32, A33, A34, B32, B31];
C89 = [B32, A37, A36, A35, A34];
C90 = [B66, B65, A28, A29, A30, A31, B97];
C91 = [B35, B63, B64, B65, B66];
C92 = [B64, A26, A27, A28, B65];
C93 = [B35, B67, B63];
C94 = [B67, B68, B69, B64, B63];
C95 = [B69, A23, A24, A25, A26, B64];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, C26, C27, C28, C29, C30, C31, C32, C33, C34, C35, C36, C37, C38, C39, C40, C41, C42, C43, C44, C45, C46, C47, C48, C49, C50, C51, C52, C53, C54, C55, C56, C57, C58, C59, C60, C61, C62, C63, C64, C65, C66, C67, C68, C69, C70, C71, C72, C73, C74, C75, C76, C77, C78, C79, C80, C81, C82, C83, C84, C85, C86, C87, C88, C89, C90, C91, C92, C93, C94, C95];

min_x = A3[0];
min_y = A16[1];
max_x = A20[0];
max_y = A50[1];

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
