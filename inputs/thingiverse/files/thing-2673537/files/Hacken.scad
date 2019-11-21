
$fn=60;


    translate([0,-1.5,-5])cylinder(d=14,h=45);

translate([0,2.5,-5])resize(newsize=[22,25,10]) sphere(r=10);

hull(){
    translate([0,-1.5,40])cylinder(d=14,h=5);
    translate([-10,45,45]) rotate([-90,0,0]) cube([20,5,5]);
}


difference(){
    translate([-10,45,45]) rotate([-90,0,0]) cube([20,45,5]);

    translate([5,70,5]) rotate([90,0,0]) cylinder(d=4,h=50);//Bohrung 1
    translate([-5,70,30]) rotate([90,0,0]) cylinder(d=4,h=50);//Bohrung 2
}



hull(){
    translate([0,35,40])sphere(d=2.5);
    translate([0,45,40])sphere(d=2.5);
    translate([0,45,20])sphere(d=2.5);
}


