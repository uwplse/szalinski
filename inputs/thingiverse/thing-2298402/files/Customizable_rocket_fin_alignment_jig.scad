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
// A customizable jig for aligning and gluing fins
// onto model rockets.

// Optimize view for Makerbot Customizer:
// preview[view:south east, tilt:top diagonal]

// Number of fins
nfins = 3; // [2:1:6]
// Diameter of the base stand
base_diam = 100; // [0:10:200]
// Wall feature thickness
wall_th = 2.0; // [0.2:0.2:6.0]
// Body tube inner diameter
tube_id = 23.8; // [10.0:0.1:50.0]
// Length of the body tube insert
insert_len = 25; // [10:0.2:60]
// Thickness at end of body tube insert to act as a stop
stop_th = 1.0; // [0.2:0.1:5]
// Length of the body tube stop
stop_len = 25; // [1:0.2:20]
// Slot width to fit thickness of rocket fins
slot_width = 2.6; // [0.2:0.1:10]
// Clearance between rocket body and fin alignment bosses
boss_clear = 4.0; // [0:1:20]
// How far below the end of the body tube the fins extend
slot_extend = 0; // [0:1:60]
// Height of fin alignment bosses
fbht = 50; // [10:1:100]
// Clearance for glue drips on the stop and insert
glue_clear = 1.2; // [0:0.2:3]
// Clearance width for accomodating an engine hook
hook_width = 4.0; // [0:0.2:10]
// Depth of the slot for accomodating an engine hook
hook_depth = 5.0; // [0:0.2:10]

/* [Hidden] */
// Special variables for facets/arcs
$fn = 48;
// Incremental offset to make good overlap for CSG operations
delta = 0.1;
// Thickness of fin alignment bosses
fbth = 2*wall_th + slot_width;
// Included angle between fins
fin_ang = 360 / nfins;
// Diameter of the "stop" cylinder
stop_diam = tube_id + 2*stop_th;
// The stop cylinder feature length needs to be at least
// as long as the slot extension. Choose the greater
// for the value to use as the actual feature height.
stop_len_1 = (slot_extend < stop_len) ? stop_len : slot_extend;

// Clearance geometry for stop and insert
module cleargeom() {
    clrth = slot_width + 2*glue_clear;
    cylht = wall_th + stop_len_1 + insert_len + delta;
    union() {
        for (i=[0:nfins-1]) {
            rotate(a = [0, 0, i * fin_ang]) {
                translate(v = [tube_id/2 - glue_clear, -clrth/2, 0]) {
                    // Clearance slot
                    cube(size = [base_diam/2, clrth, cylht]);
                }
            }
        }
        // Also include geometry that will make clearence for an
        // engine hook
        rotate(a = [0, 0, fin_ang/2]) {
            translate(v = [tube_id/2 - hook_depth, -hook_width/2, 0]) {
                // Clearance slot
                cube(size = [base_diam/2, hook_width, cylht]);
            }
        }
    }
}

// Fin boss
module finboss(ang=0) {
    cylht = wall_th + fbht + delta;
    slot_plane = wall_th + stop_len_1 - slot_extend;
    difference() {
        rotate(a = [0, 0, ang]) {
            // Cut out the fin slots
            difference() {
                // Trim fin slot boss to Base Diameter
                intersection() {
                    cylinder(h=cylht, d=base_diam);
                    translate(v = [0, -fbth/2, wall_th]) {
                        // Fin slot boss
                        cube(size = [base_diam/2, fbth, fbht]);
                    }
                }
                translate(v = [0, -slot_width/2, slot_plane]) {
                    // Fin slot
                    cube(size = [base_diam, slot_width, fbht + delta]);
                }
            }
        }
        translate(v=[0, 0, delta]){
            cylinder(h=cylht, d=stop_diam + 2*boss_clear);
        }
    }
}

// Create main base
module base() {
    union() {
        cylinder(h=wall_th, d=base_diam);
        translate(v=[0, 0, wall_th]){
            // Glue clerance slot cuts
            difference() {
                union() {
                    // Body tube stop cylinder
                    cylinder(h=stop_len_1, d=stop_diam);
                    translate(v=[0, 0, stop_len_1]){
                        // Body tube insert
                        cylinder(h=insert_len, d=tube_id);
                    }
                }
                // Glue clearence slots
                cleargeom();
            }
        }
        for (i=[0:nfins-1]) {
            finboss(i * fin_ang);
        }
    }
}

base();