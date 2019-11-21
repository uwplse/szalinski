difference(){
    union(){
    cylinder(d = 20, h = 2, $fn =90);
cylinder(d = 18, h = 8, $fn =70);
    }
translate([0,-4.5,-1])cylinder(d = 2.5, h = 22, $fn =70);
translate([-4.5,-1,1])cube([9,1.5,8]);
}