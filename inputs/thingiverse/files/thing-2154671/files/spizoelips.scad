$fn=100;
heightt=40; //mm
rotation=90; //degree
thickness=0.5; //mm
side1=20; //elips side mm
side2=10; //elips side mm
base=2; // mm
space=0.8; //space between two shapes mm

// External shape
difference () {
linear_extrude(height = heightt, center = false, convexity = 10, twist = rotation)
resize([side1,side2])circle(d=20,center=true);

translate([0,0,base])
rotate([0,0,-1*rotation/heightt*base])
linear_extrude(height = heightt, center = false, convexity = 10, twist = rotation)
resize([side1-thickness,side2-thickness])circle(d=20,,center=true);
}

// Internal shape
translate([side2+side1,0,0])
difference () {
linear_extrude(height = heightt, center = false, convexity = 10, twist = rotation)
resize([side1-thickness-space,side2-thickness-space])circle(d=20,center=true);
translate([0,0,base])
rotate([0,0,-1*rotation/heightt*base])
linear_extrude(height = heightt, center = false, convexity = 10, twist = rotation)
resize([side1-thickness*2-space,side2-thickness*2-space])circle(d=20,center=true);
}
// Base
translate([side2+side1,0,0.5])
minkowski() {
linear_extrude(0.1, center = false)
resize([side1,side2])circle(d=20,center=true);
sphere (0.5);
}