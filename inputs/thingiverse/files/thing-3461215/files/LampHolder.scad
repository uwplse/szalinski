thick = 2.5;
lamp_tube = 13.8;
press_tube = 7.7;

height = 44.28;
width = 35;

base_thick = 6.5;
base_length = 50.3;

$fn = 100;

module LampBase()
{
    difference()
    {
        union()
        {
            difference()
            {
                h = lamp_tube / 2 + 16.3;
                union()
                {
                    cylinder(d = 2 * thick + lamp_tube, h = height);
                    translate([0, 0, h])
                    rotate([0, 90, 0])
                    cylinder(d = 2 * thick + lamp_tube, h = width, center = true);
                    
                    translate([0, 0, h / 2])
                    cube([width, lamp_tube + 2 * thick, h], center = true);
                    
                    scale([1, 1.48, 1])
                    {
                        cylinder(d1 = 33.8, d2 = 0.9*lamp_tube, h = h + lamp_tube, $fn=4);
                        translate([-8, 0, 0])
                        cylinder(d1 = 33.8, d2 = 13, h=h, $fn=4);
                        translate([8, 0, 0])
                        cylinder(d1 = 33.8, d2 = 13, h=h, $fn=4);
                    }
                }
                cylinder(d = lamp_tube, h = 1.5 * height);
                translate([0, 0, h])
                rotate([0, 90, 0])
                cylinder(d = lamp_tube, h = 1.1 * width, center = true);
                
                translate([0, 0, press_tube / 2])
                rotate([0, 90, 0])
                cylinder(d = press_tube, h = 10 * width, center = true);
            }


            translate([0, 0, -base_thick / 2])
            difference()
            {
                cube([width + 2 * 7.4, base_length, base_thick], center = true);
                d = 4.3;
               
                translate([20, 20, 0])
                cylinder(d = d, h = 1.1*base_thick, center = true);
                
                translate([-20, 20, 0])
                cylinder(d = d, h = 1.1*base_thick, center = true);
                
                translate([20, -20, 0])
                cylinder(d = d, h = 1.1*base_thick, center = true);
                
                translate([-20, -20, 0])
                cylinder(d = d, h = 1.1*base_thick, center = true);
            }
        }
        
        h = press_tube / 2 + base_thick;
        translate([20 + press_tube / 2, 0, h / 2 - base_thick])
        cube([press_tube, press_tube, h], center = true);
        translate([-20 - press_tube / 2, 0, h / 2 - base_thick])
        cube([press_tube, press_tube, h], center = true);
    }
}

LampBase();