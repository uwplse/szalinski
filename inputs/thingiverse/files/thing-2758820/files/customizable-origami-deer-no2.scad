/*
 * Customizable Origami - Deeer no. 2 - https://www.thingiverse.com/thing:2758820
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2018-01-16
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
outline_size_in_millimeter = 1.5; //[0.5:0.1:20]

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
A1 = [69, 385];
A2 = [127, 229];
A3 = [213, 148];
A4 = [174, 251];
A5 = [127, 409];
A6 = [120, 464];
A7 = [188, 606];
A8 = [262, 529];
A9 = [374, 440];
A10 = [288, 546];
A11 = [231, 633];
A12 = [222, 658];
A13 = [239, 694];
A14 = [257, 694];
A15 = [485, 579];
A16 = [461, 397];
A17 = [403, 153];
A18 = [616, 17];
A19 = [453, 164];
A20 = [499, 296];
A21 = [517, 304];
A22 = [643, 257];
A23 = [710, 175];
A24 = [724, 182];
A25 = [664, 276];
A26 = [536, 340];
A27 = [518, 380];
A28 = [540, 549];
A29 = [564, 567];
A30 = [677, 549];
A31 = [677, 566];
A32 = [573, 603];
A33 = [325, 733];
A34 = [443, 889];
A35 = [477, 960];
A36 = [531, 999];
A37 = [826, 1008];
A38 = [931, 1068];
A39 = [1039, 1071];
A40 = [1133, 1079];
A41 = [1132, 1219];
A42 = [1102, 1381];
A43 = [1168, 1576];
A44 = [1136, 1817];
A45 = [1153, 1893];
A46 = [1134, 1901];
A47 = [1101, 1900];
A48 = [1116, 1823];
A49 = [1110, 1594];
A50 = [953, 1408];
A51 = [962, 1362];
A52 = [931, 1379];
A53 = [996, 1624];
A54 = [882, 1824];
A55 = [905, 1900];
A56 = [873, 1905];
A57 = [853, 1901];
A58 = [863, 1818];
A59 = [939, 1628];
A60 = [818, 1444];
A61 = [779, 1468];
A62 = [617, 1638];
A63 = [593, 1788];
A64 = [701, 1827];
A65 = [688, 1868];
A66 = [565, 1803];
A67 = [557, 1767];
A68 = [569, 1948];
A69 = [543, 1957];
A70 = [517, 1953];
A71 = [527, 1812];
A72 = [479, 1642];
A73 = [410, 1432];
A74 = [379, 1427];
A75 = [264, 1213];
A76 = [187, 963];
A77 = [86, 963];
A78 = [69, 964];
A79 = [60, 932];
A80 = [81, 900];
A81 = [103, 852];
A82 = [190, 732];
A83 = [151, 621];
A84 = [80, 479];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38, A39, /*A40,*/ A41, A42, A43, A44, A45, A46, A47, A48, A49, A50, A51, A52, A53, A54, A55, A56, A57, A58, A59, A60, A61, A62, A63, A64, A65, A66, A67, A68, A69, A70, A71, A72, A73, A74, A75, A76, A77, A78, A79, A80, A81, A82, A83, A84];

// Inner Points
B1 = [260, 724];
B2 = [186, 845];
B3 = [273, 958];
B4 = [463, 292];
B5 = [156, 231];
B6 = [96, 405];
B7 = [197, 635];
B8 = [275, 539];
B9 = [222, 612];
B10 = [420, 149];
B11 = [504, 395];
B12 = [529, 569];
B13 = [475, 616];
B14 = [298, 1045];
B15 = [326, 1216];
B16 = [508, 1438];
B17 = [559, 1138];
B18 = [624, 1385];
B19 = [694, 1381];
B20 = [814, 1427];
B21 = [834, 1250];
B22 = [832, 1158];
B23 = [822, 1382];
B24 = [1003, 1306];
B25 = [1042, 1410];
B26 = [855, 1428];
B27 = [964, 1627];
B28 = [873, 1819];
B29 = [562, 1625];
B30 = [576, 1482];
B31 = [505, 1464];
B32 = [585, 1463];
B33 = [610, 1422];
B34 = [528, 1609];
B35 = [522, 1632];
B36 = [579, 1795];
B37 = [1145, 1596];
B38 = [1125, 1822];
B39 = [224, 701];
B40 = [80, 936];
B41 = [645, 1242];
B42 = [972, 1355];

