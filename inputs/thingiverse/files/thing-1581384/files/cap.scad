l=150;
w=22;
h=20;
t=1;
g=40;
pegnumber=10;
$fn=100;



tolerance=0.1;
indent_hole_radius=6.5; 
thickness=2;
axle_radius=3; //3
axle_length=20;

cutout_height=16;
indent_thickness=3;

tolerance=0.2;

module cap()
{
//translate([0,0,50])
difference()
{
    translate([-axle_radius*2, axle_radius/2,0])
cube([axle_radius*4,axle_radius,indent_thickness]);
    translate([0,0,-1])
    cylinder(r=axle_radius, h=indent_thickness*3);
}
translate([axle_radius*1.5,axle_radius/2,indent_thickness/2])
rotate([90,0,0])
cylinder(r=indent_thickness/2-tolerance, h=axle_radius*3);


translate([-axle_radius*1.5,axle_radius/2,indent_thickness/2])
rotate([90,0,0])
cylinder(r=indent_thickness/2-tolerance, h=axle_radius*3);
}

for (i=[0:9], j=[0:1])
{
    translate([i*axle_radius*5,j*15,0])
    cap();
    
}