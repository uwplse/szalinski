$fn=50+0;

// Diameter of pilot hole (mm)
pilot_hole_diameter=3;
// Square leg size (mm)
leg_size=50.5;
half_leg=leg_size/2;
// Thickness of jig (mm)
thick=2;
// Height of guide part (mm)
guide_height=12;

union() {
 
difference() {
translate([-half_leg,-half_leg,0]) cube([leg_size,leg_size,thick]);
translate([0,0,0]) cylinder(d=pilot_hole_diameter,h=thick*2.5,center=true);
}

translate([-half_leg-thick,-half_leg-thick,0]) cube([thick,leg_size+thick,guide_height]);
translate([-half_leg,-half_leg-thick,0]) cube([leg_size,thick,guide_height]);
}