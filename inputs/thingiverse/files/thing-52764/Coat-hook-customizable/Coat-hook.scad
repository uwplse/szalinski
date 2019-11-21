// How thick the outer part will be
thickness=25; // [10:40]
// How far the outer part will be from the wall
wall_distance=25; // [10:40]
// How rounded the outer edge is
roundness=25; // [0:50]
// Diameter of outer part
Diameter=80; // [70:150]
//The diameter of the shaft towards the wall (should be smaller than outer diameter - roundness, but higher than screw distance + 2*screw hole size)
Diameter2=36; // [36:100]
// The distance between the screws, from left side to left side
screw_distance=20;
//The diameter of the screw head
screw_hole_size=8;
// How fine the round parts are
$fn=100;


s=screw_hole_size*1.53;
r1=Diameter/2;

translate([0,0,thickness/2])
cylinder(h=thickness,r=r1-roundness,center=true);

translate([0,0,thickness/2])
rotate_extrude(convexity=10)
translate([r1-roundness,0,0])
scale([roundness/thickness,1,1])
circle(thickness/2,center=true);

difference(){
translate([0,0,thickness+wall_distance/2])
cylinder(h=wall_distance,r=Diameter2/2,center=true);
translate([-s,-screw_distance/2,thickness+wall_distance-s/4])
polyhedron(
	points=[[s,s,0],[s,-s,0],[-s,0,0],[s,0,s/2]],
	triangles=[[0,2,1],[0,1,3],[2,0,3],[1,2,3]]);

translate([-s,screw_distance/2,thickness+wall_distance-s/4])
polyhedron(
	points=[[s,s,0],[s,-s,0],[-s,0,0],[s,0,s/2]],
	triangles=[[0,2,1],[0,1,3],[2,0,3],[1,2,3]]);
}

difference(){
translate([0,0,thickness+wall_distance/2])
cylinder(h=wall_distance,r=Diameter2/2,center=true);
translate([0,0,thickness+wall_distance/2])
cylinder(h=wall_distance+1,r=Diameter2/2-1,center=true);}