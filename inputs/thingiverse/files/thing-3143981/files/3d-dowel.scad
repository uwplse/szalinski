height = 60;
cap_radius = 3;
cap_height = 2;
beam_x = .75;
// cap_radius*2 will extend beam to the edge of cap
beam_y = cap_radius*2 - .3;

// x-beam, centered between two caps
translate([0,0,height/2]) {
    // cube 1
    cube(size = [beam_x,beam_y,height], center = true);
    // cube 2, twisted 90 in z
    color("red")  rotate([0,0,90]) {
      cube(size = [beam_x,beam_y,height], center = true);
    }
}

// bottom cap
color("blue")  cylinder(h = cap_height, r1 = cap_radius, r2 = cap_radius, center = true);

// top cap
color("green")  translate([0,0,height])
{
  cylinder(h = cap_height, r1 = cap_radius, r2 = cap_radius, center = true); 
}