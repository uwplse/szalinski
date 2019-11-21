/* One-piece Watch band by Ryan Huang, written on 28/10/2018, Thingiverse ID: yyh1002
*/

//width of the watch band
bandWidth = 20; 

//length of band
bandLength = 145; 

//thickness of band
bandThickness = 1.2; 

//diameter of the ends of band
endDiameter = 4.3;

//diameter of the pins
pinDiameter = 2;

//distance between the edge of window opening for peg and the edge of band
windowOffset = 2.4; 

//height of the window opening for pins
windowHeight = 3; 

//chamfer size
chamfer = 0.2;

//wear hand of watch
watchWearHand = 0; //[0:left, 1:right]

//circle resolution of band strap
resolutionStrap = 192;

//circle resolution of ends
$fn=24;

bandRadius = bandLength*0.212;

filletAngle = 90*(bandThickness/endDiameter);

filletRadius = 1*bandRadius*(bandThickness/endDiameter)*(bandThickness/endDiameter)+1*endDiameter/2;

strapProfilePts = [
    [-bandThickness/2-chamfer,0],
    [-chamfer,0],
    [0,chamfer],
    [0,bandWidth-chamfer],
    [-chamfer,bandWidth],
    [-bandThickness+chamfer,bandWidth],
    [-bandThickness,bandWidth-chamfer],
    [-bandThickness,chamfer],
    ];

endProfilePts = [
    [pinDiameter/2,0],
    [endDiameter/2-chamfer,0],
    [endDiameter/2,chamfer],
    [endDiameter/2,bandWidth-chamfer],
    [endDiameter/2-chamfer,bandWidth],
    [pinDiameter/2,bandWidth],
    ];

trimPts = [
    [-chamfer,0],
    [0,chamfer],
    [0,bandWidth-chamfer],
    [-chamfer,bandWidth],
    [2*bandRadius,bandWidth],
    [2*bandRadius,0],
    ];

module teardrop_flat(diameter) {
	union() {
		circle(r = diameter/2, $fn = 100, center=true);
		rotate(45) square(diameter/2);
	}
}


module cross_section(diameter, thickness) {
	difference() {
		teardrop_flat(diameter);
		teardrop_flat(diameter - thickness*2);
		translate([0,-diameter/2,0]) square([diameter*2,diameter], center=true);
	}
}

module pie_slice(radius, angle, step) {
	for(theta = [0:step:angle-step]) {
		rotate([0,0,0])
		linear_extrude(height = bandWidth*2, center=true)
		polygon( 
			points = [
				[0,0],
				[radius * cos(theta+step) ,radius * sin(theta+step)],
				[radius*cos(theta),radius*sin(theta)]
			] 
		);
	}
}

module partial_rotate_extrude(angle, radius, convex) {
	intersection () {
		rotate_extrude(convexity=convex) translate([radius,0,0]) child(0);
		pie_slice(radius*2, angle, angle/5);
	}
}

module bandMesh(){
union() {
partial_rotate_extrude(270, bandRadius, $fn=resolutionStrap)
    polygon( strapProfilePts );
/*
translate([bandRadius-endDiameter/2,0,0]) 
    partial_rotate_extrude(-270+filletAngle, endDiameter/2)
        polygon( strapProfilePts );
*/
translate([bandRadius-endDiameter/2-(filletRadius+endDiameter/2)*sin(filletAngle),(filletRadius+endDiameter/2)*cos(filletAngle),0]) 
    rotate([0,0,-90+filletAngle])
        partial_rotate_extrude(90-1*filletAngle, filletRadius+bandThickness)
        polygon( strapProfilePts );
/*
translate([0,-bandRadius+endDiameter/2,0]) 
    rotate([0,0,-90])
        partial_rotate_extrude(270-filletAngle, endDiameter/2)
        polygon( strapProfilePts );
*/
translate([-(filletRadius+endDiameter/2)*cos(filletAngle),-bandRadius+endDiameter/2+(filletRadius+endDiameter/2)*sin(filletAngle),0]) 
    rotate([0,0,-filletAngle])
        partial_rotate_extrude(-90+1*filletAngle, filletRadius+bandThickness)
        polygon( strapProfilePts );
translate([bandRadius-endDiameter/2,0,0])
    rotate_extrude()
        polygon( endProfilePts );
translate([0,-bandRadius+endDiameter/2,0])
    rotate_extrude()
        polygon( endProfilePts );
}
}

module windowOpeningProfile(){
linear_extrude(endDiameter/2)
union(){
    translate([-windowHeight/2+pinDiameter/2,0,0]) circle(d=pinDiameter);
    square([windowHeight-pinDiameter,pinDiameter],center=true);
    translate([windowHeight/2-pinDiameter/2,0,0]) circle(d=pinDiameter);
}
}
module windowOpeningMesh(){
translate([bandRadius+(watchWearHand-1)*endDiameter/2,0,bandWidth-windowOffset-windowHeight/2])
    rotate(-90,[0,1,0])
        windowOpeningProfile();
translate([0,-bandRadius+watchWearHand*endDiameter/2,bandWidth-windowOffset-windowHeight/2])
    rotate(90,[0,0,1])
    rotate(90,[0,1,0])
        windowOpeningProfile();
}

module pinHoleMesh(){
    translate([bandRadius-endDiameter/2,0,0])
        cylinder(h=bandWidth,d=pinDiameter);
    translate([0,-bandRadius+endDiameter/2,0])
        cylinder(bandWidth,d=pinDiameter);
}

module trimMesh(){
    rotate_extrude(angle = 360,$fn=resolutionStrap)
        translate([bandRadius,0,0]) polygon( trimPts );
}

difference(){
    bandMesh();
    windowOpeningMesh();
    pinHoleMesh();
    trimMesh();
}

