/*
 * Customizable Origami - Scarab - https://www.thingiverse.com/thing:2757885
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2018-01-15
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
inline_edge_radius_in_millimeter = 1.0; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [498, 57];
A2 = [551, 175];
A3 = [201, 545];
A4 = [429, 750];
A5 = [504, 683];
A6 = [444, 885];
A7 = [382, 955];
A8 = [449, 966];
A9 = [609, 788];
A10 = [652, 760];
A11 = [606, 720];
A12 = [555, 721];
A13 = [565, 652];
A14 = [575, 700];
A15 = [724, 704];
A16 = [748, 691];
A17 = [767, 703];
A18 = [919, 701];
A19 = [933, 646];
A20 = [943, 712];
A21 = [873, 723];
A22 = [844, 755];
A23 = [1049, 964];
A24 = [1121, 954];
A25 = [1054, 890];
A26 = [988, 681];
A27 = [1065, 746];
A28 = [1296, 539];
A29 = [944, 179];
A30 = [991, 54];
A31 = [972, 171];
A32 = [1344, 500];
A33 = [1346, 586];
A34 = [1134, 812];
A35 = [1268, 933];
A36 = [1221, 1067];
A37 = [1091, 1110];
A38 = [1101, 1181];
A39 = [1220, 1211];
A40 = [1319, 1311];
A41 = [1320, 1457];
A42 = [1429, 1498];
A43 = [1317, 1497];
A44 = [1278, 1457];
A45 = [1248, 1315];
A46 = [1123, 1316];
A47 = [1139, 1457];
A48 = [1138, 1612];
A49 = [1220, 1721];
A50 = [1223, 1798];
A51 = [1164, 1892];
A52 = [1257, 1930];
A53 = [1144, 1927];
A54 = [1137, 1887];
A55 = [1190, 1776];
A56 = [1129, 1717];
A57 = [1082, 1829];
A58 = [1036, 1894];
A59 = [995, 1918];
A60 = [755, 1920];
A61 = [514, 1923];
A62 = [473, 1896];
A63 = [424, 1828];
A64 = [375, 1715];
A65 = [316, 1779];
A66 = [368, 1879];
A67 = [360, 1921];
A68 = [244, 1939];
A69 = [335, 1898];
A70 = [280, 1815];
A71 = [283, 1723];
A72 = [364, 1614];
A73 = [368, 1428];
A74 = [387, 1318];
A75 = [256, 1318];
A76 = [231, 1437];
A77 = [189, 1502];
A78 = [73, 1503];
A79 = [181, 1466];
A80 = [182, 1315];
A81 = [280, 1217];
A82 = [399, 1183];
A83 = [406, 1109];
A84 = [277, 1070];
A85 = [229, 936];
A86 = [358, 813];
A87 = [152, 597];
A88 = [150, 502];
A89 = [515, 177];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38, A39, A40, A41, A42, A43, A44, A45, A46, A47, A48, A49, A50, A51, A52, A53, A54, A55, A56, A57, A58, A59, A60, A61, A62, A63, A64, A65, A66, A67, A68, A69, A70, A71, A72, A73, A74, A75, A76, A77, A78, A79, A80, A81, A82, A83, A84, A85, A86, A87, A88, A89];

// Inner Points
B1 = [731, 790];
B2 = [763, 788];
B3 = [870, 788];
B4 = [1080, 1000];
B5 = [943, 1264];
B6 = [813, 1268];
B7 = [683, 1263];
B8 = [566, 1266];
B9 = [750, 1366];
B10 = [730, 1343];
B11 = [769, 1338];
B12 = [617, 1912];
B13 = [894, 1909];
B14 = [984, 911];
B15 = [988, 1191];
B16 = [994, 1669];
B17 = [517, 1667];
B18 = [509, 1178];
B19 = [512, 907];
B20 = [750, 1263];
B21 = [751, 809];
B22 = [421, 1006];
B23 = [413, 1443];
B24 = [1090, 1432];
B25 = [743, 1671];
B26 = [761, 1670];

// Polygons
C1 = [A1, A2, A89];
C2 = [A2, A3, A88, A89];
C3 = [A88, A3, A4, A86, A87];
C4 = [A5, A6, A7, A85, A86, A4];
C5 = [A85, A84, A83, B22, A8];
C6 = [A30, A31, A29];
C7 = [A31, A32, A28, A29];
C8 = [A32, A33, A34, A27, A28];
C9 = [A26, A27, A34, A35, A24, A25];
C10 = [A35, A36, A37, B4, A23, A24];
C11 = [A19, A20, A18];
C12 = [A13, A14, A12];
C13 = [A14, A15, A11, A12];
C14 = [A18, A17, A21, A20];
C15 = [A11, A15, A10];
C16 = [A17, A22, A21];
C17 = [A15, B1, A9, A10];
C18 = [A17, B2, B3, A22];
C19 = [B21, A9, B19, B18, B8, B7, B20];
C20 = [B21, B3, B14, B15, B5, B6, B20];
C21 = [B14, A23, B4, B15];
C22 = [B19, A8, B22, B18];
C23 = [B22, B18, B17, B23, A74, A82, A83];
C24 = [B4, A37, A38, A46, B24, B16, B15];
C25 = [B18, B8, B7, B10, B25, B17];
C26 = [B6, B5, B15, B16, B26, B11];
C27 = [B6, B11, B9, B20];
C28 = [B7, B20, B9, B10];
C29 = [B10, B25, A60, B26, B11, B9];
C30 = [A38, A39, A40, A45, A46];
C31 = [A45, A40, A41, A43, A44];
C32 = [A41, A42, A43];
C33 = [A82, A81, A80, A75, A74];
C34 = [A80, A75, A76, A77, A79];
C35 = [A79, A77, A78];
C36 = [A74, B23, B17, A61, A62, A63, A64, A72, A73];
C37 = [A46, A47, A48, A56, A57, A58, A59, B16, B24];
C38 = [B17, B12, A60, B25];
C39 = [B26, A60, B13, B16];
C40 = [B16, A59, B13];
C41 = [B17, B12, A61];
C42 = [A48, A56, A55, A50, A49];
C43 = [A55, A54, A51, A50];
C44 = [A54, A51, A52, A53];
C45 = [A72, A71, A70, A65, A64];
C46 = [A70, A65, A66, A69];
C47 = [A66, A69, A68, A67];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, C26, C27, C28, C29, C30, C31, C32, C33, C34, C35, C36, C37, C38, C39, C40, C41, C42, C43, C44, C45, C46, C47];

min_x = A78[0];
min_y = A30[1];
max_x = A42[0];
max_y = A68[1];

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
