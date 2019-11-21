
// Radius for Snowman body
radius = 40;
// Do Snowman has left eye?
with_left_eye = "Yes"; // [Yes,No]
// Do Snowman has right eye?
with_right_eye = "Yes"; // [Yes,No]
// Radius for Snowman eye?
eye_size = 10;
// Do Snowman has nose?
with_nose = "Yes"; // [Yes,No] 
// Length for Snowman nose?
nose_length = 25;

rotate([0,0,-180])
translate([0,0,radius])
    color([1,1,1,1])
    sphere(r=radius);
rotate([0,0,-90])
translate([0,0,radius+radius*1.3])
    color([1,1,1,1])
    sphere(r=radius/2);
if (with_left_eye == "Yes") {
rotate([0,0,-180])
translate([radius/4.2,radius/2.1,radius+radius*1.4])
    color([1,1,1,1])
    sphere(r=radius*eye_size/100);
}
if (with_right_eye == "Yes") {
rotate([0,0,-180])
translate([radius/4.2-radius/2.1,radius/2.1,radius+radius*1.4])
    color([1,1,1,1])
    sphere(r=radius*eye_size/100);
}
if (with_nose == "Yes") {
rotate([0,0,-180])
translate([radius/4.2-radius/2.1/2,radius/2.1,radius+radius*1.3])
    rotate([-90,0,0])
    color([1,1,1,1])
    cylinder(radius*nose_length/100, d1=radius/6,  r2=1);
}