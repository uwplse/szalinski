//bottom radius
r1=8;
//top radius
r2=1.5;
//hole radius
r3=1;
//height
h=6;

difference(){
	cylinder(r1=r1,r2=r2,h=h,$fn=40);
	translate([0,0,-0.05])
		cylinder(r=r3,h=h+0.1,$fn=40);
}