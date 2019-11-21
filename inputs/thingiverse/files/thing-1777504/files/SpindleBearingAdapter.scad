$fn=50;
spindleInnerDia = 49.5;
bearingOuterDia = 22.5;
bearingInnerDia = 18;

maxDia = spindleInnerDia + 15;

totalWidth = 62;
bearingWidth = 8;
ringWidth = 2.5;
thickness = 2;
bearingStopThickness = 1;

module spindleBearingAdapter()
{
    // Spindle:
	difference() {
		union() {
			cylinder(d = maxDia, h = ringWidth);
	      	cylinder(d = spindleInnerDia, h = totalWidth);
		}
        //Empty out external cylinder
        translate([0,0,ringWidth]) cylinder(d = spindleInnerDia-2*thickness, h = totalWidth);
        //BEGIN Break cilynders 
        translate([-maxDia/2,-thickness,ringWidth]) cube([maxDia, 2*thickness, totalWidth]);
        translate([-thickness,-maxDia/2,ringWidth]) cube([2*thickness, maxDia, totalWidth]);
        //END Break cilynders 
      	cylinder(d = bearingInnerDia, h = totalWidth+2);
        translate([0,0,bearingStopThickness])
      	cylinder(d = bearingOuterDia, h = totalWidth+2);
	}
    // Bearing:
	difference() {
        totalBearingWidth = bearingWidth + 5;
		cylinder(d = bearingOuterDia+2*thickness, h = totalBearingWidth);
		cylinder(d = bearingOuterDia-1, h = totalBearingWidth);
		cylinder(d = bearingOuterDia, h = bearingWidth+1);
        //BEGIN Break cilynders 
        translate([-maxDia/2,-thickness,ringWidth]) cube([maxDia, 2*thickness, totalWidth]);
        translate([-thickness,-maxDia/2,ringWidth]) cube([2*thickness, maxDia, totalWidth]);
        //END Break cilynders 
    }
    
}

spindleBearingAdapter();

