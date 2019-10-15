//// Number of fragments
$fn=60;

radius=15;
height=0.81;
distance=4;
wall=0.81;
corr=0.2;
axish=5;
axisr=3;
height=0.81;

translate([-radius-10,0,0])connector();
translate([0,0,0])joint_bottom();
translate([radius+15,0,0])joint_top();

module joint_bottom() {
  difference() {
    translate([0,0,-height/2])cylinder(r=radius,h=height,center=true);
    translate([+radius+distance,0,-height/2])cylinder(r=radius+corr,h=height+corr,center=true);
  }
  translate([0,0,height])cylinder(r=axisr,h=2*height,center=true);

  translate([0,-radius+axisr,0])difference() {
    translate([0,0,height])cylinder(r=axisr,h=height*2,center=true);
    translate([0,0,height])cube([axisr+corr,axisr/2+corr,height*2+corr],center=true);
  }

  translate([0,+radius-axisr,0])difference() {
    translate([0,0,height])cylinder(r=axisr,h=height*2,center=true);
    translate([0,0,height])cube([axisr+corr,axisr/2+corr,height*2+corr],center=true);
  }
}

module joint_top() {
  difference() {
    translate([0,0,-height/2])cylinder(r=radius,h=height,center=true);
    translate([+radius+distance,0,-height/2])cylinder(r=radius+corr,h=height+corr,center=true);
  }
  translate([0,-radius+axisr,height])cube([axisr,axisr/2,height*2+corr],center=true);
  translate([0,+radius-axisr,height])cube([axisr,axisr/2,height*2+corr],center=true);
}

module connector() {
  translate([0,-radius/2-distance/2,-height/2])rotate([0,0,90])difference() {
    hull() {
      cylinder(r=3/2*axisr,h=height,center=true);
      translate([radius+distance,0,0])cylinder(r=3/2*axisr,h=height,center=true);
    }
    cylinder(r=axisr+corr,h=height+corr,center=true);
    translate([radius+distance,0,0])cylinder(r=axisr+corr,h=height+corr,center=true);
  }
}
