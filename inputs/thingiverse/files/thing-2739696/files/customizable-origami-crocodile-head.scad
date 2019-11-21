/*
 * Customizable Origami - Crocodile Head - https://www.thingiverse.com/thing:2739696
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-12-31
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
inline_edge_radius_in_millimeter = 0.3; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [119, 595];
A2 = [189, 512];
A3 = [240, 489];
A4 = [512, 458];
A5 = [808, 391];
A6 = [1086, 179];
A7 = [1322, 271];
A8 = [1559, 276];
A12 = [1746, 392];
A13 = [1810, 663];
A15 = [1346, 1087];
A16 = [1085, 1066];
A18 = [990, 1068];
A19 = [417, 932];
A20 = [270, 812];
A21 = [289, 776];
A22 = [240, 696];
A23 = [241, 750];
A24 = [202, 699];
A25 = [205, 762];
A26 = [164, 691];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A12, A13, A15, A16, A18, A19, A20, A21, A22, A23, A24, A25, A26];

// Inner Points
B1 = [543, 557];
B2 = [796, 510];
B3 = [932, 330];
B4 = [1077, 318];
B5 = [1086, 242];
B6 = [1254, 324];
B7 = [1088, 386];
B8 = [1445, 506];
B9 = [952, 612];
B10 = [1046, 688];
B11 = [982, 823];
B12 = [860, 828];
B13 = [844, 766];
B14 = [788, 834];
B15 = [748, 833];
B16 = [726, 766];
B17 = [667, 835];
B18 = [611, 837];
B19 = [572, 752];
B20 = [521, 841];
B21 = [460, 845];
B22 = [420, 758];
B23 = [365, 851];
B24 = [310, 810];
B25 = [336, 679];
B26 = [407, 759];
B27 = [425, 650];
B28 = [449, 648];
B29 = [502, 706];
B30 = [517, 620];
B31 = [571, 614];
B32 = [609, 673];
B33 = [653, 612];
B34 = [702, 611];
B35 = [738, 711];
B36 = [794, 606];

// Polygons
C1 = [A1, A2, A22];
C2 = [A1, A22, A24, A26];
C5 = [A2, B1, A22];
C6 = [A22, B1, B36, B34, B33, B31, B30, B28, B27, B25];
C7 = [A2, A3, A4];
C8 = [A2, B1, A4];
C9 = [A4, A5, B1];
C10 = [B1, B2, A5];
C11 = [A5, A6, B5, B3, B2];
C12 = [B3, B7, B2];
C13 = [B3, B5, B4];
C14 = [B5, B6, B4];
C15 = [B3, B4, B7];
C16 = [B4, B6, B7];
C17 = [A6, B6, B5];
C18 = [A6, A7, B6];
C19 = [A7, A8, B6];
C20 = [B6, B8, A12];
C21 = [B6, A8, A12];
C22 = [B8, A12, A13];
C23 = [B8, A15, A13];
C24 = [B8, A15, A16];
C27 = [A19, A16, A18];
C28 = [A20, B23, A16, A18, A19];
C29 = [B2, B7, B6, B8];
C30 = [B2, B9, B8];
C31 = [B2, B9, B36, B1];
C32 = [B9, B8, B11, B10];
C33 = [B8, A16, B11];
C34 = [B23, B21, B20, B18, B17, B15, B14, B12, B11, A16];
C45 = [B24, B25, B26, B27, B28, B29, B30, B31, B32, B33, B34, B35, B36, B9, B10, B11, B12, B13, B14, B15, B16, B17, B18, B19, B20, B21, B22, B23];

cut_polygons = [C1, C2, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C27, C28, C29, C30, C31, C32, C33, C34, C45];

min_x = A1[0];
min_y = A6[1];
max_x = A13[0];
max_y = A15[1];

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
