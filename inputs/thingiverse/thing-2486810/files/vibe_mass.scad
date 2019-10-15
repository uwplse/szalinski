//Vibration Mass (round type)
//CudaTox (@cudatox) 2017

/*

Copyright 2017 Cudatox

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

*/

thickness = 7;
d1 = 8;
d2 = 20;
spacing = 7;
shaft_dia = 2.6;
shaft_od = 6;
shaft_len = 3;

difference(){
    union(){
        hull(){
            cylinder(h=thickness, d=d1, center=true);
            translate([spacing,0,0])
            cylinder(h=thickness, d=d2, center=true);
        }
        translate([0,0,shaft_len/2 + thickness/2])
        cylinder(h=shaft_len, d=shaft_od, center=true);
    }
    cylinder(h=(thickness + shaft_len) * 2, d=shaft_dia, center=true,$fn=30);
}