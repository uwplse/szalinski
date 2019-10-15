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

// Customizable parts container

// I designed these bins for small parts storage to fit
// in card catalog style cabinet drawers I happened
// to have. The protruding tab on top has some angled rails
// for sliding in a descriptive label.

// At first I was printing these out solid until I realized
// that was using too much filament. Under the "pattern"
// dropdown box in the Customizer are options for cutting
// out a pattern in the sidewalls so the containers can use
// less material with the added bonus of being able to see
// the small parts cotained inside.

// "Hex" is very cool looking but can be taxing for the computer
// to build the STL. Your mileage may vary getting this to work
// in Customizer but you can always download the source and
// run it locally in OpenSCAD. Also it takes a long time
// to print since the extruder head has to draw a profile for
// all of the wire mesh.

// "Rect" should print much faster but your printer will have
// to do a lot of bridging.

// Units are in mm

/* [Global] */
// Type of pattern cutout for the side walls
pattern = "Rect"; // [Rect, Hex, Empty, Solid]
// Width of the compartment bins
width = 26; // [10:1:50]
// Height of the sidewalls
height = 65; // [10:5:100]
// Depth of the compartment bins
depth = 35; // [10:5:100]
//depth = 15;
//depth = 20;
//depth = 25;
//depth = 30;
//depth = 40;
//depth = 45;
//depth = 50;
// Height of the tab above the sidewall
tabheight = 25; //[10:5:50]
// Wall thickness
thick = 1.0; //[0.5:0.5:3.0]
// Thickness of the solid frame corners
frame_wd = 2.0; // [1:1:5]
// Diameter of the hexagons in the mesh for "Hex" pattern
hexdiam = 6.0;
//hexdiam = 3.0;
// Height of the rectangular cutouts for "Rect" pattern
rectht = 2.0;
// How many support pillars to build for "Rect"  pattern in depth
rect_depth_support = 1; // [0:1:4]
// How many support pillars to build for "Rect"  pattern in width
rect_width_support = 0; // [0:1:4]
// Thickness of the mesh with pattern cutouts
mesh_th = 0.8;
//mesh_th = 0.4;

/* [Hidden] */
// Radius for tab fillet
fillet_rad = 5;
// Y-location for divider at the back
divy = (depth - thick)/2;
lht0 = tabheight - fillet_rad; // Label height
lht1 = lht0 + thick; // Label frame height
lth = 0.8; // Label thickness
fth = 0.8; // Frame thickness
cht = lht1 + 0.2; // Frame cutter height

// Functions for calculating hexagonal axes
// When using a cylinder with $fn=6 for your hex specify
// d=hexmajor(<hexagonal-minor-width>)
function hexminor(major) = sqrt(3) * major / 2;
function hexmajor(minor) = 2 * minor / sqrt(3);

module labelholder() {
        // Label holder
        difference() {
            // Frame
            translate([0, divy-(thick + fth + lth)/2, (height + lht1/2 - thick)])
            cube([width, fth + lth, lht1], center=true);
            // Label cutout
            translate([0, divy-(thick+lth)/2+0.04, (height + lht0/2)+0.1])
            cube([width-2*fth, lth+0.04, lht0+0.1], center=true);
            // Window cutout
            translate([0, divy-(thick/2 + fth + lth)+0.02, (height+cht/2)])
            cube([width-6*fth, 2*(fth + lth), cht], center=true);
        }
}

module cutters(p) {
    // Parameter pattern: [Rect, Hex]
    translate([0, 0, height/2]){
    union() {
        intersection() {
            cube([2*width, depth-2*frame_wd,  height-2*frame_wd], center=true);
            if (p == "Rect") {
                rotate([90,0,0]) rotate([0, 90, 0])
                difference() {
                    rectbars(depth, height);
                    if (rect_depth_support > 0)
                    for (s=[1:rect_depth_support]) {
                        translate([s*depth/(rect_depth_support+1) - depth/2, 0, 0])
                        cube([frame_wd, height,  2*(depth+height)], center=true);
                        }
                    }
                }
            else if (p == "Hex") {
                rotate([90,0,0]) rotate([0, 90, 0])
                hexbars(depth, height); }
            else {
                cube([2*width, depth-2*frame_wd,  height-2*frame_wd], center=true);
                }
        }
          intersection() {
            cube([width-2*frame_wd, 2*depth,  height-2*frame_wd], center=true);
            if (p == "Rect") {
                rotate([90,0,0])
                difference() {
                    rectbars(width, height);
                    if (rect_width_support > 0)
                    for (s=[1:rect_width_support]) {
                        translate([s*width/(rect_width_support+1) - width/2, 0, 0])
                        cube([frame_wd, height,  2*(width+height)], center=true);
                        }
                    }
                }
            else if (p == "Hex") {
                rotate([90,0,0])
                hexbars(width, height); }
            else {
                cube([width-2*frame_wd, 2*depth,  height-2*frame_wd], center=true);
            }
          }
    }
    }
}

