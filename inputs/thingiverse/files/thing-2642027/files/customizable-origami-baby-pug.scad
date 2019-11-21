/*
 * Customizable Origami - Baby Pug - https://www.thingiverse.com/thing:2642027
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-11-13
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
inline_edge_radius_in_millimeter = 0.2; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [542, 641];
A2 = [486, 641];
A3 = [462, 566];
A4 = [488, 499];
A5 = [466, 478];
A6 = [484, 444];
A7 = [508, 435];
A8 = [527, 460];
A9 = [634, 436];
A10 = [654, 364];
A11 = [706, 327];
A12 = [756, 333];
A13 = [761, 348];
A14 = [787, 359];
A15 = [788, 403];
A16 = [757, 429];
A17 = [754, 479];
A18 = [779, 521];
A19 = [802, 524];
A20 = [823, 517];
A21 = [813, 555];
A22 = [737, 571];
A23 = [699, 541];
A24 = [665, 572];
A25 = [560, 569];
A26 = [524, 622];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26];

// Inner Points
B1 = [505, 470];
B2 = [528, 472];
B3 = [539, 475];
B4 = [704, 466];
B5 = [737, 391];
B6 = [686, 397];
B7 = [714, 375];

// Polygons
C1 = [A1, A26, A2];
C2 = [A26, A25, A3, A2];
C3 = [A3, A25, B2, B1, A4];
C4 = [A8, B3, B2, A25, A24, A9];
C5 = [A9, A10, B6, B7, A11, A12, A13, B5, A16, B4];
C6 = [B4, A16, A17];
C7 = [B4, A23, A22, A18, A17];
C8 = [A23, B4, A9, A24];
C9 = [A22, A18, A19, A21];
C10 = [A19, A21, A20];
C11 = [A4, A5, B1];
C12 = [A5, A6, A7, A8, B3, B2, B1];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12];

min_x = A3[0];
min_y = A11[1];
max_x = A20[0];
max_y = A1[1];

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
