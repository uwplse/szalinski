Thickness = 1.5; // All
Height = 15.0; // Z
Extra_Col_Spacing = 1.0;
Cols = 1;
Rows = 3;

module single(isFirst)
{
	Bucket_Base = 31.5; // X
	Bucket_Side = 26; // Y
	Lip_Offset = 2.5; // Y
	Lip_Opening_Size = 2.0; // Y
	Lip_Depth = 2.0; // X

	union()
	{
		if (isFirst)
		{

			union()
			{
				// Smaller support
				translate([0 - ((Bucket_Base / 2) + (((Lip_Depth * 2) + Extra_Col_Spacing + Thickness) / 2)), Bucket_Side - ((Lip_Offset + Thickness) / 2) + (Thickness * 2), (Height / 2)])
					cube([(Lip_Depth * 2) + Extra_Col_Spacing + Thickness, Lip_Offset + Thickness, Height], true);

				// Lip support
				translate([0 - ((Bucket_Base / 2) + (((Lip_Depth * 2) + Extra_Col_Spacing + Thickness) / 2)), (Bucket_Side + ((Lip_Opening_Size / 2) + Thickness)) - (Lip_Offset + Lip_Opening_Size), (Height / 2)])
					cube([((Lip_Depth * 2) + Extra_Col_Spacing + Thickness) - (Lip_Opening_Size * 2), Lip_Opening_Size + (Thickness * 2), Height], true);

				// Main support
				translate([0 - ((Bucket_Base / 2) + (((Lip_Depth * 2) + Extra_Col_Spacing + Thickness) / 2)), ((Bucket_Side + Thickness) - (Lip_Offset + Lip_Opening_Size)) / 2, (Height / 2)])
					cube([(Lip_Depth * 2) + Extra_Col_Spacing + Thickness, (Bucket_Side + Thickness) - (Lip_Offset + Lip_Opening_Size), Height], true);
			}
		}

		// Top
		translate([0, Bucket_Side + (Thickness * 1.5), (Height / 2)])
			cube([Bucket_Base + (Thickness * 2), Thickness, Height], true);

		// Top left of bucket
		translate([0 - ((Bucket_Base / 2) + (Thickness / 2)), (Bucket_Side - (Lip_Offset / 2)) + (Thickness * 1.5), (Height / 2)], true)
			cube([Thickness, Thickness + Lip_Offset, Height], true);

		// Top right of bucket
		translate([(Bucket_Base / 2) + (Thickness / 2), (Bucket_Side - (Lip_Offset / 2)) + (Thickness * 1.5), (Height / 2)], true)
			cube([Thickness, Thickness + Lip_Offset, Height], true);

		// Top left of lip
		translate([0 - ((Bucket_Base / 2) + ((Lip_Depth + Thickness) / 2)), (Bucket_Side - Lip_Offset) + (Thickness * 1.5), (Height / 2)])
			cube([Lip_Depth + Thickness, Thickness, Height], true);

		// Top right of lip
		translate([(Bucket_Base / 2) + ((Lip_Depth + Thickness) / 2), (Bucket_Side - Lip_Offset) + (Thickness * 1.5), (Height / 2)])
			cube([Lip_Depth + Thickness, Thickness, Height], true);

		// Left lip edge
		translate([0 - ((Bucket_Base / 2) + Lip_Depth + (Thickness / 2)), (Bucket_Side + ((Lip_Opening_Size / 2) + Thickness)) - (Lip_Offset + Lip_Opening_Size), (Height / 2)])
			cube([Thickness, Lip_Opening_Size + (Thickness * 2), Height], true);

		// Right lip edge
		translate([(Bucket_Base / 2) + Lip_Depth + (Thickness / 2), (Bucket_Side + ((Lip_Opening_Size / 2) + Thickness)) - (Lip_Offset + Lip_Opening_Size), (Height / 2)])
			cube([Thickness, Lip_Opening_Size + (Thickness * 2), Height], true);

		// Bottom left of lip
		translate([0 - ((Bucket_Base / 2) + ((Lip_Depth + Thickness) / 2)), ((Bucket_Side + (Thickness / 2)) - (Lip_Opening_Size + Lip_Offset)), (Height / 2)])
			cube([Lip_Depth + Thickness, Thickness, Height], true);

		// Bottom right of lip
		translate([(Bucket_Base / 2) + ((Lip_Depth + Thickness) / 2), ((Bucket_Side + (Thickness / 2)) - (Lip_Opening_Size + Lip_Offset)), (Height / 2)])
			cube([Lip_Depth + Thickness, Thickness, Height], true);

		// Bottom left
		translate([0 - ((Bucket_Base / 2) + (Thickness / 2)), (((Bucket_Side + Thickness) - (Lip_Opening_Size + Lip_Offset)) / 2), (Height / 2)])
			rotate([0, 0, 90])
				cube([((Bucket_Side + Thickness)- (Lip_Opening_Size + Lip_Offset)), Thickness, Height], true);

		// Bottom right
		translate([(Bucket_Base / 2) + (Thickness / 2), (((Bucket_Side + Thickness) - (Lip_Opening_Size + Lip_Offset)) / 2), (Height / 2)])
			rotate([0, 0, 90])
				cube([((Bucket_Side + Thickness) - (Lip_Opening_Size + Lip_Offset)), Thickness, Height], true);

		// Bottom
		translate([0, (Thickness / 2), (Height / 2)])
			cube([Bucket_Base + (Thickness * 2), Thickness, Height], true);
	}
}

module MakeCol(numRows, isFirst)
{
	//NOTE: Might want to double thickness here if you want thicker padding between rows
	Single_Height = 26.0 + Thickness;

	union()
	{
		for(i = [0:numRows - 1])
		{
			translate([0, i * Single_Height, 0])
				single(isFirst);
		}
	}
}

module Grid(numRows, numCols)
{
	Single_Width = 35.5 + Thickness + Extra_Col_Spacing;

	union()
	{
		for(i = [0:numCols - 1])
		{
			translate([i * Single_Width, 0, 0])
				MakeCol(numRows, (i > 0));
		}
	}
}

Grid(Rows, Cols);
single(false);