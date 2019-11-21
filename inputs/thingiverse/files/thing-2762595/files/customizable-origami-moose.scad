/*
 * Customizable Origami - Moose - https://www.thingiverse.com/thing:2762595
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2018-01-19
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
inline_edge_radius_in_millimeter = 1.3; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [191, 989];
A2 = [158, 901];
A3 = [159, 841];
A4 = [357, 586];
A5 = [379, 561];
A6 = [276, 491];
A7 = [203, 413];
A8 = [164, 296];
A9 = [226, 395];
A10 = [300, 467];
A11 = [411, 523];
A12 = [461, 464];
A13 = [480, 466];
A14 = [478, 414];
A15 = [406, 292];
A16 = [393, 192];
A17 = [420, 288];
A18 = [496, 395];
A19 = [537, 410];
A20 = [571, 364];
A21 = [581, 276];
A22 = [550, 208];
A23 = [547, 144];
A24 = [566, 211];
A25 = [604, 265];
A26 = [612, 304];
A27 = [636, 300];
A28 = [682, 244];
A29 = [691, 221];
A30 = [677, 67];
A31 = [710, 159];
A32 = [712, 203];
A33 = [747, 217];
A34 = [774, 210];
A35 = [792, 178];
A36 = [801, 200];
A37 = [822, 160];
A38 = [834, 181];
A39 = [866, 143];
A40 = [885, 96];
A41 = [886, 56];
A42 = [903, 101];
A43 = [879, 170];
A44 = [828, 248];
A45 = [724, 357];
A46 = [654, 437];
A47 = [1086, 348];
A48 = [1427, 462];
A49 = [1982, 442];
A50 = [2219, 591];
A51 = [2269, 647];
A52 = [2292, 751];
A53 = [2271, 817];
A54 = [2255, 808];
A55 = [2241, 754];
A56 = [2248, 830];
A57 = [2151, 1037];
A58 = [2208, 1376];
A59 = [2104, 1787];
A60 = [2073, 1795];
A61 = [2048, 1779];
A62 = [2076, 1422];
A63 = [1842, 1058];
A64 = [1570, 1118];
A65 = [1132, 1105];
A66 = [1093, 1779];
A67 = [1065, 1795];
A68 = [1042, 1779];
A69 = [1027, 1471];
A70 = [941, 1080];
A71 = [764, 890];
A72 = [640, 904];
A73 = [555, 1044];
A74 = [514, 1055];
A75 = [467, 938];
A76 = [413, 918];
A77 = [357, 922];
A78 = [288, 995];
A79 = [249, 993];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38, A39, A40, A41, A42, A43, A44, A45, A46, A47, A48, A49, A50, A51, A52, A53, A54, A55, A56, A57, A58, A59, A60, A61, A62, A63, A64, A65, A66, A67, A68, A69, A70, A71, A72, A73, A74, A75, A76, A77, A78, A79];

// Inner Points
B1 = [343, 891];
B2 = [518, 770];
B3 = [545, 803];
B4 = [580, 735];
B5 = [568, 680];
B6 = [481, 508];
B7 = [410, 579];
B8 = [494, 566];
B9 = [604, 497];
B10 = [815, 794];
B11 = [1084, 948];
B12 = [1627, 909];
B13 = [1783, 874];
B14 = [2125, 1413];

// Polygons
C1 = [A11, A12, A13, B6];
C2 = [A8, A9, A10, A11, B6, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38, A39, A40, A41, A42, A43, A44, A45, A46, B9, B8, B7, A6, A7];
C3 = [A46, B5, A4, A5, B7, B8, B9];
C4 = [A4, A3, A2, B1, B2, B5];
C5 = [A2, A1, A79, B1];
C6 = [A79, B1, A77, A78];
C7 = [B1, B2, B5, B4, B3, A77];
C8 = [A77, B3, B4, B10, A70, A71, A72, A73, A74, A75, A76];
C9 = [B4, B5, A46, A47, B10];
C10 = [A47, B11, A67, A68, A69, A70, B10];
C11 = [B11, A65, A66, A67];
C12 = [B11, B12, B13, A63, A64, A65];
C13 = [B11, A47, A48, B13, B12];
C14 = [A48, B12, B11];
C15 = [A48, B13, B12];
C16 = [A48, A49, B13];
C17 = [A49, A50, A55, A56, A57, A58, A59, A60, B14, B13];
C18 = [A50, A51, A52, A53, A54, A55];
C19 = [B13, B14, A60, A61, A62, A63];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, /*C14, C15,*/ C16, C17, C18, C19];

min_x = A2[0];
min_y = A41[1];
max_x = A52[0];
max_y = A60[1];

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
