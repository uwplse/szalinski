// variables
middlediameter = 20; // [20:100]
backdiameter = 50; // [40:200]
frontdiameter = 30; // [30:150]
with_hole = 0; // [1:Yes,0:No]
hole = 5; // [5,6,7,9]
fase = 8; // [10,12,15,20]
with_fase_front = 0; // [1:Yes,0:No]
resolution = 25; // [10:rough,25:middle,75:fine]

back = backdiameter/middlediameter*10;
front = frontdiameter/middlediameter*10;

function radius(i, x) = x/(x*x)*(i*i)+x/4;
// model
difference(){
	union(){
		for ( i = [back : -1 : 1] ){
			translate([0,0,middlediameter/3/back*(back-i)]) cylinder(h = middlediameter/3/back, r1 = radius(i, 2*middlediameter), r2 = radius(i, 2*middlediameter), $fn = resolution);
		}
		translate([0,0,middlediameter/3]) cylinder(h = middlediameter/2, r1 = middlediameter/2, r2 = middlediameter/2, $fn = resolution);
		for ( i = [front : -1 : 1] ){
			translate([0,0,middlediameter/3/front*i+middlediameter/3*2]) cylinder(h = middlediameter/3/front, r1 = radius(i, 2*middlediameter), r2 = radius(i, 2*middlediameter), $fn = resolution);
		}
	}
	if(with_hole==1){
		cylinder(h = middlediameter*2, r1 = hole/2, r2 = hole/2, $fn = resolution);
	}
	if(with_hole==1 && with_fase_front==1){
		cylinder(h = (fase-hole)/2, r1 = fase/2, r2 = hole/2, $fn = resolution);
	}
}