$fn = 180;
neck_dia=17;
front_height=9;
back_height=16;
total_base_size=35;


module shaft_cutout() {
    hull() {
    cylinder(h=60,d=neck_dia+0.1,center=true);
    translate([(total_base_size+5)/2,0,0])
    cylinder(h=60,d=neck_dia-0.5,center=true);
    }
}

module cutout() {
        shaft_cutout();
   
}

module round_body() {
    difference(){
        hull() {
            corner_pos=total_base_size/2;

            translate([total_base_size/2,total_base_size/2,0.005])
                cube(0.01,center=true);
            translate([total_base_size/2,-total_base_size/2,0.005])
                cube(0.01,center=true);
            translate([-total_base_size/2,-total_base_size/2,0.005])
                cube(0.01,center=true);
            translate([-total_base_size/2,total_base_size/2,0.005])
                cube(0.01,center=true);

            translate([total_base_size/2,total_base_size/2,front_height-0.005])
                cube(0.01,center=true);
            translate([total_base_size/2,-total_base_size/2,front_height-0.005])
                cube(0.01,center=true);
            translate([-total_base_size/2,-total_base_size/2,back_height-0.005])
                cube(0.01,center=true);
            translate([-total_base_size/2,total_base_size/2,back_height-0.005])
                cube(0.01,center=true);
        }
        cutout();
    }
}
    
module tail_cut() {
    intersection() {
        round_body();
        difference() {
            cube([total_base_size+5,total_base_size+5,total_base_size*2],center=true);    
            cylinder(h=total_base_size*2,d=total_base_size+2,center=true);
            translate([(total_base_size+5)/4,0,0]) cube([(total_base_size+5)/2,total_base_size+5,total_base_size*2],center=true);    
        }
    }
}
    //Lineup aids
/*
    translate([total_base_size/2+2,0,front_height/2])
    cylinder(h=front_height,d=1,center=true);
        translate([-total_base_size/2-2,0,back_height/2])
    cylinder(h=back_height,d=1,center=true);
*/
difference(){
    round_body();
    translate([0,0,-0.5])
        scale([1,1,1.5])
            tail_cut();
}