

$fn=128;

rotate(-60){
    linear_extrude(3){
    //#circle(45);
    difference(){
       circle(11);
       circle(7);
    }


    for (spin = [0 : 120 : 360]) rotate(spin+60) {
        translate([60,0,0]){
            #square([60,5], center = true);
        }

    }


    for (spin = [0 : 120 : 360]) rotate(spin) {
        translate([15,0,0]){
            square([11,5], center = true);
        }
    }
     
     
    for (spin = [0 : 40 : 360]) rotate(spin) {
        translate([31,0,0]){
             difference(){
                circle(11);
                circle(7);
             }
        }
    }
    
}
    
    for (spin = [0 : 120 : 360]) rotate(spin+60) {
            translate([88.5,0,-5]){
            cube([3,5,10], center= true);
        }
    }
} 
