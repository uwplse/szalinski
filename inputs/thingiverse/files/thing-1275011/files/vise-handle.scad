length=125;
width=35;
thickness=8;
hex_size=19.6;
bearing_count = 0;
knob_count = 2;
$fn=90;	// fragment count

module dummyBearing() {
	difference() {
		cylinder(d=22,h=7);
		translate([0,0,-1]) cylinder(d=8,h=9);
	}
}

$fn=90;

module hex(size=1,height=1,rot=0) {
    rotate([0,0,rot]) {
        w=size/1.732;
        translate ([-size/2,-w/2,0]) cube([size,w,height]);
        rotate([0,0,60]) translate ([-size/2,-w/2,0]) cube([size,w,height]);
        rotate([0,0,120]) translate ([-size/2,-w/2,0]) cube([size,w,height]);
    }
}

module knob(fixed=0) {
	difference() {
		union() {
			cylinder(d1=10,d2=15,h=20);
			translate([0,0,20]) sphere(d=15);
		}
		translate([0,0,-1]) cylinder(d=5,h=10+1);
	}
	if (fixed==1) {
		cylinder(d1=20,d2=10,h=5);
	}
}

module handle(len=90,width=32,thick=8,hex=19.6,bearings=0,bearing_depth=3,knobs=0) {
    difference() {
        union() { 
            translate([-(len-width)/2,-width/2,0]) cube([len-width,width,thick]);
            translate([-(len-width)/2,0,0]) cylinder(d=width,h=thick);
            translate([(len-width)/2,0,0]) cylinder(d=width,h=thick);
        }
        translate([0,0,-1]) hex(hex,thick+2,30);	// center hex hole
		// left end hex, knob or bearing
		if (knobs > 0) {
		} else {
			if (bearings > 0) {
				translate([-(len-width)/2,0,thick/2])	{
					translate([0,0,-thick/2-1]) cylinder(d=18,h=thick+2);
					translate([0,0,-thick/2-1]) cylinder(d=22,h=bearing_depth+1);
					translate([0,0,thick/2-bearing_depth]) cylinder(d=22,h=bearing_depth+1);
				}
			} else {
				translate([-(len-width)/2,0,-1]) hex(hex,thick+2,30);
			}
		}
		// right end hex, knob or bearing
		if (knobs > 1) {
		} else {
			if (bearings > 1) {
				translate([(len-width)/2,0,thick/2])	{
					translate([0,0,-thick/2-1]) cylinder(d=18,h=thick+2);
					translate([0,0,-thick/2-1]) cylinder(d=22,h=bearing_depth+1);
					translate([0,0,thick/2-bearing_depth]) cylinder(d=22,h=bearing_depth+1);
				}
			} else {
				translate([(len-width)/2,0,-1]) hex(hex,thick+2,30);
			}
		}
	}
	if (knobs > 0) {
		translate([-(len-width)/2,0,thick])	knob(fixed=1);
	}
	if (knobs > 1) {
		translate([(len-width)/2,0,thick])	knob(fixed=1);
	}
}

//translate([0,-60,0]) 
{
	handle(len=length,width=width,thick=thickness,hex=hex_size,bearings=bearing_count,knobs=knob_count);
}
//translate([0,-20,0]) {
//	handle(len=length,width=35,thick=8,bearings=0,knobs=2);
//}
//translate([0,20,0]) {
//	handle(len=length,width=35,thick=8,bearings=1,knobs=0);
//	translate([-(length-35)/2,0,5]) dummyBearing();
//	translate([-(length-35)/2,0,-5]) dummyBearing();
//	translate([-(length-35)/2,0,12]) knob();
//}
//translate([0,60,0]) {
//	handle(len=length,width=35,thick=8,bearings=2);
//	translate([-(length-35)/2,0,5]) dummyBearing();
//	translate([-(length-35)/2,0,-5]) dummyBearing();
//	translate([-(length-35)/2,0,12]) knob();
//	translate([(length-35)/2,0,5]) dummyBearing();
//	translate([(length-35)/2,0,-5]) dummyBearing();
//	translate([(length-35)/2,0,12]) knob();
//}
//
