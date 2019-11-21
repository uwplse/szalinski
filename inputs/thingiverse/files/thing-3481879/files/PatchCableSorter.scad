// Copyright 2019 Norbert Schulz
// 
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
// 
// 1. Redistributions of source code must retain the above copyright notice,
//    this list of conditions and the following disclaimer.
// 
// 2. Redistributions in binary form must reproduce the above copyright notice,
//    this list of conditions and the following disclaimer in the documentation
//    and/or other materials provided with the distribution.
// 
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

// Number of poles in a row
pole_count  =8;      // [2:16]
// Cable width (millimeter)
cable_width = 1.1;
// Distance between pole rows (millimeter) 
pole_dist   = 40.0;
// Height of poles (millimeter)
pole_height = 30;
// Width of a pole (millimeter)
pole_width  = 5.0;

$fn=18+0.0;

// Draw a pole with a rounded top
//
module pole() {
    cylinder(pole_height, d=pole_width);
    translate([0, 0, pole_height])
        sphere(d=pole_width);
}

// draw 2 rows of poles
//
for( i=[1:pole_count]) {
    x = (i-1) * (cable_width + pole_width);
    translate([x, 0.0, 2.0])
        pole();
    translate([x, pole_dist, 2.0])
        pole();
    
    translate([x, 0, pole_width/2.0])
        rotate([-90.0, 0.0, 0.0])
            cylinder(pole_dist, d=pole_width);
}

// draw the (rounded) ground plate
//
minkowski() {
    translate([-pole_width/2, -pole_width/2,0])
        cube([pole_count * pole_width + 
              (pole_count-1) * cable_width, pole_dist+pole_width, 2.0]);
      sphere(r=1,h=1);   
}