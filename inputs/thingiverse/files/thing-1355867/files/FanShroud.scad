// Fanshroud by skytale

/* [e3d fan shroud] */
// Select your extruder:
extruderDiameter = 22.4; // [22.4:e3d v6, 25:e3d v5]
// Height of the shroud:
extruderHeight = 30; // [30:40]
// Do you want a fan mount?
fan = true; // [true:yes,false:no]
// Height of the fan mount from bottom. Use values inbetween 0-3.
fanHeight = 2;
//Create support structure for fan mount?
support = true; 
// Do you want a blTouch mount?
blTouch = true; // [true:yes,false:no]
// Height of the blTouch mount from bottom. Use values inbetween 18-28.
blTouchHeight = 23.7;
// Do you want mounting holes?
mountingHoles = true; // [true:yes,false:no]

/* [Misc Parameters] */
overlap = 9.5;
ventDistance = 18;
cornerRadius = 2;
fanSize = 30;

/* [Hidden] */
fn = 40;

module shroud() {
	hull() {
		translate([-overlap + cornerRadius, -fanSize / 2 + cornerRadius, cornerRadius]) sphere(cornerRadius, $fn = fn);
		translate([0, -fanSize / 2 + cornerRadius, cornerRadius]) rotate([0,90,0]) cylinder(ventDistance,cornerRadius,cornerRadius,$fn = fn);
		translate([0, +fanSize / 2 - cornerRadius, cornerRadius]) rotate([0,90,0]) cylinder(ventDistance,cornerRadius,cornerRadius,$fn = fn);
		translate([-overlap + cornerRadius, +fanSize / 2 - cornerRadius, cornerRadius]) sphere(cornerRadius, $fn = fn);

		translate([-overlap + cornerRadius, -fanSize / 2 + cornerRadius, extruderHeight - cornerRadius]) sphere(cornerRadius, $fn = fn);
		translate([0, -fanSize / 2 + cornerRadius, extruderHeight - cornerRadius]) rotate([0,90,0]) cylinder(ventDistance,cornerRadius,cornerRadius,$fn = fn);
		translate([0, +fanSize / 2 - cornerRadius, extruderHeight - cornerRadius]) rotate([0,90,0]) cylinder(ventDistance,cornerRadius,cornerRadius,$fn = fn);
		translate([-overlap + cornerRadius, +fanSize / 2 - cornerRadius, extruderHeight - cornerRadius]) sphere(cornerRadius, $fn = fn);
	}
}

module extruder() {
	cylinder(extruderHeight, extruderDiameter/2, extruderDiameter/2, $fn = fn);
}

module airFlow() {
	translate([0,0,fanSize/2]) rotate([0,90,0]) cylinder(ventDistance+1, fanSize/2 - 2, fanSize/2 - 2, center=false, $fn = fn);
}

module fanHoles() {
dia = 3.2;
depth = 10;
holeDist = 12;
translate([ventDistance-depth, -holeDist, fanSize/2-holeDist]) rotate([0,90,0]) cylinder(depth+1,dia/2,dia/2,$fn = fn);
translate([ventDistance-depth, -holeDist, fanSize/2+holeDist]) rotate([0,90,0]) cylinder(depth+1,dia/2,dia/2,$fn = fn);
translate([ventDistance-depth, +holeDist, fanSize/2+holeDist]) rotate([0,90,0]) cylinder(depth+1,dia/2,dia/2,$fn = fn);
translate([ventDistance-depth, +holeDist, fanSize/2-holeDist]) rotate([0,90,0]) cylinder(depth+1,dia/2,dia/2,$fn = fn);
}

module mountingHoles() {
	dia = 3;
	depth = 3;
	holeDist = 14.5;
	holeOffset = 7;
	translate([holeDist,holeOffset, extruderHeight-depth]) cylinder(depth+1,dia/2,dia/2,$fn = fn);
	translate([holeDist,-holeOffset, extruderHeight-depth]) cylinder(depth+1,dia/2,dia/2,$fn = fn);
}

module fanHook() {
	magnetDia = 6.6;
	magnetDepth = 3;
	magnetDistance = 7.75;
	hookWidth = 8.5;
	hookHeight = 13;
	hookDepth = 4;
	hookRillDia = 3.2;
	supportWidth = 1;

	rotate([90,0,180])
	translate([0,hookWidth/2,0])
	difference(){
		union() {
			cylinder(hookDepth,hookWidth/2,hookWidth/2,$fn = fn);
			translate([-hookWidth/2, 0, 0]) cube([hookWidth, hookHeight, hookDepth], center = false);
		}
		translate([0,0,hookDepth-magnetDepth])cylinder(magnetDepth+1,magnetDia/2,magnetDia/2,$fn = fn);
		translate([0,magnetDistance,hookDepth-magnetDepth]) cylinder(magnetDepth+1,magnetDia/2,magnetDia/2,$fn = fn);
		translate([-hookWidth/2-1, hookHeight, hookDepth/2]) rotate([0,90,0]) cylinder(hookWidth+2,hookRillDia/2,hookRillDia/2,$fn = fn);
		translate([-hookWidth/2-1,hookHeight-0.6,hookDepth/2]) cube([hookWidth+2, 1, hookDepth/2+1], center = false);
	}
	if (support) translate([-supportWidth/2,0,-fanHeight]) cube([supportWidth, hookDepth,fanHeight+0.5], center = false);
}

module blTouch() {
	LatchWidth = 26;
	LatchDepth = 11.53;
	btHoleDia = 3;
	btHoleDist = 18;
	btHoleDepth = 4;
	btBodySpace = 13.5; // 13 + 0.5
	spacer = 0.5;

	translate([-LatchWidth/2,-fanSize/2,0])
	rotate([90,0,90])
	difference() {
		linear_extrude(height = LatchWidth, center = false, convexity = 10, twist = 0)
			polygon(points=[[0,blTouchHeight/2],[-LatchDepth,blTouchHeight],[0,blTouchHeight]], paths=[[0,1,2]]);	
		translate([-LatchDepth,0,LatchWidth/2-btBodySpace/2]) cube([LatchDepth, blTouchHeight, btBodySpace], center = false);
		translate([-LatchDepth/2,blTouchHeight-btHoleDepth,LatchWidth/2-btHoleDist/2]) rotate([-90,0,0]) cylinder(blTouchHeight+1,btHoleDia/2,btHoleDia/2,$fn = fn);
		translate([-LatchDepth/2,blTouchHeight-btHoleDepth,LatchWidth/2+btHoleDist/2]) rotate([-90,0,0]) cylinder(blTouchHeight+1,btHoleDia/2,btHoleDia/2,$fn = fn);
	}
}

difference() {
	union() {
		shroud();
		if (fan) translate([0,fanSize/2,fanHeight]) fanHook();
	}
	extruder();
	airFlow();
	fanHoles();
	if (mountingHoles) mountingHoles();
}
if (blTouch) translate([ventDistance-13,0,0]) blTouch();
