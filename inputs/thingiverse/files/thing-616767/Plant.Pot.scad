// variables
size = 100; // [50:S,100:M,150:L]
wallthickness = 2; // [1:S,2:M,3:L]
hole = 1; // [1:Yes,0;No]
resolution = 100; // [100:rough,150:middle,200:fine]


// model
difference(){
	difference(){
		union(){
			translate([0,0,0])cylinder(h = size, r1 = size/2, r2 = size*1.2/2, $fn = resolution);
			translate([0,0,size*0.85])cylinder(h = size*0.15, r1 = size*1.28/2, r2 = size*1.3/2, $fn = resolution);
		}
		translate([0,0,wallthickness])cylinder(h = size-wallthickness, r1 = (size-2*wallthickness)/2, r2 = (size-2*wallthickness)*1.2/2, $fn = resolution);
	}
	if(hole==1){
		cylinder(h = wallthickness, r1 = size*0.08, r2 = size*0.08, $fn = resolution);
	}
}

