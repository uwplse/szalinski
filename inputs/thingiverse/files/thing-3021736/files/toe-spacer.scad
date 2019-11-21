use <bezierconic.scad>

thickness = 1;
res = 20;
height = 20;

p0=[5, 0];
p1=[2, height / 2];
p2=[5, height];

minkowski() {
	rotate_extrude($fn=res * 2) BezConic(p0,p1,p2,steps=res);
	cube([thickness, thickness, thickness], center = true);
}
