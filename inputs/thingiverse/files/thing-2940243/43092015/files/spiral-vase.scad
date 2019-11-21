// Spiral Vase/Bowl Customizer v1.1
// Copyright (C) 2019 James C. Turner (nyponen@gmail.com)
// This program is free and has no warranty. It is licensed
// under the terms of the GNU General Public License:
// https://www.gnu.org/licenses/gpl-3.0.txt

// Width of the base on the X axis in millimeters
X_width  = 70;
// Width of the base on the Y axis in millimeters
Y_width  = 60;
// Height of the vase/bowl in millimeters
Z_height = 100;
// Thickness of the base in millimeters
Base_thickness = 3;
// Wall thickness at the base in millimeters
Wall_Thickness = 2.5;                         // [2:0.1:10]
// 1 = straight sides, <1 = flare in, >1 = flare out
Flare_factor = 0.7;                         // [0.2:0.1:4]
// How much to twist the clockwise spirals (0 = no twist)
Clockwise_degree_of_twist = 4;              // [-16:1:16]
Clockwise_spiral_face_shape = 8;            // [4:flat, 8:corner, 64:rounded]
// How much to twist the counterclockwise spirals (0 = no twist)
Counterclockwise_degree_of_twist = 8;       // [-16:1:16]
Counterclockwise_spiral_face_shape = 8;     // [4:flat, 8:corner, 64:rounded]
Resolution = 3;                             // [2:low, 3:medium, 4:high]

scale([(X_width -10)/40, (Y_width -10)/40, 1]) {
    spiral(Clockwise_spiral_face_shape, Clockwise_degree_of_twist);
    rotate([0, 0, 45]) spiral(Counterclockwise_spiral_face_shape, -Counterclockwise_degree_of_twist);
}

module spiral(fn, degree_of_twist) {
    base_extrude = min(Base_thickness,Z_height);
    linear_extrude(height = base_extrude, scale = (((Flare_factor-1) * (base_extrude/Z_height))+1), twist = 45*(((degree_of_twist*base_extrude)/Z_height)), slices = base_extrude*Resolution) {
         offset(r=10, $fn=fn) square(20, center = true);
    }
    
    if (Base_thickness < Z_height) {
        linear_extrude(height = Z_height, scale = Flare_factor, twist = 45*degree_of_twist, slices = Z_height*Resolution) {       
            difference() {
                offset(r=10, $fn=fn) {
                    square(20, center = true);
                }
                offset(r=10, $fn=fn) {
                    square(20-((max(Wall_Thickness, 1))*2.5), center = true);
                }
            }
         }
     }
 } 