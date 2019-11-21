difference(){
union(){
union(){
union(){
difference(){
difference(){
union(){
union(){

translate([0,-50,0])
cube (size=[30,40,30] , center=true);
}
translate([0,50,0])
cube (size=[30,40,30] , center=true);
}
translate ([0,55 ,0])
rotate([0,90,0])
cylinder(h=45, r1=8, r2=8, center=true);

}

translate ([0,-55 ,0])
rotate([0,90,0])
cylinder(h=45, r1=8, r2=8, center=true);
}
translate([20,-20,0])
rotate([0,0,-45])
cube(size = [20,50, 30], center=true);
}
translate([20,20,0])
rotate([0,0,-135])
cube(size = [20,50, 30], center=true);
}

rotate([90,0,90])
    translate([0,0,30])
    cylinder (h=40, r1=15,r2=15, center = true);
}
translate ([40,0 ,0])
rotate([0,90,0])
cylinder(h=65, r1=8, r2=8, center=true);
}
