
// Wheel
wheelHeight        =   3;
wheelDiameter      =  12;
wheelInnerDiameter =   8;
wheelPrecision     = 300;

// Axis
axisHeight       = 6;
axisDiameter     = 4;
axisHoleDiameter = 1.5;
axisHoleHeight   = 5 ;

// Surface
nStripes        = 50;
stripeRadius    =  0.5;
stripePresision = 10;

// Radius
nRadius =6;
radiusWidth = 1;

// Axis
difference(){
	cylinder(axisHeight,     axisDiameter/2,     axisDiameter/2,     center = false, $fn=wheelPrecision);
translate([0,0,axisHeight -axisHoleHeight ]) 
	cylinder(axisHoleHeight, axisHoleDiameter/2, axisHoleDiameter/2, center = false, $fn=wheelPrecision);
}

// Wheel
difference(){
	cylinder(wheelHeight, wheelDiameter/2     , wheelDiameter/2,      center = false, $fn=wheelPrecision);
	cylinder(wheelHeight, wheelInnerDiameter/2, wheelInnerDiameter/2, center = false, $fn=wheelPrecision);

}

// WheelSurface
WheelSurface();

// Radius
WheelRadius();

module WheelSurface() {
	for(i=[0:nStripes]) 
		rotate([0,0,i*360/nStripes])
    		translate([wheelDiameter/2 - stripeRadius/2  ,0,0]) 
        		tooth(); 
}

module tooth () {
	cylinder(wheelHeight, stripeRadius, stripeRadius, center = false,$fn=stripePresision);
}

module WheelRadius(){
for(i=[0:nRadius]) 
	rotate([0,0,i*360/nRadius])
   	SingleRadius(); 
}

module SingleRadius(){
	translate([axisHoleDiameter, -radiusWidth/2, 0])
		cube([(wheelInnerDiameter-axisHoleDiameter)/2, radiusWidth, wheelHeight]);
}
