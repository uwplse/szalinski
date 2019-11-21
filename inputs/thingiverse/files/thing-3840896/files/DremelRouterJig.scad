$fn=72;

FixingPlateMiddleDiameter=35;
FixingPlateThickness=15;
SlidesDiameter=8;
SlidesLength=20;
SlidesInteraxis=100;

BaseMiddleDiameter=123;
BasePlateThickness=20;
BaseMiddleHoleDiameter=30;
BaseMiddleHoleRecessDiameter=50;
BaseSideSquaringWidth=70;

Part=0;

if(Part==1 || Part==0)
difference()
{
	union()
	{
		hull()
		{
			translate([0,0,-2.5])
				cylinder(d=FixingPlateMiddleDiameter,h=10,center=true);

			translate([0,-SlidesInteraxis/2,0])
				cylinder(d=SlidesDiameter+8,h=FixingPlateThickness,center=true);
		}
		hull()
		{
			translate([0,0,-2.5])
				cylinder(d=FixingPlateMiddleDiameter,h=10,center=true);

			translate([0,SlidesInteraxis/2,0])
				cylinder(d=SlidesDiameter+8,h=FixingPlateThickness,center=true);
		}

		translate([0,SlidesInteraxis/2,SlidesLength/2-FixingPlateThickness/2])
			cylinder(d=SlidesDiameter+8,h=SlidesLength,center=true);
		translate([0,-SlidesInteraxis/2,SlidesLength/2-FixingPlateThickness/2])
			cylinder(d=SlidesDiameter+8,h=SlidesLength,center=true);

	}

	translate([0,SlidesInteraxis/2,SlidesLength/2-FixingPlateThickness/2])
		cylinder(d=SlidesDiameter,h=SlidesLength+2,center=true);
	translate([0,-SlidesInteraxis/2,SlidesLength/2-FixingPlateThickness/2])
		cylinder(d=SlidesDiameter,h=SlidesLength+2,center=true);

	translate([0,0,-FixingPlateThickness/2-0.01])
		linear_extrude(twist=-360*8,height=FixingPlateThickness+0.02)
			translate([0.75,0,0])
				circle(d=19);
}

if(Part==2 || Part==0)
rotate([0,180,0])
translate([0,0,-80])
difference()
{
	union()
	{
		translate([0,0,-BasePlateThickness/4])
		cylinder(d=BaseMiddleDiameter,h=BasePlateThickness/2,center=true);

		hull()
		{
			translate([0,0,-BasePlateThickness/4])
			cylinder(d=BaseMiddleHoleRecessDiameter*1.5,h=BasePlateThickness/2,center=true);

			translate([0,SlidesInteraxis/2,0])
				cylinder(d=SlidesDiameter+15,h=BasePlateThickness,center=true);
			translate([0,-SlidesInteraxis/2,0])
				cylinder(d=SlidesDiameter+15,h=BasePlateThickness,center=true);
		}
	}

	translate([0,SlidesInteraxis/2,0])
		cylinder(d=SlidesDiameter,h=SlidesLength+2,center=true);
	translate([0,-SlidesInteraxis/2,0])
		cylinder(d=SlidesDiameter,h=SlidesLength+2,center=true);

	translate([0,SlidesInteraxis/2,-BasePlateThickness+13])
		cylinder(d=15,h=BasePlateThickness,center=true,$fn=6);
	translate([0,-SlidesInteraxis/2,-BasePlateThickness+13])
		cylinder(d=15,h=BasePlateThickness,center=true,$fn=6);

	translate([0,0,0])
		cylinder(d=BaseMiddleHoleDiameter,h=BasePlateThickness+2,center=true);
	translate([0,0,12])
		scale([1.5,1,1])
			cylinder(d=BaseMiddleHoleRecessDiameter,h=BasePlateThickness+2,center=true);
	translate([0,0,5])
		scale([1,1,1])
			cylinder(d=BaseMiddleHoleRecessDiameter,h=BasePlateThickness+2,center=true);

	translate([500+BaseSideSquaringWidth/2,0,0])
		cube([1000,1000,1000],center=true);
	translate([-500-BaseSideSquaringWidth/2,0,0])
		cube([1000,1000,1000],center=true);
}
