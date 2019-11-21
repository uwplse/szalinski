



color("blue"){


w=1.5;




$fn=60;





difference(){
    translate([0,0,10]) cube([40,40,20],center=true);
    translate([0,0,10-4]) cube([40-w,40-w*2,20],center=true);
    translate([0,0,15]) cylinder(d=5.5,h=10);
    translate([-10,50,10]) rotate([90,0,0]) cylinder(d=3,h=100);
}

translate([20,-18,8])rotate([90,0,90]) linear_extrude(height=1) text("Achim");


translate([-19,-20,8])rotate([90,0,0]) linear_extrude(height=1) text("Crane");
translate([19,20,8])rotate([90,0,180]) linear_extrude(height=1) text("Crane");


}