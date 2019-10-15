/* [Case] */

//Case outer width
case_width = 34.5;

//Case outer lenth
case_lenth = 42.5;

//Case outer height
case_height = 9;

//Case thickness
case_thickness = 0.9;

//Space between the USB keys
spacing_x = 1.2;

/* [USB] */

//USB total lenth
USB_lenth = 33.2;

//USB back part width
USB_back_width = 14.5;

/* [Hidden] */
USB_front_width = 12+0.8;
USB_front_lenth = 10;
USB_height = 4.5;
lever_height = 2;
lever_depth = 2;
inside_width = case_width - (case_thickness * 2);
inside_lenth = case_lenth - (case_thickness * 2);
inside_height = case_height - (case_thickness * 2);
spacing_y = (inside_lenth-USB_lenth+lever_depth)/2;
USB_slots = floor(inside_width/(USB_back_width+spacing_x));
side_spacing = (inside_width-(spacing_x+(USB_back_width+spacing_x)*USB_slots))/2;
USB_back_lenth = USB_lenth-USB_front_lenth-1.5;

module case() {
    cube([inside_width, inside_lenth, inside_height]);
}

module USB() {
	hull() {
		cube([USB_back_width, USB_back_lenth, USB_height]);	
		translate([((USB_back_width-USB_front_width)/2),USB_back_lenth,0]) {
			cube([USB_front_width, 1.5, USB_height]);
		}
	}
	translate([((USB_back_width-USB_front_width)/2),USB_back_lenth+1.5,0]) {
			cube([USB_front_width, USB_front_lenth, USB_height]);
	}
	translate([0, -lever_depth, USB_height-lever_height]) {
		cube([USB_back_width, lever_depth, lever_height]);
	}
}

if (side_spacing < 0) {
	USB_slots = USB_slots-1;
	side_spacing = (inside_width-(spacing_x+(USB_back_width+spacing_x)*USB_slots))/2;
	difference() {
		case();
		for (x = [0:USB_slots-1]) {
			translate([(spacing_x+side_spacing+(USB_back_width+spacing_x)*x),spacing_y,(inside_height-USB_height)]) {
					USB();
			}
		}
	}
}
else {
	difference() {
		case();
		for (x = [0:USB_slots-1]) {
			translate([(spacing_x+side_spacing+(USB_back_width+spacing_x)*x),spacing_y,(inside_height-USB_height)]) {
				USB();
			}
		}
	}
}