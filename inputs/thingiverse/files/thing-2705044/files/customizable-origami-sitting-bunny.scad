/*
 * Customizable Origami - Sitting Bunny - https://www.thingiverse.com/thing:2705044
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-12-11
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
A1 = [570, 1249];
A2 = [623, 1270];
A3 = [627, 1162];
A4 = [666, 1076];
A5 = [807, 923];
A6 = [1000, 868];
A7 = [1155, 373];
A8 = [1243, 272];
A9 = [1254, 358];
A10 = [1326, 301];
A11 = [1320, 596];
A12 = [1219, 689];
A13 = [1430, 905];
A14 = [1241, 1076];
A15 = [1225, 1138];
A16 = [1156, 1264];
A17 = [1196, 1319];
A18 = [1115, 1386];
A19 = [1126, 1399];
A20 = [1027, 1483];
A21 = [620, 1378];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21];

// Inner Points
B1 = [1064, 1389];
B2 = [1099, 1369];
B3 = [1122, 1317];
B4 = [1186, 1124];
B5 = [1017, 927];
B6 = [1272, 596];
B7 = [1201, 671];

// Polygons
C1 = [A6, A7, A8, A9, B6, B7];
C2 = [A9, A10, A11, A12, B7, B6];
C3 = [A6, B5, B4, A14, A13, A12, B7];
C4 = [B4, A14, A15];
C5 = [B4, B5, B3, A16, A15];
C6 = [A16, A17, A18, B2, B3];
C7 = [A19, A20, B1, A4, A5, B2, A18];
C8 = [A5, A6, B5, B3, B2];
C9 = [A4, B1, A20, A21, A2, A3];
C10 = [A2, A1, A21];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10];

min_x = A1[0];
min_y = A8[1];
max_x = A13[0];
max_y = A20[1];

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
