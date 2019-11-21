difference () {
import("C:/x-carriage_with_end_stop.stl");
     translate([35,-6,0]) cube([12,18,9]);
}
//Wire tie Thickness and Width
wt_t = 2.25;
wt_w = 4;
//Wire tie width 3.75

difference () {
    translate([7,34,0]) cube([12.5,4,9]);
    translate([11.5,34,0]) cube([wt_w,wt_t,9]);
}

difference () {
    translate([-19.5,34,0]) cube([12.5,4,9]);
    translate([-15,34,0]) cube([wt_w,wt_t,9]);
}



