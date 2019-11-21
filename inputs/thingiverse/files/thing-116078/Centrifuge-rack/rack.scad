//Shape of Tube
_shape = 1; //[1:Cylinder,2:Square,3:Pentagon,4:Hexagon,5:Heptagon,6:Octagon]

/*
//Type of Tube
tube_type = 1; //[1:50mL Falcon, 2:15mL Corning, 3:5mL Culture Tube, 4:Other]
*/

// Tube Diameter, 
_diameter = 29;

// Cap Diameter,
cap_diameter = 34.16; 

// Thickness of the base under the tubes
_base = 1;

// Height of rack, plus thickness of base
_height = 80 + _base;

// Length of rack
_length = 133;

// Width of rack
_width = 90;

// Number of tube across
_columns = 3;

// Number of tubes deep
_rows = 2;






module tube(shape, diameter, height)
{
	if(shape == 1)
	{
		cylinder(height, diameter/2, diameter/2);
	}
	if(shape == 2)
	{
		cube([diameter,diameter,height]);
	}
	if(shape == 3)
	{
		linear_extrude(height) circle(diameter/2,$fn=5);
	}
	if(shape == 4)
	{
		linear_extrude(height) circle(diameter/2,$fn=6);
	}
	if(shape == 5)
	{
		linear_extrude(height) circle(diameter/2,$fn=7);
	}
	if(shape == 6)
	{
		linear_extrude(height) circle(diameter/2,$fn=8);
	}
}

module tubeColumn(shape, diameter, height, columns, length, capDiameter)
{
	spacing = (length - (capDiameter*columns)) / (columns + 1);
	for ( x = [spacing + capDiameter/2 : capDiameter + spacing : spacing*columns + capDiameter*(columns - 1) + capDiameter/2])
	{
		translate([x,0,0])tube(shape, diameter, height);
	}
}

module tubeArray(shape, diameter, height, rows, width, columns, length, capDiameter)
{
	spacing = (width - (capDiameter*rows)) / (rows + 1);
	for ( y = [spacing + capDiameter/2 : capDiameter + spacing : spacing*rows + capDiameter*(rows - 1) + capDiameter/2])
	{
		translate([0,y,0])tubeColumn(shape, diameter, height, columns, length, capDiameter);
	}
}

module base(height, length, width)
{
	cube([length, width, height]);
}


difference() 
{
	base(_height,_length,_width);
	translate([0,0,_base])tubeArray(_shape,_diameter,_height,_rows,_width,_columns,_length,cap_diameter);
}
