/*
 * Customizable Origami - Eagle - https://www.thingiverse.com/thing:2775144
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2018-01-30
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
outline_size_in_millimeter = 1.6; //[0.5:0.1:20]

// Thickness of the inner outline.
inline_size_in_millimeter = 0.8; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 0.6; //[0.0:0.1:5]

// Flip model
flip_model = "yes"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [155, 55];
A2 = [693, 234];
A3 = [763, 274];
A4 = [832, 286];
A5 = [870, 336];
A6 = [919, 366];
A7 = [954, 407];
A8 = [1017, 291];
A9 = [1136, 288];
A10 = [1147, 269];
A11 = [1264, 251];
A12 = [1340, 189];
A13 = [1369, 193];
A14 = [1525, 191];
A15 = [1566, 153];
A16 = [1582, 155];
A17 = [1602, 133];
A18 = [1654, 114];
A19 = [1673, 92];
A20 = [1696, 102];
A21 = [1602, 184];
A22 = [1582, 220];
A23 = [1553, 234];
A24 = [1507, 317];
A25 = [1334, 776];
A26 = [1328, 851];
A27 = [1371, 861];
A28 = [1415, 884];
A29 = [1526, 981];
A30 = [1545, 1029];
A31 = [1539, 1037];
A32 = [1563, 1092];
A33 = [1571, 1157];
A34 = [1555, 1146];
A35 = [1539, 1111];
A36 = [1480, 1067];
A37 = [1492, 1056];
A38 = [1402, 1025];
A39 = [1227, 1056];
A40 = [1161, 1005];
A41 = [1122, 1006];
A42 = [1152, 1093];
A43 = [1156, 1121];
A44 = [1141, 1157];
A45 = [1208, 1262];
A46 = [1210, 1275];
A47 = [1244, 1289];
A48 = [1253, 1306];
A49 = [1287, 1344];
A50 = [1280, 1348];
A51 = [1258, 1324];
A52 = [1222, 1317];
A53 = [1198, 1285];
A54 = [1182, 1312];
A55 = [1042, 1172];
A56 = [1028, 1127];
A57 = [1014, 1112];
A58 = [1010, 1072];
A59 = [998, 1127];
A60 = [982, 1155];
A61 = [965, 1170];
A62 = [1029, 1295];
A63 = [1029, 1314];
A64 = [1056, 1318];
A65 = [1095, 1384];
A66 = [1074, 1379];
A67 = [1055, 1355];
A68 = [1030, 1343];
A69 = [989, 1335];
A70 = [918, 1247];
A71 = [872, 1232];
A72 = [849, 1182];
A73 = [832, 1129];
A74 = [825, 1059];
A75 = [832, 985];
A76 = [844, 949];
A77 = [779, 933];
A78 = [672, 968];
A79 = [578, 956];
A80 = [573, 939];
A81 = [745, 842];
A82 = [814, 793];
A83 = [801, 608];
A84 = [721, 538];
A85 = [647, 486];
A86 = [537, 511];
A87 = [469, 512];
A88 = [412, 363];
A89 = [350, 378];
A90 = [285, 209];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38, A39, A40, A41, A42, A43, A44, A45, A46, A47, A48, A49, A50, A51, A52, A53, A54, A55, A56, A57, A58, A59, A60, A61, A62, A63, A64, A65, A66, A67, A68, A69, A70, A71, A72, A73, A74, A75, A76, A77, A78, A79, A80, A81, A82, A83, A84, A85, A86, A87, A88, A89, A90];

// Inner Points
B1 = [783, 882];
B2 = [849, 928];
B3 = [881, 842];
B4 = [1005, 912];
B5 = [1014, 1002];
B6 = [1048, 1005];
B7 = [1038, 1042];
B8 = [1016, 1038];
B9 = [907, 1221];
B10 = [1125, 1141];
B11 = [1358, 1007];
B12 = [1255, 831];
B13 = [1258, 805];
B14 = [1070, 560];
B15 = [1308, 250];
B16 = [1219, 280];
B17 = [1095, 746];
B18 = [985, 696];
B19 = [1084, 1209];

// Polygons
C1 = [A1, A2, A90];
C2 = [A90, A2, A3, A88, A89];
C3 = [A3, A4, A87, A88];
C4 = [A87, A4, A5, A85, A86];
C5 = [A85, A5, A6, A7, B14, B13, B12, B17, B18, A83, A84];
C6 = [A9, B16, A23, A22, B15, A11, A10];
C7 = [A11, A12, A13, A14, A21, A22, B15];
C8 = [A14, A21, A16, A15];
C9 = [A16, A17, A18, A19, A20, A21];
C10 = [A7, A24, A23, B16, A9, A8];
C11 = [A7, A24, A25, A26, B12, B13, B14];
C12 = [B12, A39, A38, B11, A28, A27, A26];
C13 = [A28, B11, A38, A37, A29];
C14 = [A36, A37, A29, A30, A31, A32, A33, A34, A35];
C15 = [B12, A39, B17];
C16 = [A39, B17, B18, B4, A40];
C17 = [B4, B5, B6, A41, A40];
C18 = [B8, B7, B6, B5];
C19 = [A41, A42, A43, B10, B19, A55, A56, A57, A58, B8, B7, B6];
C20 = [A43, A44, A45, A53, A54, B19, B10];
C21 = [A53, A45, A46, A47, A48, A49, A50, A51, A52];
C22 = [A71, B9, A61, A62, A63, A69, A70];
C23 = [A63, A64, A65, A66, A67, A68, A69];
C24 = [A79, B1, B2, A76, A77, A78];
C25 = [A80, A79, B1, A81];
C26 = [A82, B3, B2, B1, A81];
C27 = [A82, A83, B18, B4, B2, B3];
C28 = [B4, B5, B8, A58, A59, A60, A61, B9, A71, A72, A73, A74, A75, A76, B2];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, /*C21,*/ C22, /*C23,*/ C24, C25, C26, C27, C28];

min_x = A1[0];
min_y = A1[1];
max_x = A20[0];
max_y = A65[1];

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
