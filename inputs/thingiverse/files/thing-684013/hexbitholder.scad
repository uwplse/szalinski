//TODO: Implement / add support for tolerances

//How many bits in a row?
bits_per_row = 4;//[1:10]

//How many rows?
rows = 2;//[1,2]

//What is the diameter of your bit (in mm)?
bit_diameter = 6.35;//[6.35:6.35mm,7.938:7.938mm,11.11:11.11mm]

//in mm
holder_height = 20;//[5:20]

//Margin thickness (ratio of bit diameter)
ratio = 3;//[1.0:5.0]


diameter = bit_diameter;
height = holder_height;
thickness = diameter / ratio;
width = diameter + thickness;


// We use the bottom-up approach.

// Creates a hexagonal cylinder
module hexagon(size, height)
	{
	width = size/sqrt(3);
	cylinder(height, r=width, center=true, $fn=6);
	// alternatives for the generation of hex-cylinders
	//linear_extrude(height) circle(width, $fn=6);
	//for (r = [-60, 0, 60]) rotate([0,0,r]) cube([width, size, height], true);
	}

// Creates a "cell", i.e. a hollowed-out hexagonal cylinder
module cell(diameter, thickness, height)
	{
	difference()
		{
		hexagon(diameter + thickness, height);
		hexagon(diameter, height + 1);
		}
	}

// Creates multiple stringed together cells 
module row(width, count)
	{
	for(i = [0:count-1]) translate([0,i*width,0]) cell(diameter, thickness, height);
	}

// Creates (correctly-positions, same-length) rows of cells
module rows(width, count, rows)
	{
	for(i = [0:rows-1]) translate([i*(1.5*width/sqrt(3)), i*width/2,0]) row(width, count);
	}

// Create the whole shebang
rows(width, bits_per_row, rows);
