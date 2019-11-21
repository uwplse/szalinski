battery_w = 36.5;
battery_d = 60;
battery_h = 15.5;
wall_tick = 2;
battery_contact_d  = 25;

lock_d    = 20;
look_sw   = 2;
look_sd   = 4;

union()
{
    //translate([0,0, wall_tick])
    cube([wall_tick, look_sd, battery_h + wall_tick*2], false);
    
    translate([wall_tick, look_sd/2, (battery_h + wall_tick*2)/2 ])
        sphere(d = look_sd, $fn = 50);
    
    translate([0,look_sd,0])
        difference()
        {
            cube([battery_w + wall_tick*2,battery_d+ wall_tick,battery_h+ wall_tick*2], false);
            translate([wall_tick,0,wall_tick])
            {
                #cube([battery_w,battery_d,battery_h], false);
                #cube([battery_w,battery_d-battery_contact_d,battery_h+wall_tick], false);
            }
            
             // Lock
            translate([wall_tick,0,0])
                #cube([battery_w,lock_d,battery_h+wall_tick], false);
        }
}