
//detector holes distance
holes_dist=19;
//detector holes diameter
holes_d=3.2;
//with clip
with_clip=1; //[0:No,1:Yes]
//
holes_shift=5;

//distance between rods
rod_dist=45;
//rod diameter
rod_d=8;
//common height
height=10;
//nozzle size (for hole corrections)
nozzle=.3;

/*[hidden]*/
$fn=32;

difference(){
  union(){
    translate([0,0,0])hook(5,rod_d+4,rod_d,height);
    translate([rod_dist,0,0])hook(rod_d+7,rod_d+4,rod_d,height);
    translate([0,rod_d/2+2,0]){
       cube([rod_d+7+rod_dist,3,height]);
      translate([holes_shift,3,holes_d/2])rotate([-90,0,0]){
        cylinder(d=holes_d,h=8);
        translate([holes_dist,0,0])cylinder(d=holes_d,h=8);
      }
      if (with_clip){
        translate([-2,-1,0])cube([2,4+8+2,10]);
        translate([-2,13,0])rotate([0,0,-75])cube([2,50-1,10]);
        translate([42+5,3,0]){
          translate([-2,10,0])cube([2,2,10]);
          cube([2,12,10]);
        }
      }
    }
    translate([rod_d+2+rod_dist,-rod_d/2-2,height/2])rotate([90,0,0])
      cylinder(d1=10,d2=8,h=2);
  }
  translate([rod_d+2+rod_dist,-rod_d/2-2-2.1,height/2])rotate([-90,0,0]){
    cylinder(d=3+nozzle,h=rod_d+10);
    cylinder(d=6+2*nozzle,h=2,$fn=6);
  }
}

module hook(l=5,od=12,id=8,h=10){
difference(){
  hull(){
    cylinder(d=od,h=h);
    translate([l,0,0])cylinder(d=od,h=h);
  }
  translate([0,0,-.1]){
    hull(){
      cylinder(d=id+nozzle,h=h+.2);
      translate([l,0,0])cylinder(d=id+nozzle,h=h+.2);
    }
  translate([l,-od/2-.1,0])cube([od,od+.2,h+.2]);
  }
  }
  for (i=[1,-1])
  translate([l,i*(id/2+(od-id)/4)-.1,0])cylinder(d=(od-id)/2,h=h);
}