// variables
size = 100; // [50:S,100:M,150:L]
wallthickness = 2; // [1:S,2:M,3:L]
resolution = 100; // [100:rough,150:middle,200:fine]

// model coaster
union(){
	difference(){
		translate([0,0,0])cylinder(h = size*.1, r1 = size*1.15/2, r2 = size*1.2/2, $fn = resolution);
		translate([0,0,wallthickness])cylinder(h = size-wallthickness, r1 = (size-2*wallthickness)*1.15/2, r2 = (size-2*wallthickness)*1.2/2, $fn = resolution);
	}
	union(){
		rotate([0,0,0]) translate([0,15,wallthickness]) cube([wallthickness,size*0.30,wallthickness]);
		rotate([0,0,60]) translate([0,15,wallthickness]) cube([wallthickness,size*0.30,wallthickness]);
		rotate([0,0,120]) translate([0,15,wallthickness]) cube([wallthickness,size*0.30,wallthickness]);
		rotate([0,0,180]) translate([0,15,wallthickness]) cube([wallthickness,size*0.30,wallthickness]);
		rotate([0,0,240]) translate([0,15,wallthickness]) cube([wallthickness,size*0.30,wallthickness]);
		rotate([0,0,300]) translate([0,15,wallthickness]) cube([wallthickness,size*0.30,wallthickness]);
	}
}
