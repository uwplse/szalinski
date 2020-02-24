//Drew Vincent
//MSE4777 Fall 2019
//Customizable Model

//Customizable Charging Station
//Desktop charging station with a customizable amount of slots and customizable slot width. Each slot will have a path for the charging cable to be ran through.

//Parameters
num_slots = 5; //Input number of slots
slot_width = 11; //Input slot width in mm
slot_height = 35; //Input slot height in mm
slot_wall_width = 4; //Input slot wall width mm (recommended 2mm or above)
base_length = 100; //Input depth of charge sation
base_height = 8; //Input height of base
path_width = 3; //Input width of cable paths
path_height = 3; //Input height of cable paths

//Creation of the charging station
difference() {
union() {
//Base
overall_width = (num_slots * slot_width) + ((num_slots + 1) * slot_wall_width);
cube([overall_width, base_length, base_height], center = true);

//Slots
overall_height = slot_height + base_height;
first_slot_x = (slot_wall_width / 2) - (overall_width / 2);
first_slot_z = overall_height / 2;
for (N = [0:num_slots]) {
translate([first_slot_x + (N * slot_width) + (N * slot_wall_width), 0, first_slot_z])
cube([slot_wall_width, base_length, overall_height], center = true);
}
}

union() {
//Cable Paths
overall_width = (num_slots * slot_width) + ((num_slots + 1) * slot_wall_width);
first_path_x = -(overall_width / 2) + slot_wall_width + (slot_width / 2);
first_path_z = -(base_height / 2);
for (P = [0:num_slots - 1]) {
translate([first_path_x + (P * slot_width) + (P * slot_wall_width), 0, first_path_z])
cube([path_width, base_length, path_height * 2], center = true);
}
}
}