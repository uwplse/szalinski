/* Width including threads */
Total_diameter = 46.0;
Thread_depth = 1.5;
lid_height = 10.0;
slit_width = 1.5;


fly_trap();

module fly_trap()
{
    difference()
    {
        union() {
            lid_base();
            
            translate([0, 0, -38+lid_height])
            cylinder(d2=Total_diameter-15, d1=5, h=40, $fn=100);
        }
        translate([0, 0, -37+lid_height])
        cylinder(d2=Total_diameter-4-15, d1=2, h=40, $fn=100);


        hull()
        {
            translate([0, 0, -Total_diameter])
            rotate([0, 90, 0])
            translate([0, 0, -Total_diameter/2])
            cylinder(d=slit_width, h=Total_diameter, $fn=20);

            translate([0, 0, -10])
            rotate([0, 90, 0])
            translate([0, 0, -Total_diameter/2])
            cylinder(d=slit_width, h=Total_diameter, $fn=20);

        }

        rotate([0, 0, 90])
        hull()
        {
            translate([0, 0, -Total_diameter])
            rotate([0, 90, 0])
            translate([0, 0, -Total_diameter/2])
            cylinder(d=slit_width, h=Total_diameter, $fn=20);

            translate([0, 0, -10])
            rotate([0, 90, 0])
            translate([0, 0, -Total_diameter/2])
            cylinder(d=slit_width, h=Total_diameter, $fn=20);

        }

    }
}

module lid_base()
{
    intersection() {
        
        union() {
            difference()
            {
                cylinder(d=Total_diameter+4, h=lid_height+2, $fn=100);
                translate([0, 0, -3])
                cylinder(d=Total_diameter, h=lid_height-1+2, $fn=100);

            }
            for (a=[0:90:360])
            {
                rotate([0, 0, a])
                translate([Total_diameter/2+15-Thread_depth, 0, 0])
                cylinder(d=30, h=1.5);
            }
        }
        cylinder(d=Total_diameter+4, h=lid_height+2, $fn=100);

    }
}