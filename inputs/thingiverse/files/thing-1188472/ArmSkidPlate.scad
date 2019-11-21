armDiameter=32;
plateTilt=2;
screwHeight=0.5;
height=2.5;

motorAxleIndent=0.5;

holeDiameter=3;
holeHeadDiameter=6;
holeDistanceMin=8;
holeDistanceMax=10;

difference() {
    cylinder(d=armDiameter,d2=armDiameter-plateTilt,h=height,$fn=64);
	 cylinder(d=holeDistanceMin,h=motorAxleIndent,$fn=64);
	
    for(r=[0,90,180,270])
    {
        rotate([0,0,r+45])
        union() {
				translate([holeDistanceMin,0,-1])
				cylinder(d=holeDiameter,h=height,$fn=32);
            translate([holeDistanceMin,0,screwHeight])
            cylinder(d=holeHeadDiameter,d2=holeHeadDiameter+plateTilt,h=height,$fn=32);

				translate([holeDistanceMin,-holeDiameter/2,-1])
				cube([holeDistanceMax-holeDistanceMin,holeDiameter,height]);

				translate([holeDistanceMax,0,-1])
				cylinder(d=holeDiameter,h=height,$fn=32);
            translate([holeDistanceMax,0,screwHeight])
            cylinder(d=holeHeadDiameter,d2=holeHeadDiameter+plateTilt,h=height,$fn=32);
        }
    }
}
