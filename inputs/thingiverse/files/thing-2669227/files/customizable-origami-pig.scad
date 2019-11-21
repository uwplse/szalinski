/*
 * Customizable Origami - Pig - https://www.thingiverse.com/thing:2669227
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-11-26
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
outline_size_in_millimeter = 1.4; //[0.5:0.1:20]

// Thickness of the inner outline.
inline_size_in_millimeter = 0.7; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 0.3; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [301, 984];
A2 = [427, 903];
A3 = [424, 872];
A4 = [677, 678];
A5 = [1134, 657];
A6 = [1392, 654];
A7 = [1479, 768];
A8 = [1571, 919];
A9 = [1676, 922];
A10 = [1697, 1055];
A11 = [1629, 1091];
A12 = [1350, 1273];
A13 = [1395, 1408];
A14 = [1242, 1276];
A15 = [782, 1284];
A16 = [520, 1408];
A17 = [532, 1301];
A18 = [429, 1344];
A19 = [456, 1034];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19];

// Inner Points
B1 = [559, 972];
B2 = [546, 1212];
B3 = [1076, 1023];
B4 = [1316, 936];
B5 = [1258, 965];
B6 = [1332, 1226];

// Polygons
C1 = [A1, A2, A19];
C2 = [A3, A4, B1, B2, A17, A19, A2];
C3 = [A19, A17, A18];
C4 = [A17, B2, A15, A16];
C5 = [A4, A15, B2, B1];
C6 = [A4, A5, B3, B5, B6, A14, A15];
C7 = [B3, B5, B4, A7, A6, A5];
C8 = [A7, A8, A11, A12, B6, B5, B4];
C9 = [A14, B6, A12, A13];
C10 = [A8, A11, A10, A9];

cut_polygons = [/*C1,*/ C2, C3, C4, C5, C6, /*C7,*/ C8, C9, /*C10*/];

min_x = A1[0];
min_y = A6[1];
max_x = A10[0];
max_y = A13[1];

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
