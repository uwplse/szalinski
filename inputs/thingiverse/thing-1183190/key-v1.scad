/* 
 * Special key generator
 * All units are in milimeters
 *
 * author R. A. - 2015/12/08
 * e-mail: thingiverse@dexter.sk
 * Thingiverse username: dexterko
 *
 * Feel free to modify and distribute, but please keep the credits;-)
 */

outer_diameter=12;
inner_diameter=11;
height_of_shank=20; 
number_of_center_sides=3;
depth_of_center_hole=8;

union() {
    // key bow
    difference() {
        translate([-20, 0-(outer_diameter/2), 0])
        cube([40,outer_diameter,10]);
        
        //a hole in the bow
        rotate([0, 90, 90])
        translate([-5,15,-20])
        cylinder(r=2.5, h=40);
    }

    // Shank
    difference() {
        translate([0, 0, 10])
        cylinder(d=outer_diameter, h=height_of_shank, $fn=100);

        translate([0,0, 10+height_of_shank-depth_of_center_hole])
        cylinder(d=inner_diameter, h=depth_of_center_hole+1, $fn=number_of_center_sides);
    
    
    }

}
