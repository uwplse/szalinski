// Honda Pedal Stop

// Increase resolution
$fn=50;

// Variables
face_d = 7;
face_h = 3;
shaft_d = 3;
shaft_h = 3.5;
bump_d = 3.2;
bump_h = 1;
cone_h = 3;
cone_end_d = 1.5;

// Face
cylinder(h=face_h,r=face_d);

// Shaft
translate([0,0,face_h]) cylinder(h=shaft_h,r=shaft_d);

// Bump
translate([0,0,face_h+shaft_h]) cylinder(h=bump_h,r=bump_d);

// Cone
translate([0,0,(face_h+shaft_h+bump_h)]) cylinder(h=cone_h,r1=bump_d,r2=cone_end_d);



