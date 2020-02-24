//CUSTOMIZER VARIABLES

//	The number of columns in the tray.
number_of_columns = 10;	//	[1:20]

//	The number of rows in the tray.
number_of_rows = 5;	//	[1:20]

//  The diameter of each tray hole in mm.
diameter = 10.2; 

//  The distance between each hole in mm.
padding = 2;  //  [1:20]

//  The height of each hole in mm.
height = 10;  //  [1:20]



//NON CUSTOMIZER VARIABLES

//  Height of the base in mm.
floor_height = 3 * 1;



for ( r = [1 : number_of_rows], c = [1 : number_of_columns] ) {
	translate([c * (diameter + padding), r * (diameter + padding), 0]) {
		difference() {
			cylinder (h = height + floor_height, r=padding + diameter / 2, center = false);
			translate([0,0,floor_height]) cylinder (h = height + 1, r=diameter / 2, center = false);
		}
	}
}