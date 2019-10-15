/*
Parametric LED matrix cover by Nils R., 2013
Work in progress!
This is a script I have created to learn making stuff in OpenSCAD.

Version 1.2
Enter your parameters below.
*/

//Number of rows
rows=5;		

//Number of columns	
columns=7;

//2.54mm for standard veroboard
grid=2.54;				

//LED diameter in mm
led_diameter=5;		

//How many grid points the LEDs are apart (usually 3 for 5mm LEDs, 2 for 3mm LEDs).
spacing=3;				

//Thickness of the base plate in mm
BasePlateThickness=1;	

//Thickness of walls in mm
WallThickness=1;		

//Full height of the matrix in mm
height=8;				

//Helper Disks (1=yes, 0=no)
edge_Supports=1; 		



//Calculate base plate size and frame size
baseX=grid*spacing+(columns*grid*spacing);
baseY=grid*spacing+(rows*grid*spacing);
baseXinner=(grid*spacing+(columns*grid*spacing))-(WallThickness*2); 
baseYinner=(grid*spacing+(rows*grid*spacing))-(WallThickness*2);


//Combined object
union()
{
	//Generate basic shape with holes for LEDs
	difference()
	{
		//Generate base plate
		cube ([baseX,baseY,height]);

		//Generate holes for LEDs
		for (y = [1 : rows] )
		{
				for (x = [1 : columns] )
				{
						translate([x*grid*spacing,y*grid*spacing,-1])
						cylinder (r=led_diameter/2,h=height+1, $fn=16);
				}
		}
		
		//Leave only the frame
		translate([WallThickness,WallThickness,BasePlateThickness])
		cube ([baseXinner,baseYinner,height-(BasePlateThickness-1)]);

	}


	//Generate circles around edges of the base plate if enabled
	if (edge_Supports==1)
	{
		cylinder(r=5,h=0.1, $fn=16);
		translate ([baseX,0,0])
		cylinder(r=5,h=0.1, $fn=16);
		translate ([0,baseY,0])
		cylinder(r=5,h=0.1, $fn=16);
		translate ([baseX,baseY,0])
		cylinder(r=5,h=0.1, $fn=16);

	}
}