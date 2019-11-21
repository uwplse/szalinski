spheres = 9;
$fn = 100;
outerDiameter = 50;
wallThickness = 5;
innerDiameter = 9.6;
sphereDiameter = 9;
ballCutoff = 0.3;
height = 8.5;
tolerance = 0.2;
for(i=[0:1/spheres:1]){
    render(convexity = 1){
    difference(){
    translate([sin(i*360)*((outerDiameter/2)-(wallThickness*2)),
               cos(i*360)*((outerDiameter/2)-(wallThickness*2)),0])
        sphere(sphereDiameter/2);
    translate([0,0,-(10+sphereDiameter/2-ballCutoff)])
        cylinder(h=10,r=outerDiameter);
        }
    }
}
difference(){
    translate([0,0,-(sphereDiameter/2)+ballCutoff])
        cylinder(h=height,r=outerDiameter/2);//main Cylinder
    translate([0,0,-(sphereDiameter/2)+ballCutoff])
        cylinder(h=height,r=innerDiameter/2);//inner Cylinder
    rotate_extrude(convexity = 2) {
        translate([(outerDiameter/2)-(wallThickness*2),0,0])
            circle(sphereDiameter/2+tolerance);//torus
        }
}