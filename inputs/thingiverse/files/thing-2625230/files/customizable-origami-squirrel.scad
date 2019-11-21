/*
 * Customizable Origami - Squirrel - https://www.thingiverse.com/thing:2625230
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-11-04
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
inline_size_in_millimeter = 0.7; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 0.9; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [388, 152];
A2 = [513, 278];
A3 = [514, 336];
A4 = [646, 223];
A5 = [644, 142];
A6 = [682, 104];
A7 = [706, 143];
A8 = [863, 226];
A9 = [849, 263];
A10 = [736, 283];
A11 = [813, 328];
A12 = [724, 357];
A13 = [724, 483];
A14 = [668, 579];
A15 = [753, 634];
A16 = [635, 634];
A17 = [493, 634];
A18 = [331, 446];
A19 = [203, 332];
A20 = [186, 215];
A21 = [196, 103];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21];

// Inner Points
B1 = [456, 290];
B2 = [395, 443];
B3 = [458, 444];
B4 = [461, 422];
B5 = [664, 378];

// Polygons
C1 = [A20, A21, A1, B1];
C2 = [A1, B1, A2];
C3 = [A2, A3, B4, B3, B2, B1];
C4 = [B1, A20, A19, B2];
C5 = [A19, A18, B2];
C6 = [A18, B2, B3, A17];
C7 = [A17, A16, A14, A13, B5, B4, B3];
C8 = [A16, A14, A15];
C9 = [A13, B5, A12];
C10 = [A3, B4, B5, A12, A11, A10, A4];
C11 = [A4, A7, A8, A9, A10];
C12 = [A7, A6, A5, A4];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12];

min_x = A20[0];
min_y = A21[1];
max_x = A8[0];
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
