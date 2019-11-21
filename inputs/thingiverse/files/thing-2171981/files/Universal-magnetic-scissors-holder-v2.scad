// Copyright (C) 2016-2017 - Olivier Podevin <hillheaven@free.fr>
//
// Content: An universal magnetic scissors holder.
//
//
// The script below has the following parameters:
//      - holder height
//      - holder_wall_thickness
//      - scissors upper width
//      - scissors lower width
//      - scissors thickness
//      - magnets diameter
//      - magnets thickness
//
// Advice on parameters' value: while measuring your scissors,
//     provide some space to the scissors to let it float in the holder.
//
// This file is an OpenSCAD script, see <http://www.openscad.org/> for details
//
// This work is licensed under the Creative Commons Attribution 4.0
// International license. To view a copy of this license, visit
// <http://creativecommons.org/licenses/by/4.0/>.

// Parameters in millimeters
holder_height = 40;
holder_wall_thickness = 2;
scissors_upper_width = 24;
scissors_lower_width = 15;
scissors_thickness = 11;
magnets_diameter = 8;
magnets_thickness = 4;

// Global variables
total_holder_thickness = scissors_thickness + magnets_thickness + holder_wall_thickness * 3;

module magnet_hole() 
{
    cylinder(r = magnets_diameter / 2, h = magnets_thickness, $fn=32);
}

module body_mass() 
{
    // Holder thickness = scissor thickness + magnet thickness + some matter between magnets and scissors + thickness to hold the scissors.
    upper_width = scissors_upper_width + holder_wall_thickness * 2;
    lower_width = scissors_lower_width + holder_wall_thickness * 2;
    
    linear_extrude(height = holder_height, scale=[lower_width/upper_width, 0.8])
        hull() {
            translate([upper_width / 2 - 1,0,0])
                square(size = [2,2]);
            translate([-upper_width / 2 - 1,0,0])
                square(size = [2,2]);
            translate([upper_width / 2 - 1, total_holder_thickness - 2,0])
                circle(2, $fn=16);
            translate([-upper_width / 2 + 1, total_holder_thickness - 2,0])
                circle(2, $fn=16);
        }
}

module body_hole() 
{
    upper_width = scissors_upper_width;
    lower_width = scissors_lower_width;
    
    linear_extrude(height = holder_height, scale=[lower_width/upper_width, 0.8])
        hull() {
            translate([upper_width / 2 - 1, magnets_thickness + holder_wall_thickness,0])
                square(size = [2,2]);
            translate([-upper_width / 2 - 1,magnets_thickness + holder_wall_thickness,0])
                square(size = [2,2]);
            translate([upper_width / 2 - 1, scissors_thickness - 2 + magnets_thickness + holder_wall_thickness,0])
                circle(2, $fn=16);
            translate([-upper_width / 2 + 1, scissors_thickness - 2 + magnets_thickness + holder_wall_thickness,0])
                circle(2, $fn=16);
        }
}

module body() 
{
    difference() {
        body_mass();
        translate([0,holder_wall_thickness,0])
            body_hole();        
        rotate([90,0,0])
            translate([0,magnets_diameter / 2 + holder_wall_thickness,-magnets_thickness])
                magnet_hole();        
        rotate([90,0,0])
            translate([0,holder_height - (magnets_diameter / 2 + holder_wall_thickness),-magnets_thickness])
                magnet_hole();        
    }
}
body();

