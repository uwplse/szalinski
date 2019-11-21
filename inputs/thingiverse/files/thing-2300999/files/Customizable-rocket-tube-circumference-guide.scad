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
// Tapered rings that may be conveniently used as cutting/marking
// guides about the circumference of rocket body tubes.
//
// Outer diameters for Estes body tubes
// Ref: http://www.estesrockets.com
// BT-5: 13.8mm
// BT-20: 18.7mm // set diam=19.3
// BT-50: 24.8mm // set diam=25.4
// BT-55: 34.0mm
// BT-60: 42.0mm

// Optimize view for Makerbot Customizer:
// preview[view:south east, tilt:top diagonal]

// Body Tube Outer Diameter
diam = 19.3; // [5:0.1:60]
// Wall thickness
wall_th = 4.0; // [1:0.1:10]
// Height of the guide from top to bottom
height = 10.0; // [1:0.1:40]
// Slope angle of the taper in degrees (0 is no taper)
slope = 45.0; // [0:5:70]

/* [Hidden] */
// Special variables for facets/arcs
$fn = 48;
// Overlap offset for improved CSG operations
delta = 0.1;
// Outer diameter of the guide
od = diam + 2*wall_th;
// Height of the taper
tht = tan(slope) * wall_th;

difference() {
    union() {
        // Base cylinder
        cylinder(h=height - tht, d=od);
        translate(v = [0, 0, height - tht]) {
            // Taper
            cylinder(h=tht, d1=od, d2=diam);
        }
    }
    // Center hole
    cylinder(h=2*(height + delta), d=diam, center=true);
}