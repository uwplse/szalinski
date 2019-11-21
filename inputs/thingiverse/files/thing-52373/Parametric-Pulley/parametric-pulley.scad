// Copyright (c) 2013 by Jean-Louis Paquelin (jlp6k).
// This work is licensed under the Creative Commons Attribution
// Partage dans les Mêmes Conditions 3.0 France License.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/fr/
// CC-BY-SA

// Inspired by http://www.thingiverse.com/thing:3970
// Created 2013-02-20
// Last modified 2013-02-20

// dimensions are set in millimeters

Bearing_Outer_Diameter = 22;
Bearing_Width = 7;

Belt_Width = 6;

Pulley_Thickness = 1;

Flange_Depth = 3;
Flange_Thickness = 2;
Flange_Shape = 2; // [1:square, 2:round]

Rim_Thickness = 0.5;
Rim_Count = 3;

pulley(Bearing_Outer_Diameter, Bearing_Width, Belt_Width, Pulley_Thickness, Flange_Depth, Flange_Thickness, Flange_Shape, Rim_Thickness, Rim_Count);

module pulley(Bearing_Outer_Diameter, Bearing_Width, Belt_Width, Pulley_Thickness, Flange_Depth, Flange_Thickness, Flange_Shape, Rim_Thickness, Rim_Count) {
    width = max(Bearing_Width, Belt_Width);
    union() {
        // pulley base
        difference() {
            cylinder(h = width + (Rim_Thickness * 2), r = (Bearing_Outer_Diameter / 2) + Pulley_Thickness, center = true);
            cylinder(h = width + (Rim_Thickness * 2) + 1, r = (Bearing_Outer_Diameter / 2), center = true);
        }
        
        // add pulley flanges
        translate([0, 0, (Belt_Width + Flange_Thickness) / 2])
            pulley_flange(Bearing_Outer_Diameter, Pulley_Thickness, Flange_Depth, Flange_Thickness, Flange_Shape);
        translate([0, 0, -(Belt_Width + Flange_Thickness) / 2])
            rotate([180, 0, 0])
                pulley_flange(Bearing_Outer_Diameter, Pulley_Thickness, Flange_Depth, Flange_Thickness, Flange_Shape);
            
        // add pulley rims
        translate([0, 0, (Bearing_Width + Rim_Thickness) / 2])
            pulley_rim(Bearing_Outer_Diameter, Rim_Thickness, Rim_Count);
        translate([0, 0, -(Bearing_Width + Rim_Thickness) / 2])
            rotate([0, 0, 180 / Rim_Count])
                pulley_rim(Bearing_Outer_Diameter, Rim_Thickness, Rim_Count);
    }
}

module pulley_flange(Bearing_Outer_Diameter, Pulley_Thickness, Flange_Depth, Flange_Thickness, Flange_Shape) {
    if(Flange_Shape == 2) {
        // round flange
        translate([0, 0, Flange_Thickness / 2])
            difference() {
                union() {
                    rotate_extrude(convexity = 10)
                        translate([(Bearing_Outer_Diameter / 2) + Pulley_Thickness, 0, 0])
                            scale([Flange_Depth / Flange_Thickness, 1, 1])
                                circle(r = Flange_Thickness, $fn = 30);
                    cylinder(h = Flange_Thickness * 2, r = (Bearing_Outer_Diameter / 2) + Pulley_Thickness, center = true);
                }
                cylinder(h = (Flange_Thickness * 2) + 1, r = (Bearing_Outer_Diameter / 2), center = true);
                translate([0, 0, (Flange_Thickness + 1)/ 2])
                    cube([Bearing_Outer_Diameter + (2 * (Pulley_Thickness + Flange_Depth)), Bearing_Outer_Diameter + (2 * (Pulley_Thickness + Flange_Depth)), Flange_Thickness + 1], center = true);
            }
    } else {
        // square flange
        difference() {
            cylinder(h = Flange_Thickness, r = (Bearing_Outer_Diameter / 2) + Pulley_Thickness + Flange_Depth, center = true);
            cylinder(h = Flange_Thickness + 1, r = (Bearing_Outer_Diameter / 2), center = true);
        }
    }
}

module pulley_full_rim(Bearing_Outer_Diameter, Rim_Thickness) {
    rotate_extrude(convexity = 10)
        translate([Bearing_Outer_Diameter / 2, 0, 0])
            circle(r = Rim_Thickness / 2);
}

module pulley_rim(Bearing_Outer_Diameter, Rim_Thickness, Rim_Count) {
    if(Rim_Count < 2) {
        pulley_full_rim(Bearing_Outer_Diameter, Rim_Thickness);
    } else {
        intersection() {
            pulley_full_rim(Bearing_Outer_Diameter, Rim_Thickness);
            union() {
                for(index = [1 : Rim_Count]) {
                    rotate([0, 0, (index * 360) / Rim_Count])
                        translate([(Bearing_Outer_Diameter + Rim_Thickness)/ 2, 0, 0])
                            sphere(r = (Bearing_Outer_Diameter * PI) / (Rim_Count * 4));
                }
            }
        }
    }
}
