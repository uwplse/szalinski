$fa = 1 +0;
$fs = 1 +0;

width = 45;
length = 45;
height = 35;

gapCurveDiameter = 60;
gapWidthAtBottom = 2;
gapWidthAtTop = 6;
gapOffsetTowardsFront = 6;
gapOffsetFromBottom = 4;
gapAngle = 10;

xScale = length / width;
zScale = height / (width/2);

rotate([0,0,-90]) difference() {
	scale([xScale,1,zScale]) difference() {
		sphere(d=width);
		translate([-length, -length, -height])
			cube([length*2, length*2, height]);
	}

	translate([gapOffsetTowardsFront,0,gapOffsetFromBottom])
		rotate([0,-gapAngle,0])
			translate([gapCurveDiameter/2, 0, 0])
				difference() {
					cylinder(d=gapCurveDiameter, h=height-gapOffsetFromBottom+1.5);
					translate([0,0,-0.01])
						cylinder(
							d1=gapCurveDiameter-2*gapWidthAtBottom,
							d2=gapCurveDiameter-2*gapWidthAtTop,
							h=height-gapOffsetFromBottom
						);
			}
}