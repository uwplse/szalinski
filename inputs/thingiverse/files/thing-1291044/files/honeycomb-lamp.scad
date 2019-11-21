//
// Copyright (C) 2016, Jason S. McMullan <jason.mcmullan@gmail.com>
// Copyright (C) 2016. Jennfier E. Merriman <je.merriman@gmail.com>
// All rights reserved.
//
// Licensed under the MIT License:
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.
//
// Version 0.1 - Initial version
// Version 0.2 - Corrected inner wall thickness calculations
// All units are in mm

// Interior diameter (mm)
inner_diameter = 52; 

// Height (mm)
height = 107;

// Inner width of translucent wall - should be no less than nozzle width (mm)
inner_width = 0.5;

// Width of honeycomb (mm)
comb_width = 10;

// Honeycomb wall width (mm)
wall_width = 1;

// Honeycomb cells for a complete circle
comb_cells = 17; // [5:180]

PI = 3.14159*1;

module honeycomb_row(diameter, wall_width, comb_cells)
{
    od_unit = diameter*PI / comb_cells;
        
    for (u = [0:1]) {
        translate([0, 0, sqrt(3)/2*od_unit*u])
        for (i = [0:comb_cells-1]) {
            rotate([0, 0, i * 360/comb_cells + u*(180/comb_cells)]) 
                    rotate([0, 90, 0])
                        cylinder(d1 = 0, d2 = 2*od_unit/sqrt(3)-wall_width,
                                  h = diameter / 2 + 0.1, $fn = 6);
        }
    }
}

module honeycomb_layer(inner_diameter = inner_diameter,
                          height = height,
                          inner_width = inner_width,
                          comb_width = comb_width,
                          wall_width = wall_width,
                          comb_cells = comb_cells)
{
    diameter = inner_diameter+inner_width*2+comb_width*2;
    od_unit = diameter*PI / comb_cells * sqrt(3) / 2;
    translate([0, 0, od_unit / 4]) {
        honeycomb_row(diameter = diameter, wall_width = wall_width, comb_cells = comb_cells);
        difference() {
            for (layer = [2*od_unit:2*od_unit:height]) {
                translate([0, 0, layer])
                honeycomb_row(diameter = diameter, wall_width = wall_width, comb_cells = comb_cells);
            }
            translate([0, 0, -0.1]) cylinder(d = inner_diameter + inner_width*2, h = height + 0.2, $fn = comb_cells*4);
        }
    }
}

module honeycomb_vase(inner = inner_diameter,
                          height = height,
                          inner_width = inner_width,
                          comb_width = comb_width,
                          wall_width = wall_width,
                          comb_cells = comb_cells)
{
    difference() {
        rotate([0, 0, 180/comb_cells]) cylinder(d = inner_diameter + inner_width * 2 + comb_width * 2, h = height, $fn = comb_cells);
        translate([0, 0, -0.1]) cylinder(d = inner_diameter, h = height + 0.2, $fn = comb_cells * 4);
        difference() {
            translate([0, 0, wall_width*4])
            honeycomb_layer(inner = inner_diameter,
                              height = height,
                              inner_width = inner_width,
                              comb_width = comb_width,
                              wall_width = wall_width,
                              comb_cells = comb_cells);
            translate([0, 0, -0.1])
                cylinder(d = inner_diameter + inner_width * 2 + comb_width * 2, h = wall_width*4 + 0.1, $fn = comb_cells * 2);
            translate([0, 0, height - wall_width*4])
                cylinder(d = inner_diameter + inner_width * 2 + comb_width * 2, h = wall_width*4 + 0.1, $fn = comb_cells * 2);
        }
    }
}

// projection(cut = true) translate([0, 0, -height/2])
honeycomb_vase();

// vim: set shiftwidth=4 expandtab: //