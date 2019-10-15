// total length of device less the length of the type A connector
LengthOfBody=44;
// thickness from centerline of type A connector to bottom
// if the device is symmetrical, this value is the thickness of the body / 2
BottomHalfBodyThickness=5;
// tab hight to hold device in place
HeightOfLatch=5;


difference()
{
	// a cube to hold the USB type A connector
	// on the device
	cube([10,19,14]);
	
	// make a hole to slide the type A connector into
	translate([((BottomHalfBodyThickness*2)-5)/2,(19-13)/2,0])
	cube([5,13,15]);
}

// bottom plate to hold everything together
translate([-3,0,0])
cube([3,19,LengthOfBody+14]);

// clip to hold the device in place
translate([-3,0,LengthOfBody+14])
cube([HeightOfLatch,19,3]);



