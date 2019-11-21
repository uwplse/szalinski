/*********************************************
 * Basic Parameters -- Adjust these to taste *
 *********************************************/
// Number of Cartridges to hold
cart_count = 12;

/***************************************************
 * Holder design -- You can generally ignore these *
 ***************************************************/
holder_height       = 15;
perimeter_thickness = 2;
divider_thickness   = 2;

/************************
 * Cartridge Dimensions *
 ************************/
/* (Only adjust if your carts don't fit for some reason
 * or you want to use this code for a different style of
 * cartridge.
 */
cart_depth          = 7.7; // Nominal 7.6
cart_width          = 57;   // Nominal 56.8;
// cart_wall_thickness = 1.3;

/***********************
 * Let's Get Dangerous *
 ***********************/
overall_width = cart_width + (2 * perimeter_thickness);
overall_length = cart_count * (cart_depth + divider_thickness) - divider_thickness + (2 * perimeter_thickness);

difference() {
    cube([overall_width, overall_length, holder_height]);
    for(i = [0:cart_count-1]) {
        translate([
            perimeter_thickness,
            perimeter_thickness + (divider_thickness + cart_depth) * i,
            perimeter_thickness
        ])
            cube([cart_width, cart_depth, holder_height]);
    }
}
