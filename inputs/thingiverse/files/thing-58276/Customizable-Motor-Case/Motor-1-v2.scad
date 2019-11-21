
// This is a parametric case maker for a motor

// to make a custom case, replace the parameters with your own

diameter_of_motor = 18;
thickness_of_case = 2;
// Distance from the front of the motor(not including the spinning end) to the other end (not including the power ends)
height_of_motor = 28; 
// The height from the ground to the first power end when the motor is sideways
height_to_ends = 19; 
diameter_of_ends = 4; 
// Distance on a different axis than "Height To Ends"
distance_between_ends = 12.5;
// The length of the ends protruding out of the motor 
length_of_ends = 5;
// Where along the motor do the ends come out? If it is at the way end, put in 0
distance_to_ends = 7;
// Number of edges on cylinder (use smaller numbers for rendering quickly and higher ones for final output)
resolution = 100;


//program
if (length_of_ends - distance_to_ends >0)
{
rotate ([0,0,180])
difference() {
cylinder(r = (diameter_of_motor/2+thickness_of_case),$fn = resolution, h = (height_of_motor+thickness_of_case));
cylinder(r = (diameter_of_motor/2), h = height_of_motor,$fn = resolution);
translate([diameter_of_motor/2-height_to_ends,distance_between_ends/2,height_of_motor-distance_to_ends/2])
cylinder(r = (diameter_of_ends/2)+thickness_of_case, h = length_of_ends+2 * thickness_of_case, center = true,$fn = resolution);
translate([diameter_of_motor/2-height_to_ends,-distance_between_ends/2,height_of_motor-distance_to_ends/2])
cylinder(r = (diameter_of_ends/2)+thickness_of_case, h = length_of_ends+2 * thickness_of_case, center = true,$fn = resolution);
}
}
else
{
rotate ([0,0,180])
difference() {
cylinder(r = (diameter_of_motor/2+thickness_of_case), h = (height_of_motor+thickness_of_case),$fn = resolution);
cylinder(r = (diameter_of_motor/2), h = height_of_motor,$fn = resolution);
translate([diameter_of_motor/2-height_to_ends,distance_between_ends/2,height_of_motor-distance_to_ends/2])
cylinder(r = (diameter_of_ends/2)+thickness_of_case, h = length_of_ends, center = true,$fn = resolution);
translate([diameter_of_motor/2-height_to_ends,-distance_between_ends/2,height_of_motor-distance_to_ends/2])
cylinder(r = (diameter_of_ends/2)+thickness_of_case, h = length_of_ends, center = true,$fn = resolution);
}
}
