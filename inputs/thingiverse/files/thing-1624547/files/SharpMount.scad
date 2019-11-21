
angle = 10;

difference(){



union(){

difference(){ 
cube([45,14,2]);
translate([4,7,0-1])
    cylinder(r=1.5,h=10,$fs = 0.1);
translate([4+37,7,0-1])
    cylinder(r=1.5,h=10,$fs = 0.1); 
}



translate([15,0,2])
rotate([-angle,0,0])

difference(){ 
cube([15,5,8]);
translate([3.5,7,5.4])
rotate([90,0,0])
    cylinder(r=1.5,h=10,$fs = 0.1);
translate([3.5+8,7,5.4])
rotate([90,0,0])
    cylinder(r=1.5,h=10,$fs = 0.1); 
}


}



translate([0,0,-10])
cube([45,20,10]);
}