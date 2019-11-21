$fn=32;

difference() {
  union() {
    translate([0,0,3])
    cylinder(d=15.5,h=7,center=true);
    translate([0,0,6.95])
    cylinder(d=16,h=3,center=true);
    translate([0,0,8.95])
    cylinder(d=22,h=2,center=true);

    translate([11.3,0,5.8])
    rotate([90,0,0])
    difference() {
      cylinder(d=2.7,h=5.5,center=true);
      cylinder(d=1.5,h=5.6,center=true);
    }

    translate([-11.3,0,5.8])
    rotate([90,0,0])
    difference() {
      cylinder(d=2.7,h=5.5,center=true);
      cylinder(d=1.5,h=5.6,center=true);
    }

    translate([-10.7,0,8])
    rotate([0,-75,0])
    cube([2.5,5,1.7],center=true);

    translate([10.7,0,8])
    rotate([0,75,0])
    cube([2.5,5,1.7],center=true);

  }
  cylinder(d=12.4,h=20,center=true);
  translate([0,0,-4.95])
  cylinder(d=13,h=3,center=true);

  translate([0,0,8])
  #cylinder(d=14.5,h=4.2,center=true);


  translate([0,0,8.44])
  difference() {
    cylinder(d=20,h=1,center=true);
    cylinder(d=16.5,h=1.1,center=true);      
  }
}

