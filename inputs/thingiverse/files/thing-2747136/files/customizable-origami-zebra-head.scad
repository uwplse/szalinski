/*
 * Customizable Origami - Zebra Head - https://www.thingiverse.com/thing:2747136
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2018-01-05
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
outline_size_in_millimeter = 0.8; //[0.5:0.1:20]

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
A1 = [1235, 469];
A2 = [1353, 541];
A3 = [1446, 539];
A4 = [1489, 450];
A5 = [1568, 310];
A6 = [1649, 199];
A7 = [1746, 142];
A8 = [1846, 125];
A9 = [1904, 166];
A10 = [1955, 305];
A11 = [1963, 405];
A12 = [1922, 580];
A13 = [1835, 686];
A14 = [1610, 893];
A15 = [1744, 1063];
A16 = [1768, 1138];
A17 = [1739, 1223];
A18 = [1737, 1258];
A19 = [1798, 1306];
A20 = [1727, 1317];
A21 = [1711, 1377];
A22 = [1708, 1446];
A23 = [1709, 1561];
A24 = [1709, 1659];
A25 = [1694, 1790];
A26 = [1673, 1894];
A27 = [1640, 1989];
A28 = [1593, 2116];
A29 = [1524, 2258];
A30 = [1610, 2522];
A31 = [1563, 2653];
A32 = [1237, 2867];
A33 = [911, 2654];
A34 = [861, 2521];
A35 = [944, 2259];
A36 = [882, 2119];
A37 = [832, 1997];
A38 = [801, 1897];
A39 = [778, 1790];
A40 = [769, 1657];
A41 = [765, 1561];
A42 = [763, 1447];
A43 = [760, 1373];
A44 = [745, 1315];
A45 = [671, 1304];
A46 = [733, 1221];
A47 = [708, 1136];
A48 = [727, 1055];
A49 = [796, 975];
A50 = [855, 901];
A51 = [826, 858];
A52 = [634, 686];
A53 = [552, 585];
A54 = [501, 404];
A55 = [566, 173];
A56 = [625, 129];
A57 = [726, 146];
A58 = [821, 197];
A59 = [902, 311];
A60 = [962, 426];
A61 = [1023, 533];
A62 = [1124, 536];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38, A39, A40, A41, A42, A43, A44, A45, A46, A47, A48, A49, A50, A51, A52, A53, A54, A55, A56, A57, A58, A59, A60, A61, A62];

// Inner Points
B1 = [889, 375];
B2 = [1581, 380];
B3 = [1235, 608];
B4 = [1236, 730];
B5 = [1237, 760];
B6 = [1236, 821];
B7 = [1236, 878];
B8 = [1238, 949];
B9 = [1238, 1001];
B10 = [1233, 1223];
B11 = [1237, 1644];
B12 = [1234, 2007];
B13 = [1234, 2233];
B14 = [1235, 2489];
B15 = [1449, 1941];
B16 = [1020, 1941];
B17 = [963, 2124];
B18 = [1511, 2123];
B19 = [981, 1948];
B20 = [987, 1828];
B21 = [1029, 1767];
B22 = [904, 1646];
B23 = [929, 1748];
B24 = [939, 1847];
B25 = [1532, 1846];
B26 = [1544, 1750];
B27 = [1490, 1948];
B28 = [1483, 1824];
B29 = [1446, 1769];
B30 = [1338, 2027];
B31 = [1128, 2021];
B32 = [1162, 2051];
B33 = [1308, 2051];
B34 = [855, 1325];
B35 = [907, 1329];
B36 = [991, 1311];
B37 = [1059, 1334];
B38 = [1124, 1302];
B39 = [1162, 1305];
B40 = [1311, 1305];
B41 = [1347, 1300];
B42 = [1415, 1337];
B43 = [1474, 1308];
B44 = [1566, 1322];
B45 = [1621, 1323];
B46 = [783, 1285];
B47 = [924, 1095];
B48 = [1088, 937];
B49 = [1043, 914];
B50 = [1025, 889];
B51 = [1057, 785];
B52 = [1415, 784];
B53 = [1447, 885];
B54 = [1688, 1119];
B55 = [1639, 1013];
B56 = [1712, 1123];
B57 = [1724, 1213];
B58 = [1701, 1233];
B59 = [1690, 1285];
B60 = [735, 1263];
B61 = [790, 1124];
B62 = [776, 1234];
B63 = [1081, 983];
B64 = [1428, 915];
B65 = [1326, 960];
B66 = [1149, 962];
B67 = [1161, 1017];
B68 = [1310, 1018];
B69 = [1468, 795];
B70 = [1473, 744];
B71 = [1642, 784];
B72 = [830, 786];
B73 = [999, 748];
B74 = [1004, 794];
B75 = [831, 1021];
B76 = [1718, 1074];
B77 = [1736, 1132];
B78 = [737, 1128];
B79 = [761, 1069];
B80 = [999, 677];
B81 = [1473, 677];
B82 = [1115, 593];
B83 = [1109, 805];
B84 = [1363, 803];
B85 = [542, 409];
B86 = [1931, 406];
B87 = [585, 222];
B88 = [1885, 222];
B89 = [1857, 625];
B90 = [615, 627];
B91 = [749, 1213];
B92 = [902, 1565];
B93 = [1573, 1565];
B94 = [1642, 1399];
B95 = [829, 1398];
B96 = [872, 1376];
B97 = [1601, 1373];
B98 = [941, 1584];
B99 = [965, 1559];
B100 = [1535, 1582];
B101 = [1506, 1561];
B102 = [1465, 1559];
B103 = [1415, 1593];
B104 = [1057, 1593];
B105 = [1192, 1735];
B106 = [1283, 1735];
B107 = [1193, 2035];
B108 = [1283, 2031];
B109 = [1205, 1037];
B110 = [1266, 1035];
B111 = [1304, 1035];
B112 = [1175, 1032];
B113 = [1195, 1367];
B114 = [1279, 1365];
B115 = [1083, 1748];
B116 = [1393, 1745];
B117 = [1044, 1963];
B118 = [1425, 1962];
B119 = [1436, 1682];
B120 = [1459, 1692];
B121 = [1039, 1682];
B122 = [1017, 1694];
B123 = [1003, 1555];
B124 = [1393, 986];
B125 = [1387, 940];
B126 = [1549, 1099];
B127 = [904, 1444];
B128 = [1568, 1445];
B129 = [1565, 1648];
B130 = [1170, 2238];
B131 = [1305, 2236];
B132 = [764, 1125];
B133 = [1366, 595];

// Polygons
C1 = [B40, B33, B41];
C2 = [B9, B110, B41, B40];
C3 = [B39, B9, B109, B38];
C4 = [B39, B32, B38];
C5 = [B10, B11, B113];
C6 = [B10, B114, B11];
C7 = [B113, B105, B11];
C8 = [B11, B106, B114];
C9 = [B105, B12, B107];
C10 = [B106, B108, B12];
C11 = [B8, B67, B112];
C12 = [B8, B68, B111];
C13 = [B68, B43, B42, B111];
C14 = [B112, B37, B36, B67];
C15 = [B31, B115, B104, B36, B37];
C16 = [B30, B42, B43, B103, B116];
C17 = [B30, B116, B102, B44, B45, B97, B101, B119, B118];
C18 = [B31, B115, B123, B99, B121, B117];
C19 = [B99, B96, B34, B35, B123];
C20 = [B34, B63, B7, B66, B35];
C21 = [B7, B124, B45, B44, B65];
C22 = [B62, B49, B6, B7, B48, B47, B46];
C23 = [B62, B91, B60, B46];
C24 = [B91, A46, A45, B60];
C25 = [A46, A47, A49, A50, B79, B78, B91];
C26 = [A14, A16, A17, B57, B77, B76];
C27 = [B58, B57, A17, A18, B59];
C28 = [B7, B6, B64, B58, B59, B126, B125];
C29 = [A42, B127, B98, B122, B21, B92, A41];
C30 = [A22, A23, B93, B29, B120, B100, B128];
C31 = [B129, A24, A25, B26, B28, B29];
C32 = [B29, B28, B27, B18, B15];
C33 = [B27, B25, A26, A27];
C34 = [B18, A28, A29];
C35 = [B130, B13, B14];
C36 = [B14, B131, B13];
C37 = [A35, B17, A36];
C38 = [B20, B21, B16, B17, B19];
C39 = [B21, B22, A40, A39, B23, B20];
C40 = [A38, B24, B19, A37];
C41 = [A43, B95, B96, B127, A42];
C42 = [B97, B94, A21, A22, B128];
C43 = [B91, B132, B75, B74, B50, B61, B62];
C44 = [B74, B3, B4, B51, B50];
C45 = [B3, B69, B53, B52, B4];
C46 = [B69, B55, B56, B57, B58, B54, B53];
C47 = [B83, B5, B84, B6];
C48 = [A45, B60, B46, A44];
C49 = [B59, A20, A19, A18];
C50 = [B85, B87, B90];
C51 = [A56, A57, B87];
C52 = [A57, A58, B87];
C53 = [B87, B1, A60, A59, A58];
C54 = [B87, B1, B90];
C55 = [A53, A52, A51, A50, B72, B90];
C56 = [B3, B73, A50, B72, B80];
C57 = [A1, A62, A61, B82];
C58 = [B90, B80, B1];
C59 = [B90, B72, B80];
C60 = [B82, B80, B1, A61];
C61 = [A1, B133, A3, A2];
C62 = [B3, B81, B71, A14, B70];
C63 = [B81, B89, B71];
C64 = [B71, B89, A12, A13, A14];
C65 = [A8, B88, A7];
C66 = [A6, B88, A7];
C67 = [B88, B2, A4, A5, A6];
C68 = [B2, B88, B89];
C69 = [B88, B86, B89];
C70 = [B81, B2, B89];
C71 = [B133, A3, B2, B81];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, C26, C27, C28, C29, C30, C31, C32, C33, C34, C35, C36, C37, C38, C39, C40, C41, C42, C43, C44, C45, C46, C47, C48, C49, C50, C51, C52, C53, C54, C55, C56, C57, C58, C59, C60, C61, C62, C63, C64, C65, C66, C67, C68, C69, C70, C71];

min_x = A54[0];
min_y = A8[1];
max_x = A11[0];
max_y = A32[1];

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
