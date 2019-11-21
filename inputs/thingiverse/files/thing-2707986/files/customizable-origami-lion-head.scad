/*
 * Customizable Origami - Lion Head - https://www.thingiverse.com/thing:2707986
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-12-12
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
inline_edge_radius_in_millimeter = 0.1; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [418, 909];
A2 = [422, 877];
A3 = [452, 813];
A4 = [677, 592];
A5 = [871, 491];
A6 = [997, 368];
A7 = [1153, 396];
A8 = [1345, 492];
A9 = [1466, 673];
A10 = [1539, 872];
A11 = [1443, 1034];
A12 = [1250, 1098];
A13 = [1122, 1292];
A14 = [871, 1481];
A15 = [710, 1669];
A16 = [642, 1294];
A17 = [713, 1156];
A18 = [710, 1098];
A19 = [678, 1098];
A20 = [613, 1133];
A21 = [548, 1132];
A22 = [521, 1073];
A23 = [487, 1040];
A24 = [450, 936];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24];

// Inner Points
B1 = [452, 879];
B2 = [552, 813];
B3 = [646, 719];
B4 = [736, 688];
B5 = [678, 747];
B6 = [616, 1067];
B7 = [742, 939];
B8 = [772, 1037];
B9 = [807, 1383];
B10 = [963, 1165];
B11 = [1058, 1004];
B12 = [1155, 877];
B13 = [1285, 749];
B14 = [1251, 624];
B15 = [997, 718];
B16 = [868, 623];
B17 = [966, 558];
B18 = [1029, 528];
B19 = [1074, 557];
B20 = [1060, 618];
B21 = [1346, 593];
B22 = [1218, 492];
B23 = [1091, 419];
B24 = [963, 464];
B25 = [933, 911];
B26 = [1148, 563];

// Polygons
C1 = [A2, B1, B2, B3, A4, A3];
C2 = [A4, B16, B4, B3];
C3 = [A4, B16, A5];
C4 = [A5, A6, B24];
C5 = [A6, B23, B24];
C6 = [A6, B23, A7];
C7 = [B23, B22, A7];
C8 = [B22, A8, A7];
C9 = [A8, B21, B22];
C10 = [B21, A8, A9];
C11 = [A9, A10, B21];
C12 = [B21, A10, A11];
C13 = [B21, A11, B13];
C14 = [B13, A11, A12];
C15 = [B13, B14, B21];
C16 = [B22, B21, B14];
C17 = [B22, B23, B24];
C18 = [B26, B22, B14];
C19 = [B26, B22, B24];
C20 = [B24, B16, A5];
C21 = [B24, B17, B16];
C22 = [B24, B26, B15, B20, B19, B18, B17];
C23 = [B15, B20, B19, B18, B17, B16];
C24 = [B15, B26, B14];
C25 = [B14, B12, B13];
C26 = [B14, B12, B15];
C27 = [B13, A12, B12];
C28 = [A15, A16, A17, B8];
C29 = [A15, B8, B9];
C30 = [A15, B9, A14];
C31 = [B9, B10, A14];
C32 = [B10, A13, A14];
C33 = [B10, A13, B11];
C34 = [B11, A13, A12];
C35 = [B11, B12, A12];
C36 = [B15, B11, B12];
C37 = [B15, B25, B11];
C38 = [B25, B10, B11];
C39 = [B25, B9, B10];
C40 = [B8, B9, B25];
C41 = [B7, B8, B25];
C42 = [B7, B6, B8];
C43 = [A18, A17, B8];
C44 = [A18, A19, A20, A21, A22, B6, B8];
C45 = [A23, A24, B1, B2, B3, B5, B7, B6];
C46 = [B5, B4, B16, B7];
C47 = [B16, B25, B7];
C48 = [B16, B25, B15];
C49 = [B3, B5, B4];
C50 = [A2, A1, A24, B1];
C51 = [A23, B6, A22];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, C26, C27, C28, C29, C30, C31, C32, C33, C34, C35, C36, C37, C38, C39, C40, C41, C42, C43, C44, C45, C46, C47, C48, /*C49, C50, C51*/];

min_x = A1[0];
min_y = A6[1];
max_x = A10[0];
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
