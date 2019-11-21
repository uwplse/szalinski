//bottom radius
r1=8;
//top radius
r2=1.5;
//hole radius
r3=1;
//height
h=6;
//left cylinder cutout
r4=6.5;
//right cylinder cutout
r5=8;
//clearance between bolt and top of hotend
clear1=1.5;
//clearance between bearing and top of hotend
clear2=0.5;

difference(){
	cylinder(r1=r1,r2=r2,h=h,$fn=40);
	translate([0,0,-0.05])
		cylinder(r=r3,h=h+0.1,$fn=40);
	translate([-r4-r3/2,25,clear1+r4])
		rotate([90,0,0])
			cylinder(r=r4,h=50,$fn=40);
	translate([r5+r3/2,25,clear2+r5])
		rotate([90,0,0])
			cylinder(r=r5,h=50,$fn=40);
}