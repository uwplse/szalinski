$fn = 100;
battery_diameter = 19; // 18.3
battery_length = 66; // 65.2
wall_thickness = 3;
corner_radius = 3;
box_length = battery_length + 8;
box_width = 43;
box_height = 21;

translate([74,55,27])
{
    rotate(a=[0,180,0])
    {
        difference()
        {
            // lid
            translate([-3,-15,24]) lid();

            // voltmeter
            #translate([13,11,20]) voltmeter();

            // switch
            #translate([49,12,22.5]) power_switch();
        }
    }
}

difference()
{
    // box
    translate([-3,-15,0]) box();

    // circuits
    translate([0,12,wall_thickness]) circuit_boards();

    // screw terminals
    //#translate([66.4,16,5+wall_thickness]) cube([12,10.3,9.7]);

    // output wires hole
    #translate([73,20,10]) rotate([0,90,0]) cylinder(d=4, h=5);
}

// battery holder - 37 offset due to center weirdness
translate([37,-30,0]) battery_box();

module box()
{
    difference()
    {
        // outer box
        roundedBox(box_length+2*wall_thickness, box_width+2*wall_thickness, box_height+2*wall_thickness, corner_radius);

        // inner box
        translate([3,3,3]) roundedBox(box_length, box_width, box_height+4, corner_radius);

        // groove 1
        translate([(box_length+2*wall_thickness)/4,wall_thickness,box_height+wall_thickness*1.5])
        {
            hull()
            {
                translate([0,0,0])sphere(r=0.5);
                translate([box_length/2,0,0])sphere(r=0.5);
            }
        }

        // groove 2
        translate([(box_length+2*wall_thickness)/4,box_width+wall_thickness,box_height+wall_thickness*1.5])
        {
            hull()
            {
                translate([0,0,0])sphere(r=0.5);
                translate([box_length/2,0,0])sphere(r=0.5);
            }
        }
    }
}

module lid()
{
    roundedBox(box_length+2*wall_thickness, box_width+2*wall_thickness, wall_thickness, corner_radius);

    difference()
    {
        // rim
        translate([3,3,-3]) roundedBox(box_length-0.5, box_width-0.5, 2*wall_thickness, corner_radius);
        translate([5,5,-4]) roundedBox(box_length-0.5-wall_thickness, box_width-0.5-wall_thickness, wall_thickness, corner_radius);
    }

    // lip1
    translate([(box_length+2*wall_thickness)/4,wall_thickness,-wall_thickness/2])
    {
        hull()
        {
            translate([0,0,0])sphere(r=0.5);
            translate([box_length/2,0,0])sphere(r=0.5);
        }
    }

    // lip2
    translate([(box_length+2*wall_thickness)/4,box_width+wall_thickness-0.5,-wall_thickness/2])
    {
        hull()
        {
            translate([0,0,0])sphere(r=0.5);
            translate([box_length/2,0,0])sphere(r=0.5);
        }
    }
}

module circuit_boards()
{
    // two boards
    cube([57,17,7]);

    // usb port
    #translate([-4,2,2]) cube([5,12,8]);

    // potentiometer
    #translate([50,23,9]) rotate([90,0,0]) cylinder(d=4.5, h=6);
}

module voltmeter()
{
    // base
    cube([33,15,3]);

    // display
    translate([5,0,1]) cube([24,15,8]);
}

module power_switch()
{
    // base
    cube([6,12,5.5]);

    // switch
    translate([1.2,2.35,5.5]) cube([3.4,6.8,2.6]);
}

module edge(radius, height)
{
	difference()
	{
		translate([radius/2-0.5, radius/2-0.5, 0]) cube([radius+1, radius+1, height], center = true);
		translate([radius, radius, 0]) cylinder(h = height+1, r1 = radius, r2 = radius, center = true);
	}
}

