// Copyright (c) 2013, 2014 by Jean-Louis Paquelin (jlp6k).
// This work is licensed under the Creative Commons Attribution
// Partage dans les Mêmes Conditions 3.0 France License.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/fr/
// CC-BY-SA

// Created 2013-11-29
// Last modified 2014-02-15

// dimensions are set in millimeters

Has_Inner_Cutter = "yes"; // [yes:Output will have an inner cutter, no: simple cookie cutter]

Cutter_Thickness = 0.5;

Outer_Side = 75;
Outer_Height = 23;

Inner_Side_Difference = 15;
Inner_Height_Difference = 3;

Frame_Thickness = 3;
Frame_Flange = 2;

union() {
    // grip / frame
    translate([0, 0, -(Outer_Height / 2) - (Frame_Thickness / 2) + (Frame_Thickness / 10)])
        difference() {
            cube([Outer_Side + Frame_Flange * 2,
                  Outer_Side + Frame_Flange * 2,
                  Frame_Thickness],
                  center = true);

            if(Has_Inner_Cutter == "yes") {
                cube([Outer_Side - Inner_Side_Difference * 2 - Cutter_Thickness * 2 - Frame_Flange * 2,
                      Outer_Side - Inner_Side_Difference * 2 - Cutter_Thickness * 2 - Frame_Flange * 2,
                      Frame_Thickness + 1],
                      center = true);
            } else {
                cube([Outer_Side - Cutter_Thickness * 2 - Frame_Flange * 2,
                      Outer_Side - Cutter_Thickness * 2 - Frame_Flange * 2,
                      Frame_Thickness + 1],
                      center = true);

            }
        }

    // outer cutter
    difference() {
        cube([Outer_Side,
              Outer_Side,
              Outer_Height],
              center = true);
        cube([Outer_Side - Cutter_Thickness * 2,
              Outer_Side - Cutter_Thickness * 2,
              Outer_Height + 10],
              center = true);
    }


    if(Has_Inner_Cutter == "yes") {
        // inner cutter
        translate([0, 0,  -Inner_Height_Difference / 2])
            difference() {
                cube([Outer_Side - Inner_Side_Difference * 2,
                      Outer_Side - Inner_Side_Difference * 2,
                      Outer_Height - Inner_Height_Difference],
                      center = true);
                cube([Outer_Side - Inner_Side_Difference * 2 - Cutter_Thickness * 2,
                      Outer_Side - Inner_Side_Difference * 2 - Cutter_Thickness * 2,
                      Outer_Height - Inner_Height_Difference + 10],
                      center = true);
            }
    }
}


