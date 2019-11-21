/*	Zip-Plate Custome Plate
	Created by Newton Robinson

	Zip-Plate is a construction set that is connected with 4" zip ties
	
	My plan is to create a set of pieces that can be used as a platform for robots.
*/

//Height of the Zip-Plate in mm: 
Height = 3;				// [1:5]	
//Length should be in a multiple of Spacing: 
Length = 50;			// [10:200:5] 
//Width should be in a multiple of Spacing: 
Width = 50;				// [10:200] 
//Spacing between holes in mm: 
Spacing = 5;			// [5:20]
// Height of the zip tie (Flat part): 
Zip_Tie_Height = 1;	// [1:2] 
// Width of the zip tie: 
Zip_Tie_Width = 3;	// [3:5] 

difference() {
	cube(size = [Length, Width, Height], center = false);
	for (x = [Spacing : Spacing : Length - Spacing] )
	{
		for (y = [Spacing : Spacing : Width - Spacing] )
		{
			translate ([ x , y , 0 ]) cube( size = [Zip_Tie_Height, Zip_Tie_Width, Height * 2], center = true);
		}
	}
}



































