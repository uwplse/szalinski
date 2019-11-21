$fn = 100; // upgrade resolution
battery_diameter = 19;
battery_length = 73; // 69 for unprotected

difference()
{
    union()
    {
        // battery holder
        translate([0, 0, 4]) cube(size=[battery_length+8+4, battery_diameter, 8], center=true);

        // positive outside edge
        translate([(battery_length/2)+4, 0, 9]) cube(size=[4, battery_diameter, 18], center=true);

        // positive terminal holder
        translate([(battery_length/2)+1, 0, 8.75]) cube(size=[2, battery_diameter, 13.5], center=true);

        // negative outside edge
        translate([-((battery_length/2)+4), 0, 9]) cube(size=[4, battery_diameter, 18], center=true);

        // negative terminal holder
        translate([-((battery_length/2)+1), 0, 8.75]) cube(size=[2, battery_diameter, 13.5], center=true);
    }

    // battery cradle
    translate([0, 0, (battery_diameter/2)+3]) rotate(90, [0, 1, 0]) cylinder(r=battery_diameter/2, h=battery_length, center=true);

    // positive plate cutout
    translate([(battery_length+2)/2, 0, battery_diameter/2]) cube(size=[1, 5.5, 20], center=true);
    translate([(battery_length+2)/2-0.5, 0, 11]) cube(size=[2, 12.5, 12], center=true);

    // negative spring cutout
    translate([-((battery_length+2)/2), 0, battery_diameter/2]) cube(size=[1, 5.5, 20], center=true);
    translate([-((battery_length+2)/2-0.5), 0, 11]) cube(size=[2, 12.5, 12], center=true);

    // positive solder flange cutout
    translate([(battery_length/2-1.5), 0, -0.5]) cube(size=[7, 5.5, 5], center=true);
    translate([(battery_length/2)-4.5, 0, -0.5]) cylinder(r=2.75, h=5, center=true);

    // negative solder flange cutout
    translate([-(battery_length/2-1.5), 0, -0.5]) cube(size=[7, 5.5, 5], center=true);
    translate([-(battery_length/2)+4.5, 0, -0.5]) cylinder(r=2.75, h=5, center=true);

    // positive bottom cutout for wires
    translate([30/2, 0, -0.75]) cube(size=[30, 2.25, 5.5], center=true);
    translate([3/2, 1, -0.75]) edge(4, 5.5);
    translate([3/2, -1, -0.75]) rotate(-90, [0, 0, 1]) edge(4, 5.5);

    // negative bottom cutout for wires
    translate([-30/2, 0, -0.75]) cube(size=[30, 2.25, 5.5], center=true);
    translate([-3/2, 1, -0.75]) rotate(90, [0, 0, 1]) edge(4, 5.5);
    translate([-3/2, -1, -0.75]) rotate(180, [0, 0, 1]) edge(4, 5.5);

    // joining bottom cutout for wires
    translate([0, 0, -0.75]) cube(size=[4.25, battery_diameter+5, 5.5], center=true);

    // rounded corners on end plates
    translate([0, -battery_diameter/2, 18]) rotate(90, [0, 1, 0]) edge(4, battery_length+13);
    translate([0, battery_diameter/2, 18]) rotate(90, [0, 1, 0]) rotate(-90, [0, 0, 1]) edge(4, battery_length+13);
    translate([0, -battery_diameter/2, 16.5]) rotate(90, [0, 1, 0]) edge(5, battery_length+4);
    translate([0, battery_diameter/2, 16.5]) rotate(90, [0, 1, 0]) rotate(-90, [0, 0, 1]) edge(5, battery_length+4);
}

module edge(radius, height)
{
	difference()
	{
		translate([radius/2-0.5, radius/2-0.5, 0]) cube([radius+1, radius+1, height], center = true);
		translate([radius, radius, 0]) cylinder(h = height+1, r1 = radius, r2 = radius, center = true);
	}
}
