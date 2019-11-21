//CUSTOMIZER VARIABLES

//	This should be a small number relative to your height of wall
width_Of_wall = .05;

//How tall do you want this
height_Of_wall = 1;

//	Vector path of wall, (wall thickness is only right angles for now), to generate a seperate path make a null/blank entry in your vector of order pairs, please note these are in whatever unit you selected earlier.
cords_Of_wall = [[1,0],[0,0],[0,1],[-1,1],[-1,3],[0,3],[0,4],[3,4],[4,3],[4,1],[3,1],[3,0],[2,0],[,],[1,1],[1,2],[2,2],[2,1],[1,1]];

//Basically are you using american units or real units
units_entered = 25.4;//[1:mm, 10:cm, 1000:meter, 25.4:inch, 304.8:foot]

//default is mm for most printers
desired_units_for_output = 1;//[1:mm, .1:cm, 0.001:meter, 0.0393701:inch, 0.00328084:foot]

//	This option will not appear because of the *1
//CUSTOMIZER VARIABLES END

width_of_wall = width_Of_wall;
unit_conversion_factor = units_entered*desired_units_for_output;
height_of_wall = height_Of_wall*unit_conversion_factor;

module make_wall_segments(cords = cords_Of_wall, number_your_on,units = 25.4) {
	/*number_your_on works such that when it equals 1, that is the begining.
		(yes I am one of those people who belives arrays 
		should have started with 1 instead of 0)
	*/
	point1 = cords[number_your_on-1]*unit_conversion_factor;
	point2 = cords[number_your_on]*unit_conversion_factor;
	point3 = [point2[0]+width_Of_wall*unit_conversion_factor,point2[1]+width_Of_wall*unit_conversion_factor];
	point4 = [point1[0]+width_Of_wall*unit_conversion_factor,point1[1]+width_Of_wall*unit_conversion_factor];
	
	linear_extrude(height = height_of_wall){
			polygon([point1,point2,point3,point4]);
		}
		if(number_your_on < len(cords)){
			make_wall_segments(cords = cords_Of_wall,number_your_on = number_your_on+1, units = unit_conversion_factor);
		}
}

make_wall_segments(cords = cords_Of_wall,number_your_on = 1, units = unit_conversion_factor);