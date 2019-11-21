// Frame rod diameter in mm
rod_d = 9;

// Frame rod spacing, mm (outer - to - outer)
rod_spacing = 74;

// Thickness of the part in mm
thickness = 12;

// Thickness of material outside the holes.
thickness_edge = 2;


rod_r = rod_d / 2;

offset = (rod_spacing - rod_r * 2)/2;

e = 0.1;

generic_offset = 3;

button_r = 9/2;
button_offset = button_r + generic_offset;

led_w = 19.1;
led_h = 5;
led_offset = generic_offset;
// width of the actual LED component
led_side = 3.5;
led_from_usb = 7;

module main_bar() {
    hull() {
        translate([-offset, 0, 0])
            cylinder(r = rod_r + thickness_edge, h = thickness);
        translate([offset, 0, 0])
            cylinder(r = rod_r + thickness_edge, h = thickness);
    }
}



difference() {
    main_bar();
    
    // mounting holes
    translate([offset, 0, -e])
        cylinder(r = rod_r, h = thickness + 2 * e);
    
    translate([-offset, 0, -e])
        cylinder(r = rod_r, h = thickness + 2 * e);
    
    // safety button
    translate([-button_offset, 0, -e])
        cylinder(r = button_r, h = thickness + 2 * e);
    
    // led + usb module
    y_offs = rod_r;
    
    translate([led_offset, -y_offs, -e]) {
        cube([led_w, led_h, thickness + e * 2]);
        translate([
                led_w / 2 - led_side / 2,
                -thickness_edge - e,
                led_from_usb])
            cube([led_side, thickness_edge + 2*e, led_side]);
    }
}
