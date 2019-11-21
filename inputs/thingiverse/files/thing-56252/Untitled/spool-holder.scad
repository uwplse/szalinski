// Copyright (c) 2013 by Jean-Louis Paquelin (jlp6k).
// This work is licensed under the Creative Commons Attribution
// Partage dans les Mêmes Conditions 3.0 France License.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/fr/
// CC-BY-SA

// Created 2013-02-22
// Last modified 2013-03-02

// dimensions are set in millimeters

Render = 2; // [0:centering_pulley, 1: leg, 2:setup]

Min_Spool_Hole_Diameter = 27;
Max_Spool_Hole_Diameter = 37;
Spool_Diameter = 160;
Under_Spool_Clearance = 20;

Axle_Diameter = 8;
Axle_Clearance = 1;

Nut_Size = 14.62;
Nut_width = 6.26;

Flange_Width = 10;

Bearing_Outer_Diameter = 22;
Bearing_Width = 7;

if(Render == 0)
    centering_pulley(Min_Spool_Hole_Diameter, Max_Spool_Hole_Diameter, Axle_Diameter, Nut_Size, Nut_width, Flange_Width);
else if(Render == 1)
    leg(Spool_Diameter, Axle_Diameter, Bearing_Outer_Diameter, Bearing_Width);
else {
    // complete setup
    rotate([0, -90, 45]) {
        color("grey")
        union() {
            // spool
            cylinder(h = Spool_Diameter / 2, r = Spool_Diameter / 2, center = true);
            
            // axle
            cylinder(h = Spool_Diameter * 1.5, r = Axle_Diameter / 2, center = true);
            
            // nuts
            translate([0, 0, (-Spool_Diameter / 3.5) - (Max_Spool_Hole_Diameter - Min_Spool_Hole_Diameter + Flange_Width - Nut_width) / 2])
                rotate([0, 0, 45])
                    cylinder(h = Nut_width + 0.1, r = Nut_Size / 2, center = true, $fn = 6);
            translate([0, 0, (Spool_Diameter / 3.5) + (Max_Spool_Hole_Diameter - Min_Spool_Hole_Diameter + Flange_Width - Nut_width) / 2])
                rotate([0, 0, 30])
                    cylinder(h = Nut_width + 0.1, r = Nut_Size / 2, center = true, $fn = 6);

            // bearings
            translate([0, 0, Spool_Diameter / 2])
                cylinder(h = Bearing_Width + 0.1, r = Bearing_Outer_Diameter / 2, center = true);
            translate([0, 0, -Spool_Diameter / 2])
                cylinder(h = Bearing_Width + 0.1, r = Bearing_Outer_Diameter / 2, center = true);
        }
        translate([0, 0, -Spool_Diameter / 3.5])
            rotate([0, 0, 45])
                centering_pulley(Min_Spool_Hole_Diameter, Max_Spool_Hole_Diameter, Axle_Diameter, Nut_Size, Nut_width, Flange_Width);
        translate([0, 0, Spool_Diameter / 3.5])
            rotate([180, 0, 30])
                centering_pulley(Min_Spool_Hole_Diameter, Max_Spool_Hole_Diameter, Axle_Diameter, Nut_Size, Nut_width, Flange_Width);
        translate([-((Spool_Diameter / 2) + Under_Spool_Clearance) / 2, 0, Spool_Diameter / 2])
            leg(Spool_Diameter, Axle_Diameter, Bearing_Outer_Diameter, Bearing_Width);
        translate([-((Spool_Diameter / 2) + Under_Spool_Clearance) / 2, 0, -Spool_Diameter / 2])
            leg(Spool_Diameter, Axle_Diameter, Bearing_Outer_Diameter, Bearing_Width);
    }
}

module leg(Spool_Diameter, Axle_Diameter, Bearing_Outer_Diameter, Bearing_Width) {
    leg_height = (Spool_Diameter / 2) + Under_Spool_Clearance;
    bearing_holder_radius = (Bearing_Outer_Diameter / 2) + Bearing_Width;
    
    difference() {
        union() {
            // leg base
            difference() {
                cube([leg_height, bearing_holder_radius * 2, Bearing_Width], center = true);
                cube([leg_height - 2 * Bearing_Width, (bearing_holder_radius  - Bearing_Width) * 2, Bearing_Width + 1], center = true);
            }
            
            // bearing holder
            translate([leg_height / 2, 0, 0])
                cylinder(h = Bearing_Width, r = (Bearing_Outer_Diameter / 2) + Bearing_Width, center = true, $fn = 100);
                
            // feet
            translate([-leg_height / 4, bearing_holder_radius * 1.9, 0])
                foot(leg_height / 2, bearing_holder_radius * 2, Bearing_Width);
            translate([-leg_height / 4, -bearing_holder_radius * 1.9, 0])
                rotate([180, 0, 0])
                    foot(leg_height / 2, bearing_holder_radius * 2, Bearing_Width);
        }
        
        // bearing hole
        translate([leg_height / 2, 0, 0])
            cylinder(h = Bearing_Width + 1, r = Bearing_Outer_Diameter / 2, center = true, $fn = 100);
    }
}

module foot(x, y, z) {
    inner_radius = x - z;

    scale([1, y / x, 1])
    difference() {
        difference() {
            translate([-x / 2, -x / 2, 0])
                 cylinder(h = z, r = x, center = true, $fn = 100);
            translate([-x - x / 2, -x / 2, 0])
                cube([x * 2, x *  2, z + 1], center = true);
            translate([-x / 2, -x - x / 2, 0])
                cube([x * 2, x *  2, z + 1], center = true);
        }

    scale([1, 1, 1.1])
        difference() {
            translate([-x / 2, -x / 2, 0])
                 cylinder(h = z, r = inner_radius, center = true, $fn = 100);
            translate([-inner_radius - x / 2 + z, -x / 2, 0])
                cube([inner_radius * 2, inner_radius *  2, z + 1], center = true);
            translate([-x / 2, -inner_radius - x / 2, 0])
                cube([inner_radius * 2, inner_radius *  2, z + 1], center = true);
        }
    }
}

module centering_pulley(Min_Spool_Hole_Diameter, Max_Spool_Hole_Diameter, Axle_Diameter, Nut_Size, Nut_width) {
    centering_pulley_width = Max_Spool_Hole_Diameter - Min_Spool_Hole_Diameter;
    flange_radius = (Max_Spool_Hole_Diameter + Flange_Width) / 2;
    hole_extension = 1;
    
    difference() {
        translate([0, 0, Flange_Width / 2])
            union() {
                // auto centering pulley base
                cylinder(h = centering_pulley_width, r1 = Max_Spool_Hole_Diameter / 2, r2 = Min_Spool_Hole_Diameter / 2, center = true, $fn = 100);
                
                // flange
                translate([0, 0, -(centering_pulley_width + Flange_Width) / 2])
                    cylinder(h = Flange_Width, r = flange_radius, center = true, $fn = 6);
            }
        
        // nut hole
        translate([0, 0, -(centering_pulley_width + Flange_Width - Nut_width + hole_extension) / 2])
            cylinder(h = Nut_width + hole_extension, r = Nut_Size / 2, center = true, $fn = 6);

        // axle hole
        cylinder(h = centering_pulley_width + Flange_Width + hole_extension, r = (Axle_Diameter + Axle_Clearance) / 2, center = true, $fn = 100);
    }
}
