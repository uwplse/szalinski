// Created by Manny DelaCruz
// Copyright 2016 - All Rights Reserved
// Commercial Duplication Prohibited

Diameter_slider=46.5;  // [20:0.1:100]
Bell_Length_slider=36;  // [20:50]
Resolution_slider = 50;  // [20:80]
sh = Bell_Length_slider/2;
shf = sh*1.6;
//dia = 56.8;
            text = Diameter_slider;
            font = "Liberation Sans Narrow";


dia=Diameter_slider-0.4;

translate([100,0,0]){
    union(){
        difference(){
            //EXTERIOR
            cylinder(h=sh,r=((dia/2)+2.5),$fn=Resolution_slider);
            //INTERIOR HIDDEN - ACTUAL WIDTH
            translate([0,0,-1]){
            cylinder(h=sh+2,r=(dia/2),$fn=Resolution_slider);
            }
        }
        union(){
            //UPPER & LOWER RIM
            union(){
                rotate_extrude(convexity = 10, $fn = Resolution_slider){
                    translate([((dia/2)+1.2), 0, 0]){
                        circle(r=1.3, $fn = Resolution_slider);
                    }
                }
                translate([0,0,(sh-0.2)]){
                    rotate_extrude(convexity = 10, $fn = Resolution_slider){
                        translate([((dia/2)+1.2), 0, 0]){
                            circle(r=1.3, $fn = Resolution_slider);
                        }
                    }
                }
            }
            //OUTER BANDS
            union(){
                rotate_extrude(convexity = 10, $fn = Resolution_slider){
                    translate([((dia/2)+1.2), 0, 0]){
                        square(size=2);
                    }
                }
//                translate([0,0,(sh-2)]){
//                    rotate_extrude(convexity = 10, $fn = Resolution_slider){
//                        translate([((dia/2)+1.2), 0, 0]){
//                            square(size=2);
//                        }
//                    }    
//                }
            }
        }
    }

//CAP
translate([0,0,-1.4]){
    translate([((shf*1.8)+Diameter_slider),0,1.4])
        union(){
            union(){
                difference(){
                    //EXTERIOR
                    cylinder(h=sh,r=((dia/2)+2.5),$fn=Resolution_slider);
                    //INTERIOR HIDDEN - ACTUAL WIDTH
                    cylinder(h=sh+1,r=(dia/2),$fn=Resolution_slider);
                }
                //FLOOR
                translate([0,0,-1.4]){
                    cylinder(h=2,r=((Diameter_slider/2+1)),$fn=Resolution_slider);
                }  
            }
            union(){
            //UPPER & LOWER RIM
            union(){
                rotate_extrude(convexity = 10, $fn = Resolution_slider){
                    translate([((dia/2)+1.2), 0, 0]){
                        circle(r=1.3, $fn = Resolution_slider);
                    }
                }
                translate([0,0,(sh-0.2)]){
                    rotate_extrude(convexity = 10, $fn = Resolution_slider){
                        translate([((dia/2)+1.2), 0, 0]){
                            circle(r=1.3, $fn = Resolution_slider);
                        }
                    }
                }
            }
            //OUTER BANDS
            union(){
                rotate_extrude(convexity = 10, $fn = Resolution_slider){
                    translate([((dia/2)+1.2), 0, 0]){
                        square(size=2);
                    }
                }
//                translate([0,0,(sh-2)]){
//                    rotate_extrude(convexity = 10, $fn = Resolution_slider){
//                        translate([((dia/2)+1.2), 0, 0]){
//                            square(size=2);
//                        }
//                    }    
//                }
            }
        }
            
        }
        translate([(Diameter_slider/2),(((sh/2)/2)*-1),0]){
            
         
            union(){
                cube([(shf*1.8),9,2]);
                translate([((shf*1.8)/2), 1, 0]) {
                    linear_extrude(height = 4) {
                        text(text = str(text,"mm"), font = font, size = 6, halign="center");
                    }
                }
            }
        }
    }
     
}



