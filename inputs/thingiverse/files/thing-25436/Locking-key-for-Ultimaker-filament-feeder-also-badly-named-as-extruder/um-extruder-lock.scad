tol=0.01;
armWidth=6;
armLength=20;
armHeight1=5.0;
armHeight2=7.5;
handleHeadSize=6;
handleDiameter= armHeight2;

armGap=16-armWidth*2;
$fn=20;
module arm()
{
	difference()
	{
		hull()
		{
			cube([armWidth+armGap+armWidth,tol,armHeight1]);
			translate([0,armLength-tol,0])
				cube([armWidth+armGap+armWidth,tol,armHeight2]);
		}
		translate([armWidth,-tol,-tol])
			cube([armGap,armLength,armHeight2+0.01]);
	}
	rotate([0,90,0])
	{
		hull()
		{
			translate([-handleDiameter/2,armLength,-handleHeadSize/2])
				sphere(r=handleDiameter/2);
			translate([-handleDiameter/2,armLength,armWidth+armGap+armWidth+handleHeadSize/2])
				sphere(r=handleDiameter/2);
		}
	}
}

arm();

