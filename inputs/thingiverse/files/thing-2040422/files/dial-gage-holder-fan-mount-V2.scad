difference(){
    union(){
    translate ([0,15,8.5])
cube([41.25,35.085,17], center = true);
cylinder(17,31.085,31.085, center=false, $fn=200);}
cylinder(13,8.5,8.5, center=true, $fn=200);
translate ([0,0,2])
    cylinder(15,29.085,29.085, center=false, $fn=100);

translate ([-4.86,34,9])
rotate ([90,0,0])
cube([9.72,15,10], center=false);
translate([0,35,9])
rotate ([90,0,0])
    cylinder (8,4.86,4.86, $fn=100);
}

translate([-15.5,39,12.6])
rotate([90,0,0])
cylinder(13,1.5,1.5, $fn=100);
translate([16,39,12.6])
rotate([90,0,0])
cylinder(13,1.5,1.5, $fn=100);