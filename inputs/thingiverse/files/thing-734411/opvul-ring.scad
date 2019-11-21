$fa = .05;
$fn = 200;

// Inner diameter
InnerDiameter = 27.2; 

// Outer diameter
OuterDiameter = 31.5; 

//Width of the Gap
OpenGap = 3; 

// Heigth
Heigth = 70; 
HeigthTop = 1;
TopOverHang = 2;

//=============START===================

InnerRadius = InnerDiameter/2; 
OuterRadius = OuterDiameter/2;

openCyl(Heigth,InnerRadius,OuterRadius, OpenGap);

translate([0,0,Heigth/2])
openCyl(HeigthTop,InnerRadius,OuterRadius+TopOverHang, OpenGap);

module openCyl(CylHeigth,CylInnerRadius, CylOuterRadius, CylOpengap){
	difference(){
		cylinder(CylHeigth,CylOuterRadius,CylOuterRadius, true);
		cylinder(CylHeigth+1,CylInnerRadius,CylInnerRadius, true);

		rotate([0,0,90])
		translate([100,0,0])
		cube([200,CylOpengap,CylHeigth+1], true);

	}
}