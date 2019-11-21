width = 40;
length = 120;
height = 20;
wall_thickness = 3;
//ensure that the edge roundness is greater than the wall thickness
edge_roundness = 4;
tolerance = 0.3;

$fn = 20;

/* [Hidden] */

//ignore!
inner_box_dimentions = [length,width,height];

difference ()
{

	hull()
	{
		addOutterCorners(0,0);
		addOutterCorners(1,0);
		addOutterCorners(0,1);
		addOutterCorners(1,1);
	}
	
	translate([0,0,wall_thickness])
	hull()
	{
		addInnerCorners(0,0);
		addInnerCorners(1,0);
		addInnerCorners(0,1);
		addInnerCorners(1,1);
	}

	translate([0,0,inner_box_dimentions[2]+0.1])
	hull()
	{
		addLidCorners(0,0);
		addLidCorners(1,0);
		addLidCorners(0,1);
		addLidCorners(1,1);
	}

	translate([inner_box_dimentions[0]-wall_thickness,0,inner_box_dimentions[2]+0.1])
	cube([wall_thickness,inner_box_dimentions[1],wall_thickness]);
}

difference ()
{
	translate([0,inner_box_dimentions[1]+2,0])
	hull()
	{
		Lid(0,0);
		Lid(1,0);
		Lid(0,1);
		Lid(1,1);
	}

	//translate([20,inner_box_dimentions[1]*1.5+2,0])
	//rotate([0,90,0]);

	
}



module addOutterCorners(x = 0, y = 0)
{
	translate([(inner_box_dimentions[0] - edge_roundness*2 + 0.1)*x,(inner_box_dimentions[1] - edge_roundness*2 +0.1)*y,0] + [edge_roundness,edge_roundness,0])

	cylinder(inner_box_dimentions[2]+wall_thickness,edge_roundness,edge_roundness);
	
	echo((inner_box_dimentions[0] - edge_roundness)*x);
	echo((inner_box_dimentions[1] - edge_roundness)*y);
}

module addInnerCorners(x = 0, y = 0)
{
	translate([(inner_box_dimentions[0] - edge_roundness*2 + 0.1)*x,(inner_box_dimentions[1] - edge_roundness*2 +0.1)*y,0] + [edge_roundness,edge_roundness,0])

	cylinder(inner_box_dimentions[2],edge_roundness-wall_thickness,edge_roundness-wall_thickness);
	
	echo((inner_box_dimentions[0] - edge_roundness)*x);
	echo((inner_box_dimentions[1] - edge_roundness)*y);
}

module addLidCorners(x = 0, y = 0)
{
	translate([(inner_box_dimentions[0] - edge_roundness*2 - 0.1 +wall_thickness)*x,(inner_box_dimentions[1] - edge_roundness*2 +0.1)*y,0] + [edge_roundness,edge_roundness,0])

	cylinder(wall_thickness,edge_roundness-wall_thickness+1.5,edge_roundness-wall_thickness+0.5);
	
	echo((inner_box_dimentions[0] - edge_roundness)*x);
	echo((inner_box_dimentions[1] - edge_roundness)*y);
}

module Lid(x = 0, y = 0)
{
	translate([(inner_box_dimentions[0] - edge_roundness*2 - 0.1 +wall_thickness-2)*x,(inner_box_dimentions[1] - edge_roundness*2 +0.1)*y,0] + [edge_roundness,edge_roundness,0])

	cylinder(wall_thickness,edge_roundness-wall_thickness+1.5-tolerance,edge_roundness-wall_thickness+0.5-tolerance);
	
	echo((inner_box_dimentions[0] - edge_roundness)*x);
	echo((inner_box_dimentions[1] - edge_roundness)*y);
}