// 3d model of Matthias Wandel's clever 3-way joint

joint_size = 200;
js = joint_size;
tol = 0.2;
length = 20;

diag = joint_size * sqrt(2);

module cylinder_slice(dia, height, angle, tol=0) {
  difference() {
    cylinder(d=dia, h=height);
    translate([-dia/2-1,-tol,-1]) cube(dia+2);
    translate([0,-2*dia+1,-1]) cube(2*dia);
    rotate(-(90-angle)) translate([-tol/sin(angle),-2*dia+1,-1]) cube(2*dia);
  }
}
/*for (a = [0:2*60:360]) rotate(a) cylinder_slice(50,20,60);*/

module joint_3way() {
  angle = atan(2*js/diag);
  polyhedron(points=[[-js/2, js/2, js/2], [js/2, -js/2, js/2], [-js/2, -js/2, -js/2], [-js/2, -js/2, js/2]], faces=[[0,2,1],[0,1,3],[1,2,3],[0,3,2]]);
  rotate([0,0,-45]) rotate([angle,0,0]) intersection() {
    rotate([-angle,0,0]) rotate([0,0,45]) polyhedron(points=[[-js/2, js/2, js/2], [js/2, -js/2, js/2], [-js/2, -js/2, -js/2], [-js/2, js/2, -js/2], [js/2, -js/2, -js/2], [js/2, js/2, js/2]], faces=[[0,1,2],[3,4,5], [0,5,1], [2, 4, 3], [0,2,3], [1,4,2], [1,5,4], [0,3,5]]);
    rotate(60) for (a = [0:2*60:360]) rotate(a) translate([0,0,-js/2]) cylinder_slice(diag*3/2,js,60, tol);
  }
}
/*joint_3way();*/

module joint_3way_assembled(attached=false) {
  joint_3way();
  rotate([-90,0,0]) rotate(180) joint_3way();
  if ((attached=="perpendicular")||(attached=="right")) {
    translate([0,-(4*js+js)/2,0]) cube([js, 4*js, js], center=true);
    rotate((attached=="right"?0:-90)) translate([0,(4*js+js)/2,0]) cube([js, 4*js, js], center=true);
  }
}
/*joint_3way_assembled();*/
/*joint_3way_assembled("right");*/
/*joint_3way_assembled("perpendicular");*/

module joint_3way_rtp(length) {
  translate([0,0,js/2]) rotate([0,180,0]) {
    joint_3way();
    translate([0,-(length+js)/2,0]) cube([js, length, js], center=true);
  }
}
joint_3way_rtp(length);
