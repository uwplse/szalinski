
// include landscape mount
include_horizontal=1; // [0,1]

//width of phone connector
w_usb = 11;
//depth of phone connector
d_usb = 6.5;
//length of phone connector
l_usb=29;

//height of tilted back
h_back = 35;
//angle of tilt
th_back = 15; // [10:25]

//width of phone
w_phone = 71;

//depth of phone
d_phone = 14.5;

dock_offset=10;
d_mount = 45;
h_mount = 42;

//width of wire
w_wire = 4.5;
l_feet=80;

h_horiz=150;

// calculated values (do not edit)

w_mount = w_phone + 4;
pos_back = h_back/tan(90-th_back);
y_usb = sin(th_back)*l_usb;
z_usb = l_usb-cos(th_back)*l_usb;
//


feet();
wire_clips();
upper_back();

difference() {
translate([0,-d_mount/2,0]) cube([w_mount,d_mount,h_mount]);
translate([0,dock_offset,0]) {
dock_cutout();
wire_slot();
}
}

if (include_horizontal) {
horizontal_dock();
}


module wire_slot() {

//micro-usb cutout
translate([w_mount/2-w_usb/2,y_usb-d_usb/2,h_mount+z_usb-l_usb]) 
rotate([th_back,0,0]) cube([w_usb, d_usb,l_usb]);

//wire cutouts
translate([w_mount/2-w_wire/2,y_usb+sin(th_back)*(h_mount+10)/2,0]) 
rotate([th_back,0,0]) cube([w_wire, d_mount,h_mount+10]);

translate([w_mount/2-w_wire/2,y_usb,0]) cube([w_wire, d_mount,h_mount]);

translate([w_mount/2-w_wire/2,-d_mount/2-dock_offset,0]) cube([w_wire,d_mount,7.5]);
}


module dock_cutout() {
translate([0,0,-3]) {
translate([2,0,1.03*h_mount]) rotate([0,90,0]) cylinder(r=d_phone/2,h=w_phone);
translate([2,-d_phone/2,1*h_mount]) cube([w_phone,d_phone,d_phone]);
}
}

module wire_clips() {
translate([w_mount/2-w_wire/2,-2.5,0]) cube([1.25,5,1.5]);
translate([w_mount/2+w_wire/4,10,0]) cube([1.25,5,1.5]);
translate([w_mount/2+w_wire/4,-15,0]) cube([1.25,5,1.5]);
}


module upper_back() {

//triangular prism
translate([0,-d_phone/2-pos_back+dock_offset,h_mount-0.1])
rotate([90,0,90]) linear_extrude(height=w_mount) {
polygon(points=[[0,0],[0,h_back],[pos_back,0]],paths=[[0,1,2]],convexity=1);
}

// add a cube from back of mount to back of triangular prism
translate([0,-d_mount/2,h_mount]) cube([w_mount,(d_mount/2-pos_back-d_phone/2)+dock_offset,h_back]);
}


module feet() {
translate([0,-40,0]) cube([15,l_feet,5]);
translate([w_mount-15,-40,0]) cube([15,l_feet,5]);
}

module horizontal_dock() {

hull() {
translate([-24+2,d_mount/2-5,0]) cube([24,5,h_horiz]);
translate([-5+2,-l_feet/2,0]) cube([5,10,h_horiz]);
}
}
