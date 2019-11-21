$fn=64;
overlap = 0.1;

module solid(){
union() {
cylinder(h=3.16, d=60.5);
translate([0,0,overlap]) color("green") cylinder(h=6.1-overlap, d=50.6);
}
}

module remove(){
    union(){
linear_extrude(height = 20, center = true, convexity = 10) circle(r=13.15/2, $fn=6);
        for (a =[0:2]) rotate([0,0,120*a]) color("red") translate([22.5,0,-overlap]) cylinder(h=10, d=3.6, $fn=32);
    
for (a =[0:2]) rotate([0,0,120*a]) color("red") translate([22.5,0,3.16]) rotate([0,0,30]) cylinder(h=10, d=6.6, $fn=6);
    }
}

difference(){
    solid();
    remove();
}