module roundedBox(xdim, ydim, zdim, rdim)
{
    hull()
    {
        translate([rdim,rdim,0]) cylinder(h=zdim,r=rdim);
        translate([xdim-rdim,rdim,0]) cylinder(h=zdim,r=rdim);
        translate([rdim,ydim-rdim,0]) cylinder(h=zdim,r=rdim);
        translate([xdim-rdim,ydim-rdim,0]) cylinder(h=zdim,r=rdim);
    }
}

module battery_box()
{
	difference()
	{
		union()
		{
            // battery holder
			translate([0, 0, 4]) cube(size=[battery_length+8, battery_diameter, 8], center=true);

            // positive outside edge
			translate([(battery_length/2)+3, 0, 9]) cube(size=[2, battery_diameter, 18], center=true);

            // positive terminal holder
			translate([(battery_length/2)+1, 0, 8.75]) cube(size=[2, battery_diameter, 11.5], center=true);

            // negative outside edge
			translate([-((battery_length/2)+3), 0, 9]) cube(size=[2, battery_diameter, 18], center=true);

            // negative terminal holder
			translate([-((battery_length/2)+1), 0, 8.75]) cube(size=[2, battery_diameter, 11.5], center=true);
		}

        // battery cradle
        #translate([0, 0, (battery_diameter/2)+3]) rotate(90, [0, 1, 0]) cylinder(r=battery_diameter/2, h=battery_length, center=true);

        // positive plate cutout
        translate([(battery_length+2)/2, 0, battery_diameter/2]) cube(size=[1, 5.5, 20], center=true);
        translate([(battery_length+2)/2-0.5, 0, 11]) cube(size=[2, 9.8, 12], center=true);

        // negative spring cutout
        translate([-((battery_length+2)/2), 0, battery_diameter/2]) cube(size=[1, 5.5, 20], center=true);
        translate([-((battery_length+2)/2-0.5), 0, 11]) cube(size=[2, 9.8, 12], center=true);

        // positive solder flange cutout
        translate([(battery_length/2-1.5), 0, -0.5]) cube(size=[7, 5.5, 5], center=true);
        translate([(battery_length/2)-4.5, 0, -0.5]) cylinder(r=2.75, h=5, center=true);

        // negative solder flange cutout
        translate([-(battery_length/2-1.5), 0, -0.5]) cube(size=[7, 5.5, 5], center=true);
        translate([-(battery_length/2)+4.5, 0, -0.5]) cylinder(r=2.75, h=5, center=true);

        // positive polarity marking
        translate([20, 0, 4.5]) cube(size=[6, 2, 4], center=true);
        translate([20, 0, 4.5]) cube(size=[2, 6, 4], center=true);

        // negative polarity marking
        translate([-20, 0, 4.5]) cube(size=[6, 2, 4], center=true);

		// positive bottom cutout for wires
		translate([30/2, 0, -0.75]) cube(size=[30, 2, 5.5], center=true);
		translate([3/2, 1, -0.75]) edge(4, 5.5);
		translate([3/2, -1, -0.75]) rotate(-90, [0, 0, 1]) edge(4, 5.5);

		// negative bottom cutout for wires
		translate([-30/2, 0, -0.75]) cube(size=[30, 2, 5.5], center=true);
		translate([-3/2, 1, -0.75]) rotate(90, [0, 0, 1]) edge(4, 5.5);
		translate([-3/2, -1, -0.75]) rotate(180, [0, 0, 1]) edge(4, 5.5);

		// joining bottom cutout for wires
		translate([0, 0, -0.75]) cube(size=[3, battery_diameter+5, 5.5], center=true);

		// rounded corners on end plates
		translate([0, -battery_diameter/2, 18]) rotate(90, [0, 1, 0]) edge(4, battery_length+12);
        translate([0, battery_diameter/2, 18]) rotate(90, [0, 1, 0]) rotate(-90, [0, 0, 1]) edge(4, battery_length+12);
		translate([0, -battery_diameter/2, 14.5]) rotate(90, [0, 1, 0]) edge(3, battery_length+4);
		translate([0, battery_diameter/2, 14.5]) rotate(90, [0, 1, 0]) rotate(-90, [0, 0, 1]) edge(3, battery_length+4);
	}
}
