// Joe Stubbs
// February 24 2012
// http://www.thingiverse.com/thing:53816


use <utils/build_plate.scad>

$fn=20*1;



//pick from the list of available bracelet sizes
bracelet_size = 65; //[35:0-6 Mos,39:6-12 Mos,44:12-24 Mos,48:2-5 Yrs,52:6-8 Yrs,57:9-13 Yrs,62:Women's Petite,65:Women's Small,68:Women's Medium,75:Women's Large,80:Women's Plus,86:Women's Ankle,70:Men's Small,73:Men's Medium,78:Men's Large,83:Men's Plus]

//width of the bracelet surface
width_in_millimeters = 20; // [8:30]

// What basic shape do you wish to make you bracelet out of
shape = 20;  //[3:Triangle,4:Square,5:Pentagon,6:Hexagon,7:Heptagon,8:Octagon,9:Nonagon,10:Decagon,20:Circle]

//How many rows of shapes would you like?
Stacked = 3; // [1:Single, 2:Double, 3:Triple]

//The overlap between the shapes.  Note: If the shapes do not overlap you must add the outline for the bracelet to hold together
Overlap = 0.75; // [0.5:Spaced, 0.75:Small Spaces, 1:Just Touching, 1.25:Small, 1.5:Medium, 1.75:Larger, 2:Double,3:Tripple, 4:Quadrupal]

//Would you like the bracelet edges outlined.  This may be required if your shapes are not touching based on previous selections.
Outlined = 0; // [1:Yes,0:No]


//How thick would you like the lines to be?
Line_thinkness = 2; //[1:1mm Thin,2:2mm Normal,3:3mm Normal,4:4mm Thick]

//Do you want the bracelet to be hollow?
Hollow_braclet_band=1; // [1:Yes,0:No]





//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);





// adjust the inside diameter depending if the bracelet is hollow or not.
inside_width = bracelet_size+(Hollow_braclet_band*(width_in_millimeters/3)); // x
inside_height = inside_width * 55 / 65; // y







thick = Line_thinkness;
shape_width = Line_thinkness;

outside_width = inside_width + (thick) / 2 * 2; // x
outside_height = inside_height + thick + thick; //y

width = width_in_millimeters;

number_of_shapes_height = Stacked;

circumferance = outside_height*3.1415;

	
echo("minimum_number_of_shapes :", minimum_number_of_shapes );

fudge = 0.05*1;

ratio = Overlap;
number_of_shapes = (round(circumferance/(width/round(number_of_shapes_height/2))*ratio/2)+1)*2; // Round(/2)*2 to get an even number all the time!
rotate_angle = 360/number_of_shapes;

width_of_ring = width/3;

shape_length = outside_height+width_of_ring*2+2; //just needs to be larger then any braclet you might make


/* 
difference() {
bracelet_space ();
		cube([100,10,100],center=true);
}
*/



translate (v=[0, 0,(width/2)]) 
scale (v=[outside_width/outside_height,1,1]) 
intersection() {
	bracelet_allshapes();
	bracelet_space ();
}







module bracelet_space () {

if (Hollow_braclet_band==0) {
	difference () {
	// full shape
	
		cylinder(r = outside_height/2, h = width, center = true);
		
	// inside cutout
			cylinder(r = inside_height/2, h = width+fudge, center = true);
	
	}
} else {



difference () {
	rotate_extrude(convexity = 10)
		translate([(outside_height/2+inside_height/2)/2, 0, 0])
				scale (v=[1,width/width_of_ring,1]) 
					circle(r = width_of_ring/2, $fn = 20, center= true);

	rotate_extrude(convexity = 10)
		translate([(outside_height/2+inside_height/2)/2, 0, 0])
				scale (v=[1,width/width_of_ring,1]) 
					circle(r = width_of_ring/2-thick, $fn = 20,center= true);
}



}

						


}


module bracelet_allshapes () {
	
	for (h = [1:number_of_shapes_height]) {
		if (number_of_shapes_height==1) 
			bracelet_spin();

		if (number_of_shapes_height==2) {
			if (h==1)
				translate (v=[0, 0,width/6-shape_width/4]) 
					bracelet_spin();
			if (h==2)
				rotate (a=rotate_angle/2,v=[0,0,1])
				translate (v=[0, 0,-width/6+shape_width/4]) 
					bracelet_spin();
		}


		if (number_of_shapes_height==3) {
			if (h==1)
				translate (v=[0, 0,width/2/2-shape_width/4]) 
					bracelet_spin();
			if (h==2)
				rotate (a=rotate_angle/2,v=[0,0,1])
					bracelet_spin();
			if (h==3)
				translate (v=[0, 0,-width/2/2+shape_width/4]) 
					bracelet_spin();
		}



	}

	if (Outlined ==1) 
		bracelet_outline ();
}


module bracelet_spin () {

	for (i = [1:number_of_shapes/2]){
		//echo("i:", i);
		rotate (a=rotate_angle*i,v=[0,0,1])
			bracelet_shape ();
	}
}

module bracelet_shape () {
	rotate (a=90,v=[1,0,0])
{
		if (number_of_shapes_height==1) {
		difference() {
			cylinder(r = width/2, h = shape_length, center = true, $fn=shape);
			cylinder(r = width/2-shape_width, h = shape_length+fudge, center = true, $fn=shape);
			}
		}


		if (number_of_shapes_height==2) {
		difference() {
			cylinder(r = width/3, h = shape_length, center = true, $fn=shape);
			cylinder(r = width/3-shape_width, h = shape_length+fudge, center = true, $fn=shape);
			}
		}


		if (number_of_shapes_height==3) {
			difference() {
			cylinder(r = width/2/2, h = shape_length, center = true, $fn=shape);
			cylinder(r = width/2/2-shape_width, h = shape_length+fudge, center = true, $fn=shape);
			}
		}

	}

}



module bracelet_outline () {


	// full shape
		translate (v=[0, 0,width/2-shape_width]) 
		cylinder(r = outside_height/2, h = shape_width*2, center = true);
		
	// full shape
		translate (v=[0, 0,-width/2+shape_width]) 
		cylinder(r = outside_height/2, h = shape_width, center = true);
		
/*
	if (number_of_shapes_height==2) {//  && ratio < 1.25) {
			cylinder(r = outside_height/2, h = shape_width, center = true);
	}


	if (number_of_shapes_height==3 ) {// && ratio < 1.75) {
		translate (v=[0, 0,width/6-shape_width/2]) 
			cylinder(r = outside_height/2, h = shape_width, center = true);
		translate (v=[0, 0,-width/6+shape_width/2]) 
			cylinder(r = outside_height/2, h = shape_width, center = true);
	}
*/


}



