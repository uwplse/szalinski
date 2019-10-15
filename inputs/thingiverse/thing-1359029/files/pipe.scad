
$fn=100;
hole_radius=6;
pipe_diameter=14; //actually radius
thickness=2;

module pipe()
{

difference()
{
cylinder(r=pipe_diameter+thickness, h=hole_radius*4);
translate([0,0,-0.5])
cylinder(r=pipe_diameter, h=hole_radius*4.1);
translate([-(pipe_diameter+thickness)*2,-(pipe_diameter+thickness),-1])
cube([(pipe_diameter+thickness)*2,(pipe_diameter+thickness)*2,hole_radius*5]);

}

difference()
{
union()
{
translate([-pipe_diameter*3,pipe_diameter+thickness,hole_radius*2])
rotate([90,0,0])
cylinder(r=hole_radius*2, h=thickness);
translate([-pipe_diameter*3,pipe_diameter,0])
cube([pipe_diameter*3,thickness, hole_radius*4]);
}

translate([-pipe_diameter*3,pipe_diameter+thickness/2,hole_radius*2])
rotate([90,0,0])
cylinder(r=hole_radius, h=thickness*2);

translate([-pipe_diameter*3,pipe_diameter+thickness+1,hole_radius*2])
rotate([90,0,0])
cylinder(r=1, h=thickness*2);

}
}

for (i=[0:4])
{

translate([0,pipe_diameter*3*i,0])
pipe();
}

//cylinder(r=pipe_diameter, h=hole_radius*2);