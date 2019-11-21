$fn = 30;
// track width, +0.1 for inner wall
W = 40.0 + 0.1;
// track height, +0.1 for inner wall
H = 12.1 + 0.1;
// length of holder
L = 24.0;
// depth for holder to go inside
D = 2.0;
// thickness of each wall
T = 2;
// angle
A = 5;
// offset
OFS = 0.5;

linear_extrude(height=L)
	offset(OFS) offset(-OFS)
		polygon(points = [
					[-W/2, 0], [-W/2, H],
					[-W/2+D, H], [-W/2+D, H+T],
					[-W/2-T, H+T], [-W/2-T, -T-(W+2*T)*tan(A)],
					[W/2+T, -T], [W/2+T, H+T],
					[W/2-D, H+T], [W/2-D, H],
					[W/2, H], [W/2, 0]
					]);