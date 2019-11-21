//
//	Customizable Horn
//		Steve Medwin
//		May 29, 2014
//
$fn=120*1;
//
//	Customizing
//

Height=30;	// [10:100]
Twist=90;	// [0:360]
Taper=3;		// [1:10]
Offset=5;	// [0:10]
Radius=4;	// [1:10]
//(Must be less than radius or will be set to one) 
Thickness=1;	//	[1:9]

module ring(){
	difference() {
		circle(r = Radius);
		if (Thickness>Radius) {
			circle(r=Radius-1);
		} else {
			circle(r = Radius-Thickness);
		}
	}
}

translate([0,0,Height]) 
rotate(a=[0,180,0]) {
	linear_extrude(height = Height, center = false, convexity = 10, twist = Twist, scale=Taper)
	translate([Offset, 0, 0]) ring();
}


