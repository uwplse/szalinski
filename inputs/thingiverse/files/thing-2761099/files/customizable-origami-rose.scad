/*
 * Customizable Origami - Rose - https://www.thingiverse.com/thing:2761099
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2018-01-18
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
outline_size_in_millimeter = 2.0; //[0.5:0.1:20]

// Thickness of the inner outline.
inline_size_in_millimeter = 0.8; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 0.4; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [386, 554];
A2 = [752, 196];
A3 = [1117, 269];
A4 = [1373, 152];
A5 = [1490, 413];
A6 = [1702, 416];
A7 = [1780, 751];
A8 = [1700, 905];
A9 = [1706, 1003];
A10 = [1825, 1186];
A11 = [1619, 1352];
A12 = [1642, 1587];
A13 = [1199, 1653];
A14 = [982, 1845];
A15 = [676, 1526];
A16 = [458, 1491];
A17 = [508, 1351];
A18 = [173, 1143];
A19 = [344, 913];
A20 = [360, 749];
A21 = [510, 666];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21];

// Inner Points
B1 = [748, 527];
B2 = [631, 774];
B3 = [699, 641];
B4 = [850, 563];
B5 = [797, 556];
B6 = [832, 486];
B7 = [954, 502];
B8 = [1084, 434];
B9 = [1304, 306];
B10 = [1268, 374];
B11 = [1188, 523];
B12 = [1217, 552];
B13 = [1342, 458];
B14 = [1396, 592];
B15 = [1378, 661];
B16 = [1340, 586];
B17 = [1410, 551];
B18 = [1703, 669];
B19 = [1595, 948];
B20 = [1394, 941];
B21 = [1463, 995];
B22 = [1469, 835];
B23 = [1508, 1266];
B24 = [1495, 1485];
B25 = [1342, 1525];
B26 = [570, 1403];
B27 = [541, 1273];
B28 = [324, 1099];
B29 = [569, 997];
B30 = [863, 652];
B31 = [962, 638];
B32 = [1389, 744];
B33 = [1244, 831];
B34 = [1222, 1153];
B35 = [920, 778];
B36 = [855, 833];
B37 = [963, 835];
B38 = [1161, 888];
B39 = [1156, 967];
B40 = [1062, 1084];
B41 = [1034, 1060];
B42 = [904, 1051];
B43 = [873, 917];
B44 = [900, 929];
B45 = [800, 887];
B46 = [753, 923];
B47 = [1000, 1181];
B48 = [874, 1182];
B49 = [835, 1240];
B50 = [1000, 1266];
B51 = [852, 1297];
B52 = [1188, 1317];
B53 = [1305, 1159];
B54 = [1702, 1094];
B55 = [1602, 1285];
B56 = [1105, 948];
B57 = [979, 1008];
B58 = [1064, 1002];
B59 = [938, 967];
B60 = [978, 890];
B61 = [739, 554];
B62 = [1265, 594];
B63 = [1341, 1404];
B64 = [1215, 1098];
B65 = [789, 1079];
B66 = [972, 1159];

// Polygons
C1 = [A1, A2, A3, B9, B10, B11, B8, B7, B6, B5, B61, B1, A21];
C2 = [B6, B7, B4, B5];
C3 = [B61, B5, B4, B3];
C4 = [B1, B61, B3, B2, A21];
C5 = [A3, A4, A5, B10, B9];
C6 = [B11, B10, A5, A6, A7, A8, B23, B53, B21, B19, B18, B17, B14, B13, B12];
C7 = [B12, B13, B14, B15, B16, B62];
C8 = [B15, B14, B17, B18, B19, B20, B22];
C9 = [B19, B21, B20];
C10 = [A8, A9, B54, B55, B24, B63, B52, B53, B23];
C11 = [A9, A10, A11, B55, B54];
C12 = [B55, A11, A12, A13, B25, B63, B24];
C13 = [B63, B25, A13, A14, A15, B26, B51, B52];
C14 = [B27, B51, B26];
C15 = [B27, B26, A15, A16, A17];
C16 = [A17, A18, A19, B28, B27];
C17 = [A20, A21, B2, B29, B65, B49, B50, B64, B34, B20, B21, B53, B52, B51, B27, B28, A19];
C18 = [B29, B2, B3, B4, B7, B8, B31, B30, B36, B45, B46, B65];
C19 = [B8, B11, B12, B62, B31];
C20 = [B62, B16, B15, B22, B20, B34, B32, B30, B31];
C21 = [B32, B34, B64, B33, B30];
C22 = [B30, B33, B37, B35, B36];
C23 = [B46, B66, B48];
C24 = [B46, B48, B66, B47, B64, B50, B49, B65];
C25 = [B46, B66, B47, B64, B33, B37, B38, B39, B40, B42, B43, B45];
C26 = [B45, B36, B35, B37, B60, B44, B43];
C27 = [B60, B59, B44];
C28 = [B43, B44, B59, B57, B41, B40, B42];
C29 = [B41, B58, B56, B39, B40];
C30 = [B38, B37, B60, B56, B39];
C31 = [B60, B58, B59];
C32 = [B59, B58, B41, B57];
C33 = [B60, B56, B58];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, C26, C27, C28, C29, C30, C31, C32, C33];

min_x = A18[0];
min_y = A4[1];
max_x = A10[0];
max_y = A14[1];

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
