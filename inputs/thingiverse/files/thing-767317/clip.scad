// washer dimentions
id = 7.6;
width = 2.5;
h = 10;
tabl = 8;

$fa=.5;
$fs = .5;

od = id + 2*width;


difference(){

	x = tabl/sqrt(2);
	
	union(){
		translate([0,0,h/2]) cylinder(r=od/2,h=h,center=true);
		translate([x,x,(h-2)/2]) rotate([0,0,-45]) cube([width,tabl,h-2],center=true);
		translate([x,-x,(h-2)/2]) rotate([0,0,45]) cube([width,tabl,h-2],center=true);
		}
		translate([0,0,h/2]) cylinder(r=id/2,h=h+1,center=true);
		translate([tabl/2,0,h/2]) rotate([0,0,0]) cube([tabl,id*.75,h+2],center=true);

		translate([((2*tabl+width)/sqrt(2)),0,h/2]) rotate([0,0,45]) cube([2*tabl,2*tabl,h+2],center=true);	
	
}