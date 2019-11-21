// Copyright (c) 2013 by Jean-Louis Paquelin (jlp6k).
// This work is licensed under the Creative Commons Attribution
// Partage dans les Mêmes Conditions 3.0 France License.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/fr/
// CC-BY-SA

// Created 2014-01-02
// Last modified 2014-01-02

// dimensions are set in millimeters

Type = 1; // [0: cylinder, 1: toroid, 2: rounded_cylinder]
Inner_Diameter = 18;
Thickness = 3;
Height = 8;

ring(Type, Inner_Diameter, Thickness, Height);

module ring(type, inner_diameter, thickness, height) {
    if(type == 0) {
        difference() {
            cylinder(h = height, r = (inner_diameter / 2) + thickness, center = true, $fn = 100);
            cylinder(h = height + 1, r = inner_diameter / 2, center = true, $fn = 100);
        }
    } else if(type == 1) {
        rotate_extrude(convexity = 10, $fn = 100)
            translate([(inner_diameter + thickness) / 2, 0, 0])
                scale([thickness / height, 1, 1])
                    circle(r = height / 2, $fn = 100);
    } else {
        union() {
            difference() {
                cylinder(h = height - thickness, r = (inner_diameter / 2) + thickness, center = true, $fn = 100);
                cylinder(h = height + 1, r = inner_diameter / 2, center = true, $fn = 100);
            }
            // top
            translate([0, 0, (height - thickness) / 2])
                rotate_extrude(convexity = 10, $fn = 100)
                    translate([(inner_diameter + thickness) / 2, 0, 0])
                        circle(r = thickness / 2, $fn = 100);
            // bottom
            translate([0, 0, -(height - thickness) / 2])
                rotate_extrude(convexity = 10, $fn = 100)
                    translate([(inner_diameter + thickness) / 2, 0, 0])
                        circle(r = thickness / 2, $fn = 100);            
        }
    }
}
