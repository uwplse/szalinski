/*
 * Customizable Origami - Christmas Tree - https://www.thingiverse.com/thing:2654198
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-11-18
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
A1 = [679, 24];
A2 = [797, 369];
A3 = [780, 368];
A4 = [756, 363];
A5 = [907, 672];
A6 = [883, 672];
A7 = [832, 672];
A8 = [1018, 969];
A9 = [981, 971];
A10 = [989, 983];
A11 = [914, 982];
A12 = [1126, 1265];
A13 = [1068, 1267];
A14 = [1090, 1299];
A15 = [1003, 1293];
A16 = [1233, 1557];
A17 = [1151, 1558];
A18 = [1194, 1615];
A19 = [1106, 1607];
A20 = [1339, 1845];
A21 = [1221, 1847];
A22 = [1300, 1942];
A23 = [1009, 1896];
A24 = [1063, 2026];
A25 = [690, 1846];
A26 = [312, 2026];
A27 = [360, 1898];
A28 = [70, 1944];
A29 = [147, 1846];
A30 = [29, 1844];
A31 = [261, 1610];
A32 = [176, 1620];
A33 = [216, 1558];
A34 = [134, 1557];
A35 = [362, 1293];
A36 = [276, 1299];
A37 = [299, 1266];
A38 = [239, 1265];
A39 = [452, 981];
A40 = [384, 983];
A41 = [391, 970];
A42 = [354, 968];
A43 = [529, 672];
A44 = [486, 672];
A45 = [460, 670];
A46 = [604, 368];
A47 = [585, 369];
A48 = [571, 369];

outline = [A1, /*A2, A3, A4,*/ A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38, A39, A40, A41, A42, A43, A44, A45, /*A46, A47, A48*/];

// Inner Points
B1 = [378, 1670];
B2 = [484, 1627];
B3 = [349, 1600];
B4 = [523, 1306];
B5 = [447, 1325];
B6 = [419, 1289];
B7 = [485, 983];
B8 = [508, 994];
B9 = [564, 986];
B10 = [607, 669];
B11 = [552, 672];
B12 = [611, 366];
B13 = [634, 360];
B14 = [645, 367];
B15 = [720, 364];
B16 = [742, 364];
B17 = [761, 673];
B18 = [800, 674];
B19 = [814, 674];
B20 = [572, 674];
B21 = [881, 976];
B22 = [863, 995];
B23 = [802, 990];
B24 = [926, 1323];
B25 = [836, 1305];
B26 = [949, 1286];
B27 = [992, 1667];
B28 = [1019, 1597];
B29 = [883, 1630];

// Polygons
C1 = [A1, A5, A6];
C2 = [A1, A6, A7, B19, A9, A10, A11, B21, A13, A14, A15, B26, A17, A18, A19, B28, A21, A22, A23, B29, B27, B25, B24, B23, B22, B17, B18];
C3 = [A1, B18, B17, B22, B23, B24, B25, B27, B29, A23, A24, A25];
C4 = [A7, A8, A9, B19];
C5 = [B21, A11, A12, A13];
C6 = [A15, A16, A17, B26];
C7 = [A19, A20, A21, B28];
C8 = [B2, A27, A28, A29, B3, A31, A32, A33, B6, A35, A36, A37, B7, A39, A40, A41, B11, A43, A44, A1, B20, B10, B8, B9, B5, B4, B1];
C9 = [A29, A30, A31, B3];
C10 = [A34, A33, B6, A35];
C11 = [A38, A37, B7, A39];
C12 = [A41, A42, A43, B11];
C13 = [A1, A44, A45];
C14 = [A25, A26, A27, B2, B1, B4, B5, B9, B8, B10, B20, A1];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14];

min_x = A30[0];
min_y = A1[1];
max_x = A20[0];
max_y = A24[1];

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
