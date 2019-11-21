//Open Lampshade
//by Mark Rasmussen
//myfourkids@gmail.com
//
//Licensed under http://creativecommons.org/licenses/by-nc-sa/4.0/
//Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
//
//Variables Measurements in mm
//Parameters
//Ikea Lamps Hemma = 41 mm, Strala =  28mm
shade = "A+B"; // [A:Lamp A,B:Lamp B,A+B:Lamp A+B]

lamp_opening_diameter = 41; //
lamp_height = 150; //[10:5:500]
lamp_base_diameter = 125;//[10:5:500]

lamp_top_diameter = 70;//[10:5:500]
lamp_scale = lamp_top_diameter/lamp_base_diameter;
base_thickness = .5; //# of layers * extrusion height

A_sides = 4;//[[1:1:20]]
A_total_twists = 3;//[[.25:.25:30]]

B_sides = 3;//[[1:1:20]]
B_total_twists = 2;//[[.25:.25:30]]


sliced = 100;//[10:5:500]



print_shade();

module print_shade() {
	if (shade == "A") {
		lampA();
	} else if (shade == "B") {
		lampB();
	} else if (shade == "A+B") {
		lampAB();
	} else {
		lampAB();
	}
}


module lampA() {
    difference(){
        linear_extrude (height = lamp_height, center = false, convexity = 10, scale = [lamp_scale,lamp_scale], twist = A_total_twists*90 , slices = sliced , $fn=100){
        circle (lamp_base_diameter/2, $fn=A_sides);
        }
        cylinder(h = base_thickness, d=lamp_opening_diameter, $fa=5);
    }
}

module lampB() {
    difference(){
        linear_extrude (height = lamp_height, center = false, convexity = 10, scale = [lamp_scale,lamp_scale], twist = -B_total_twists*90 , slices = sliced , $fn=100){
        circle (lamp_base_diameter/2, $fn=B_sides);
        }
        cylinder(h = base_thickness, d=lamp_opening_diameter, $fa=5);
    }
}

module lampAB() {
    difference(){
       union(){
          linear_extrude (height = lamp_height, center = false, convexity = 10, scale = [lamp_scale,lamp_scale], twist = A_total_twists*90 , slices = sliced, $fn=100){
          circle (lamp_base_diameter/2, $fn=A_sides);
        }
        linear_extrude (height = lamp_height, center = false, convexity = 10, scale = [lamp_scale,lamp_scale], twist = -B_total_twists*90 , slices = sliced, $fn=100){
        circle (lamp_base_diameter/2, $fn=B_sides);
        }
        }
        cylinder(h = base_thickness, d=lamp_opening_diameter, $fa=5);
    }
}
