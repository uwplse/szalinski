car_len=65;
car_wid=30;
car_h=15;
axle_wid=10;
axle_correction=0.26;
seat_widx=14;
seat_widy=12;
tolerance=0.25;

$fn=32;


module peg(rotation) {
  rotate([-90,rotation,0]) {
  sphere(5);
  c=6+tolerance; 
  translate([0,0,-21])
    cylinder(r=c, h=15, $fn=3);
  translate([0,0,-6])
    linear_extrude(height=5, scale=0.1)
      circle(r=c,  $fn=3);
}}

module wheel(deco) { 
  translate([0,0,-axle_correction]) {
  difference() {
    cylinder(r=5,h=2);
    if (deco==1) {
      cylinder(r=4,h=.2);
    }
  }
  cylinder(r=3,h=.2);
  translate([0,0,2])
    linear_extrude(height=6, scale=0.2)
      circle(r=5);
  cylinder(r=1.5,h=car_wid/2+axle_correction);
  }
}

module axle(deco) {
  wheel(deco);
  translate([0,0,car_wid])
    mirror([0,0,1])
      wheel(deco);
}

module chassis(number) {
  translate([0,car_h+8,0])
    rotate([0,0,-12])
      cube([10,2,car_wid]);
  translate([0,car_h,0])
    rotate([0,0,-12])
      cube([10,2,car_wid]);
  translate([0,car_h,0])
    cube([10,8,2]);
  translate([0,car_h,car_wid-2])
    mirror([0,0,1])
      linear_extrude(height=10, scale=[0,0])
        square([10,8]);
  translate([0,car_h,2])
      linear_extrude(height=10, scale=[0,0])
        square([10,8]);
  translate([0,car_h,car_wid-2])
    cube([10,8,2]);
  difference() {
  translate([0,2,0])
    cube([car_len+2,2,car_wid]);
  translate([-2,2,0])
    rotate([0,0,-12])
      cube([12,2,car_wid]);
  }  
  difference() {
    translate([0,4,0])
      cube([car_len,car_h-4,car_wid]);
    translate([30,39,2])
      rotate([0,0,-45])
      cube([car_len,car_h-4,car_wid-4]);
    translate([30,39.5,0])
      rotate([0,0,-45])
      cube([car_len,car_h-6,car_wid]);
  }

  translate([63,5,car_wid/2+4])
    rotate([0,90,45])
      linear_extrude(height=1, size=10)
      text(number);

}

module seating() {
  for (i=[1,-1])
  for (j=[car_len/2, car_len/2-seat_widx, car_len/2+seat_widx])
    translate([j,25,car_wid/2+i*seat_widy/2]) {
        peg(90);
      }
}

module car(number) {
  difference() {
  minkowski() {
    chassis(number);
    sphere(.25, $fn=8);
  }
  seating();
  translate([axle_wid,5,0])
    scale([1.2,1.2,1])
      axle(0);
  translate([car_len-axle_wid,5,0])
    scale([1.2,1.2,1])
      axle(0);
  }
  translate([axle_wid,5,0])
    axle(1);
  translate([car_len-axle_wid,5,0])
    axle(1);
  
}

car("1");