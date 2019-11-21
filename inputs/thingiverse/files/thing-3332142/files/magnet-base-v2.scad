outer_radius = 21; //12.5 is standard
magnet_radius = 5.1;
base_height = 3;
magnet_height = 2.1;
slot = 0;
oval = 1;

difference(){
    if (oval == 1){
        scale([1.0,1.786,1.0]) cylinder(h = base_height, r1 = outer_radius-1, r2 = outer_radius, center = false);
    } else {
        cylinder(h = base_height, r1 = outer_radius-1, r2 = outer_radius, center = false);
    }
    
    if (slot == 1) {
        translate([-outer_radius+1.5,0,-magnet_height]){
            cube([outer_radius*2-3,2,2*base_height], false);
                }
    }
    if (outer_radius > 20){
        for (i = [0:3]) {
            rotate([0,0,90*i]){
                translate([outer_radius/2,0,base_height-magnet_height]){
                    color([0,0,1]) cylinder(h=magnet_height*2, r=magnet_radius);
                }
            }
        }
    } else {
        translate([0,0,base_height-magnet_height]){
            color([0,0,1]) cylinder(h = magnet_height*2, r1 = magnet_radius, r2 = magnet_radius, center = false);
        }        
    }
}