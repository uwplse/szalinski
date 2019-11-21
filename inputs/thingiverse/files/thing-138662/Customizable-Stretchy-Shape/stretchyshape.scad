// stretchy bands

// (not including the curved parts)
_1_insideDiameter = 36; //[1:300]

// (not including the curved parts)
_2_outsideDiameter = 48; //[1:300]

_3_height = 6; //[1:100]

// number of loops around the ring
_4_radialCount = 6; //[2:60]

// twist
_5_twist = 0.0;

// number of slices per mm
_6_slices = 1;

// (of the arcs)
_7_resolution = 48; //[24:Low, 36:Medium, 48:High, 64:VeryHigh]



linear_extrude( height = _3_height,
	center = true,
	convexity = _4_radialCount,
	twist = _5_twist,
	slices = _5_twist == 0 ? 1 : max(1,_6_slices*_3_height) )

	stretchyShape(	_1_insideDiameter > _2_outsideDiameter ? _2_outsideDiameter/2 : _1_insideDiameter/2, 
					_2_outsideDiameter/2, 
					_4_radialCount, 
					0, 
					$fn=_7_resolution
);


module stretchyShape(r1, r2, count, thickness) {

	angle = 180/count;
	eps = 0.1;
	overlap = 2;

	cord2 = 2 * r2 * sin(angle/2);
	outsideArc = 180 + angle + overlap;
	outsideRadius = cord2/sin(90-angle/2)/2;
	outsideOffset = r2 * cos(angle/2) + cos(90-angle/2) * outsideRadius;

	insideArc = 180 - angle + overlap;
	cord1 = 2 * r1 * sin(angle/2);
	insideRadius = cord1/sin(90-angle/2)/2;
	insideOffset = r1 * cos(angle/2) + cos(90-angle/2) * insideRadius;

	union()
	{
		for(a = [0:angle*2:360])
			rotate([0,0,a])
				for(b=[0,angle])
					rotate([0,0,angle/2 - b])
						translate( [(b==0?+1:-1)*insideRadius,r1 + (r2-r1)/2,0] )
							square( [insideRadius*2+thickness, r2 - r1 + eps], center=true);

	for(a = [0:angle*2:360])
		rotate([0,0,a])
			translate([0,outsideOffset,0])
				circle( r = outsideRadius+thickness/2, center = true );
	
	difference()
	{
		circle( r = insideOffset, center = true );	
		for(a = [0:angle*2:360])
			rotate([0,0,a+angle])
				translate([0,insideOffset,0])
					circle(r = insideRadius-thickness/2, center = true );
	}
	}
}
