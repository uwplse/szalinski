/*
 * Customizable Origami - Sparrow - https://www.thingiverse.com/thing:2619670
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-11-01
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
A1 = [11, 297];
A2 = [144, 203];
A3 = [127, 165];
A4 = [182, 99];
A5 = [228, 48];
A6 = [367, 9];
A7 = [531, 104];
A8 = [845, 190];
A9 = [1163, 26];
A10 = [1197, 4];
A11 = [1031, 198];
A12 = [927, 256];
A13 = [932, 269];
A14 = [1139, 353];
A15 = [993, 347];
A16 = [1201, 598];
A17 = [1110, 565];
A18 = [1255, 829];
A19 = [797, 517];
A20 = [623, 557];
A21 = [656, 612];
A22 = [425, 657];
A23 = [515, 605];
A24 = [371, 630];
A25 = [505, 556];
A26 = [355, 548];
A27 = [254, 481];
A28 = [215, 317];
A29 = [189, 295];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29];

// Inner Points
B1 = [220, 258];
B2 = [246, 67];
B3 = [430, 196];
B4 = [524, 331];
B5 = [887, 228];
B6 = [999, 163];
B7 = [529, 557];
B8 = [549, 589];
B9 = [598, 561];

// Polygons
C1 = [A5, A6, A7, B3, B2];
C2 = [A7, A8, B5, A12, A13];
C3 = [A8, A9, B6, B5];
C4 = [B5, B6, A9, A10, A11, A12];
C5 = [A7, A13, A14, A15, B4, B3];
C6 = [B4, A15, A16, A17];
C7 = [B4, A19, A18, A17];
C8 = [A19, A20, B9, B7, A25, A26, A27, A28, A29, B1, A2, A3, A4, B2, B3, B4];
C9 = [A25, A24, A23, B8, B7];
C10 = [A20, A21, A22, A23, B8, B9];
C11 = [B8, B9, B7];
C12 = [A29, A1, B1];
C13 = [A1, A2, B1];
C14 = [A4, B2, A5];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14];

min_x = A1[0];
min_y = A10[1];
max_x = A18[0];
max_y = A18[1];

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
