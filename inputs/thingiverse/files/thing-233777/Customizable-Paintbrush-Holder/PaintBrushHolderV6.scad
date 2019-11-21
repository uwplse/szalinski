use <utils/build_plate.scad>;

// The number of brushes that the holder can take. Currently set to:
01_Number_Of_Brushes = 5; // [1:12]
// The width of the holder in mm. Currently set to:
02_Holder_Width = 40; // [20:70]
// This variable controls the length of the holder, expressed as additional length per brush in mm. The length of the holder will be this number multiplied by the number of brushes + 1. E.g. with the default setting of 5 brushes and the Holder Length Per Brush set to 22 mm the total length of the holder is 22 x (5 + 1) = 132 mm.  Currently set to:
03_Holder_Length_Per_Brush = 22; // [10:50]
// The holder height in mm.  Currently set to:
04_Holder_Height = 18; // [10:40]
// How thick the profile of the holder is, expressed as the distance between the top of the upper surface of the holder and the bottom surface of the holder in mm.  Set to:
05_Holder_Thickness = 12; //[5:30]
// Thickness of the base underneath the V shaped portion of the holder in mm (if this is bigger than the Holder Thickness it will make no difference).  Currently set to:
06_Holder_Base_Height = 10; // [0:30]
// The slope of the paintbrush holding portion in degrees.  Currently set to:
07_Slope_In_Degrees = 22.55; // [0:35]

//Build plate for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

Holder_Unit_Length = 03_Holder_Length_Per_Brush/1;
TriHalfWidth = Holder_Unit_Length/2;
TriBackElev = 07_Slope_In_Degrees/90*02_Holder_Width;
TriBackOffset = -TriBackElev;
RemoveSurfaceWidth = 0.01/1; //Used to remove zero width surfaces


difference(){
	union	(){
		for (TriX = [0 : 01_Number_Of_Brushes]) //Create 5 copies of spike
		{ 
		polyhedron(
			points=[ 	[0 + Holder_Unit_Length * TriX,0,0], 
							[Holder_Unit_Length + Holder_Unit_Length * TriX,0,0], 
							[TriHalfWidth + Holder_Unit_Length * TriX, 04_Holder_Height,0], 
							[0 + Holder_Unit_Length * TriX,TriBackElev, 02_Holder_Width], 
							[Holder_Unit_Length + Holder_Unit_Length * TriX, TriBackElev, 02_Holder_Width], 
							[TriHalfWidth + Holder_Unit_Length * TriX ,04_Holder_Height, 02_Holder_Width] 
						],
		
			triangles=[ [1,2,0], 
							[5,4,3], 
							[3,2,5], 
							[0,2,3], 
							[0,3,4], 
							[1,0,4], 
							[4,5,2], 
							[1,4,2] 
						]
		);
		}
		
		
		//Create spike base
		polyhedron(
			points=[	[0,0,0],
						[Holder_Unit_Length + Holder_Unit_Length * 01_Number_Of_Brushes, 0, 0],
						[0,0,02_Holder_Width],
						[Holder_Unit_Length + Holder_Unit_Length * 01_Number_Of_Brushes, 0, 02_Holder_Width],
						[0,TriBackElev,02_Holder_Width],
						[Holder_Unit_Length + Holder_Unit_Length * 01_Number_Of_Brushes, TriBackElev, 02_Holder_Width]
					],
		
			triangles=[	[0,4,2],
							[3,5,1],
							[1,0,2],
							[3,1,2],
							[4,5,2],
							[5,3,2],
							[1,4,0],
							[1,5,4]
						]
		);
		
		//Create spacer base
		translate([0,-06_Holder_Base_Height,0])
		cube([Holder_Unit_Length + Holder_Unit_Length * 01_Number_Of_Brushes, 06_Holder_Base_Height, 02_Holder_Width]);
	}

	//Cut out the bottom portion
	translate([0,-05_Holder_Thickness,+RemoveSurfaceWidth]){
	union	(){
		for (TriX = [0 : 01_Number_Of_Brushes]) //Create 5 copies of spike
		{ 
		polyhedron(
			points=[ 	[0 + Holder_Unit_Length * TriX,0,0], 
							[Holder_Unit_Length + Holder_Unit_Length * TriX,0,0], 
							[TriHalfWidth + Holder_Unit_Length * TriX, 04_Holder_Height,0], 
							[0 + Holder_Unit_Length * TriX,TriBackElev+TriBackOffset, 02_Holder_Width], 
							[Holder_Unit_Length + Holder_Unit_Length * TriX, TriBackElev+TriBackOffset, 02_Holder_Width], 
							[TriHalfWidth + Holder_Unit_Length * TriX ,04_Holder_Height, 02_Holder_Width] 
						],
		
			triangles=[ [1,2,0], 
							[5,4,3], 
							[3,2,5], 
							[0,2,3], 
							[0,3,4], 
							[1,0,4], 
							[4,5,2], 
							[1,4,2] 
						]
		);
		translate([0, 0, -(1-(2 * RemoveSurfaceWidth))]) cube([(01_Number_Of_Brushes +1)* 03_Holder_Length_Per_Brush,04_Holder_Height+06_Holder_Base_Height+05_Holder_Thickness,1]);

		}
		
		
		//Create spike base
		polyhedron(
			points=[	[0,0,0],
						[Holder_Unit_Length + Holder_Unit_Length * 01_Number_Of_Brushes, 0, 0],
						[0,0,02_Holder_Width],
						[Holder_Unit_Length + Holder_Unit_Length * 01_Number_Of_Brushes, 0, 02_Holder_Width],
						[0,TriBackElev+TriBackOffset,02_Holder_Width],
						[Holder_Unit_Length + Holder_Unit_Length * 01_Number_Of_Brushes, TriBackElev+TriBackOffset, 02_Holder_Width]
					],
		
			triangles=[	[0,4,2],
							[3,5,1],
							[1,0,2],
							[3,1,2],
							[4,5,2],
							[5,3,2],
							[1,4,0],
							[1,5,4]
						]
		);
		
		//Create spacer base
		translate([0,-06_Holder_Base_Height,0])
		cube([Holder_Unit_Length + Holder_Unit_Length * 01_Number_Of_Brushes, 06_Holder_Base_Height, 02_Holder_Width]);
	}
}

//Remove zero width surfaces



}