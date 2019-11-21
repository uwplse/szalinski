basePlate();
translate([8.5, -19, 0]) sensorMount();

//translate([-8, -19, 0]) rotate ([25, 0, 0])  ledMount();
//translate([25, -19, 0]) rotate ([25, 0, 0]) ledMount();

module basePlate()
{
    bolt_diameter = 4;
    thickness = 4;    
    
    union()
    {
        difference()
        {
            linear_extrude(height=7) square ([17, 17], centre = true);
            
            /* Left hole */
            rotate ([90, 0, 0]) 
            {
                translate([3, 7 / 2, -17])
                cylinder(d = bolt_diameter, h = 17, centre = true, $fn = 18);
            }   
       
            /* Right hole */
            rotate ([90, 0, 0]) 
            {
                translate([17-3, 7 / 2, -17])
                cylinder(d = bolt_diameter, h = 17, centre = true, $fn = 18);
            }          
        }
        
        translate([6, -7, 0])
        linear_extrude(height=7) square ([5, 7], centre = true);
    }
}

module sensorMount()
{
    difference()
    {
        cylinder(d = 28, h = 7, centre = true);
        cylinder(d = 19, h = 7, centre = true);
    }
}

module ledMount()
{
    difference()
    {
        cylinder(d = 8, h = 7, centre = true);
        cylinder(d = 5, h = 7, centre = true);
    }
}
