// Sealing (not just) for Ikea Korken
// https://www.thingiverse.com/thing:3724464
// Vilem Marsik, 2019
// CC BY-NC-SA
// https://creativecommons.org/licenses/by-nc-sa/4.0/


outer_diameter=95;
inner_diameter=74;
thickness=3;
/* [Hidden] */
$fa=.5;
difference()	{
	cylinder(d=outer_diameter,h=thickness);
	translate([0,0,-1])
		cylinder(d=inner_diameter,h=thickness+2);
}