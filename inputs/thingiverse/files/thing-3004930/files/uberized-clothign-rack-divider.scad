/* Uberized Simple Clothing Rack Divider */

// Inner Hole Diameter
box = 20;

// Outer Hole Diameter
outer = 80;

// Thickness
thick = 1;

// Cutout Size
cutout= 5;

difference() {
cylinder(r=outer/2, h=thick);
#translate([-box/2, -box/2 , -thick/2])
    cube([box, box, thick*2]);
#rotate(180)
#translate([0  , -cutout/2  , -thick/2])
    cube([outer, cutout, thick*2]);
}

