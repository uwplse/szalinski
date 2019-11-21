/*
 * Customizable Origami - Christmas Star No2 - https://www.thingiverse.com/thing:2648532
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-11-15
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
outline_size_in_millimeter = 1.8; //[0.5:0.1:20]

// Thickness of the inner outline.
inline_size_in_millimeter = 0.7; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 0.4; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [112, 527];
A2 = [426, 489];
A3 = [346, 190];
A4 = [615, 355];
A5 = [752, 47];
A6 = [889, 347];
A7 = [1162, 180];
A8 = [1084, 479];
A9 = [1411, 525];
A10 = [1159, 733];
A11 = [1412, 959];
A12 = [1092, 979];
A13 = [1160, 1285];
A14 = [887, 1116];
A15 = [750, 1444];
A16 = [632, 1105];
A17 = [357, 1280];
A18 = [425, 978];
A19 = [86, 975];
A20 = [363, 752];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20];

// Inner Points
B1 = [268, 909];
B2 = [411, 786];
B3 = [463, 826];
B4 = [444, 910];
B5 = [683, 1073];
B6 = [753, 1025];
B7 = [819, 1069];
B8 = [748, 1254];
B9 = [1233, 900];
B10 = [1046, 327];
B11 = [450, 341];
B12 = [589, 410];
B13 = [488, 480];
B14 = [911, 409];
B15 = [1014, 474];
B16 = [1106, 778];
B17 = [1073, 904];
B18 = [1050, 820];
B19 = [933, 462];
B20 = [559, 475];
B21 = [278, 572];
B22 = [462, 620];
B23 = [755, 219];
B24 = [752, 400];
B25 = [1046, 620];
B26 = [1231, 572];
B27 = [930, 959];
B28 = [1043, 1117];
B29 = [572, 964];
B30 = [463, 1124];
B31 = [621, 750];
B32 = [666, 595];
B33 = [831, 588];
B34 = [886, 746];
B35 = [753, 842];
B36 = [748, 916];
B37 = [544, 777];
B38 = [618, 528];
B39 = [876, 525];
B40 = [956, 775];
B41 = [754, 700];

// Polygons
C1 = [A2, A3, A4, B12, B11, B13];
C2 = [B11, B12, B20, B13];
C3 = [A6, A7, A8, B15, B10, B14];
C4 = [B10, B15, B19, B14];
C5 = [A10, A11, A12, B17, B9, B16];
C6 = [B16, B9, B17, B18];
C7 = [A14, A15, A16, B5, B8, B7];
C8 = [B7, B8, B5, B6];
C9 = [A18, A19, A20, B2, B1, B4];
C10 = [B2, B1, B4, B3];
C11 = [A2, B13, B20, B12, A4, A5, B23, B38, B21, A1];
C12 = [A5, B23, B39, B26, A9, A8, B15, B19, B14, A6];
C13 = [A9, A10, B16, B18, B17, A12, A13, B28, B40, B26];
C14 = [A13, A14, B7, B6, B5, A16, A17, B30, B36, B28];
C15 = [B30, B37, B21, A1, A20, B2, B3, B4, A18, A17];
C16 = [B21, B22, B32, B24, B23, B38];
C17 = [B23, B39, B26, B25, B33, B24];
C18 = [B26, B25, B34, B27, B28, B40];
C19 = [B28, B36, B30, B29, B35, B27];
C20 = [B29, B31, B22, B21, B37, B30];
C21 = [B22, B41, B29, B31];
C22 = [B24, B41, B22, B32];
C23 = [B24, B33, B25, B41];
C24 = [B25, B34, B27, B41];
C25 = [B35, B29, B41, B27];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25];

min_x = A19[0];
min_y = A5[1];
max_x = A11[0];
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
