// Copyright 2017 Arthur Davis (thingiverse.com/artdavis)
// This file is licensed under a Creative Commons Attribution 4.0
// International License.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.
//
// A coupler that may be used to join a model rocket nose cone
// to the main body tube. This is especially useful for a split
// halves nosecone as in the Eggloft Egg Rocket Nose Cone here:
// http://www.thingiverse.com/thing:2228825
// The top setback portion is available area to tape the shoulder
// of the nosecond to this coupler. This length in combination
// with the length of the nosecone shoulder should be enough to
// accomodate the width of the tape that will be used.
// The hole in the bottom allows an eyelet to be screwed in to
// the coupler for tying to the shock cord.
//
// Estes body tube dimensions
// Ref: http://www.estesrockets.com
// Inner diameters:
// BT-5: 13.2mm
// BT-20: 18.0mm
// BT-50: 24.1mm
// BT-55: 32.6mm
// BT-60: 40.5mm
// Outer diameters:
// BT-5: 13.8mm
// BT-20: 18.7mm // set diam=19.3
// BT-50: 24.8mm // set diam=25.4
// BT-55: 34.0mm
// BT-60: 42.0mm

// Optimize view for Makerbot Customizer:
// preview[view:south east, tilt:top diagonal]

// Body Tube Inner Diameter
btid = 24.1; // [5:0.1:60]
// Coupling pocket inner diameter
pid = 18.0; // [5:0.1:60]
// Coupler coupling outer diameter
ccod = 19.0; // [5:0.1:60]
// Length of the whole coupling
length = 32.0; // [5:0.1:60]
// Diameter for eyelet screw hole
hole_diam = 2.0; // [0:0.1:10]
// Depth of coupling pocket
pocket = 12.0; // [0:0.1:60]
// Length of coupler coupling OD to expose
setback = 10.0; // [0:0.1:60]

/* [Hidden] */
// Special variables for facets/arcs
$fn = 48;
// Overlap offset for improved CSG operations
delta = 0.1;

difference() {
    difference() {
        union() {
            translate(v = [0, 0, length - setback]) {
                // Top of coupling
                cylinder(h=setback, d=ccod);
            }
            // Bottom of coupling
            cylinder(h = length - setback, d = btid);
        }

        // Coupling pocket
        translate(v = [0, 0, length - pocket]) {
            cylinder(h=pocket + delta, d = pid);
        }
    }
    // Eyelet screw hole
    cylinder(h = 2*(length + delta), d = hole_diam, center=true);
}