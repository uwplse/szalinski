/*
 * Customizable Origami - Octopus - https://www.thingiverse.com/thing:2756117
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2018-01-13
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
outline_size_in_millimeter = 1.9; //[0.5:0.1:20]

// Thickness of the inner outline.
inline_size_in_millimeter = 0.8; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 1.3; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [319, 1563];
A2 = [355, 1568];
A3 = [390, 1544];
A4 = [405, 1453];
A5 = [435, 1386];
A6 = [462, 1341];
A7 = [509, 1248];
A8 = [537, 1117];
A9 = [471, 1142];
A10 = [411, 1178];
A11 = [331, 1197];
A12 = [259, 1171];
A13 = [229, 1151];
A14 = [236, 1135];
A15 = [324, 1171];
A16 = [427, 1080];
A17 = [493, 1046];
A18 = [537, 996];
A19 = [481, 975];
A20 = [436, 939];
A21 = [425, 965];
A22 = [393, 934];
A23 = [431, 890];
A24 = [468, 896];
A25 = [499, 939];
A26 = [565, 927];
A27 = [572, 898];
A28 = [557, 882];
A29 = [500, 826];
A30 = [489, 779];
A31 = [502, 776];
A32 = [512, 801];
A33 = [526, 804];
A34 = [527, 791];
A35 = [546, 775];
A36 = [547, 727];
A37 = [492, 601];
A38 = [454, 481];
A39 = [451, 451];
A40 = [600, 299];
A41 = [811, 297];
A42 = [880, 367];
A43 = [916, 446];
A44 = [934, 528];
A45 = [831, 675];
A46 = [831, 760];
A47 = [841, 774];
A48 = [936, 764];
A49 = [1039, 706];
A50 = [1085, 697];
A51 = [1172, 729];
A52 = [1201, 691];
A53 = [1200, 660];
A54 = [1239, 591];
A55 = [1218, 725];
A56 = [1184, 750];
A57 = [1144, 755];
A58 = [1088, 731];
A59 = [942, 865];
A60 = [936, 905];
A61 = [1026, 949];
A62 = [1136, 946];
A63 = [1186, 964];
A64 = [1221, 992];
A65 = [1242, 1046];
A66 = [1244, 1113];
A67 = [1261, 1131];
A68 = [1311, 1149];
A69 = [1302, 1156];
A70 = [1249, 1147];
A71 = [1236, 1140];
A72 = [1216, 1110];
A73 = [1206, 1076];
A74 = [1209, 1037];
A75 = [1198, 1008];
A76 = [1162, 994];
A77 = [1114, 996];
A78 = [1071, 1001];
A79 = [1031, 1017];
A80 = [985, 1094];
A81 = [962, 1161];
A82 = [1058, 1256];
A83 = [1113, 1344];
A84 = [1141, 1363];
A85 = [1209, 1359];
A86 = [1240, 1374];
A87 = [1284, 1406];
A88 = [1303, 1466];
A89 = [1292, 1476];
A90 = [1286, 1459];
A91 = [1264, 1427];
A92 = [1224, 1394];
A93 = [1161, 1391];
A94 = [1104, 1379];
A95 = [1008, 1302];
A96 = [913, 1217];
A97 = [864, 1229];
A98 = [811, 1318];
A99 = [871, 1450];
A100 = [954, 1671];
A101 = [961, 1717];
A102 = [952, 1775];
A103 = [916, 1861];
A104 = [928, 1776];
A105 = [926, 1691];
A106 = [898, 1641];
A107 = [856, 1586];
A108 = [732, 1346];
A109 = [663, 1304];
A110 = [573, 1311];
A111 = [509, 1401];
A112 = [489, 1415];
A113 = [434, 1537];
A114 = [416, 1566];
A115 = [374, 1594];
A116 = [339, 1587];
A117 = [324, 1576];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38, A39, A40, A41, A42, A43, A44, A45, A46, A47, A48, A49, A50, A51, A52, A53, A54, A55, A56, A57, A58, A59, A60, A61, A62, A63, A64, A65, A66, A67, A68, A69, A70, A71, A72, A73, A74, A75, A76, A77, A78, A79, A80, A81, A82, A83, A84, A85, A86, A87, A88, A89, A90, A91, A92, A93, A94, A95, A96, A97, A98, A99, A100, A101, A102, A103, A104, A105, A106, A107, A108, A109, A110, A111, A112, A113, A114, A115, A116, A117];

// Inner Points
B1 = [754, 788];
B2 = [620, 811];
B3 = [651, 994];
B4 = [804, 786];
B5 = [895, 994];
B6 = [802, 1096];
B7 = [664, 999];
B8 = [813, 1016];
B9 = [561, 963];
B10 = [759, 870];
B11 = [852, 876];
B12 = [886, 824];
B13 = [885, 795];
B14 = [841, 793];
B15 = [674, 1118];
B16 = [704, 1241];
B17 = [792, 1196];
B18 = [991, 1015];
B19 = [596, 409];
B20 = [812, 611];
B21 = [808, 491];
B22 = [816, 416];
B23 = [815, 361];
B24 = [686, 303];
B25 = [536, 371];
B26 = [549, 606];
B27 = [601, 612];
B28 = [686, 614];
B29 = [691, 806];
B30 = [571, 797];
B31 = [904, 883];
B32 = [629, 993];

// Polygons
C1 = [B19, B25, A40];
C2 = [B19, A40, B24];
C3 = [B19, B24, A41];
C4 = [B19, A41, B23];
C5 = [B19, B23, B22];
C6 = [B19, B22, B21];
C7 = [B19, B21, B20];
C8 = [B19, B20, B28];
C9 = [B19, B28, B27];
C10 = [B19, B27, B26];
C11 = [B19, B26, A37];
C12 = [A37, B19, A38];
C13 = [B25, B19, A38, A39];
C14 = [A41, A42, B23];
C15 = [B23, A42, A43, A44, B22];
C16 = [B22, A44, A45, A46, B4, B20, B21];
C17 = [B28, B1, B4, B20];
C18 = [B27, B28, B1, B29, B2];
C19 = [B27, B2, B30, A35, A36, A37, B26];
C20 = [B3, B2, B29, B1, B4, B10];
C21 = [B2, B3, A27, A28, A35, B30];
C22 = [A35, A28, A33, A34];
C23 = [A28, A29, A30, A31, A32, A33];
C24 = [B10, B11, B12, B13, B14, A47, A46, B4];
C25 = [B10, B11, B8, B7, B3];
C26 = [B9, A26, A27, B3];
C27 = [A47, B14, B13, B12, B11, B31, A59, A58, A57, A56, A55, A54, A53, A52, A51, A50, A49, A48];
C28 = [B31, A59, A60];
C29 = [B5, B18, A79, A80, A81];
C30 = [A96, B6, B17, A98, A97];
C31 = [A108, B16, B15, B7, B3, B32, A110, A109];
C32 = [B11, B5, B18, A79, A78, A77, A76, A75, A74, A73, A72, A71, A70, A69, A68, A67, A66, A65, A64, A63, A62, A61, A60, B31];
C33 = [B11, B5, A81, A82, A83, A84, A85, A86, A87, A88, A89, A90, A91, A92, A93, A94, A95, A96, B6, B8];
C34 = [B8, B6, B17, A98, A99, A100, A101, A102, A103, A104, A105, A106, A107, A108, B16, B15, B7];
C35 = [B32, A110, A111, A112, A113, A114, A115, A116, A117, A1, A2, A3, A4, A5, A6, A7, A8, B9];
C36 = [A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, B9];
C37 = [A18, B9, A26, A25, A24, A23, A22, A21, A20, A19];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, C26, C27, C28, C29, C30, C31, C32, C33, C34, C35, C36, C37];

min_x = A13[0];
min_y = A41[1];
max_x = A68[0];
max_y = A103[1];

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
