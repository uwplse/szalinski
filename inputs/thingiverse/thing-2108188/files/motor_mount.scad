$fn=50;

thick=3;
arm_width=10;

d_mot_screw_x = 19;
d_mot_screw_y = 16;
d_mount_screw = 33.3;
screw_d = 3.5;
screw_h = 7.5;



difference(){
  union(){
    for (i=[0,1]) {
    rotate(i*90) hull(){
        translate([16.5,0,0]) cylinder(h=thick,d=arm_width);
        translate([-16.5,0,0]) cylinder(h=thick,d=arm_width);
      }
    }
    for (i=[0,1,2,3]){
      rotate(i*90) translate([arm_width/2,arm_width/2,0]) difference(){
        cube([arm_width/2,arm_width/2,thick]);
        translate([arm_width/2,arm_width/2,-0.1]) cylinder(d=arm_width,h=thick+0.2);
      }
      rotate(90*i) translate([d_mount_screw/2,0,0]) cylinder(h=screw_h, d=7);
    }
  }

  for (i=[0,1]){
    rotate(i*180) translate([d_mot_screw_x/2,0,-0.1]) cylinder(d=screw_d, h=screw_h+0.2);
    rotate(i*180 +90) translate([d_mot_screw_y/2,0,-0.1]) cylinder(d=screw_d, h=screw_h+0.2);
    
    rotate(i*180) translate([d_mount_screw/2,0,-0.1]) cylinder(d=screw_d, h=screw_h+0.2);  
    rotate(i*180 +90) translate([d_mount_screw/2,0,-0.1]) cylinder(d=screw_d, h=screw_h+0.2);  
  }
}