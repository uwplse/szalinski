/*
 * Customizable Origami - Little Astronaut - https://www.thingiverse.com/thing:2763444
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2018-01-20
 * version v1.0
 *
 * Changelog
 * --------------
 * v1.1:
 *      - added hollow visor option (thanks @Zarsk)
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
inline_edge_radius_in_millimeter = 0.0; //[0.0:0.1:5]

// Hollow visor
hollow_visor = "no"; //[yes,now]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [833, 129];
A2 = [1631, 99];
A3 = [1972, 312];
A4 = [2060, 367];
A5 = [2205, 645];
A6 = [2215, 1163];
A7 = [1987, 1495];
A8 = [1665, 1662];
A9 = [1718, 1828];
A10 = [1735, 1938];
A11 = [1710, 2047];
A12 = [1735, 2094];
A13 = [1735, 2177];
A14 = [1711, 2203];
A15 = [1686, 2211];
A16 = [1653, 2176];
A17 = [1643, 2148];
A18 = [1650, 2104];
A19 = [1604, 2090];
A20 = [1550, 2180];
A21 = [1487, 2196];
A22 = [1500, 2256];
A23 = [1509, 2325];
A24 = [1507, 2398];
A25 = [1499, 2468];
A26 = [1533, 2538];
A27 = [1567, 2626];
A28 = [1554, 2723];
A29 = [1524, 2722];
A30 = [1454, 2758];
A31 = [1324, 2767];
A32 = [1212, 2754];
A33 = [1209, 2718];
A34 = [1189, 2713];
A35 = [1038, 2744];
A36 = [922, 2746];
A37 = [858, 2730];
A38 = [823, 2601];
A39 = [892, 2482];
A40 = [953, 2462];
A41 = [1028, 2474];
A42 = [1025, 2455];
A43 = [1017, 2386];
A44 = [1016, 2312];
A45 = [1022, 2246];
A46 = [1029, 2190];
A47 = [993, 2182];
A48 = [911, 2038];
A49 = [904, 1983];
A50 = [803, 2058];
A51 = [764, 2067];
A52 = [729, 2083];
A53 = [705, 2144];
A54 = [660, 2149];
A55 = [636, 2118];
A56 = [637, 2082];
A57 = [658, 2027];
A58 = [708, 1993];
A59 = [743, 1876];
A60 = [824, 1771];
A61 = [875, 1688];
A62 = [843, 1692];
A63 = [460, 1420];
A64 = [402, 1266];
A65 = [335, 1081];
A66 = [296, 965];
A67 = [293, 899];
A68 = [297, 832];
A69 = [454, 424];
A75 = [530, 295];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38, A39, A40, A41, A42, A43, A44, A45, A46, A47, A48, A49, A50, A51, A52, A53, A54, A55, A56, A57, A58, A59, A60, A61, A62, A63, A64, A65, A66, A67, A68, A69, A75];

// Inner Points
B1 = [1363, 159];
B2 = A69;
B3 = [703, 356];
B4 = [1107, 379];
B5 = [1467, 479];
B6 = [1744, 907];
B7 = [1743, 1042];
B8 = [1475, 1472];
B9 = [1110, 1563];
B10 = [712, 1543];
B13 = [481, 476];
B14 = [703, 414];
B15 = [1073, 437];
B16 = [1400, 527];
B17 = [1657, 916];
B18 = [1659, 1036];
B19 = [1413, 1425];
B20 = [1078, 1507];
B21 = [713, 1492];
B22 = [487, 1380];
B23 = [335, 967];
B24 = [335, 845];
B25 = [1740, 355];
B26 = [1901, 700];
B27 = [2096, 771];
B28 = [2130, 948];
B29 = [2099, 1130];
B30 = [1989, 1191];
B31 = [1876, 1153];
B32 = [1840, 982];
B33 = [1869, 808];
B34 = [1980, 736];
B35 = [1749, 976];
B38 = [1751, 1540];
B39 = [1380, 1711];
B40 = [1806, 978];
B41 = [1845, 788];
B42 = [1966, 714];
B43 = [1847, 1165];
B44 = [1971, 1210];
B45 = [1561, 1670];
B46 = [1616, 1644];
B47 = [1563, 1712];
B48 = [1633, 1697];
B49 = [1586, 1830];
B50 = [1660, 1815];
B51 = [1605, 1941];
B52 = [1676, 1929];
B53 = [864, 1790];
B54 = [924, 1692];
B55 = [1047, 1699];
B56 = [1261, 1711];
B57 = [1230, 1831];
B58 = [1247, 2065];
B59 = [1312, 2212];
B60 = [1430, 2204];
B61 = [1236, 2209];
B62 = [1243, 2238];
B63 = [1248, 2305];
B64 = [1248, 2381];
B65 = [1243, 2447];
B66 = [1263, 2499];
B67 = [1302, 2484];
B68 = [1300, 2406];
B69 = [1298, 2333];
B70 = [1303, 2268];
B71 = [1310, 2633];
B72 = [1436, 2634];
B73 = [1519, 2635];
B74 = [1197, 2629];
B75 = [995, 2619];
B76 = [883, 2614];
B77 = [1027, 2496];
B78 = [1171, 2535];
B79 = [1227, 2536];
B80 = [1244, 2506];
B81 = [1429, 2516];
B82 = [1493, 2546];
B83 = [1068, 2253];
B84 = [1133, 2256];
B85 = [1201, 2251];
B86 = [1064, 2319];
B87 = [1132, 2320];
B88 = [1208, 2314];
B89 = [1064, 2394];
B90 = [1137, 2396];
B91 = [1211, 2389];
B92 = [1070, 2460];
B93 = [1139, 2458];
B94 = [1208, 2454];
B95 = [1381, 2472];
B96 = [1378, 2413];
B97 = [1374, 2334];
B98 = [1379, 2274];
B99 = [1456, 2269];
B100 = [1464, 2334];
B101 = [1468, 2409];
B102 = [1460, 2474];
B103 = [1033, 2054];
B104 = [1023, 1818];
B105 = [1454, 2061];
B106 = [1453, 1832];
B107 = [783, 1901];
B108 = [850, 1940];
B109 = [778, 2018];
B110 = [729, 2016];
B111 = [548, 735];
B112 = [1031, 760];
B113 = [1035, 1227];
B114 = [552, 1208];
B115 = [301, 705];
B116 = [1441, 1705];
B117 = [1903, 1222];
B118 = [1984, 964];
B119 = [1522, 1688];
B120 = [1542, 1863];
B121 = [1549, 1973];
B122 = [1517, 1744];
B123 = [1094, 2200];
B124 = [892, 1804];
B125 = [1678, 1709];
B126 = [1698, 2084];
B127 = [684, 2038];
B128 = [707, 2063];
B129 = [743, 2041];
B130 = [661, 2097];
B131 = [681, 2119];
B132 = [1333, 2483];
B133 = [1305, 2457];

// Polygons
C1 = [B2, B13, B14, B3];
C2 = [B2, A75, A1, B3];
C3 = [A1, A2, B1];
C4 = [B1, B4, B3, A1];
C5 = [B1, A2, A3, B25];
C6 = [A3, A5, A4];
C7 = [A3, B25, B26, A5];
C8 = [B25, B5, B6, B26];
C9 = [B25, B1, B4, B5];
C10 = [B3, B4, B15, B14];
C11 = [B4, B5, B16, B15];
C12 = [B5, B6, B17, B16];
C13 = [B6, B35, B7, B18, B17];
C14 = [B18, B19, B8, B7];
C15 = [B20, B9, B8, B19];
C16 = [B20, B9, B10, B21];
C17 = [B22, B21, B10, A63];
C18 = [A63, A64, A65, A66, B23, B22];
C19 = [A66, A67, A68, B24, B23];
C20 = [A68, B2, B13, B24];
C27 = [A63, A62, B10];
C28 = [B10, B9, B39, B56, B55, B54, A61, A62];
C29 = [B9, B8, B38, B39];
C30 = [B8, B7, B43, B117, B38];
C32 = [B26, B117, B43, B7, B35, B6];
C37 = [B26, A5, A6, B117];
C42 = [B117, B44, A6, A7, B38];
C43 = [B39, B38, A7, A8, B46, B45, B119, B116];
C44 = [B56, B57, B58, B59, B60, B105, B106, B116, B39];
C45 = [B116, B106, B105, B60, A21, A20, A19, B121, B120, B122, B119];
C46 = [B56, B57, B58, B59, B61, B123, B103, B104, B55];
C47 = [B55, B104, B103, B123, A46, A47, A48, A49, B124, B54];
C48 = [B122, B47, B48, B125, A8, B46, B45, B119];
C49 = [B122, B120, B49, B50, A9, B125, B48, B47];
C50 = [B120, B121, B51, B52, A10, A9, B50, B49];
C51 = [A19, A18, B126, A12, A11, A10, B52, B51, B121];
C52 = [B126, A15, A16, A17, A18];
C53 = [B126, A15, A14, A13, A12];
C54 = [A61, B54, B124, B53, A60];
C55 = [A59, B107, B108, A49, B124, B53, A60];
C56 = [A59, A58, B110, B109, A50, A49];
C57 = [A58, A57, A56, A55, B130, B127, B110];
C58 = [A55, B130, B127, B110, B109, B129, B128, B131, A54];
C59 = [A54, A53, A52, A51, A50, B109, B129, B128, B131];
C60 = [A46, B123, B61, B62, B85, B84, B83, A45];
C61 = [A45, A44, B86, B87, B88, B63, B62, B85, B84, B83];
C62 = [A44, A43, B89, B90, B91, B64, B63, B88, B87, B86];
C63 = [A43, A42, B92, B93, B94, B65, B64, B91, B90, B89];
C64 = [A42, A41, B78, B79, B80, B66, B65, B94, B93, B92];
C65 = [B59, B60, A21, A22, B99, B98, B70];
C66 = [B70, B69, B97, B100, A23, A22, B99, B98];
C67 = [B69, B68, B96, B101, A24, A23, B100, B97];
C68 = [B68, B96, B101, A24, A25, B102, B95, B67, B133];
C69 = [B67, B95, B102, A25, A26, B82, B81, B132];
C70 = [A40, B77, B78, A41];
C71 = [A39, A38, A37, A36, A35, B75, B77, A40];
C72 = [A35, A34, A33, B74, B79, B78, B77, B75];
C73 = [A32, A31, A30, B72, B81, B132, B66, B80, B79, B74, A33];
C74 = [B81, B82, A26, A27, A28, A29, A30, B72];
C75 = [B61, B59, B70, B69, B68, B133, B67, B66, B65, B64, B63, B62, B61];
C76 = [B13, B14, B15, B16, B17, B18, B19, B20, B21, B22, B23, B24];

cut_polygons_filled = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C27, C28, C29, C30, C32, C37, C42, C43, C44, C45, C46, C47, C48, C49, /*C50,*/ C51, C52, C53, C54, /*C55,*/ C56, C57, C58, C59, C60, /*C61,*/ C62, /*C63,*/ C64, C65, /*C66,*/ C67, /*C68,*/ C69, /*C70, C71,*/ C72, /*C73,*/ C74, C75];
cut_polygons_hollow_visor = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C27, C28, C29, C30, C32, C37, C42, C43, C44, C45, C46, C47, C48, C49, /*C50,*/ C51, C52, C53, C54, /*C55,*/ C56, C57, C58, C59, C60, /*C61,*/ C62, /*C63,*/ C64, C65, /*C66,*/ C67, /*C68,*/ C69, /*C70, C71,*/ C72, /*C73,*/ C74, C75, C76];

min_x = A65[0];
min_y = A2[1];
max_x = A6[0];
max_y = A31[1];

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
                    create();
                }
            }
        } else {
            create();
        }
    }
} else {
    resize(newsize=[y_factor * x_size, max_size, model_height]){
        if(flip_model == "yes") {
            mirror([0,1,0]) {
                rotate([180,180,0]) {    
                    create();
                }
            }
        } else {
            create();
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
            if(hollow_visor == "no") {
                for(cut_polygon = [0:len(cut_polygons_filled)]) {
                    offset(r = +inline_edge_radius) {
                        offset(r = -inline_size - inline_edge_radius) {
                            polygon(points = cut_polygons_filled[cut_polygon], convexity = 10);
                        }
                    }
                }
            } else {
                for(cut_polygon = [0:len(cut_polygons_hollow_visor)]) {
                    offset(r = +inline_edge_radius) {
                        offset(r = -inline_size - inline_edge_radius) {
                            polygon(points = cut_polygons_hollow_visor[cut_polygon], convexity = 10);
                        }
                    }
                }   
            }
        }
    }
}
