// ----------------------------------------------
// Thing: Customizable NeoPixel Ring
// Author: Petr Ptacek
// Last updte: 12/31/2017
// License: Attribution-ShareAlike (CC BY-SA 3.0)
// ----------------------------------------------

/* [General] */

// Which part would you like to see?
part = "Holder"; //[Holder: Holder Only,Cover: Cover Only]

// Number of NeoPixels in the ring.
number_of_neopixels = 32; // [3:100]

// Diameter running through the centers of the NeoPixels.
middle_diameter = 102;

/* [Hidden] */

$fa = 2;
$fs = 0.5;
inch = 25.4;
bit = 0.01;
inf = 1e3;
loose_fit = 0.3;
press_fit = 0.2;
hole_compensation = 0.2;

extrusion_w = 0.5;
extrusion_h = 0.2;

neo_ring_d = middle_diameter;
echo("Holder md:", middle_diameter);
neo_ring_n = number_of_neopixels;

neopixel_h = 3;
neopixel_pcb_d = 10 + loose_fit;
neopixel_pcb_h = 2; 
neopixel_led_w = 5.3 + loose_fit;
neopixel_led_h = neopixel_h - neopixel_pcb_h;

holder_rim_h = 5*extrusion_h;
holder_rim_od = neo_ring_d + neopixel_pcb_d;
holder_rim_id = neo_ring_d - neopixel_pcb_d;
holder_od = holder_rim_od + 4*extrusion_w;
echo("Holder od:", holder_od);
holder_id = holder_rim_id - 4*extrusion_w;
echo("Holder id:", holder_id);
holder_front_t = 3*extrusion_h;
holder_h = holder_front_t + neopixel_h + holder_rim_h;
echo("Holder height:", holder_h);

cover_rim_h = holder_rim_h;
cover_rim_w = 2*extrusion_w;
cover_rim_od = holder_rim_od - press_fit;
cover_rim_id = holder_rim_id + press_fit + hole_compensation;
cover_back_t = 3*extrusion_h;
echo("Ring height:", holder_h + cover_back_t);

wire_hole_d = 8;

module ring(od, id, height) {
    linear_extrude(height = height)
        difference() {
            circle(d = od);
            circle(d = id);
        }
}

module neopixel() {
    cylinder(d = neopixel_pcb_d, h = neopixel_pcb_h);
    translate([0, 0, neopixel_pcb_h + neopixel_led_h/2 - bit])
        cube([neopixel_led_w, neopixel_led_w, neopixel_led_h], center = true);
}

module holder() {
    difference() {
        // body
        ring(holder_od, holder_id, holder_h);
        // turned and shifted
        translate([0, 0, neopixel_h + holder_front_t + bit])
            mirror([0, 0, 1])
                // neopixel matrix
                for (a = [0:360/neo_ring_n:359])
                    rotate([0, 0, a])
                        translate([neo_ring_d/2, 0, 0])
                            neopixel();
        // rim
        translate([0, 0, holder_front_t + neopixel_h])
            ring(holder_rim_od, holder_rim_id, holder_rim_h + bit);
    }
}

module cover() {
    // body
    difference() {
        ring(holder_od, holder_id, cover_back_t);
        translate([neo_ring_d/2, 0, 0])
        cylinder(d = wire_hole_d, h = inf, center = true);
    }
    // rim
    translate([0, 0, cover_back_t]) {
        ring(cover_rim_od, cover_rim_od - 2*cover_rim_w, cover_rim_h);
        ring(cover_rim_id + 2*cover_rim_w, cover_rim_id, cover_rim_h);
    }
}

if (part == "Holder")
    holder();
else
    cover();

// Both
*translate([0, 0, holder_h + cover_back_t]) 
    mirror([0, 0, 1])
        cover();
