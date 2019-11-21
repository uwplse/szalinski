

Wood_size = 20; // [10:Small,20:Medium,30:Large]

Wood_length = 10;
Wood_height = 5;

// How many fingers do you want for articulation?
Number_of_fingers = 5; // [2:10]

// How thick should the wood be?
Wood_thickness = 2; // [1:5]

difference() {
  union() {
    translate([0, 0, Wood_size/2]) cube([Wood_length,Wood_height,Wood_thickness], center=true);
} }          
        