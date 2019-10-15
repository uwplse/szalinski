mount_width=105;
mount_length=70;
mount_height=10;
mount_thickness=3;
mount_corner_radius=10;
magnet_hole_diameter=13;
magnet_height=1.2;
$fn=100;

use <hull.scad>

points_solid=[[-mount_width/2,-mount_length/2,0],[-mount_width/2,mount_length/2,0],[mount_width/2,-mount_length/2,0],[mount_width/2,mount_length/2,0],[0,-mount_length/2,0],[0,mount_length/2,0]];
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

module solid_base(whichpoints,howhigh){
//multiHull(whichpoints);
rounded_box(whichpoints,mount_corner_radius,howhigh);
}


translate([0,0,-mount_height*.5])
union(){
difference(){
solid_base(points_solid,mount_height);
translate([0,0,-mount_thickness])
solid_base(points_remove,mount_height*2);
    for (a=[0:5])
		place(a) magnet();
}

magnet_mounts();
}


difference(){
union(){
difference(){
scale([1.05,1.05,1]){
solid_base(points_solid,mount_height);}
translate([0,0,-mount_thickness])
scale([0.95,0.95,1]){
solid_base(points_remove,mount_height*2);}
}
}
translate([0,0,0.01])
difference(){
solid_base(points_solid,mount_height);
translate([0,0,-mount_thickness])
solid_base(points_remove,mount_height*2);
    for (a=[0:5])
		place(a) magnet();
}
}
