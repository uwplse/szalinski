length = 23.28; // length
width = 12.5; // width (or depth)
height = 23.3; // height of main body
bottom_cap = 6; // bottom "cap" height
flange_lengths = 5; // length of flange
flange_thickness = 2.36; // thickness of flange
flange_position = 16.44 + (flange_thickness/2); // position of flange

// based on:
// http://www.hobbyking.com/hobbyking/store/__34112__HK15178_Analog_Servo_10g_1_4kg_0_09s_USA_Warehouse_.html

module 9g_servo() {
	$fn=100;

	l = length; // length
	w = width; // width (or depth)
	h = height; // height of main body
	c = bottom_cap; // bottom "cap" height
	f = flange_lengths; // length of flange
	fz = flange_thickness; // thickness of flange
	fh = flange_position; // position of flange

	a = "White";
	b = "Dimgray";
	g = "SaddleBrown";
	v = "DarkRed";
	s = "Orange";

	mc = 3.75; // main cyl height
	ax = 2.75; // axle height
	ar = 2.455; // axle radius
	ah = h+ax; // axle pos
	sx = -0.89; // sub cyl center
	sr = 2.905; // sub cyl radius

	l2 = l/2;
	l4 = l/4;
	w2 = w/2;

	wy = 4.66; // wire entry width
	wx = 2;
	wz = 2.4;
	wh = wy/2;
	wp = 4 + wz/2;
	wd = 1;
	lw = l2+wx;

	difference() {
		union() {
			color(a) translate( [-l2, -w2,  c] ) cube([l,w,h-c]); // main body
			color(a) translate( [-l2, -w2,  0] ) cube([l,w,  c]); // bottom cap
			color(a) translate( [  0,   0, fh] ) cube([l+f+f,w,fz], center=true); // flange
			color(a) translate( [ l4,   0,  h] ) cylinder(r=l4, h=mc); // main cyl
			color(a) translate( [ sx,   0,  h] ) cylinder(r=sr, h=mc); // sub cyl
			color(b) translate( [ l4,   0, ah] ) cylinder(r=ar, h=ax); // axle
			color(a) translate( [ l2, -wh,  4] ) cube(size=[wx, wy, wz]); // wire entry
			color(g) translate( [ lw, -wd, wp] ) rotate([0,90,0]) cylinder(r=wd/2, h=8); // ground
			color(s) translate( [ lw,   0, wp] ) rotate([0,90,0]) cylinder(r=wd/2, h=8); // signal
			color(v) translate( [ lw,  wd, wp] ) rotate([0,90,0]) cylinder(r=wd/2, h=8); // vcc
		}
		translate([ 13.89,0,16.44]) cylinder(r=1, h=10, center=true);
		translate([-13.89,0,16.44]) cylinder(r=1, h=10, center=true);
		translate([ 13.89+1.5,0,16.44]) cube([3,1,10], center=true);
		translate([-13.89-1.5,0,16.44]) cube([3,1,10], center=true);
		translate([-l2+1,-w2+1,-1]) cylinder(r=0.5, h=10);
		translate([l2-1,w2-1,-1]) cylinder(r=0.5, h=10);
		translate([-l2+1,w2-1,-1]) cylinder(r=0.5, h=10);
		translate([l2-1,-w2+1,-1]) cylinder(r=0.5, h=10);

		translate([-l2+0.5,-w2+0.5,-0.01]) cylinder(r=1.75, h=0.25);
		translate([l2-0.5,w2-0.5,  -0.01]) cylinder(r=1.75, h=0.25);
		translate([-l2+0.5,w2-0.5, -0.01]) cylinder(r=1.75, h=0.25);
		translate([l2-0.5,-w2+0.5, -0.01]) cylinder(r=1.75, h=0.25);
	}

}

9g_servo();