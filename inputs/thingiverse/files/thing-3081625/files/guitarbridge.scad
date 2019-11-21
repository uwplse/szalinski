length = 75; // [120]
height = 8.8; // [1:0.1:14]
depth = 3; // [0.1:0.1:5]
fingerboard_radius = 381; // [184.15:7-1/4", 241.3:9-1/2", 254:10", 304.8:12", 355.6:14", 381:15", 406.4:16", 431.8:17", 508:20"]
center_offset = 0.64; // [0.5:0.01:0.67]

/* [Hidden] */
radius = depth/2 - 0.25;

difference() {
  minkowski() {
    translate([radius, 0, 0])
      intersection () {
        cube([length-depth, 0.01, height-radius]);
        translate([center_offset * length, 0, -fingerboard_radius+height-radius])
        rotate([90, 0, 0])
        cylinder(h = depth * 2, r = fingerboard_radius, $fn = 120);
      }
      sphere(radius, $fn = 30);
  }
  translate([0, -radius, -depth])
  cube([length, depth, depth]);
}