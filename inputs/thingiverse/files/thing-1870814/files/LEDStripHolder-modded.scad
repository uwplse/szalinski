$fn = 25;

TEXT="Your Text";
FONT="Arial:style=bold";
FONTSIZE=8;

X = 60;		// mounting plate width
XB = 40;	// screw hole distance
Y = 10;		// mounting plate depth (and block width)
YF = 14.5;	// full mounting depth
Z = 12.5;	// mounting height

SD = 2.7;	// screw hole diameter to tap M3 in
OFF = 3; 	// offset/chamfer for bottom block
RND = 1.5;	// rounded corners

LW = 10;	// LED strip cutout width
LD = 3;		// LED strip cutout depth

WX = 5;		// wire block width
WY = 5;		// wire block depth
WZ = 12;	// wire block height

WD = 2;		// wire hole diameter

module rounded(size, radius, center) {
	size = (size[0] == undef) ? [size, size, size] : size;
	resize(size)
		if (center) {
			minkowski() {
				children();
				sphere(r=radius);
			}
		} else {
			translate([radius, radius, radius])
				minkowski() {
					children();
					sphere(r=radius);
				}
		}
}

difference() {
union() {
	difference() {
		translate([0, 0, OFF]) {
			translate([(X-XB-Y)/2, 0, 0])
				rounded([Y, Y, Z+YF-OFF], RND)
					cube([Y, Y, Z+YF-OFF]);
			translate([(X-XB-Y)/2 + XB, 0, 0])
				rounded([Y, Y, Z+YF-OFF], RND)
					cube([Y, Y, Z+YF-OFF]);
			translate([-WX/2, 0, 0])
				rounded([X+WX, YF-OFF, YF-OFF], RND)
					cube([X+WX, YF-OFF, YF-OFF]);
			translate([(X-XB-Y)/2 + Y/6, Y/2, YF])	
				difference() {
					cylinder(d=Y, h=5);
					translate([0, 0, -0.05])
						cylinder(d=Y-2.4, h=5.1);
				}
		}
		{
			translate([-X/2, -YF/2, -YF/2])
				rotate([-45, 0, 0]) {
					cube([2*X, 2*YF, 3*YF]);
					translate([0, -LD, YF*1.08])
						cube([2*X, LD+0.01, LW]);
				}
			translate([(X-XB-Y)/2 + Y/2, Y/2, YF])
				cylinder(d=SD, h=Z*2);		
			translate([(X-XB-Y)/2 + XB+Y/2, Y/2, YF])
				cylinder(d=SD, h=Z*2);		
		}
	}
	rotate([-45, 0, 0])
		translate([-WX, -WY+1, WZ/2-1.5])
			difference() {
				rounded([WX, WY, WZ], RND)
					cube([WX, WY, WZ]);
				{
					translate([-WZ/2, WX/2, WZ/2-WX/2+0.66])
						rotate([0, 90, 0])
							cylinder(d=WD, h=WZ*2);
					translate([-WZ/2, WX/2, WZ/2+WX/2-0.66])
						rotate([0, 90, 0])
							cylinder(d=WD, h=WZ*2);
					translate([WD/4, WX/2, WZ/2-WX/2+0.66])
						rotate([90, 0, 0])
							cylinder(d=WD, h=WZ*2);
					translate([WD/4, WX/2, WZ/2+WX/2-0.66])
						rotate([90, 0, 0])
							cylinder(d=WD, h=WZ*2);
				}
			}
	rotate([-45, 0, 0])
		translate([X+WX/8, -WY+1, WZ/2-1.5])
			rounded([WX/2, WY, WZ], RND)
				cube([WX/2, WY, WZ]);
}

translate([X/2,0.6,WZ-OFF-0.5])
	rotate([90,0,0])
		scale([1,1,1])
			linear_extrude(height=1)
				text(TEXT, halign="center", valign="center",
				spacing=1.0, size=FONTSIZE, font=FONT);
		}