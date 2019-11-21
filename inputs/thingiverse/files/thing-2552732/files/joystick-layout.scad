// Copyright (c) 2017  Timm Murray
// All rights reserved.
// 
// Redistribution and use in source and binary forms, with or without 
// modification, are permitted provided that the following conditions are met:
// 
//     * Redistributions of source code must retain the above copyright notice, 
//       this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright 
//       notice, this list of conditions and the following disclaimer in the 
//       documentation and/or other materials provided with the distribution.
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
//
THICKNESS = 20;
JOYSTICK_HOLE_DIAMETER = 30;
BTN_HOLE_DIAMETER = 25.4;

// Layout from:
// http://www.slagcoin.com/joystick/layout/sega2_m.png
//
// Tends to assume num_btns is an even number, and is between 4 and 8
// (inclusive)
module joystick( num_btns )
{
    mirror() {
        // Joystick hole
        translate(v = [
            (197.5 - 36 - 36 - 30.5 - 63),
            (9 + 11 + 19),
            0
        ]) {
            cylinder(
                h = THICKNESS,
                d = JOYSTICK_HOLE_DIAMETER,
                center = true
            );
        }

        // Left buttons
        translate(v = [ (197.5 - 36 - 36 - 30.5), 0, 0 ]) {
            translate( v = [ 0, (9 + 11), 0 ] )
                cylinder(
                    h = THICKNESS,
                    d = BTN_HOLE_DIAMETER,
                    center = true
                );
            translate( v = [ 0, (9 + 11 + 19 + 9 + 11), 0 ])
                cylinder(
                    h = THICKNESS,
                    d = BTN_HOLE_DIAMETER,
                    center = true
                );
        }
        // Middle-left buttons
        translate(v = [ (197.5 - 36 - 36), 0, 0 ]) {
            translate( v = [ 0, 0, 0 ] )
                cylinder(
                    h = THICKNESS,
                    d = BTN_HOLE_DIAMETER,
                    center = true
                );
            translate( v = [ 0, (9 + 11 + 19), 0 ])
                cylinder(
                    h = THICKNESS,
                    d = BTN_HOLE_DIAMETER,
                    center = true
                );
        }

        if( num_btns > 4 ) {
            // Middle-right buttons
            translate(v = [ (197.5 - 36), 0, 0 ]) {
                translate( v = [ 0, 0, 0 ] )
                    cylinder(
                        h = THICKNESS,
                        d = BTN_HOLE_DIAMETER,
                        center = true
                    );
                translate( v = [ 0, (9 + 11 + 19), 0 ])
                    cylinder(
                        h = THICKNESS,
                        d = BTN_HOLE_DIAMETER,
                        center = true
                    );
            }
        }

        if( num_btns > 6 ) {
            // Right buttons
            translate(v = [ 197.5, 0, 0 ]) {
                translate( v = [ 0, 9, 0 ] )
                    cylinder(
                        h = THICKNESS,
                        d = BTN_HOLE_DIAMETER,
                        center = true
                    );
                translate( v = [ 0, (9 + 11 + 19 + 9), 0 ])
                    cylinder(
                        h = THICKNESS,
                        d = BTN_HOLE_DIAMETER,
                        center = true
                    );
            }
        }
    }
}


joystick( 8 );
