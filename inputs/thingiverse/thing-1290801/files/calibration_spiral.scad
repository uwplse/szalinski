//
// Copyright (C) 2016, Jason S. McMullan <jason.mcmullan@gmail.com>
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
// All units are in mm


// Nozzle width (mm)
nozzle = 0.5;

// Start radius (mm)
start_radius = 40; // [0:290]

// Bed radius (mm)
bed_radius = 80; // [10:300]

// Segments per spiral
segments = 30; // [12:60]

module calibration_spiral(nozzle = 0.5, start_radius = 40, bed_radius = 80, segments = 30)
{
    for (r = [start_radius:nozzle*4:bed_radius]) {
        diameter = bed_radius * PI * 2;
        for (a = [0:360/segments:360-360/segments]) {
            radius = r + nozzle*4*a/360;
            diameter = radius * PI * 2;
            length = diameter / segments + 0.1;
            rotate([0, 0, a])
                translate([radius - nozzle/2, -length / 2, 0]) cube([nozzle, length, nozzle]);
        }
    }
}

calibration_spiral(nozzle, start_radius, bed_radius, segments);
