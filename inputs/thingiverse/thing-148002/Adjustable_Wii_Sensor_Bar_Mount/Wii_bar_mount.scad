// Wii Sensor Bar Stand


// Angle of sensor
a = 10;

// Width of TV edge (mm)
w = 22;

// Depth of TV edge (mm)
d = 9;

/*[Hidden]*/
$fn=20;

// Wii sensor holder
difference(){
	translate([-25,0,0])cube([25,11,10]);
	translate([-24,1,-1]) cube([23,11,12]);
	}
	translate([-24,11,0]) cylinder(r=1,h=10);
	translate([-1,11,0]) cylinder(r=1,h=10);

// TV edge holder
difference(){
	rotate([0,0,180+a]) translate([0,0,0]) cube([w+2,d+1,10]);
	rotate([0,0,180+a]) translate([1,1,-1]) cube([w,d+1,12]);
	}

// Fill piece
intersection(){
	rotate([0,0,180+a]) translate([0,-2*d,0]) cube([w+2,2*d+1,10]);
	translate([-26,-30,0])cube([26,31,10]);
}