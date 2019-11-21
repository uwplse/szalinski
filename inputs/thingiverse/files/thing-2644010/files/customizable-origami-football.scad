/*
 * Customizable Origami - Football - https://www.thingiverse.com/thing:2644010
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-11-14
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
inline_edge_radius_in_millimeter = 1.0; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [99, 309];
A2 = [215, 184];
A3 = [391, 57];
A4 = [483, 38];
A5 = [717, 41];
A6 = [764, 57];
A7 = [1079, 279];
A8 = [1135, 489];
A9 = [1166, 672];
A10 = [1148, 712];
A11 = [1005, 1008];
A12 = [803, 1119];
A13 = [638, 1161];
A14 = [431, 1139];
A15 = [241, 1038];
A16 = [120, 897];
A17 = [41, 714];
A18 = [33, 507];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18];

// Inner Points
B1 = [175, 304];
B2 = [375, 170];
B3 = [522, 296];
B4 = [401, 522];
B5 = [186, 523];
B6 = [873, 156];
B7 = [783, 286];
B8 = [926, 505];
B9 = [1091, 492];
B10 = [1060, 280];
B11 = [545, 746];
B12 = [808, 739];
B13 = [873, 940];
B14 = [660, 1071];
B15 = [462, 959];
B16 = [246, 943];
B17 = [114, 732];
B18 = [1040, 912];

// Polygons
C1 = [A1, A2, A3, A4, B2, B1];
C2 = [B2, A4, A5, B6, B7, B3];
C3 = [A5, A6, A7, B10, B6];
C4 = [A10, B9, B10, A7, A8, A9];
C5 = [B8, B7, B3, B4, B11, B12];
C6 = [B8, B9, A10, B18, B13, B12];
C7 = [A11, B18, A10, A9];
C8 = [A11, B18, B13, B14, A13, A12];
C9 = [B14, B15, B16, A15, A14, A13];
C10 = [B15, B11, B4, B5, B17, B16];
C11 = [B17, B5, B1, A1, A18, A17];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11];

min_x = A18[0];
min_y = A4[1];
max_x = A9[0];
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
