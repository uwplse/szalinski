/* [Holder] */
// Holder hight
holder_height = 30;
// Holder width
holder_width = 5;

/* [Magnets] */
// Magnet diameter
magnet_d = 10.5; // Diameter
// Magnet distance from border and adjacent pen support
magnet_distance = 2;

/* [Pens holders] */
// Pen holder height
pen_holder_height = 12;
// Pen holder width
pen_holder_width = 4;

/* [Pens] */
// Pen diameter (larger to allow insert in the holder)
pen_d = 10.5;
// Nick size to hold pen in support
pen_inside = 1;
// Pen number
pen_number = 4;

/* [Hidden] */
magnet_r = magnet_d/2;

pen_r = pen_d / 2;

offcet_base = magnet_d + magnet_distance * 2;
offcet_holder = offcet_base;
offcet_pen = offcet_base + pen_holder_width - pen_inside;

holder_length = offcet_base + pen_holder_width*(pen_number+1) + pen_d*pen_number - pen_inside*pen_number*2 + magnet_d + magnet_distance*2;

$fn = 100;

difference() {
    union() {
        difference() {
            cube([holder_length, holder_height, holder_width]);
            magnet(0);
            translate([0, 0, 0])
                magnet(offcet_base + pen_holder_width*(pen_number+1) + pen_d*pen_number - pen_inside*pen_number*2);
            }
        for (i=[0:pen_number]) {
            pen_holder(offcet_holder + pen_holder_width*i + pen_d*i - pen_inside*i*2);
        }        
    }
    for (i=[0:pen_number-1]) {
        pen(offcet_pen + pen_d*i + pen_holder_width*i - pen_inside*i*2);
    }
}

module magnet(shift) {
    translate([shift + magnet_r + magnet_distance, holder_height/2, magnet_distance])
        cylinder(holder_width, r=magnet_r);
}

module pen_holder(shift) {
    union() {
        translate([shift, (holder_height-pen_holder_height)/2, holder_width-0.1])
            cube([pen_holder_width, pen_holder_height, pen_holder_height]);
        translate([shift+pen_holder_width/2, (holder_height-pen_holder_height)/2,    holder_width+pen_holder_height])
            rotate([-90, 0, 0])
                cylinder(pen_holder_height, r=pen_holder_width/2);
    }
}

module pen(shift) {
    translate([shift + pen_r, 0, holder_width+pen_holder_height/1.8])
        rotate([-90, 0, 0])
            cylinder(holder_height, r=pen_r);
}