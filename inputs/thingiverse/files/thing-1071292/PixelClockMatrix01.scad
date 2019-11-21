// Template for Pixel Clock Display with Std. LEDs
// by Jochen Krapf
// Version 1.01

// preview[view:south east, tilt:top diagonal]

/* [Global] */

// To render the parts choose the correcponding Part Name
Type = 4;   // [3:3x5-Digit,4:4x7-Digit,5:5x9-Digit]


// Parameters

// Distance between LEDs in mm (Grid size)
LedDistance = 9;

// Mounting Depth in mm
MountingDepth = 10;

// Horozontal Mounting Size in mm (min Width of Digits or 0 for no spacer)
MountingWidth = 0;

// Vertical Mounting Size in mm (min Heigth of Digits or 0 for no spacer)
MountingHeight = 0;

// Wall Width in mm
WallWidth = 1;

// Diameter of a single LED in mm
LedDiameter = 5.1;

/* [Hidden] */

// Level of Details - Set to 0.1 for export to stl
//$fn = 24*4;
$fs = 0.5;

grid5 = [ 
[2, 1, 1, 1, 2, 0, 2, 1, 1, 1, 2, 0,-2, 0, 2, 1, 1, 1, 2, 0, 2, 1, 1, 1, 2],
[1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1],
[1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1],
[1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1],
[2, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1],
[1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1],
[1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1],
[1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1],
[2, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1],
];

grid4 = [ 
[2, 1, 1, 2, 0, 2, 1, 1, 2, 0,-2, 0, 2, 1, 1, 2, 0, 2, 1, 1, 2],
[1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1],
[1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1],
[2, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1],
[1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1],
[1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1],
[2, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1],
];

grid3 = [ 
[2, 1, 2, 0, 2, 1, 2, 0,-2, 0, 2, 1, 2, 0, 2, 1, 2],
[1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1],
[2, 1, 1, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1],
[1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1],
[2, 1, 1, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1],
];

SizeX = 4*Type + 5;
SizeY = 2*Type - 1;
OffsetX = LedDistance * (SizeX-1)/2;
OffsetY = LedDistance * (SizeY-1)/2;
Wall = WallWidth;

echo (str("Grid Size : ", SizeX, " x ", SizeY));
echo (str("Dimensions : ", SizeX*LedDistance+Wall, " x ", SizeY*LedDistance+Wall, " mm"));
echo (str("LED Matrix Size : ", Type*4, " x ", SizeY));
echo (str("LEDs : ", (3*Type + 4*(Type-2))*4, " plus 2 for colon"));
echo (str("Controller Ports : ", 4*Type + SizeY, " plus 1 for colon"));


// Modules

module SegTemplate(w, l, h)
{
render()
	difference()
	{
		// make solid softbox
		hull()
		{
			// upper segment plate
			translate([-w/2,-w/2,h-Wall])
				cube([w,w,Wall]);
		
			// lower led circle
			cylinder(d=l, h=Wall, $fn=24);
		}
	}
}

module Matrix()
{
	difference()
	{
		union()
		{
			// segments outside
            for (x=[0:(SizeX-1)])
                for (y=[0:(SizeY-1)])
                {
                    if ( (Type == 3 && grid3[y][x] > 0) || (Type == 4 && grid4[y][x] > 0) || (Type == 5 && grid5[y][x] > 0) )
                    {
                        translate([x*LedDistance-OffsetX, y*LedDistance-OffsetY, 0])
                            SegTemplate(LedDistance+Wall-0.01, LedDiameter+2*Wall, MountingDepth);
                    }
				}
		
            // print support
            for (x=[0:(SizeX-1)])
                    if ( (Type == 3 && abs(grid3[0][x]) > 1) || (Type == 4 && abs(grid4[0][x]) > 1) || (Type == 5 && abs(grid5[0][x]) > 1) )
                translate([x*LedDistance-OffsetX, 0, MountingDepth/2])
                    cube([1, 2*OffsetY, MountingDepth], center=true);
            
            for (y=[0:(SizeY-1)])
                    if ( (Type == 3 && abs(grid3[y][0]) > 1) || (Type == 4 && abs(grid4[y][0]) > 1) || (Type == 5 && abs(grid5[y][0]) > 1) )
                translate([0, y*LedDistance-OffsetY, MountingDepth/2])
                    cube([2*OffsetX, 1, MountingDepth], center=true);

            // mounting spacer
            for (i=[-1,-0.5,0,0.5,1])
                translate([i*OffsetX, 0, MountingDepth/2])
                    cube([1, MountingHeight, MountingDepth], center=true);
                    
            for (i=[-1,1])
                translate([0, i*OffsetY, MountingDepth/2])
                    cube([MountingWidth, 1, MountingDepth], center=true);

                    
		}
	
		color( [1, 1, 1, 1] )
        for (x=[0:(SizeX-1)])
            for (y=[0:(SizeY-1)])
            {
                if ( (Type == 3 && grid3[y][x] > 0) || (Type == 4 && grid4[y][x] > 0) || (Type == 5 && grid5[y][x] > 0) )
                {
				// segments inside
                    translate([x*LedDistance-OffsetX, y*LedDistance-OffsetY, Wall+0.01])
                        SegTemplate(LedDistance-Wall, LedDiameter, MountingDepth-Wall);

				// LEDs
				translate([x*LedDistance-OffsetX, y*LedDistance-OffsetY, -1])
					#cylinder(d=LedDiameter, h=3);
                }
            }
	}
}

// Use Modules

Matrix();

