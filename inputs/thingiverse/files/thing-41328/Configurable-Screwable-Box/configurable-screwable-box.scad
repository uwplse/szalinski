// Configurable screwable box
// (c) 2013 Laird Popkin

// Height (mm)
h=100;
// Number of times screw spirals around
nw=1;
// Inner box diameter (mm)
inside=80;
// Outer box diameter (mm)
outside=150;
// Thickness of box walls (mm)
t=1;
// Number of parallel threads
threads = 8; //[1:32]
// Gap between inner and outer box
gap=0.5;

cr=inside/2;
w=(outside/2)-cr-t;
step = 360/threads;

g=0.01*1;
max = 1*(360 - step);

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