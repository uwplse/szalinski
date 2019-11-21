// -----------------------------------------------------
// anti-spam-keychain (it took less than 5 minutes)
//
//  Detlev Ahlgrimm, 06.2018
// -----------------------------------------------------

$fn=100;

base_x=110;
base_y=20;
base_z=4;
base_r=3;
hole_d=4;
text="stop spamming!";
text_size=10;
text_height=2;

difference() {
  hull() {
    translate([base_r, base_r, 0]) cylinder(r=base_r, h=base_z);
    translate([base_x-base_r, base_r, 0]) cylinder(r=base_r, h=base_z);
    translate([base_r, base_y-base_r, 0]) cylinder(r=base_r, h=base_z);
    translate([base_x-base_r, base_y-base_r, 0]) cylinder(r=base_r, h=base_z);
  }
  translate([5, base_y/2, -0.1]) cylinder(d=hole_d, base_z+0.2);
}
translate([10, 5, base_z]) linear_extrude(text_height) text(text=text, size=text_size);
