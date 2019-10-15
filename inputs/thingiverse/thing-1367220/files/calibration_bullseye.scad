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
start_radius = 20; // [0:290]

// Bed radius (mm)
bed_radius = 100; // [10:300]

// Segments per ring
segments = 120; // [3:120]

module calibration_bullseye(nozzle = 0.5, start_radius = 40, bed_radius = 80, segments = 30)
{
    for (r = [start_radius:nozzle*4:bed_radius]) {
        difference() {
            cylinder(r = r, h = nozzle, $fn = segments);
            translate([0, 0, -0.1])
                cylinder(r = r - nozzle*2, h = nozzle + 0.2, $fn = segments);
          
        }
    }
}

calibration_bullseye(nozzle, start_radius, bed_radius, segments);
