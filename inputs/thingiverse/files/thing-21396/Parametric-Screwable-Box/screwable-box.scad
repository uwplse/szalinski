// Parametric screwable box

h=100;
nw=1;
cr=40;
w=30;
t=1;
g=0.01;
gap=0.5;	// gap between inner and outer

step=45; // degrees
max=360-step;

module cup(r2,h) {
	echo("cup radius ",r2);
	difference() {
		for (a = [0:step:max]) {
			rotate([0,0,a]) linear_extrude(height = h, center = false, convexity = 10, twist = nw*360)
				translate([w, 0, 0]) circle(r = r2);
			}
		difference() {
			for (a = [0:step:max]) {
				rotate([0,0,a]) linear_extrude(height = h+g, center = false, convexity = 10, twist = nw*360)
					translate([w, 0, 0]) circle(r = r2-t);
				}
			cylinder(r=r2+w,h=t);
			}
		}
	}

translate([-cr-w-5,0,0]) cup(cr,h);
translate([cr+w+5,0,0]) cup(cr+t+gap,h+t+g);