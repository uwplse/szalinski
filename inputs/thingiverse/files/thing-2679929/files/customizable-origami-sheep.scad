/*
 * Customizable Origami - Sheep - https://www.thingiverse.com/thing:2679929
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-11-30
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
inline_edge_radius_in_millimeter = 0.6; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [231, 938];
A2 = [468, 724];
A3 = [448, 719];
A4 = [470, 650];
A5 = [723, 507];
A6 = [784, 514];
A7 = [803, 541];
A8 = [1000, 600];
A9 = [938, 626];
A10 = [913, 631];
A11 = [1126, 680];
A12 = [1812, 620];
A13 = [2266, 660];
A14 = [2363, 718];
A15 = [2480, 903];
A16 = [2433, 1220];
A17 = [2452, 1511];
A18 = [2421, 1527];
A19 = [2419, 1570];
A20 = [2186, 1864];
A21 = [2151, 1864];
A22 = [2248, 1547];
A27 = [1850, 1376];
A28 = [1627, 1533];
A29 = [1396, 1520];
A30 = [1050, 1501];
A35 = [1000, 1779];
A36 = [943, 1864];
A37 = [910, 1864];
A38 = [898, 1481];
A39 = [798, 1430];
A40 = [416, 1069];
A41 = [246, 1046];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A27, A28, A29, A30, A35, A36, A37, A38, A39, A40, A41];

// Inner Points
B1 = [1667, 1112];
B2 = [1727, 931];
B3 = [1656, 954];
B4 = [2301, 1573];
B5 = [807, 651];
B6 = [677, 684];
B7 = [580, 950];
//B8 = [1130, 1501];

// Polygons
C1 = [A3, A4, A5, A6, B6, A2];
C2 = [A40, B7, B5, A39];
C3 = [B5, A10, A11, A12, A39];
C4 = [A39, A38, A30, A29, B3, A12];
C5 = [B3, A12, A13, A14, B2];
C6 = [B3, B2, B1, A27, A29];
C7 = [B2, A14, A15, A16, B4, A22, A27, B1];
C8 = [A16, A17, A18, B4];
C9 = [A27, A29, A28];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9];

min_x = A1[0];
min_y = A5[1];
max_x = A15[0];
max_y = A36[1];

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
