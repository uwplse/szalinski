difference () {
import("C:/x-carriage_with_end_stop.stl");
     translate([35,-6,0]) cube([12,18,9]);
}


difference () {
    translate([9.5,34,0]) cube([7,5,12]);
    translate([3,34,3]) cube([14,3,6]);
}

difference () {
    translate([-17.5,34,0]) cube([7,5,12]);
    translate([-24.5,34,3]) cube([14,3,6]);
}



