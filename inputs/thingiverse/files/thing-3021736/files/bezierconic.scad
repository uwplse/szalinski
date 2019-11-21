/* 
Conic Bezier Curve
also known as Quadratic Bezier Curve
also known as Bezier Curve with 3 control points 

Please see 
http://www.thingiverse.com/thing:8443 by William A Adams
http://en.wikipedia.org/wiki/File:Bezier_2_big.gif by Phil Tregoning
http://en.wikipedia.org/wiki/B%C3%A9zier_curve by Wikipedia editors

By Don B, 2011, released into the Public Domain
*/

module BezConic(p0,p1,p2,steps=5) {

	stepsize1 = (p1-p0)/steps;
	stepsize2 = (p2-p1)/steps;

	for (i=[0:steps-1]) {
		assign(point1 = p0+stepsize1*i) 
		assign(point2 = p1+stepsize2*i) 
		assign(point3 = p0+stepsize1*(i+1))
		assign(point4 = p1+stepsize2*(i+1))  {
			assign( bpoint1 = point1+(point2-point1)*(i/steps) )
			assign( bpoint2 = point3+(point4-point3)*((i+1)/steps) ) {
				polygon(points=[bpoint1,bpoint2,p1]);
			}
		}
	}
}


p0=[15,0];
p1=[1,14];
p2=[7,30];
//BezConic(p0,p1,p2,20);

//translate([0,20,0]) rotate([90,0,0]) BezConic(p0,p1,p2,20);
//translate([0,20,0]) cylinder(h=30,r=0.5,$fn=10);

linear_extrude(height=1) translate([15,0,0]) BezConic(p0,p1,p2,20);

rotate_extrude($fn=100) BezConic(p0,p1,p2,steps=40);
