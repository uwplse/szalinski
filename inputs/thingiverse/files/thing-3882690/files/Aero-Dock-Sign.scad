// Aero Dock Signage - KLG 2019

echo(version=version());

font = "Liberation Sans"; //["Liberation Sans", "Liberation Sans:style=Bold", "Liberation Sans:style=Italic", "Liberation Mono", "Liberation Serif"]

name = "AERO";
cube_w = 40;
cube_d = 2;
cube_h = 9;
letter_size = cube_h -2;
letter_height = cube_d*2;

o = cube_d / 2 - letter_height / 2;

rotate(-[90, 0, 0]) sign();

module letter(l) {
  // Use linear_extrude() to make the letters 3D objects as they
  // are only 2D shapes when only using text()
 scale([1.2,1,1])  linear_extrude(height = letter_height) {
    text(l, size = letter_size, font = font, halign = "center", valign = "center", $fn = 16);
  }
}

module sign() {

union() {
    translate([0, cube_d/2, 8+cube_h/2])
    {

     color("gray") cube([cube_w,cube_d,cube_h], center = true);   

    translate([0, -o, 0]) rotate([90, 0, 0]) letter(name);

}
 translate([0, 1.2, 6]) color("black") cube([14,0.8,4], center = true);
  translate([0, 0.8, 2]) color("gray") cube([14,1.6,6], center = true);
}
}