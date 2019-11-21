/* [Parameters for LED jig] */
//Gap between LEDs
gap = 70;//[10:0.5:150]

/* [Hidden] */
Base_length = 2*gap+40;
difference(){
difference(){
difference(){
Base();
translate([0,0,5.5])
LEDhole();
}
translate([0,gap,5.5])
LEDhole();
}
translate([0,-gap,5.5])
LEDhole();
}
module LEDhole(){
union(){
cube(size = [15,15,4], center = true);
translate([0,0,-1])
    cylinder(h = 4, r=5.25, center = true, $fn = 100);
translate([0,0,-5])
    cube(size = [8,5.5,5.5], center = true);
}
translate([0,-13,-3])
linear_extrude(height = 1, center = false, convexity = 10, twist = 0)
polygon([[-1,0],[-1,5],[-2,5],[0,7],[2,5],[1,5],[1,0]]);
}
module Base(){
translate([0,0,-7])
//difference(){
difference(){
difference(){
rotate([90,0,0])
cylinder(h = Base_length, r=12, center = true, $fn = 100);
translate([0,0,-13])
cube(size = [40,Base_length+1,40], center = true);
}
translate([0,0,11.25])
cube(size = [6,Base_length+1,1.5], center = true);
}}