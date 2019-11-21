// ancre__dfl
// D. Lorentzen
// escapement for Gyrotourbillon

$fn=30;

difference() {
    cube([23.1,8,5]);
    
    translate([8.2,4.7,0]) cylinder(h=5,d=1.3,center=false); // pivot hole
    translate([21,3.1,0]) cube([3.5,3.6,7]); //cut-out on end
    translate([22,5,0]) cylinder(h=5,d=3.3,center=false); // cut-out on end
    translate([23.8,4.8,0]) #cylinder(h=5,d=4.5,center=false); // cut-out on end
    translate([5,13,0]) cylinder(h=5,d=15,center=false); // cut-out on side
    translate([17,11,0]) cylinder(h=5,d=10,center=false); // cut-out on side
    translate([0,6,0]) cube([18,2,5]); // side 



        rotate([0,0,-20]) translate([-1.5,-1.2,0]) cube([6,2.5,5]); // shape near "tooth"
        translate([5.8,1.6,0]) cylinder(h=5,d=4.8,center=false); // cut-out on side near tooth
        rotate([0,0,-52]) translate([9.4,12.1,0]) cube([2.3,3.4,5]); // far shape far "tooth"
        rotate([0,0,35]) translate([10.8,-10.2,0]) cube([1.8,3.3,5]); // near shape far "tooth"
        translate([3.5,0,0]) cube([10.5,3.3,5]); // shape far "tooth"
        translate([18,0,0]) cube([8,2,5]); // shape far "tooth"
        translate([12.1,1.2,0]) cylinder(h=5,d=5.3,center=false); // cut-out on side far tooth

//        translate([0,0,0]) cube([15,.3,5]); // shape near and far "tooth"

    }