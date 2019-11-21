clipInnerDiam = 5;
clipThikness = 3;
clipHeight = 20;
clipPercentOverlap = 10;
clipAngle = 60;
bevelAngle = 45;

module clip(id=clipInnerDiam,t=clipThikness,h=clipHeight){

	difference(){
		cylinder(r=id/2+t,h=h,$fn=PI*(id/2+t)*5);
		translate([0,0,-.5])
		cylinder(r=id/2,h=h+1,$fn=PI*id/2*5);
	}
}

module pie(radius, angle, height, spin=0) {
    // Negative angles shift direction of rotation
    clockwise = (angle < 0) ? true : false;
    // Support angles < 0 and > 360
    normalized_angle = abs((angle % 360 != 0) ? angle % 360 : angle % 360 + 360);
    // Select rotation direction
    rotation = clockwise ? [0, 180 - normalized_angle] : [180, normalized_angle];
    // Render
    if (angle != 0) {
        rotate([0,0,spin]) linear_extrude(height=height)
            difference() {
                circle(radius);
                if (normalized_angle < 180) {
                    union() for(a = rotation)
                        rotate(a) translate([-radius, 0, 0]) square(radius * 2);
                }
                else if (normalized_angle != 360) {
                    intersection_for(a = rotation)
                        rotate(a) translate([-radius, 0, 0]) square(radius * 2);
                }
            }
    }
}

difference() {
    union() {
        difference() {
            clip();
            translate([0,0,-.5])
            pie(clipInnerDiam+clipThikness, clipAngle, clipHeight+1, -clipAngle/2);
        }

        for (r=[-clipAngle/2,clipAngle/2]) rotate([0,0,r])
            translate([clipInnerDiam/2+clipThikness/2,0,0])
            cylinder(r=clipThikness/2*(1+clipPercentOverlap/100),h=clipHeight,$fn=PI*clipThikness/2*5);
    }

    rotate([0,-bevelAngle,0])
    translate([0,-clipInnerDiam-clipThikness,-clipHeight-0.5])
    cube([(clipInnerDiam+clipThikness)*2, (clipInnerDiam+clipThikness)*2, clipHeight]);
    
    translate([0,-clipInnerDiam-clipThikness,clipHeight+0.5])
    rotate([0,bevelAngle,0])
    cube([(clipInnerDiam+clipThikness)*2, (clipInnerDiam+clipThikness)*2, clipHeight]);
}
