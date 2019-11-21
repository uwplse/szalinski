$fn=50/1;

// The size of one single block in mm
single_piece_size = 4; // [3:10]

//How thick shall the blocks be?
block_thickness = 2; // [1:5]

//How long shall the sticks be?
stick_length = 3; // [2:5]

//What type of thing do you need? Start with a "test set" to see whether the settings work for your printer. Then print "complete block set" in multiple colors and a separat "base plate" . Print the other blocks if necessary.
thing_type = "test set"; // [complete block set,base plate,one-block,two-block,three-block,corner-block,four-block, test set]

//If thing shall be a "base plate" - what size in x shall it have?
base_plate_x_count = 20; // [5:40]

//If thing shall be a "base plate" - what size in y shall it have?
base_plate_y_count = 20; // [5:40]

//How many thing pieces (not relevant for "test set" and "base plate")?
how_many = 1; // [1:50]

//The space between multible thing pieces in mm
space_between_things = 2; // [2;10]

if (thing_type == "test set") 
{
	CreateSingleBlock();
	translate([(single_piece_size+space_between_things),0,0]) CreateTwoBlock();
	translate([2*(single_piece_size+space_between_things),0,0]) CreateThreeBlock();
	translate([3*(single_piece_size+space_between_things),0,0]) CreateFourBlock();
	translate([5*(single_piece_size+space_between_things),0,0]) CreateCornerBlock();
	
	difference()
	{
		translate([0,4*single_piece_size,0]) cube([single_piece_size*4,single_piece_size*4,stick_length]);
	      translate([0,4*single_piece_size,0]) for (x = [0: 4]) 
		{
			translate([0,x*(single_piece_size),0])
			for (y = [0: 4]) 
			{
				translate([y*(single_piece_size),0,0]) CreateBasePlateHole();
			}
		}
	}
}
if (thing_type == "complete block set") 
{
	for (z = [0: how_many-1]) 
	{
    		translate([z*((single_piece_size+space_between_things)*3), 0, 0]) 
			CreateSetRow();
	}
}
if (thing_type == "base plate") 
{
	difference()
	{
		cube([single_piece_size*base_plate_x_count,single_piece_size*base_plate_y_count,stick_length]);
		for (x = [0: base_plate_x_count]) 
		{
			translate([0,x*(single_piece_size),0])
			for (y = [0: base_plate_y_count]) 
			{
				translate([y*(single_piece_size),0,0]) CreateBasePlateHole();
			}
		}
	}
}
if (thing_type == "one-block") 
{
	for (z = [0: how_many-1]) 
	{
    		translate([z*(single_piece_size+space_between_things), 0, 0]) CreateSingleBlock();
	}
}
if (thing_type == "two-block") 
{
	for (z = [0: how_many-1]) 
	{
    		translate([z*(single_piece_size+space_between_things), 0, 0]) CreateTwoBlock();
	}
}
if (thing_type == "three-block") 
{
	for (z = [0: how_many-1]) 
	{
    		translate([z*(single_piece_size+space_between_things), 0, 0]) CreateThreeBlock();
	}
}
if (thing_type == "corner-block") 
{
	for (z = [0: how_many-1]) 
	{
    		translate([z*((single_piece_size*2)+space_between_things), 0, 0]) CreateCornerBlock();
	}
}
if (thing_type == "four-block") 
{
	for (z = [0: how_many-1]) 
	{
    		translate([z*((single_piece_size*2)+space_between_things), 0, 0]) CreateFourBlock();
	}
}

module CreateSetRow()
{
	CreateSingleBlock();
	translate([0,(single_piece_size+space_between_things),0])	CreateFourBlock();
	translate([0,(single_piece_size*3+space_between_things*2),0])	CreateFourBlock();
	translate([0,(single_piece_size*5+space_between_things*3),0])	CreateCornerBlock();
	translate([0,(single_piece_size*7+space_between_things*4),0])	CreateThreeBlockTurned();
	translate([0,(single_piece_size*8+space_between_things*5),0])	CreateThreeBlockTurned();
	translate([0,(single_piece_size*9+space_between_things*6),0])	CreateThreeBlockTurned();
	translate([0,(single_piece_size*10+space_between_things*7),0])	CreateTwoBlockTurned();
	translate([0,(single_piece_size*11+space_between_things*8),0])	CreateTwoBlockTurned();
	translate([0,(single_piece_size*12+space_between_things*9),0])	CreateTwoBlockTurned();
	translate([0,(single_piece_size*13+space_between_things*10),0])	CreateTwoBlockTurned();
	translate([0,(single_piece_size*14+space_between_things*11),0])	CreateTwoBlockTurned();
	translate([0,(single_piece_size*15+space_between_things*12),0])	CreateTwoBlockTurned();
	translate([0,(single_piece_size*16+space_between_things*13),0])	CreateTwoBlockTurned();
	translate([0,(single_piece_size*17+space_between_things*14),0])	CreateTwoBlockTurned();
	translate([0,(single_piece_size*18+space_between_things*15),0])	CreateThreeBlockTurned();
	translate([0,(single_piece_size*19+space_between_things*16),0])	CreateThreeBlockTurned();
	translate([0,(single_piece_size*20+space_between_things*17),0])	CreateThreeBlockTurned();
	translate([0,(single_piece_size*21+space_between_things*18),0])	CreateCornerBlock();
	translate([0,(single_piece_size*23+space_between_things*19),0])	CreateFourBlock();
	translate([0,(single_piece_size*25+space_between_things*20),0])	CreateFourBlock();
}

module CreateTwoBlock()
{
	CreateSingleBlock();
	translate([0,single_piece_size,0]) CreateSingleBlock();
}

module CreateTwoBlockTurned()
{
	CreateSingleBlock();
	translate([single_piece_size,0,0]) CreateSingleBlock();
}

module CreateThreeBlock()
{
	CreateSingleBlock();
	translate([0,single_piece_size,0]) CreateSingleBlock();
	translate([0,single_piece_size+single_piece_size,0]) 	CreateSingleBlock();
}

module CreateThreeBlockTurned()
{
	CreateSingleBlock();
	translate([single_piece_size,0,0]) CreateSingleBlock();
	translate([single_piece_size+single_piece_size,0,0]) 	CreateSingleBlock();
}

module CreateFourBlock()
{
	CreateSingleBlock();
	translate([single_piece_size,0,0]) CreateSingleBlock();
	translate([single_piece_size,single_piece_size,0]) 	CreateSingleBlock();
	translate([0,single_piece_size,0]) 	CreateSingleBlock();
}

module CreateCornerBlock()
{
	CreateSingleBlock();
	translate([single_piece_size,0,0]) CreateSingleBlock();
	translate([0,single_piece_size,0]) 	CreateSingleBlock();
}

module CreateSingleBlock()
{
	stick_radius = ( single_piece_size / 2 ) - 1;
	union()
	{
		cube([single_piece_size,single_piece_size,block_thickness]);
		translate([single_piece_size/2,single_piece_size/2,block_thickness]) cylinder(h=stick_length, r=stick_radius);
	}
}

module CreateBasePlateHole()
{
	wallThickness = 1;
//	wallThickness = ( single_piece_size / 2 )-1.1;
	translate([wallThickness,wallThickness,0-stick_length]) cube([single_piece_size-(wallThickness*2),single_piece_size-(wallThickness*2),stick_length*3]);
}