// length of the arm
length= 125;
//height of the arm
height= 100;

//resolution (higher needs more time to render)
$fn=100;

difference(){
    minkowski(){
        union(){
            cube([length,10,5]);
            cube([10,10,height]);
            translate([0,4,0]){
                hull(){
                    cube([length,2,5]);
                    cube([10,2,35]);
                }
            }
        }
        sphere(1);
    } 
    translate([5,5,-1]){
        cylinder(d=5.5,h=height+2);
        cylinder(d=8.5,h=height-7);
    }
    translate([length-10,5,-1]){
        cylinder(d=5,h=7);
    }
    translate([length-10,5,1]){
        cylinder(d=9,h=10);
    }
}

