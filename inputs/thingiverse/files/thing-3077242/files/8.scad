$fn=100;//Convexity of circles (20 for rapid rendering 100 for printing)
$diameter=50;//Diameter of the rings (mm)
$rope=100;//Diameter of the hole for the rope (mm)

module rotate_circle(){
    rotate_extrude()
        translate([($diameter+$rope)/2,0,0])
        circle($diameter/2);
}

union(){
    translate([$rope-$diameter/2,0,0])
    rotate_circle();
    translate([-($rope-$diameter/2),0,0])
    rotate_circle();
    translate([-($rope-$diameter/2),($rope-$diameter/2),0])
    rotate([0,90,0])
    cylinder($diameter+$rope,r=$diameter/2);
    translate([-($rope-$diameter/2),-($rope-$diameter/2),0])
    rotate([0,90,0])
    cylinder($diameter+$rope,r=$diameter/2);
}