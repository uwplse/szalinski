difference(){
    union(){
hull(){
translate([22.5,0,0]) cylinder(3,15,15,center = true,$fn=24);
translate([-22.5,0,0]) cylinder(3,15,15,center = true,$fn=24);

translate([22.5,-40,0]) cylinder(3,10,10,center = true,$fn=24);
translate([-22.5,-40,0]) cylinder(3,10,10,center = true,$fn=24);
}


translate([-10,-30,0]) rotate([0,-90,0]) color("red") cylinder(90,12,12,center = true,$fn=24);

translate([0, -25,0]) color("green") cube([40,50,30],center = true);

}
translate([-45,-30,0]) rotate([0,-90,0]) color("green") cylinder(50,8,8,center = true,$fn=24);

translate([35,-30,0]) rotate([0,-90,0])color("blue") cylinder(50,3,3,center = true,$fn=24);

translate([0, -37,0]) color("yellow") cube([25,60,40],center = true);
}