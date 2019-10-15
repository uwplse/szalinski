wheel_width = 19.1;

rim_external_radius = 38;
rim_thickness = 2;

inner_rim_thickness = 4;
inner_rim_height = 18;

hub_height = 15;
hub_radius = 5;

shaft_radius = 1.5;
shaft_flat = true;
shaft_flat_offset=1;

12mm_hex_drive = true;

spoke_type = 1; // 1 = parallel 2= wedge
num_spokes = 10;
spoke_thickness = 3;
spoke_height = 15;
spoke_angle = -10;

// size is the XY plane size, height in Z
module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}


union(){
// outer rim
difference()
{
    cylinder(wheel_width,rim_external_radius,rim_external_radius, $fn=128);  // outer rim
 
    translate([0,0,-1])
    {     // inner rim
        cylinder(wheel_width+2, rim_external_radius-                rim_thickness,rim_external_radius-                  rim_thickness, $fn=64);
    }
}

// inner rim
difference()
{
    cylinder(inner_rim_height,rim_external_radius-rim_thickness,rim_external_radius-rim_thickness, $fn=128);  // outer rim
 
    translate([0,0,-1]){     // inner rim
        cylinder(wheel_width+2, rim_external_radius-rim_thickness-inner_rim_thickness,rim_external_radius-rim_thickness-inner_rim_thickness, $fn=64);
    }
}

// hub
difference()
{
    if (12mm_hex_drive == true)
    {
        if (hub_radius < 8)
        {
            hub_radius =8;
             cylinder(hub_height,hub_radius,8, $fn=64);  // outer hub
        }
        else
        {
             cylinder(hub_height,hub_radius,hub_radius, $fn=64);  // outer hub
        }
    }
   
 
    translate([0,0,-1])
    {   
        // inner hub
        difference()
        {
            cylinder(wheel_width+2,shaft_radius, shaft_radius, $fn=64); 
            //flat on shaft
            if (shaft_flat == true)
            {
                translate([shaft_radius+shaft_flat_offset,0,15])
                {
                    cube([shaft_radius*2
                    ,shaft_radius*2,29], true); //shaft diameter
                }
            }   
        }
    }
    if (12mm_hex_drive == true)
    {
        hexagon(12,4.5);
    }
}



step_angle = 360/num_spokes;
for (angle = [0: step_angle: 360])
{
    rotate ( angle)
    {
        if (spoke_type == 1) // original
        {
            translate([(rim_external_radius-rim_thickness-hub_radius)/2+hub_radius,0,           spoke_height/2]) 
            {
                difference()
                {
                    cube([rim_external_radius-rim_thickness-hub_radius+1,spoke_thickness,                   spoke_height], true);  // fudge
                    rotate([0,spoke_angle,0])
                    {
                        translate([0,0,spoke_height])
                        {
                            cube([rim_external_radius-rim_thickness-hub_radius+1,spoke_thickness+1,spoke_height], true);  // fudge
                        }
                    }
                }
            }
        }
        else
        { 
            if (spoke_type ==2)  // parallel
            {
                rotate([90,0,0])
                {
        
                    linear_extrude(1.5, center = true)
                    {
                        polygon( [[hub_radius-0.5,0], [rim_external_radius-rim_thickness-                       inner_rim_thickness+0.5,0],
                            [rim_external_radius-rim_thickness-inner_rim_thickness+0.5,                         inner_rim_height],[hub_radius-0.5, hub_height-0.5]]);
                    }
                }
            }
            else
            {
                if (spoke_type ==3) // wedge
                {
                    rotate_extrude(angle = spoke_thickness * 4, $fn=128)
                    {   
                        /*polygon( [[hub_radius-0.5,0], [rim_external_radius-rim_thickness-                       inner_rim_thickness+0.5,0],
                           [rim_external_radius-rim_thickness-inner_rim_thickness+0.5,                      inner_rim_height],
                            [hub_radius-0.5, hub_height-0.5]]);*/
                        polygon( [[hub_radius-0.5, 0], [rim_external_radius-rim_thickness-                       inner_rim_thickness+0.5,0],
                           [rim_external_radius-rim_thickness-inner_rim_thickness+0.5,                      inner_rim_height],
                            [hub_radius-0.5, hub_height-0.5]]);
                    }
                }
            }
        }
    }
}

}


