// Copyright 2019 Luke Johnson
// Copyright 2019 Michael K Johnson
// Licensed under the Creative Commons - Attribution license.
// http://creativecommons.org/licenses/by/3.0/

// Create a set of polygon tiles, all with the same length sides

// How many sides should the larges polygon have?
max_sides=7; // [3:16]
// How many tiles of each size?
quantity=5; // [1:10]
// How long should each side be (mm)
side_length=15; // [5:25]
// How thick should the tiles be (mm)
height=2; // [1:5]

module polygon_tile(sides, side_length, height) {
    int_ang=((sides-2)*180)/sides;
    cylinder(r=(sides)/(2*cos(int_ang/2)),h=height,$fn=sides);
}

for (t=[1:quantity]) {
    translate([0, (t-1) * (max_sides*side_length/(5)), 0]) {
        for (sides=[3:max_sides]) {
            translate([(sides-3) * (sides*side_length/(5)), 0, 0])
                polygon_tile(sides, side_length, height);
        }
    }
}