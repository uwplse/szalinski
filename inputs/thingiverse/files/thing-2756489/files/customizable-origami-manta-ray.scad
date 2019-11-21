/*
 * Customizable Origami - Manta Ray - https://www.thingiverse.com/thing:2756489
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2018-01-14
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
inline_edge_radius_in_millimeter = 0.7; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [110, 766];
A2 = [323, 599];
A3 = [528, 477];
A4 = [692, 416];
A5 = [779, 314];
A6 = [782, 260];
A7 = [821, 172];
A8 = [874, 115];
A9 = [862, 198];
A10 = [858, 243];
A11 = [908, 292];
A12 = [997, 289];
A13 = [1094, 298];
A14 = [1148, 249];
A15 = [1151, 191];
A16 = [1134, 108];
A17 = [1202, 182];
A18 = [1204, 240];
A19 = [1229, 268];
A20 = [1225, 324];
A21 = [1313, 416];
A22 = [1466, 494];
A23 = [1687, 628];
A24 = [1893, 787];
A25 = [1661, 751];
A26 = [1504, 772];
A27 = [1283, 908];
A28 = [1132, 1034];
A29 = [1019, 1079];
A30 = [979, 1472];
A31 = [955, 1083];
A32 = [847, 1039];
A33 = [707, 906];
A34 = [493, 750];
A35 = [348, 731];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35];

// Inner Points
B1 = [954, 472];
B2 = [1052, 469];
B3 = [1001, 474];
B4 = [948, 626];
B5 = [997, 642];
B6 = [1052, 625];
B7 = [1222, 629];
B8 = [1259, 565];
B9 = [1324, 503];
B10 = [656, 495];
B11 = [735, 560];
B12 = [769, 622];
B13 = [987, 1086];
B14 = [776, 441];
B15 = [1224, 445];
B16 = [840, 530];
B17 = [942, 544];
B18 = [1048, 543];
B19 = [1161, 536];

// Polygons
C1 = [A8, A7, A6, A10, A9];
C2 = [A16, A17, A18, A14, A15];
C3 = [A6, A10, A11, B1];
C4 = [A14, A18, A19, B2, A13];
C5 = [A11, A12, B3, B1];
C6 = [A12, A13, B2, B3];
C7 = [B2, A19, A20, A21, B15];
C8 = [A6, B1, B14, A4, A5];
C9 = [A4, A3, B10, B14];
C10 = [A1, A2, A3, B10, A35];
C11 = [A35, B10, A34];
C12 = [A34, B10, B11];
C13 = [A34, B11, B12];
C14 = [B10, B1, B17, B16, B11];
C15 = [B3, B17, B4, B5];
C16 = [B3, B18, B6, B5];
C17 = [B18, B2, B9, B8, B19];
C18 = [B15, B9, A22, A21];
C19 = [A22, A23, A24, A25, B9];
C20 = [B9, A26, A25];
C21 = [B9, A26, B8];
C22 = [B8, B7, A26];
C23 = [B7, A27, A26];
C24 = [B7, A28, A27];
C25 = [A28, B6, B7];
C26 = [B6, B18, B19, B8, B7];
C27 = [B17, B16, B11, B12, B4];
C28 = [B12, A34, A33];
C29 = [B12, A32, A33];
C30 = [B12, A32, B4];
C31 = [B4, A32, A31];
C32 = [B6, A29, A28];
C33 = [B13, B4, B5];
C34 = [B5, B6, B13];
C35 = [A30, A31, B13, A29];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, C26, C27, C28, C29, C30, C31, C32, C33, C34, C35];

min_x = A1[0];
min_y = A16[1];
max_x = A24[0];
max_y = A30[1];

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
