// Switch Socket for mounting the switch below the panel
// KBS3056 29.12.2018
switch_width            = 21.5;// without collet
switch_length           = 29;  // without collet
switch_deepth           = 26;  // without collet, with or without terminals
switch_bridge_width     = 2;   // default 2

sunk_width              = 26.5;  // bigger than switch collet
sunk_length             = 31.5;  // bigger than switch collet
sunk_deepth             = 8.6;   // bigger than switch collet height + lever

collet_brim             = 2;   // default 2
collet_height           = 1.5; // default 1.5

wall_thickness          = 1.5; // default 1.5
///////////////////////////////////////////////////////////////////////////
switch_cover            = 1;// [0:1]



union(){
    //collet
    difference(){
        cube([sunk_width + 2 * wall_thickness + 2 * collet_brim, sunk_length + 2 * wall_thickness + 2 * collet_brim, collet_height]);
        translate([collet_brim + wall_thickness, collet_brim + wall_thickness, -0.1])
        cube([sunk_width, sunk_length, collet_height + 0.2]);
    }
    
    //sunk
    translate([collet_brim, collet_brim, collet_height]){
        difference(){
            cube([sunk_width + 2 * wall_thickness, sunk_length + 2 *    wall_thickness, sunk_deepth - collet_height]);
            translate([wall_thickness, wall_thickness, -0.1])
            cube([sunk_width, sunk_length, sunk_deepth - collet_height + 0.2]);
        }
    }
    
    //switch
    translate([collet_brim, collet_brim, sunk_deepth]){
        cube([(sunk_width - switch_width) / 2 + wall_thickness, sunk_length + 2 * wall_thickness, switch_bridge_width + 0.18]);
        translate([sunk_width - (sunk_width - switch_width) / 2 + wall_thickness, 0, 0])
        cube([(sunk_width - switch_width) / 2 + wall_thickness, sunk_length + 2 * wall_thickness, switch_bridge_width + 0.18]);
        
        translate([0, 0, 0.18])
        cube([sunk_width + 2 * wall_thickness, (sunk_length - switch_length) / 2 + wall_thickness, switch_bridge_width]); 
        translate([0, sunk_length - (sunk_length - switch_length) / 2 + wall_thickness, 0.18])
        cube([sunk_width + 2 * wall_thickness, (sunk_length - switch_length) / 2 + wall_thickness, switch_bridge_width]); 
        
        //switch cover
        if (switch_cover){
            translate([(sunk_width - switch_width) / 2, (sunk_length - switch_length) / 2, switch_bridge_width + 0.18]){
                difference(){
                    cube([switch_width + 2 * wall_thickness, switch_length + 2 * wall_thickness, switch_deepth - switch_bridge_width]);
                    translate([wall_thickness - 0.05, wall_thickness - 0.05, -0.1])
                    cube([switch_width + 0.1, switch_length + 0.1, switch_deepth - switch_bridge_width + 0.2]);
                }
            }
        }
    }
}