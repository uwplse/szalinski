/* Clamping piece */

diameter= 32.4;
height = 10;
thickness = 0.8;
ridges= 3;
ridge_height= 0.6;
entry_slope= 0.5;

difference(){
    union(){
        // Main body
        difference(){
            cylinder(r=diameter / 2 + thickness, h = height, $fa=0.1, $fs=0.1);
            translate([0, 0, thickness]){
               cylinder(r=diameter / 2, h = height- thickness, $fa=0.1, $fs=0.1);
            };
        }
        
        // "blobs"
        for(i = [0:ridges - 1])
        {
            rotate([0, 0, i * 360/ridges]){
                translate([diameter/2, 0, 0]){
                    difference(){
                        cylinder(r = ridge_height, h = height, $fa=0.1, $fs=0.1);
                        translate([0, -ridge_height, 0]){cube([ridge_height*2, ridge_height*2,height]);}
                    }
                }
            }
        }
    }
    translate([0, 0, thickness]){
        cylinder(h=height- thickness, d1=diameter/3, d2=diameter + 2*thickness);
    }
}