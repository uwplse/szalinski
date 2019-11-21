lagard_key_radius = 4.42;
lagard_long_pie_cut_angle = 45;
lagard__inner_radius = 2.87;
lagard__inner_depth =  20;
lagard_cutting_tool_radius = 1.15;
lagard_key_length = 95;
lagard_guide_cut_angle = 250; //this angle may not be correct
lagard_guide_cut_depth = 1.53;
lagard_degree_per_cut_number = 5; //fixme I dont know what this is, not enough keys to measure
lagard_key_cut_offsets = [5.1,8.81,12.6,16.18];
cut_offset_angle = 10;

  $fn=64;
 
 //labels = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"];
 labels = ["F","E","D","C","B","A","9","8","7","6","5","4","3","2","1","0"];
 
 difference(){
    union(){  
        cylinder(60,lagard__inner_radius-.1, lagard__inner_radius-.1);
        translate([0,0,3])
            rotate([-90,0,0])
                translate([0,0,-(lagard_key_radius)])
                    cylinder(3,lagard_cutting_tool_radius-.1, lagard_cutting_tool_radius);
    }
    draw_ticks();
    for (e = lagard_key_cut_offsets)
        draw_label_ring(e+10);
    draw_label_ring(4);
}

module draw_ticks(a){
    for(i = [0:2:15]){
        rotate([0,0,-i*lagard_degree_per_cut_number])
            translate([lagard__inner_radius-.1,0,2])
                cylinder(25.5,.05, .05);
    }
}
module draw_label_ring(h){
    for(i = [0:2:15]){                
        rotate([0,0,-(i*lagard_degree_per_cut_number) - 4])
            translate([lagard__inner_radius-.5,0,h])
                  rotate([0,90,0])
                    rotate([0,00,90])
                        linear_extrude(height=.5)
                            text(labels[i],.6);
    }
}