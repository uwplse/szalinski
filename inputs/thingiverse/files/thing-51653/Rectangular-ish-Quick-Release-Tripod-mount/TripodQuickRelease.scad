

//How wide the clip part is flat side to flat side
ShoeBottomWidth = 68;
// The widest part of the angle
ShoeBottomLength = 61; 
//How wide the clip part is flat side to flat side
ShoeTopWidth = 68;
// The narrowest part of the angle
ShoeTopLength = 54; 
// How tall the shoe part is
ShoeDepth = 8;

// How long any 'keying' is on the front/back face of the shoe
FrontDetentLength = 15;
// How wide any 'keying' is on the front/back face of the shoe
FrontDetentWidth = 2;

// How long any 'keying' is on the side of the shoe
SideDetentLength = 16;
// How wide any 'keying' is on the side of the shoe
SideDetentWidth = 3;

TopPlateWidth = 78;
TopPlateLength = 69;
TopPlateDepth = 1;

$fn=50 + 0;

rotate(a=[0,180,0])
{
	difference()
	{
		shoe();
		shoekeys();
		cylinder(h = ShoeDepth, r=3);
		rotate(a=[0,180,0]) translate([0,0,2-ShoeDepth]) cylinder(h = ShoeDepth, r1 = 9, r2 = min(ShoeBottomWidth, ShoeBottomLength, ShoeTopWidth, ShoeTopLength) * .5);
	
	}
	
	// Face Plate
	difference()
	{
		minkowski()
		{
			translate([0,0, ShoeDepth]) cube(size = [TopPlateWidth - TopPlateDepth- TopPlateDepth,TopPlateLength - TopPlateDepth - TopPlateDepth,.001], center = true);
		 	cylinder(r=TopPlateDepth,h=TopPlateDepth);
		}
		translate([0,0, TopPlateDepth * 2]) cylinder(h = ShoeDepth, r=3);
	}
}



module shoe() {
	hull() {
		translate([0,0, .001]) cube(size = [ShoeBottomWidth,ShoeBottomLength,.001], center = true);
 		translate([0,0,ShoeDepth-.001]) cube(size = [ShoeTopWidth,ShoeTopLength,.001], center = true);
	}
}

module shoekeys()
{

	//Front and back keys
	hull()
	{	
		translate([(ShoeTopWidth * .5) - FrontDetentLength, (ShoeTopLength * .5) - ShoeTopLength, 0]) cube(size = [FrontDetentLength,FrontDetentWidth,ShoeDepth], center = false);
		translate([(ShoeBottomWidth * .5) - FrontDetentLength, -(ShoeBottomLength * .5) , 0]) cube(size = [FrontDetentLength,FrontDetentWidth,ShoeDepth], center = false);
	}
	hull()
	{	
		translate([-(ShoeTopWidth * .5) , (ShoeTopLength * .5) - ShoeTopLength, 0]) cube(size = [FrontDetentLength,FrontDetentWidth,ShoeDepth], center = false);
		translate([-(ShoeBottomWidth * .5) , -(ShoeBottomLength * .5) , 0]) cube(size = [FrontDetentLength,FrontDetentWidth,ShoeDepth], center = false);
	}

	hull()
	{	
		translate([(ShoeTopWidth * .5) - FrontDetentLength, (ShoeTopLength * .5) -FrontDetentWidth, 0]) cube(size = [FrontDetentLength,FrontDetentWidth,ShoeDepth], center = false);
		translate([(ShoeBottomWidth * .5) - FrontDetentLength, (ShoeBottomLength * .5) , 0]) cube(size = [FrontDetentLength,FrontDetentWidth,ShoeDepth], center = false);
	}
	hull()
	{	
		translate([-(ShoeTopWidth * .5) , (ShoeTopLength * .5) -FrontDetentWidth, 0]) cube(size = [FrontDetentLength,FrontDetentWidth,ShoeDepth], center = false);
		translate([-(ShoeBottomWidth * .5) , (ShoeBottomLength * .5) , 0]) cube(size = [FrontDetentLength,FrontDetentWidth,ShoeDepth], center = false);
	}

	// Side Keys
	hull()
	{
		translate([(ShoeTopWidth * .5) - SideDetentWidth , (ShoeTopLength * .5) - SideDetentLength, 0]) cube(size = [SideDetentWidth,SideDetentLength,ShoeDepth], center = false);
		translate([(ShoeBottomWidth * .5) - SideDetentWidth , (ShoeBottomLength * .5) - SideDetentLength, 0]) cube(size = [SideDetentWidth,SideDetentLength,ShoeDepth], center = false);
	}
	hull()
	{
	translate([-(ShoeTopWidth * .5)  , (ShoeTopLength * .5) - SideDetentLength, 0]) cube(size = [SideDetentWidth,SideDetentLength,ShoeDepth], center = false);
		translate([-(ShoeBottomWidth * .5)  , (ShoeBottomLength * .5) - SideDetentLength, 0]) cube(size = [SideDetentWidth,SideDetentLength,ShoeDepth], center = false);
	}
	hull()
	{
		translate([(ShoeTopWidth * .5) - SideDetentWidth , -(ShoeTopLength * .5), 0]) cube(size = [SideDetentWidth,SideDetentLength,ShoeDepth], center = false);
		translate([(ShoeBottomWidth * .5) - SideDetentWidth , -(ShoeBottomLength * .5), 0]) cube(size = [SideDetentWidth,SideDetentLength,ShoeDepth], center = false);
	}
	hull()
	{
	translate([-(ShoeTopWidth * .5)  , -(ShoeTopLength * .5) , 0]) cube(size = [SideDetentWidth,SideDetentLength,ShoeDepth], center = false);
		translate([-(ShoeBottomWidth * .5)  , -(ShoeBottomLength * .5) , 0]) cube(size = [SideDetentWidth,SideDetentLength,ShoeDepth], center = false);
	}
}