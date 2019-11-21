/*

Created by Arthur Palmer 30.09.2015

*/

// Amount of tybes in the X-Direction
x_count = 3; 

// Amount of tybes in the Y-Direction
y_count = 2; 

// Random height can be changed here
random_seed = 1;

// Minimum height of the types
min_height = 30;

// Maximum height of the types
max_height = 70;

// Tybe-Radius
radius = 13;

// How thick should the wall be:
thickness = 2;

// Should it be thiker on the bottom?
base_extra = 5;

difference()
{
for ( x = [0:(x_count - 1)])
    for( y = [0:(y_count - 1)])
    {
        zy = (x % 2) * radius * 0.8645;
        translate([x * radius * 1.489, y * radius * 1.729 + zy, 1])
            createBase(rands(min_height, max_height, 1, random_seed + x + x_count * y)[0]);
    }

for ( x = [0:(x_count - 1)])
    for( y = [0:(y_count - 1)])
    {
        zy = (x % 2) * radius * 0.8645;
        translate([x * radius * 1.489, y * radius * 1.729 + zy, 1])
            createHoles(rands(min_height, max_height, 1, random_seed + x + x_count * y)[0]);
    }
}

module createBase(height)
{
    cylinder(height, radius + base_extra, radius, $fn=6);
}

module createHoles(height)
{
    translate([0, 0, thickness])
        cylinder(height+max_height, radius - thickness, radius - thickness, $fn=6);
}