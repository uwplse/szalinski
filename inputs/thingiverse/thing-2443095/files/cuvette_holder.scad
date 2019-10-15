// Cuvette Holder
// 8/19/15
// Justin Chew
// Rust Lab
// measurements are in mm

//cuvette_width = 12;
//cuvette_height = 45;

// Length (number of holders)
long = 1;
// Width (number of holders)
wide = 1;
support_height = 24*1;
support_length = 5*1;
support_thick = 2*1;
base_inner_hole = 10*1;
base_int_hole = 13.5*1;
base_ext = base_int_hole+2*support_thick;
base_thick = 3*1;

for (i = [0:long-1]) {
for (j = [0:wide-1]) {

translate([i*(base_ext-support_thick),j*(base_ext-support_thick),0]) {

// base of support
difference() {
    
    cube([base_ext, base_ext, base_thick]);
    
    translate([(base_ext-base_inner_hole)/2, (base_ext-base_inner_hole)/2, 0]) {
        cube([base_inner_hole, base_inner_hole, base_thick]);
    }

}

// side wall supports
for (k = [0:1]) {
translate([k*(base_ext-support_thick),0,0]) {
difference() {
cube([support_thick, base_ext, support_height]);
translate([0, support_length, base_thick]) {
cube([support_thick, base_ext-2*support_length, support_height-2*base_thick]);
}
}
}
}
// start four-corner supports
// bottom left corner
cube([support_length, support_thick, support_height]);
// top left corner
translate([0, base_ext-support_thick, 0]) {
    cube([support_length, support_thick, support_height]);
}
// bottom right corner
translate([base_ext-support_length, 0, 0]) {
    cube([support_length, support_thick, support_height]);
}
// top right corner
translate([base_ext-support_length, base_ext-support_thick, 0]) {
    cube([support_length, support_thick, support_height]);
}


} // end translate

} // end for y
} // end for x