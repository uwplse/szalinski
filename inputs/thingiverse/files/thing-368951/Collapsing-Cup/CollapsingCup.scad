$fn = 60;
module HollowCylinders(HeightOfSection,WallThickness,BottomOuterRadius,StartingTopRadius)
{
	difference()
	{
		cylinder(HeightOfSection,BottomOuterRadius,StartingTopRadius);
		cylinder(HeightOfSection,BottomOuterRadius-WallThickness,StartingTopRadius-WallThickness);
	}
}



module NestingPolygons(WallThickness,StartingTopRadius,BottomOuterRadius,EndingTopRadius,NumberOfCones,HeightOfSection)
{
for(RadiusDifference = [0:((StartingTopRadius-EndingTopRadius)/NumberOfCones):(StartingTopRadius-EndingTopRadius)-((StartingTopRadius-EndingTopRadius)/NumberOfCones)])
	{
		HollowCylinders(HeightOfSection,WallThickness,BottomOuterRadius-RadiusDifference,StartingTopRadius-RadiusDifference);
	}
}








module CollapsingCup(WallThickness,StartingTopRadius,BottomOuterRadius,EndingTopRadius,NumberOfCones,HeightOfSection,BottomThickness)
{
	cylinder( h = BottomThickness, r = EndingTopRadius+(WallThickness/2)+((StartingTopRadius-EndingTopRadius)/NumberOfCones));	
	rotate([180,0,0])
	{
	translate([0,0,-HeightOfSection])
NestingPolygons(WallThickness,StartingTopRadius,BottomOuterRadius,EndingTopRadius,NumberOfCones,HeightOfSection);
	}
}








CollapsingCup(2/5,100/5,125/5,45/5,4,60/5,4/5);

//NestingPolygons(2/5,100/5,125/5,45/5,4,60/5);























