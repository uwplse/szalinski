$fn=180;

SphereDiameter=180;	//Diameter of the main sphere
SphereOffsetZ=-35;

CardSlotsRadius=72;	//Set radial position of first row of slots
CardSlotsRadiusIncrease=20;	//Set increase of radial position for each rown
CardSlotsInclination=-40;		//Set inclination of each slot
CardSlotsInclinationIncrease=10;		//Each row will be added this inclination from first row value
CardSlotsStartRotation=51;
CardSlotsRotationIncrease=15;		//Set extra rotation around Z axis that increase for each row
CardSlotsTransversalRotation=50;
CardSizeX=25;
CardSizeY=3;
CardSizeZ=33;
CardSlotsOffsetZ=-10;	//Set vertical offset for each slot
CardSlotsOffsetZIncrease=-12;	//Set an increase of Z offset that increase with row number. Can be positive or negative
SlotGroupOffsetZ=-10;	//Set vertical offset for all slots together
CardSlotsNumber=15;  //Number of slots for each ring
CardSlotsNumberIncrease=0;
CardSlotsRows=1;

//As card slots parameters, but for cylindrical slots

PenSlotsRadius=0;
PenSlotsRadiusIncrease=8;
PenSlotsInclination=0;
PenSlotsInclinationIncrease=10;		//Each row will be added this inclination from first row value
PenSlotsStartRotation=0;
PenSlotsRotationIncrease=0;
PenSlotsTransversalRotation=0;
PenSlotsDiameter=8;
PenSlotsOffsetZ=13;
PenSlotsOffsetZIncrease=0;
PenGroupOffsetZ=15;
PenSlotsNumber=1;  //Number of slots for each ring
PenSlotsNumberIncrease=6;
PenSlotsRows=5;

CentralSlot=0; 	//Add a concave area in the top of the sphere
ShowCentralSlotSphere=0;
CentralSlotSphereDiameter=170;
CentralSlotSphereOffsetZ=90;

ShowInserts=0;
Section=0;

difference()
{
	union()
	{
		translate([0,0,SphereOffsetZ])
		sphere(d=SphereDiameter);
	}

	translate([0,0,SlotGroupOffsetZ])
		for(b=[0:1:CardSlotsRows-1])
			rotate([0,0,CardSlotsStartRotation+CardSlotsRotationIncrease*b])
				for(a=[0:1:CardSlotsNumber+CardSlotsNumberIncrease*b])
				{
					rotate([-CardSlotsInclinationIncrease*b,0,a*360/(CardSlotsNumber+CardSlotsNumberIncrease*b)])
						translate([0,CardSlotsRadius+CardSlotsRadiusIncrease*b,CardSizeZ])
							rotate([CardSlotsInclination,0,CardSlotsTransversalRotation])
								translate([0,0,CardSlotsOffsetZ+CardSlotsOffsetZIncrease*b])
									cube([CardSizeX,CardSizeY,CardSizeZ],center=true);
					if(ShowInserts==1)
						%color("royalblue")
							rotate([-CardSlotsInclinationIncrease*b,0,a*360/(CardSlotsNumber+CardSlotsNumberIncrease*b)])
								translate([0,CardSlotsRadius+CardSlotsRadiusIncrease*b,CardSizeZ])
									rotate([CardSlotsInclination,0,CardSlotsTransversalRotation])
										translate([0,0,CardSlotsOffsetZ+CardSlotsOffsetZIncrease*b])
											cube([CardSizeX-1,CardSizeY-1,CardSizeZ-1],center=true);
				}

	translate([0,0,PenGroupOffsetZ])
		for(b=[0:1:PenSlotsRows-1])
			rotate([0,0,PenSlotsStartRotation+PenSlotsRotationIncrease*b])
				for(a=[0:1:PenSlotsNumber+PenSlotsNumberIncrease*b])
				{
					rotate([-PenSlotsInclinationIncrease*b,0,a*360/(PenSlotsNumber+PenSlotsNumberIncrease*b)])
						translate([0,PenSlotsRadius+PenSlotsRadiusIncrease*b,0])
							rotate([PenSlotsInclination,PenSlotsTransversalRotation,0])
								translate([0,0,PenSlotsOffsetZ+PenSlotsOffsetZIncrease*b])
									cylinder(d=PenSlotsDiameter,h=100);
					if(ShowInserts==1)
						%color("White")
							rotate([-PenSlotsInclinationIncrease*b,0,a*360/(PenSlotsNumber+PenSlotsNumberIncrease*b)])
								translate([0,PenSlotsRadius+PenSlotsRadiusIncrease*b,0])
									rotate([PenSlotsInclination,PenSlotsTransversalRotation,0])
										translate([0,0,PenSlotsOffsetZ+PenSlotsOffsetZIncrease*b])
											cylinder(d=PenSlotsDiameter,h=100);
				}

	if(ShowCentralSlotSphere==1 && CentralSlot==1)
		%translate([0,0,CentralSlotSphereOffsetZ])
			sphere(d=CentralSlotSphereDiameter);
	if(CentralSlot==1)
		translate([0,0,CentralSlotSphereOffsetZ])
			sphere(d=CentralSlotSphereDiameter);

	translate([0,0,-SphereDiameter])
		cube([SphereDiameter*2,SphereDiameter*2,SphereDiameter*2],center=true);

	if(Section==1 || Section==3)
		translate([-SphereDiameter,0,0])
			cube([SphereDiameter*2,SphereDiameter*2,SphereDiameter*2],center=true);
	if(Section==2 || Section==3)
		translate([0,-SphereDiameter,0])
			cube([SphereDiameter*2,SphereDiameter*2,SphereDiameter*2],center=true);
}
