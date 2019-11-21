// max. radius of the base
lower_radius = 30;

// max. radius of the top
upper_radius = 40;

// which shape should be used: 3: triangle, 4: square, 5...
corner_count = 4;

// number of slices 10 ... draft, 1000 ... for printing
slices = 10;

// height of the vase
height = 100;

// how much the vase should be twisted
twist = 90;

// how many objects of shape corner_count should be used
number_of_stars = 2;

// double twisted vase
double = true;

// angle which rotates the second twist
angle = 0;

module base()
{circle(r=lower_radius, $fn=corner_count);
}

module vase(){
linear_extrude(height, twist=twist, slices =slices, scale=upper_radius / lower_radius){
for (i=[0:(360/corner_count/number_of_stars):360/corner_count])
rotate([0,0,i])render()base();}}

render()vase();
if (double)
scale([-1,1,1])rotate([0,0,angle])vase();