// Height of bottom part
h1=70;//[40:10:150]
// Height of top part
h2=80;//[40:10:150]
// Bottom radius
r1=70;//[30:5:80]
// Middle radius
r2=50;//[20:5:70]
// Top radius
r3=90;//[40:5:100]
// Thickness of walls
s=0.75;//[0.5:0.1:2]
// Number of corners
c=19;//[3:1:19]
// Bottom twist angle
a1=75;//[-180:5:180]
// Top twist angle
a2=42;//[-180:5:180]
tc1=r2/r1;
tc2=r3/r2;
//24 8b fb
// [34/255,139/255,251/255]
color([34/255,139/255,251/255])translate([0,0,s])union() {
	union() {
		translate([0,0,-s])linear_extrude(height = s, center = false, convexity = 10, twist = 0,slices=s,scale=1,$fn=c)
			circle(r1);
		difference() {
			linear_extrude(height = h1, center = false, convexity = 10, twist = a1,slices=h1,scale=tc1,$fn=c)
				circle(r1);
			translate([0,0,-s/2])
				linear_extrude(height = h1+s, center = false, convexity = 50, twist = a1,slices=h1,scale=tc1,$fn=c)
					circle(r1-s);
		}
	}
	rotate([0,0,-a1]) {
		translate([0,0,h1]) {
			difference() {
				linear_extrude(height = h2, center = false, convexity = 10, twist = a2,slices=h2,scale=tc2,$fn=c)
					circle(r2);
				translate([0,0,-s/2])
					linear_extrude(height = h2+s, center = false, convexity = 50, twist = a2,slices=h2,scale=tc2,$fn=c)
						circle(r2-s);
			}
		}
	}
}

