// usb a pinout: vcc, d-, d+, gnd
isolate_pins = [ 0, 1, 1, 0 ];
isolator_thickness = 0.1;
tolerance = 0.4;

{
    usb_a_male_outter_dimensions =  [ 12, 12, 4.5 ];
    usb_a_metal_casing_thickness = 0.3;
    usb_a_pin_offsets = [ 9, 6.5, 4.5, 2 ];
    usb_a_pin_width = 1;

    isolator_pin_depth = usb_a_male_outter_dimensions[1] - 3;
    groove_width = usb_a_pin_width * 2;

    difference() {
        translate([tolerance,0,0])
            cube([usb_a_male_outter_dimensions[0] - 2*usb_a_metal_casing_thickness - 2*tolerance, isolator_pin_depth, isolator_thickness]);
        for (pin = [0:len(isolate_pins) - 1]) {
            if (isolate_pins[pin] == 0) {
                translate([usb_a_pin_offsets[pin] - groove_width/2, -1, -isolator_thickness])
                    cube([groove_width, isolator_pin_depth * 0.8 + 1 , 3 * isolator_thickness]);
            }
        }
    }
}