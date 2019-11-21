
//Created by Oskar Henriksson, Chalmers, Sweden
//[mm]


z = 15; //just the total width
edge_skirt_h = 5;
edge_skirt_t = 2;

glass_t = 2.5; //glass thickness
glass_space = 18/2; //space between glass and end of heat bed
glass_overlap = 5;
glass_overlap_t = 2.5;

screw_offs_z = 2.2; //distance from edge of the bed to center of the screw
screw_offs_y = 2.7; 
screw_r = 1.5+0.2; // d+margin
screw_head_r = 3+0.2; // margin included
screw_head_h = 3;
if(screw_head_h >= glass_t + glass_overlap_t){
    echo("ERROR: screw_head_h is too high!");
}
if(screw_offs_y < screw_r || screw_offs_z < screw_r){
    echo("ERROR: screw_offset destroys the skirt");
}


tot_y = edge_skirt_t + glass_overlap + glass_space;
tot_z = edge_skirt_t + z;
tot_x = edge_skirt_h + glass_t + glass_overlap_t; // total height including skirt



clampPair();
translate([tot_z*2+2,0,0])
mirror([1,0,0])
clampPair();
    

module clampPair(){
    translate([0,0,tot_x])
     rotate([0,90,0]){
                leftClamp();
                translate([0,-2,0])
                  rightClamp();
                
            }
        }


module rightClamp(){
      mirror([0,1,0]){
        leftClamp();
    }
}

module leftClamp(){
    difference(){
        difference(){
            cube([tot_x,tot_y,tot_z]);
            translate([0,0,edge_skirt_t])
            union(){
                  cube([edge_skirt_h+glass_t,glass_overlap,z]);
                    cube([edge_skirt_h,tot_y-edge_skirt_t,z]);
                }
            
        }
        #translate([0,tot_y-edge_skirt_t-screw_offs_y,edge_skirt_t+screw_offs_z]) rotate ([0,90,0])
        union(){
            cylinder (h = tot_x, r=screw_r, $fn=50);
            translate([0,0,tot_x-screw_head_h]) cylinder (h = screw_head_h+1, r=screw_head_r, $fn=50);
        }
    }
}