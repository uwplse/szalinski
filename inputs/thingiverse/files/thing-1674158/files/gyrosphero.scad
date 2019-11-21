DIAMETER = 72.8;
RING_WIDTH = 5;
RING_HEIGHT = 16;
RING_SPACE = 8;

$fn = 100;

intersection() {
    cylinder(h = (RING_HEIGHT-6), r = DIAMETER * 2, center = true);
    union(){
        //first ring
        difference(){
            sphere(d = DIAMETER + 2 * RING_WIDTH);
            sphere(d = DIAMETER); 
        }
        
        for (a =[0:1]) {
            rotate([0,0,a*180]){
                translate([0,-(DIAMETER/2 + RING_WIDTH - 2),0]){
                    rotate([90,0,0]){
                        cylinder(h = 8, d1 = RING_HEIGHT, d2 = 0, center = false);
                    }
                }
            }
        }
    }
}

intersection() {
    cylinder(h = RING_HEIGHT - 6, r = DIAMETER * 2, center = true);

    union(){
        
        //second ring
        difference(){
            difference(){
                sphere(d = DIAMETER + 2 * RING_WIDTH + 2 * RING_SPACE);
                sphere(d = DIAMETER + 2 * RING_SPACE); 
            }
            
            for (a =[0:1]) {
                rotate([0,0,a*180]){
                    translate([0,-(DIAMETER/2 + RING_WIDTH - 2),0]){
                        rotate([90,0,0]){
                            cylinder(h = 8.1, d1 = RING_HEIGHT + 6, d2 = 0, center = false);
                        }
                    }
                }
            }
        }
        
        for (a =[0:1]) {
            rotate([0,0,a*180 + 90]){
                translate([0,-(DIAMETER/2 + RING_WIDTH + RING_SPACE - 2),0]){
                    rotate([90,0,0]){
                        cylinder(h = 8, d1 = RING_HEIGHT, d2 = 0, center = false);
                    }
                }
            }
        }
        
        //third ring
        difference(){
            difference(){
                sphere(d = DIAMETER + 2 * RING_WIDTH + 4 * RING_SPACE);
                sphere(d = DIAMETER + 4 * RING_SPACE); 
            }
            
            for (a =[0:1]) {
                rotate([0,0,a*180 + 90]){
                    translate([0,-(DIAMETER/2 + RING_WIDTH + RING_SPACE - 2),0]){
                        rotate([90,0,0]){
                            cylinder(h = 8.1, d1 = RING_HEIGHT + 6, d2 = 0, center = false);
                        }
                    }
                }
            }
        }
        
        for (a =[0:1]) {
            rotate([0,0,a*180]){
                translate([0,-(DIAMETER/2 + RING_WIDTH + 2*RING_SPACE - 2),0]){
                    rotate([90,0,0]){
                        cylinder(h = 8, d1 = RING_HEIGHT, d2 = 0, center = false);
                    }
                }
            }
        }
        
    }
    
    

}

difference(){
    union(){
        for (a =[-1:2:1]) {
            translate([0,a*(DIAMETER + 2 * RING_WIDTH + 5.3 * RING_SPACE)/2,0]){
                for (b =[-1:2:1]) {
                    union(){
                        rotate([0,b*30,0]){
                            union(){
                                translate([(DIAMETER*1.5)/2,0,0]){
                                    cube(size = [DIAMETER*1.5,RING_WIDTH,RING_HEIGHT], center = true);
                                }
                                rotate([0,90,90]){
                                    cylinder(h=RING_WIDTH, d=RING_HEIGHT, center=true);
                                }
                                translate([(DIAMETER*1.5),0,0]){
                                    rotate([0,90,90]){
                                        cylinder(h=RING_WIDTH, d=RING_HEIGHT, center=true);
                                    }
                                }
                            }
                        }
                        
                        translate([(DIAMETER*1.5)-RING_HEIGHT+1.36,0,0]){
                            rotate([0,90,0]){
                                cube(size = [DIAMETER*1.5,RING_WIDTH,RING_HEIGHT], center = true);
                            }
                        }
                    }
                }
            }
        }
    }
    
    union(){
        for (a =[0:1]) {
            rotate([0,0,a*180]){
                translate([0,-(DIAMETER/2 + RING_WIDTH + 2*RING_SPACE - 2),0]){
                    rotate([90,0,0]){
                        cylinder(h = 8.1, d1 = RING_HEIGHT + 6, d2 = 0, center = false);
                    }
                }
            }
        }
    }
}

for (a =[-1:2:1]) {
    translate([0,0,a*30]){
        difference(){
            translate([DIAMETER + RING_HEIGHT,0,0]){
                union(){
                    cube(size = [RING_HEIGHT, 2*DIAMETER,RING_WIDTH], center = true);
                    translate([0,DIAMETER,0]){
                        cylinder(h=RING_WIDTH, d=RING_HEIGHT, center=true);
                    }
                    translate([0,-DIAMETER,0]){
                        cylinder(h=RING_WIDTH, d=RING_HEIGHT, center=true);
                    }
                }
            }
            
            union(){
                for (a =[-1:2:1]) {
                    translate([0,a*(DIAMETER + 2 * RING_WIDTH + 5.3 * RING_SPACE)/2,0]){
                        translate([(DIAMETER*1.5)-RING_HEIGHT+1.36,0,0]){
                            rotate([0,90,0]){
                                cube(size = [DIAMETER*1.5,RING_WIDTH,RING_HEIGHT], center = true);
                            }
                        }
                    }
                }
            }
        }
    }
}    

