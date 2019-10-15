//          VARIABLES
x=40.4; // Length 40.4
y=35;   // Width 35
z=6;    // Heigth 6
//
difference(){
    cube([x+9.5,y+9,z+1]);
    translate([5,5,1]){
        union(){
            difference(){
                cube([x,y,z]);
                union(){
                    translate([0,0,z-2]){
                        cube([2,1,2]);
                    }
                    translate([0,y-1,z-2]){
                        cube([1,1,2]);
                    }
                }
            }
            translate([x-5,y/2,-6]){
                rotate([0,90,0]){
                    cylinder(10,10,10);
                }
            }
            translate([x-5,0,z-2]){
                rotate([0,5,0]){
                    cube([5,y,5]);
                }
            }
        }
    }
}