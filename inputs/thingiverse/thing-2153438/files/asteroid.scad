size = 150;
deformation_scale = 50;
deform_seed = 42;

skew_scale = .5;
skew_seed = 51;

resolution = 20;
finest_point = 6;

// Hidden
$fn = 4;

hull(){
  translate([.1*size, 0, 0]) {
    random_skew=rands(0, skew_scale, 4, skew_seed);
    echo ("random_skew", random_skew);
    scale([ 1 + random_skew[0], 1 + random_skew[1], 1 + random_skew[2]]) {
      for (ii=[0:resolution:360]) {
        for (i=[0:resolution:170]) {
          translate([size * sin(ii),  size * cos(ii) * cos(i), size * cos(ii) * sin(i)]) {
            random_offset=rands(0, deformation_scale, 4, deform_seed + i + ii);

            translate([ random_offset[0], random_offset[1], random_offset[2]]) {
              sphere(finest_point);
            }
          }
        }
      }
    }
  }
}
