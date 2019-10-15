//This differs from the original mount by spacing of 2mm for acoustic washers and locating pins for them
difference(){//overall size
translate([0,0,0])cube ([24.5+7,7,21+14.5+12]);
translate([-1,-1,19])cube ([21.5,9,31]);
translate([9.5,-1,9.5])cube ([16,9,3.5]);
translate([16,-1,8.5])cube ([3.5,9,5.5]);
translate([24.5,-1,-1])cube ([8,9,24]);
translate([24.5,-1,37.5])cube ([8,9,12]);
}
difference(){
translate([19.1,0,19])//corner reinforcement
    rotate ([0,45,0]) cube ([2,7,2]);
}
difference(){
translate([20.5/2,3.5,19])//acoustic washer locatin pin
    rotate(a=[0,0,90])cylinder(r=1.2,h=1,$fn=100);
}
difference(){
translate([19.5,3.5,34])//acoustic washer locatin pin
    rotate(a=[0,90,0])cylinder(r=1.2,h=1,$fn=100);
}