//Cube Generator with Inset
//created 2013-11-18
//collaboration between Jonathan Schmid (@schmidjon and Michael Frey (@ChickenCutlass)

//variables, whole numbers only

// Cube Size
cube_size = 2; //[0, 1, 2, 3]
// Number of Cubes in X Axis (whole numbers only)
x_var = 3;
// Number of Cubes in Y Axis (whole numbers only)
y_var= 3;
// Number of Cubes in z Axis (whole numbers only)
z = 3;
// Inset amount
inset = .1; //[.1,.2,.3,.4,.5,.6,.7]

// create inner cube with insets on all sides
translate([inset,inset,inset]){
cube([x_var+(inset*(x_var-1))-(inset*2),y_var+(inset*(y_var-1))-(inset*2),z+(inset*(z-1))-(inset*2)]);
}

//create grid of cubes

for ( z = [0:z-1]) {
	for ( x = [0:y_var-1]) {
		for ( i = [0:x_var-1]) {
			translate([i*(1+inset),x*(1+inset),z*(1+inset)]) {
				cube([cube_size]);
			}
		}
	}
}
