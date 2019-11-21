$fn=200;

gBinHeight=100;
gBinWidth=100;
gBinThickness=3;

gBinName="Recycle";

difference()
{
	minkowski()
	{
		translate([1,1,0]*-gBinWidth/2)
		cube([gBinWidth, gBinWidth, gBinHeight]);
		cylinder(r=2, h=1);


	}

	for(i = [0:3])
	{
		rotate([0,0,90*i])
		translate([0,-gBinWidth/2+gBinThickness,gBinHeight-17])
		rotate([90,0,0])
		linear_extrude(gBinThickness*2)
		text(gBinName, halign="center", valign="center");
	}
	
	minkowski()
	{
		translate([1,1,0]*-(gBinWidth/2-gBinThickness))
		translate([0,0,gBinThickness])
		cube([gBinWidth-gBinThickness*2, gBinWidth-gBinThickness*2, gBinHeight]);
		cylinder(r=2, h=1);
	}
}
