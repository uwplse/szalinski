/*
 * Customizable Christmas Tree - https://www.thingiverse.com/thing:2694509
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-12-06
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

// The height of the Tree.
tree_height_in_millimeter = 100; //[10:400]

// The bottom diameter of the Tree. Please ensure in the preview, that the angle of the segments are not too flat. You can correct it by decreasing the diameter and/or increasing the height Otherwise it will cause print fails if you are using vase mode or zero infill!
tree_bottom_diameter_in_millimeter = 66; //[10:300]

// Number of segments.
tree_segments = 10; //[3:100]

// Set the number of sides. A value between 3 and 10 looks like a low poly Tree. Greater than 24 looks like a round tree.
number_of_sides = 7;  //[3:100]

/* [Hidden] */
segment_h = tree_height_in_millimeter / (tree_segments + 1);
half_segment_h = segment_h / 2;
segment_w = tree_bottom_diameter_in_millimeter / (tree_segments + 1);
tree_d = tree_bottom_diameter_in_millimeter;


 // Program Section //
//-----------------//

color("green")
for(segment = [0:1:tree_segments - 1]) {
    bottom_d = tree_d - segment_w * (segment + 1) > 0 ? tree_d - segment_w * (segment + 1) : 2;
    middle_d = tree_d - segment_w * segment > 0 ? tree_d - segment_w * segment : 2;
    top_d = tree_d - segment_w * (segment + 2) > 0 ? tree_d - segment_w * (segment + 2) : 2;
    dynamic_half_segment_h = segment == tree_segments - 1 ? half_segment_h * 3 : half_segment_h;
    translate([0, 0, segment_h * segment]) {        
        cylinder(d1 = bottom_d, d2 = middle_d, h = half_segment_h, $fn = number_of_sides);
        translate([0, 0, half_segment_h]) {
            cylinder(d1 = middle_d, d2 = top_d, h = dynamic_half_segment_h, $fn = number_of_sides);
        }
    }
}
