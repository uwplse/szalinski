$fn=64;

length=25; // plus 10 cause of cubes
height=1.5;
d_body=30;
d_head=10;
d_keychain=6;
d_chip=25;
h_chip=0.5;

difference() {
  union() {
    cylinder(d=d_body,h=height);

    translate([length/2,0,0]) difference() {
      rotate([0,90,0]) cylinder(h=length, d1=d_body, d2=d_head, center=true);
      translate([-length/2,-d_body/2,height]) cube([length,d_body,length]);
      translate([-length/2,-d_body/2,-length]) cube([length,d_body,length]);
      translate([length/2,0,0]) cylinder(h=height,d=d_keychain);
    }

    difference() {
      translate([length,0,0]) cylinder(h=height,d=d_head);
      translate([length,0,0]) cylinder(h=height,d=d_keychain);
    }
  }

  translate([0,0,(height-h_chip)/2]) cylinder(d=d_chip,h=h_chip);
}