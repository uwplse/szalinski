//thank you to Elliot Williams and the article at https://hackaday.com/2018/02/13/openscad-tieing-it-together-with-hull/
mount_width=105;
mount_length=70;
mount_height=10;
mount_thickness=3;
mount_corner_radius=10;
router_diameter=64; //actual router diameter
router_mount_thickness=2;
router_mount_height=20; //base size (gives shape to the router mount side)
router_mount_height_extension=10; //extra length to give the router mount
router_x_offset=25;
vacuum_mount_diameter=30.5; //inside diameter of vacuum hose that goes over the top of the mount minus 0.5-1mm
vacuum_mount_thickness=2;
vacuum_mount_height=20; //base size (gives shape to the vacuum mount side)
vacuum_mount_height_extension=5; //extra length to give the vacuum mount
vacuum_mount_angle=15;
vacuum_x_offset=25;
magnet_hole_diameter=13;
magnet_height=1.2;
$fn=50;

use <hull.scad>

points_solid=[[-mount_width/2,-mount_length/2,0],[-mount_width/2,mount_length/2,0],[mount_width/2,-mount_length/2,0],[mount_width/2,mount_length/2,0]];
points_remove=[[-mount_width/2+mount_thickness,-mount_length/2+mount_thickness,0],[-mount_width/2+mount_thickness,mount_length/2-mount_thickness,0],[mount_width/2-mount_thickness,-mount_length/2+mount_thickness,0],[mount_width/2-mount_thickness,mount_length/2-mount_thickness,0]];
points_magnets=[[-mount_width/2-mount_thickness*2,-mount_length/2-mount_thickness*2,0],[-mount_width/2-mount_thickness*2,mount_length/2+mount_thickness*2,0],[mount_width/2+mount_thickness*2,-mount_length/2-mount_thickness*2,0],[mount_width/2+mount_thickness*2,mount_length/2+mount_thickness*2,0],[0,-mount_length/2-mount_thickness*2,0],[0,mount_length/2+mount_thickness*2,0]];

module magnet_mounts(){
    for (a=[0:5])
        difference(){
		place(a) foot();
		place(a) magnet();
	}
}

module place(i){
	translate(points_magnets[i])
        children(0);
}

module foot(){
	cylinder(d=magnet_hole_diameter*1.5,h=mount_height);
}

module magnet(){
    translate([0,0,-0.1])
	cylinder(d=magnet_hole_diameter,h=magnet_height+0.2);
}

module solid_base(whichpoints){
union(){
multiHull(whichpoints){
rounded_box(whichpoints,mount_corner_radius,mount_height);

rotate([0,-vacuum_mount_angle,0])
translate([-vacuum_x_offset,0,mount_height])
cylinder(d=vacuum_mount_diameter,h=vacuum_mount_height);

translate([router_x_offset,0,mount_height])
cylinder(d=router_diameter+2*router_mount_thickness,h=router_mount_height);
}
}
}

difference(){
union(){
difference(){
union(){
difference(){
solid_base(points_solid);
translate([0,0,-mount_thickness])
solid_base(points_remove);
    for (a=[0:5])
		place(a) magnet();
}

rotate([0,-vacuum_mount_angle,0])
translate([-vacuum_x_offset,0,mount_height*2+0.01])
cylinder(d=vacuum_mount_diameter,h=vacuum_mount_height);

translate([router_x_offset,0,mount_height*2])
cylinder(d=router_diameter+2*router_mount_thickness,h=router_mount_height);
}
union(){
rotate([0,-vacuum_mount_angle,-.1])
translate([-vacuum_x_offset,0,mount_height*2])
cylinder(d=vacuum_mount_diameter-vacuum_mount_thickness*2,h=vacuum_mount_height+20.2);

translate([router_x_offset,0,mount_height*2-0.1])
cylinder(d=router_diameter,h=router_mount_height+0.2);
}
}

//add additional length to ports without changing the shape of the base mount

difference(){
union(){
rotate([0,-vacuum_mount_angle,0])
translate([-vacuum_x_offset,0,mount_height*2+0.01])
cylinder(d=vacuum_mount_diameter,h=vacuum_mount_height+vacuum_mount_height_extension);

translate([router_x_offset,0,mount_height*2])
cylinder(d=router_diameter+2*router_mount_thickness,h=router_mount_height+router_mount_height_extension);
}
union(){
rotate([0,-vacuum_mount_angle,-.1])
translate([-vacuum_x_offset,0,mount_height*2])
cylinder(d=vacuum_mount_diameter-vacuum_mount_thickness*2,h=vacuum_mount_height+vacuum_mount_height_extension+20.2);

translate([router_x_offset,0,mount_height*2-0.1])
cylinder(d=router_diameter,h=router_mount_height+router_mount_height_extension+0.2);
}
}
}
union(){
for (a =[0:5])
translate([router_x_offset,0,mount_height+router_mount_height+mount_thickness*2+0.1])
rotate([0,0,a*30])
translate([-router_mount_thickness/2,-(router_diameter+router_mount_thickness*2)/2,0])
cube([router_mount_thickness,router_diameter+router_mount_thickness*2,mount_height+router_mount_height+router_mount_height_extension]);
}

union(){
for (a =[0:5])
rotate([0,-vacuum_mount_angle,0])
translate([-vacuum_x_offset,0,mount_height+vacuum_mount_height+mount_thickness*2+0.1])
rotate([0,0,a*30])
translate([-vacuum_mount_thickness/2,-(vacuum_mount_diameter)/2,0])
cube([vacuum_mount_thickness,vacuum_mount_diameter,mount_height+vacuum_mount_height+vacuum_mount_height_extension]);
}
}

magnet_mounts();