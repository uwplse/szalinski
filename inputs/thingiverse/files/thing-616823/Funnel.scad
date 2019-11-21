// variables
size = 100; // [50:S,100:M,150:L,200:XL]
wallthickness = 1; // [0.5:S,1:M,1.5:L]
resolution = 100; // [100:rough,150:middle,200:fine]

// model
union(){
	difference(){
		union(){
			translate([0,0,0])cylinder(h = size*0.6, r1 = size/2, r2 = size*0.15/2, $fn = resolution);
			translate([-0.5,-0.6,0]) translate([0,size*0.12,0]) rotate([1/tan(size*0.1/(size*0.4)*180/PI),0,0]) cube([1,1.2,size]);
			rotate([0,0,120]) translate([-0.5,-0.6,0]) translate([0,size*0.12,0]) rotate([1/tan(size*0.1/(size*0.4)*180/PI),0,0]) cube([1,1.2,size]);
			rotate([0,0,240]) translate([-0.5,-0.6,0]) translate([0,size*0.12,0]) rotate([1/tan(size*0.1/(size*0.4)*180/PI),0,0]) cube([1,1.2,size]);
		}
		translate([0,0,0])cylinder(h = size*0.6, r1 = (size)/2-wallthickness, r2 = (size)*0.15/2-wallthickness, $fn = resolution);
	}
	difference(){
		translate([0,0,size*0.6])cylinder(h = size*0.4, r1 = size*0.15/2, r2 = size*0.1/2, $fn = resolution);
		translate([0,0,size*0.6])cylinder(h = size*0.4, r1 = (size)*0.15/2-wallthickness, r2 = (size)*0.1/2-wallthickness, $fn = resolution);
	}
}