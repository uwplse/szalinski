/*
shells.scad
v 0.1
*/

// helper function
module GE_cone(r1, r2, h) {
	cylinder(r1=r1, r2=r2, h=h);
}

/*
Creates a conic shell with an open top and open bottom.
Specify the bottom inside radius, shell thickness, slope/taper (dr/dz) and height

TODO: 
* Allow specification of top radius vice taper.
* Allow inside shell as well as outside shell.
* Simplify parameter names.
* Call from a general-purpose convenience function.
*/
module GE_cylinder_shell(t,h,r, top=true, bottom=true) {
	echo(str("cylinder_shell():t=",t," h=",h));
	GE_cone_shell(t, h, r, 0, top, bottom);
}

module GE_cone_shell(t, h, r1, taper, top=true, bottom=true) {
	echo(str("cylinder_shell():t=",t," h=",h," r1=",r1," taper=",taper));
	EPSILON = 0.05;
	ring_thickness = t;
	OutsideR1 = r1 + ring_thickness;
	OutsideR2 = OutsideR1 - h*taper;
	InsideR1 = r1;
	InsideR2 = InsideR1 - h*taper;
	difference() {
		GE_cone(r1 = OutsideR1, r2 = OutsideR2, h=h);
		translate([0,0,-EPSILON]) GE_cone(r1 = InsideR1, r2 = InsideR2, h=h+EPSILON*2);
	}
	BottomR = (taper > 0 ? InsideR1 : OutsideR1);
	TopR = (taper > 0 ? OutsideR2 : InsideR2);
	if (bottom) cylinder(r=BottomR,h=t);
	if (top) translate([0,0,h-t]) cylinder(r=TopR,h=t);
	
}

GE_cylinder_shell(r=250,h=20,t=5,bottom=false);
GE_cone_shell(5,40,200,3/10, top=false);
dz = 10;
dTheta = 10;
for(i=[0:dTheta:360]) {
	R = 50*sin(i);
	RNext = 50*sin(i+dTheta);
	taper = (R-RNext)/dz;
	#translate([0,0,i]) GE_cone_shell(1,dz,R+100,taper);
}
