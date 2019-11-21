//Heigth of the Foot
FootHeigth = 15; //[5:50]

//Top foot size
TopWith = 10; //[5:30]

//Bottom foot size
BottomWith = 8; //[5:30]

//Hole diameter
HoleDiameter = 2; //[0.5:5]

//Size of the screw / nail
HeadHigth = 2; //[1:10]

//Size of the screw / nail Head
HeadWith = 4; //[2:10]


module FurnitureFoot()
{
	difference()
	{
		cylinder(r1=TopWith, r2=BottomWith, h=FootHeigth, $fn=250);
		translate([0,0,-1])cylinder(r=HoleDiameter, h=(FootHeigth+2),$fn=100);
		translate([0,0,FootHeigth-HeadHigth])cylinder(r=HeadWith, h=HeadHigth+1,$fn=100);
	}
}

FurnitureFoot();