beam_wall_thickeness = 1;
beam_width_or_radius = 20;
beam_length = 100;
i_beam = 1; 
t_stock = 1; 
u_channel = 1; 
rectangle_tube = 1; 
cross = 1; 
cylinder_tube = 1;
wing = 1; 
pillars = 6;
pillar_width = 2;


//No need to eddit below this line
if (pillars > 0 )


  for ( i = [0 : pillars - 1] )
  {

    translate([beam_width_or_radius / 2, 0, 0 ])
    rotate(a = i * 360 / pillars , v = [0, 0, 1])
    rotate(a = 360 / pillars / 4 , v = [0, 0, 1])
    translate([-beam_width_or_radius / 2, beam_width_or_radius / 8, 0 ])
    cylinder (h = beam_length, r = pillar_width, center = true, $fn = 100);
  }



if (i_beam > 0) {

  cube(size = [beam_wall_thickeness, beam_width_or_radius, beam_length], center = true);
  translate([beam_wall_thickeness / 2 + (beam_width_or_radius / 2), 0, 0])
  rotate(a = [0, 0, 90])
  cube(size = [beam_wall_thickeness, beam_width_or_radius, beam_length], center = true);
  translate([beam_wall_thickeness / 2 + beam_width_or_radius, 0, 0])
  cube(size = [beam_wall_thickeness, beam_width_or_radius, beam_length], center = true);
}

if (u_channel > 0) {

  cube(size = [beam_wall_thickeness, beam_width_or_radius, beam_length], center = true);
  translate([beam_wall_thickeness / 2 + beam_width_or_radius / 2, beam_width_or_radius / 2 - beam_wall_thickeness / 2, 0])
  rotate(a = [0, 0, 90])
  cube(size = [beam_wall_thickeness, beam_width_or_radius, beam_length], center = true);
  translate([beam_wall_thickeness / 2 + beam_width_or_radius, 0, 0])
  cube(size = [beam_wall_thickeness, beam_width_or_radius, beam_length], center = true);
}

if (rectangle_tube > 0) {

  cube(size = [beam_wall_thickeness, beam_width_or_radius, beam_length], center = true);
  translate([beam_wall_thickeness / 2 + beam_width_or_radius / 2, beam_width_or_radius / 2 - beam_wall_thickeness / 2, 0])
  rotate(a = [0, 0, 90])
  cube(size = [beam_wall_thickeness, beam_width_or_radius, beam_length], center = true);
  translate([beam_wall_thickeness / 2 + beam_width_or_radius, 0, 0])
  cube(size = [beam_wall_thickeness, beam_width_or_radius, beam_length], center = true);
  translate([beam_wall_thickeness / 2 + beam_width_or_radius / 2, -beam_width_or_radius / 2 + beam_wall_thickeness / 2, 0])
  rotate(a = [0, 0, 90])
  cube(size = [beam_wall_thickeness, beam_width_or_radius, beam_length], center = true);
}

if (cross > 0) {

  translate([beam_wall_thickeness / 2 + beam_width_or_radius / 2, 0, 0])
  cube(size = [beam_wall_thickeness, beam_width_or_radius, beam_length], center = true);

  translate([ beam_width_or_radius /2 + beam_wall_thickeness/3, (beam_width_or_radius)/2  - beam_width_or_radius/2 , 0])
  rotate(a = [0, 0, 270])
  cube(size = [beam_wall_thickeness, beam_width_or_radius, beam_length], center = true);

}

if (wing > 0) {

  translate([beam_wall_thickeness - beam_wall_thickeness / 8, beam_width_or_radius / 4, 0])
  cube(size = [beam_wall_thickeness, beam_width_or_radius / 2, beam_length], center = true);
  translate([-beam_width_or_radius / 4 * -1 + beam_wall_thickeness, beam_width_or_radius / 2 - beam_wall_thickeness / 2, 0])
  rotate(a = [0, 0, 270])
  cube(size = [beam_wall_thickeness, beam_width_or_radius / 2, beam_length], center = true);
  difference() {
    translate([beam_wall_thickeness / 3 + beam_width_or_radius / 2, 0, 0])
    cylinder (h = beam_length, r = beam_width_or_radius / 2, center = true, $fn = 100);
    translate([beam_wall_thickeness / 2 + beam_width_or_radius / 2, 0, 0])
    rotate ([0, 0, 0]) cylinder (h = beam_length + 2, r = beam_width_or_radius / 2 - beam_wall_thickeness, center = true, $fn = 100);
  }

}


if (cylinder_tube > 0) {

  difference() {
    translate([beam_wall_thickeness / 3 + beam_width_or_radius / 2, 0, 0])
    cylinder (h = beam_length, r = beam_width_or_radius / 2, center = true, $fn = 100);
    translate([beam_wall_thickeness / 2 + beam_width_or_radius / 2, 0, 0])
    rotate ([0, 0, 0]) cylinder (h = beam_length + 2, r = beam_width_or_radius / 2 - beam_wall_thickeness, center = true, $fn = 100);
  }
}

if (t_stock > 0) {
{

  translate([beam_wall_thickeness / 2 + beam_width_or_radius / 2, 0, 0])
  cube(size = [beam_wall_thickeness, beam_width_or_radius, beam_length], center = true);

  translate([ beam_width_or_radius /2 + beam_wall_thickeness/2, -beam_width_or_radius/2, 0])
  rotate(a = [0, 0, 270])
  cube(size = [beam_wall_thickeness, beam_width_or_radius, beam_length], center = true);






}
}


