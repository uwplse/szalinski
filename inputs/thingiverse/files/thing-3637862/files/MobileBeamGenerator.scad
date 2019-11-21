// Mobile Beam Generator
//   by Michael Van Biesbrouck, (c) 2019.
//   License: Attribution 4.0 International
//            https://creativecommons.org/licenses/by/4.0/
//
// First published 17 May 2019 in honour of my niece Daria's birth.

// preview[view:south, tilt:top]
/* [Global] */
// You probably want to print BeamsOnly and look at AssemblyInstructions on a computer.
part = "AssemblyInstructions"; // [AssemblyInstructions, BeamsOnly] 
/* [General Configuration] */
// Length of largest beam in mm.
beam_length = 100;      // [50:300]
// Width of beams in mm.
beam_width = 5;         // [3:25]
// Thickness of beams in mm.
beam_thickness = 2;     // [1:0.5:10]
// Diameter of wire holes in mm.
hole_diameter = 2;      // [1:0.5:10]
// Percentage length of child beams.
beam_length_decay = 80; // [50:100]
// Density in g/cm^3.  Default is for PLA with 100% infill.
filament_density = 1.25;// [0:0.01:10]
// Mass of each connecting wire in g; use 0 for light wire or thread.
wire_mass = 0;          // [0:0.1:10]
/* [Weights (with labels) for hanging objects] */
// Weight in g of first object.
weight_1 = 10; // [0:0.1:100]
// Name used for first object in assembly instructions.
weight_1_name = "1";
weight_2 = 20; // [0:0.1:100]
weight_2_name = "2";
weight_3 = 0; // [0:0.1:100]
weight_3_name = "3";
weight_4 = 0; // [0:0.1:100]
weight_4_name = "4";
weight_5 = 0; // [0:0.1:100]
weight_5_name = "5";
weight_6 = 0; // [0:0.1:100]
weight_6_name = "6";
weight_7 = 0; // [0:0.1:100]
weight_7_name = "7";
weight_8 = 0; // [0:0.1:100]
weight_8_name = "8";
weight_9 = 0; // [0:0.1:100]
weight_9_name = "9";
weights = [
[weight_1_name, weight_1],
[weight_2_name, weight_2],
[weight_3_name, weight_3],
[weight_4_name, weight_4],
[weight_5_name, weight_5],
[weight_6_name, weight_6],
[weight_7_name, weight_7],
[weight_8_name, weight_8],
[weight_9_name, weight_9],
];

eps = 0 + 0.000001;
pi = 3.14159265358979323846 + 0;
row_delta = beam_width + 5;
$fn = 75 + 0;

beam_separation = beam_length - beam_width;
beam_mass = 0.001 * filament_density * beam_thickness * (beam_separation*beam_width + pi/4 * (pow(beam_width, 2) - 3*pow(hole_diameter, 2)));

module beam (separation, fulcrum, description) {
    difference () {
        union () {
            cube ([separation, beam_width, beam_thickness], center=true);
            translate ([separation/2, 0, 0]) cylinder (h=beam_thickness, d=beam_width, center=true);
            translate ([-separation/2, 0, 0]) cylinder (h=beam_thickness, d=beam_width, center=true);
        }
        translate ([separation/2, 0, 0]) cylinder (h=beam_thickness+1, d=hole_diameter, center=true);
        translate ([-separation/2, 0, 0]) cylinder (h=beam_thickness+1, d=hole_diameter, center=true);
        translate ([separation*(fulcrum-0.5), 0, 0]) cylinder (h=beam_thickness+1, d=hole_diameter, center=true);
    }
    if (part == "AssemblyInstructions" && len(description) > 0) translate ([separation/2+beam_width+5, 0, -beam_thickness/2]) linear_extrude(height=1) text(text=description, size=beam_width, halign="left", valign="center");
}

function find_fulcrum(a, b, m) = (wire_mass+b+m/2)/(2*wire_mass+a+b+m);

function build_node_int(label, a, b, separation, beam_mass) =
    [label, a[1]+b[1]+beam_mass+wire_mass*2, a, b, separation, find_fulcrum(a[1], b[1], beam_mass), str(label,"=",a[0],"+",b[0])];

function build_node(label, cur_length, a, b) =
    build_node_int(label, a, b, cur_length-beam_width, 0.001 * filament_density * beam_thickness * ((cur_length-beam_width)*beam_width + pi/4 * (pow(beam_width, 2) - 3*pow(hole_diameter, 2))));

function sublist(list, start, end) = [for (i = [start:end]) list[i]];
    
function rec_combine(node_list, split, cur_length, new_length, label) =
    build_node (label, cur_length,
        combiner(sublist(node_list, 0, split-1), new_length, str(label, "L")),
        combiner(sublist(node_list, split, len(node_list)-1), new_length, str(label, "R")));

function combiner (node_list, cur_length, label) =
    len(node_list) == 1 ? node_list[0] :
        rec_combine(node_list, floor(len(node_list)/2), cur_length, cur_length*beam_length_decay/100, label);

function count_beams (subtree) = len(subtree) == 2 ? 0 : 1+count_beams(subtree[2])+count_beams(subtree[3]);

module render_tree(subtree) {
    if (len(subtree) > 2) {
        beam (subtree[4], subtree[5], subtree[6]);
        translate ([0, row_delta, 0]) render_tree (subtree[2]);
        translate ([0, (count_beams(subtree[2])+1)*row_delta, 0]) render_tree (subtree[3]);
    }
}

render_tree(combiner ([for (w=weights) if (w[1] > 0) w], beam_length, "T"));
