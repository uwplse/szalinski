/* Simple Clothing Rack Divider */

// Inner Hole Diameter
inner = 35;

// Outer Hole Diameter
outer = 80;

// Thickness
thick = 1;

// Cutout Size
cutout= 5;

difference() {
cylinder(r=outer/2, h=thick);
#translate([0  , 0  , -thick/2])cylinder(r=inner/2, h=thick*2);
#translate([0  , -cutout/2  , -thick/2])cube([outer, cutout, thick*2]);
}
