$fn=256;

wall = 1.2;

fan_hole_x = 15.5;
fan_hole_y = 13;
fan_hole_depth = 7;

tube_height = 22;

beam_size_x = 20;
beam_size_y = 10;
nozzle_size=52;

hole_dia=3;

fan_offset_x = 8;
fan_offset_y = 45;


difference()
{
    union()
    {
        rotate([0,0,20])
        {
            translate([0,0,beam_size_y/2])
            {
                rotate_extrude(angle = 320, convexity = 20)
                {
                    translate([-nozzle_size/2,0,0])
                        polygon([[-beam_size_x/2,-beam_size_y/2],
                                 [0,-beam_size_y/2],
                                 [beam_size_x/4,0],
                                 [beam_size_x/4,beam_size_y/2],
                                 [-beam_size_x/2,beam_size_y/2]]);
                }
            }
        }   
        
        translate([-fan_offset_x,fan_offset_y,0])
        {
            translate([-(fan_hole_x+2*wall)/2,-(fan_offset_y-nozzle_size/2)/2-5,0])
                cube([fan_hole_x+2*wall,(fan_offset_y-nozzle_size/2)+3,beam_size_y]);
            
            translate([-fan_hole_x/2,-fan_hole_y/2,tube_height])
                cube([fan_hole_x,fan_hole_y,fan_hole_depth]);
            
            translate([-(fan_hole_x+2*wall)/2,-(fan_hole_y+2*wall)/2,0])
                cube([fan_hole_x+2*wall,fan_hole_y+2*wall,tube_height]);                    
        }
    }

    rotate([0,0,20])
    {
        translate([0,0,beam_size_y/2])
        {
            rotate([0,0,5])
            {
                rotate_extrude(angle = 310, convexity = 20)
                {
                    translate([-(nozzle_size)/2,0,0])
                        polygon([[-(beam_size_x-wall)/2,-(beam_size_y-wall)/2],
                                 [0-wall,-(beam_size_y-wall)/2],
                                 [(beam_size_x-2*wall)/4,(beam_size_y-wall)/2],
                                 [-(beam_size_x-wall)/2,(beam_size_y-wall)/2]]);
                }
            }
            
            for (i=[140:20:440])
            {
                    translate([(-nozzle_size/2+2)*sin(i),(-nozzle_size/2+2)*cos(i),-2])
                        rotate([0,0,-i-90])
                            rotate([0,-45,180])
                                cylinder(d=hole_dia, h=7,center=true);
            }
        }
    }
    
    translate([-fan_offset_x,fan_offset_y,0])
    {        
        translate([-(fan_hole_x-2*wall)/2,-(fan_hole_y-2*wall)/2,wall])
            cube([fan_hole_x-2*wall,fan_hole_y-2*wall,fan_hole_depth+tube_height]);

        translate([-(fan_hole_x-2*wall)/2,-(fan_hole_y-2*wall)/2-10,wall])
            cube([fan_hole_x-2*wall,fan_hole_y-2*wall+10,beam_size_y-2*wall]);

    }
    
    //cube([100,10,30],center=true);
}