// Polygons
C1 = [A84, A1, A2, A3, B5, B6];
C2 = [A3, A4, A5, A6, A84, B6, B5];
C3 = [A84, A83, A7, A6];
C4 = [A83, B7, B9, B8, A9, A8, A7];
C5 = [A9, B8, B9, B7, A11, A10];
C6 = [B7, B39, A14, A13, A12, A11];
C7 = [A83, A82, B39, B7];
C8 = [B39, B1, B13, A15, A14, A13];
C9 = [B1, A33, A32, B12, B13];
C10 = [B12, A28, A29, A32];
C11 = [A29, A30, A31, A32];
C12 = [B13, A15, A16, B11, A27, A28, B12];
C13 = [A16, B4, A20, A21, A22, A23, A24, A25, A26, A27, B11];
C14 = [B4, B10, A19, A20];
C15 = [A17, B10, B4, A16];
C16 = [B10, A18, A19];
C17 = [A79, B40, B2, B1, B39, A82, A81, A80];
C18 = [B2, B3, A76, A77, B40];
C19 = [A78, A77, B40, A79];
C20 = [B2, B1, A33, A34, B3];
C21 = [B3, A35, A34];
C22 = [B3, B14, A35];
C23 = [B14, A36, A35];
C24 = [A76, B15, B14, B3];
C25 = [B14, A36, B15];
C26 = [A75, A76, B15];
C27 = [A74, A73, B16, B15, A75];
C28 = [B15, A36, B16];
C29 = [B16, A36, B17];
C30 = [B17, B18, B33, B32, B16];
C31 = [A73, B31, B30, B32, B16];
C32 = [B31, B35, A69, A68, A67, B34, B30];
C33 = [A73, A72, B35, B31];
C34 = [A72, A71, A70, A69, B35];
C35 = [A64, A65, A66, B36, A63];
C36 = [A66, B36, B29, B34];
C37 = [B36, A63, A62, B29];
C38 = [B34, B30, B32, B33, B18, B19, B29];
C39 = [B19, B20, A60, A61, A62, B29];
C40 = [A36, B17, B18, B19, B41];
C41 = [A36, A37, B41];
C42 = [A37, B22, B21, B41];
C43 = [B41, B19, B21];
C44 = [B21, B23, B20, B19];
C45 = [A37, B42, B22];
C46 = [B22, B42, A51, B23, B21];
C47 = [A60, B20, B23, A51, A52, B26];
C48 = [B42, A37, A38, A39, B24];
C49 = [A39, A40, A41];
C50 = [A39, A41, A42, B25];
C51 = [A39, B25, A50, A51, B42, B24];
C52 = [A50, A49, B37, B25];
C53 = [B25, A42, A43, B37];
C54 = [A47, A48, B38, A46];
C55 = [A44, B38, A46, A45];
C56 = [A44, A43, B37, B38];
C57 = [A48, A49, B37, B38];
C58 = [B26, B27, A59, A60];
C59 = [B26, A52, A53, B27];
C60 = [A53, A54, B28, B27];
C61 = [A59, A58, B28, B27];
C62 = [A58, A57, A56, B28];
C63 = [A54, A55, A56, B28];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, /*C19,*/ C20, C21, C22, C23, C24, C25, C26, C27, C28, C29, C30, C31, C32, C33, C34, C35, C36, C37, C38, C39, C40, C41, C42, C43, C44, C45, C46, C47, C48, /*C49,*/ C50, C51, C52, C53, C54, C55, C56, C57, C58, C59, C60, C61, C62, C63];

min_x = A79[0];
min_y = A18[1];
max_x = A43[0];
max_y = A69[1];

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
