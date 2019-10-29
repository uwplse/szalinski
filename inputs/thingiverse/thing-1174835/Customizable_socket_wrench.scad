// Copyright 2015 Arthur Davis (thingiverse.com/artdavis)
// This file is licensed under a Creative Commons Attribution 4.0
// International License.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.

/* [Global] */

/* [Geometry] */
// Hex socket minor axis width
hex_width = 5.4; // [2.0:0.1:20.0]
// Wall thickness of socket
wall_thick = 2.0; // [1.0:1.0:5.0]
// Hex drive socket depth
socket_depth = 5.0; // [2.0:0.5:20.0]
// Handle length
handle_length = 50.0; // [10:5:100]
// Handle thickness
handle_thick = 2.0; // [1.0:0.5:10.0]

/* [Build Plate] */
use <utils/build_plate.scad>;
// Show build plate?
show_build_plate = "Yes"; // [Yes, No]
// For display only, doesn't contribute to final object
build_plate_selector = 3; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
//For "Manual" option: Build plate x dimension
build_plate_manual_x = 200; //[100:400]
//For "Manual" option: Build plate y dimension
build_plate_manual_y = 200; //[100:400]
if (show_build_plate == "Yes") {
    build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y); 
}

/* [Hidden] */
hex_diam = hexmajor(hex_width);
handle_diam = hex_diam + 2 * wall_thick;

// Functions for calculating hexagonal axes
function hexminor(major) = sqrt(3) * major / 2;
function hexmajor(minor) = 2 * minor / sqrt(3);

difference() {
    union() {
        // Socket boss
        cylinder(h=socket_depth, d=handle_diam, $fn=50);
        // Handle
        translate([handle_length/2, 0, handle_thick/2])
        cube([handle_length, handle_diam, handle_thick], center=true);
        // Handle endround
        translate([handle_length, 0, 0])
        cylinder(h=handle_thick, d=handle_diam, $fn=50);
    }
    // Hex boss
    cylinder(h=2.1*socket_depth, d=hex_diam, $fn=6, center=true);
}