module hexcutters() {
    // Help Customizer work
    cutters("Hex");
}

module rectcutters() {
    // Help Customizer work
    cutters("Rect");
}

module emptycutters() {
    // Help Customizer work
    cutters("Empty");
}

module hexbars(wd, ht) {
    ex = 2*(wd + ht); // Extrusion distance
    tilehex = hexdiam + 2*mesh_th;
    //cube([wd, ht,  ex], center=true); // Reference block
    intersection() {
        cube([wd-2*frame_wd, ht-2*frame_wd,  ex*1.1], center=true);
        for (xpos=[-wd: hexminor(tilehex): wd],
             ypos=[-ht: 3*tilehex/2 : ht]) {
        translate([xpos, ypos, 0])
        rotate([0,0,90]) {
        cylinder(d=hexdiam, h=ex, center=true, $fn=6);
        translate([3*tilehex/4, hexminor(tilehex)/2,0])
        cylinder(d=hexdiam, h=ex, center=true, $fn=6);
        }
         }
     }
}

module rectbars(wd, ht) {
    ex = 2*(wd + ht); // Extrusion distance
    //cube([wd, ht,  ex], center=true); // Reference block
    intersection() {
        cube([wd-2*frame_wd, ht-2*frame_wd,  ex*1.1], center=true);
        for (ypos=[-ht: rectht + mesh_th : ht]) {
        translate([0, ypos, 0])
        //rotate([0,0,90])
        cube([1.1*wd, rectht, ex], center=true);
         }
     }
}

module fillcorner() {
translate([0, depth/2, height])
difference() {
    rotate([0,90,0])
    rotate([0,0,45])
    cube([2*fillet_rad, 2*fillet_rad, width], center=true);
    translate([0, width, 0])
    cube(2*width, center=true);
    translate([0, 0, -width])
    cube(2*width, center=true);
    cube([width - 2*thick, 2*width, 2*width], center=true);   
}
}

module cylcoord(x, y, z, r, th) {
        translate([x, y, z])
        rotate(a=[90,0,0])
        cylinder(h=th, r=r, center=true, $fn=50);
}

module fillet(x, y, z, r, dir) {
    union() {
        cylcoord(x-r*dir,y,z-r,r,thick);
    difference() {
        children();
        cylcoord(x,y,z,r, 2*thick);
    }}
    
}

module makebin() {
        difference() {
            fillet((width)/2, divy, height + tabheight, fillet_rad, 1)
            fillet(-(width)/2, divy, height + tabheight, fillet_rad, -1)
            union() {
            difference() {
                // Outer shell
                translate([0, 0, height/2])
                cube([width, depth, height], center = true);
                // Inside cut
                translate([0, 0, height/2 + thick])
                cube([width - 2*thick, 1.1*depth, height], center = true);
            }

            // Divider tab back
            translate([0, divy, (height + tabheight)/2])
            cube([width, thick, height + tabheight], center = true);
            // Divider tab front
            translate([0, -divy, height/2])
            cube([width, thick, height], center = true);
            fillcorner();
            labelholder();
            }
            // Sidewall cutouts
            //if (pattern != "Solid")
            //    cutters(p=pattern);
            if (pattern == "Rect") {
                rectcutters(); }
            else if (pattern == "Hex") {
                hexcutters(); }
            else if (pattern == "Empty") {
                emptycutters(); }
        }
}

// For running in native OpenSCAD
makebin();
// For debugging:
//hexbars(depth, height);
//rectbars(depth, height);
//cutters(pattern="Rect");
//translate([0, divy, height + tabheight/2 - thick])
//cube([width, thick, tabheight], center = true);
//labelholder();