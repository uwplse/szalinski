/* [Global] */

d1 = 22.6;
d2 = 45;
d3 = 51.7;
d4 = 56;
h1 = 2;
h2 = 11;
h3 = 20;
chamfer = 0.5;
boltHoles = 3;
boltDia = 34;
boltHoleDia = 3;


difference(){
	rotate_extrude($fn=200)
		polygon(points=[[0,0],[d4/2,0],[d4/2,h1],[d3/2,h1],[d3/2,h3-chamfer],[d3/2-chamfer,h3],[d2/2+chamfer,h3],[d2/2,h3-chamfer], [d2/2,h2],[0,h2]], paths=[[0,1,2,3,4,5,6,7,8,9]]);
	union(){
		translate([0,0,-h3/2])
			cylinder(r=d1/2, h=h3*2,$fn=36);
		boltHoles();
	}
}

module boltHoles(){
	for (i=[0:boltHoles-1])
		rotate([0,0,i*360/boltHoles])
			translate([0,boltDia/2,-h3/2])
				cylinder(r=boltHoleDia/2,h=h3*2,$fn=36);
}