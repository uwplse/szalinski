//Design by Bogdan Ionescu 2019
//Liscence GPL 2.0

handle_l = 100;

difference(){
    union(){
        hull(){
            cylinder(d = 28, h = 7);
            translate([0,handle_l,0])cylinder(d = 10, h = 7);
        }
        
        
    }
    cylinder(d = 22, h = 10);
    translate([0,handle_l,0])cylinder(d = 4, h = 7);
    //translate([2,-15,0])cube([30,30,7]);
    //translate([0,-22/2,0])cube([30,22,7]);
}
for(i = [0:360/6:360]){
            rotate([0,0,i])translate([-2,17/2,0]){
                difference(){
                    cube([4,4,7]);
                    rotate([15,0,0])translate([0,-2,-2])cube([4,4,10]);
                }
            }
        }