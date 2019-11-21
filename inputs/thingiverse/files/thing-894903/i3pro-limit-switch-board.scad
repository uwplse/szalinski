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

// Endstop limit switch board
//
// This is a model of the MakerBot endstop limit switch in my Makerfront i3PRO.
// This is a commonly used switch in other 3D printers. I wanted a CAD model of
// the switch for a project but the model also prints well enough for a
// tangible application. The model includes some tiny stubs beneath the leaf
// spring to help the material bridge which are easily snipped off after
// printing. To get a CAD model without the stubs, change the "support=true"
// parameter in the limswitch() call near the bottom of the file to
// "support=false".

// Units are in mm

// Optimize view for Makerbot Customizer:
// preview[view:"south west", tile:"top diagonal"]

/* [Global] */
// Whether or not to include printer support
support = "Yes"; // [Yes, No]
// 0.8 prints well (atcual thick ~0.25)
leaf_spring_thickness = 0.8; // [0.2:0.1:1.2]


/* [Hidden] */
// Special variables for arc generation:
$fa = 0.1; // minimum fragment angle
$fs = 0.2; // minimum fragment size

// Circuit board dimensions
board_width=16;
board_height=39.5;
board_th=1.5;

module circ_board() {
// Circuit board with holes
    hole_diam = 3.8;
    hole_coords = [
      [3, 3],
      [13, 3],
      [3, 18],
      [3, 37],
    ];
    difference() {
        // Circuit board
        cube(size = [board_width,
                     board_height,
                     board_th]);
        for (xy = hole_coords) {
            translate([xy[0], xy[1], 0])
                cylinder(h=4, d=hole_diam, center=true);
        }
    }
}

module connector(origin=[0, 0, 0]) {
    // Connector
    //
    // Parameters
    // ----------
    // origin : [x, y, z] coordinate of connector origin
    //          (default: [0, 0, 0]
    conn_width = 12.4;
    conn_depth = 6.9;
    conn_height = 5.9;
    conn_wall = 0.5;
    translate(origin) {
        difference() {
        // External shell of connector
        cube(size = [conn_width, conn_depth, conn_height]);
        // Internal shell of connector
        translate([conn_wall, -conn_wall, conn_wall])
        cube(size = [conn_width - conn_wall * 2,
                     conn_depth,
                     conn_height - conn_wall * 2]);
        }
    }
}

// Limit switch
module limswitch(origin=[0, 0, 0], support=true) {
    // Limit Switch
    //
    // Parameters
    // ----------
    // origin : [x, y, z] coordinate of limit switch origin
    //          (default: [0, 0, 0]
    // support : boolean for putting in support for the leaf spring
    //           when printing (default: true)
    sw_width = 6.6;
    sw_length = 12.7;
    sw_height = 7.4;
    leaf_th = leaf_spring_thickness;
    leaf_coords = [
      [0, 0.5],
      [-3.81 , 12.2],
      [-5.1, 13.7],
      [-2.8, 16.5],
      // Give the leaf spring thickness so it can be extruded
      [-2.8 + leaf_th, 16.5],
      [-5.1 + leaf_th, 13.7],
      [-3.81 + leaf_th , 12.2],
      [0 + leaf_th, 0.5],
    ];
    support_coords = [
      [-1.8, 6],
      [-3.81 , 12.2],
      [-5.1, 13.7],
      [-2.8, 16.5],
    ];
    translate(origin) {
        union() {
            cube(size = [sw_width, sw_length, sw_height]);
            linear_extrude(height = sw_height)
                polygon(leaf_coords);
            if(support) {
                for(i = [0 : 3]){
                    translate([support_coords[i][0] + leaf_th/2,
                               support_coords[i][1], -board_th]){
                    cylinder(h=board_th, d1=2*leaf_th, d2=leaf_th);
                    }
                }
            }
        }
    }
}

// Assemble the board
module assemble(support=true) {
    union() {
        circ_board();
        connector(origin=[2, 4, board_th]);
        limswitch(origin=[0, 21, board_th], support=support);
    }
}

if (support == "Yes")
    assemble(support=true);
else
    assemble(support=false);
