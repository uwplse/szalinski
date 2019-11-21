// Customizer_Values
arrowhead_width = 1; //[0.5:0.25:5]
arrowhead_height = 2; //[1:0.25:5]
hook_radius = 0.25; //[0.05:0.05: 1]
sweep_radius = 1.25; //[1:0.25:10]
sweep_angle = 180;//[90:5:270]
hoop_radius = 0.75; //[0.5:0.25:6]
hoop_height = 1.5;//[0.5:0.25:5]
n_hooks = 5;//[1:8]

module torus(r1,r2)
{
    RA= r1/2;
    RB= r2/2 - r1/2; 
    
    rotate_extrude(convexity = 10, $fn = 72){
        translate([RB, 0, 0]) {
            circle(r = RA, $fn = 72); 
        }
    }
}

module arrowhead(){
    scale([hook_radius*4, arrowhead_width, arrowhead_height/2]){
        rotate([0, 90, 0]){
            for(i = [-1, 1]){
                scale([1, i, 1]){
                    intersection(){
                        scale([1, 1, 0.5]){ 
                            rotate([90, 0, 45]){
                                cylinder( h = 2,
                                r1 = 1,
                                r2 = 0, center=true, $fn=4);
                            }
                        }
                        translate([0, -1, 0]){
                            cube([3, 2, 2], center = true);
                        }
                    }
                }
            }
        }
    }
}

module hook(){
    for(i=[0:n_hooks-1])rotate([0, 0, 360*i/n_hooks]){
        translate([sweep_radius-hook_radius, 0, 0]){
            rotate([90, 0, 0]){
                intersection(){
                    torus( hook_radius*2, sweep_radius*2 );
                    union(){
                        translate([-sweep_radius/2, -sweep_radius/2, 0]){
                            cube([sweep_radius,sweep_radius,sweep_radius], center=true);
                        }
                        if(sweep_angle > 180){
                            translate([0, -sweep_radius/2, 0]){
                                cube([sweep_radius*2,sweep_radius,sweep_radius], center=true);
                            }
                        }
                        rotate([0, 0, sweep_angle-180]){
                            translate([sweep_radius/2, -sweep_radius/2, 0]){
                                cube([sweep_radius,sweep_radius,sweep_radius], center=true);
                            }
                        }
                    }
                }
            }       
        }
        translate([sweep_radius-hook_radius, 0, 0]){
            rotate([0, 180-sweep_angle, 0]){
                translate([sweep_radius-hook_radius, 0, 0]){
                    translate([0, 0, 0.08 * arrowhead_height]){
                        arrowhead();
                    }
                    cylinder(r1=hook_radius, r2=0, h = arrowhead_height/2, $fn=72);
                }
            }
        }
        cylinder(r=hook_radius, h = hoop_height, $fn=72);
    }
    translate([0, 0, hoop_height+hoop_radius-hook_radius]){
        rotate([90, 0, 0]){
            torus(hook_radius*2, hoop_radius*2);
        }
    }
}

hook();
