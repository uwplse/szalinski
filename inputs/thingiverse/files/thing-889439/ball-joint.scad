
// the model's wall thickness (in mm)
wall_thickness = 1.2;
// the bigger sphere's diameter (in mm)
big_sphere_diameter = 12;
// the model's inner minimum radius (in mm)
tube_inner_diameter = 4;
// distance of the two spheres
spheres_distance = 0; // [-2:0.1:5]
// the model's resolution
model_resolution = 50;


ball_joint(
    wall_th=wall_thickness,
    big_dia=big_sphere_diameter,
    balls_dis=spheres_distance,
    tube_inner_dia=tube_inner_diameter,
    resolution=model_resolution);


// Hack a ball joint based on all parameters
// undef default values will be calculated/set automatically
module ball_joint(
  wall_th = 1.2,            // the joint's wall thickness (mm)
  big_dia = 12,             // big ball diameter (mm)
  small_ball_tol = undef,   // factor reducing small ball diameter to create tolerance (%)
  balls_dis = 0,            // small and big balls distance (mm)
  tube_inner_dia = 4,       // model's tube inner minimum diameter (mm)
  big_cut = 0.17,           // cut x% off the big ball
  small_cut = 0.1,          // cut x% off the small ball
  flex_h = 0.7,             // height of big ball cut to make it flexible (%)
  resolution = 50) {

    // Calculate/set all undef and further values:
    big_rad   = big_dia/2;
    small_dia = big_dia - 2*wall_th;
    small_rad = small_dia/2;
    small_ball_tol = (small_ball_tol == undef) ? 0.99 : small_ball_tol;
      
    balls_dis = (small_rad+big_rad)*0.8 + balls_dis;
    tube_inner_rad = tube_inner_dia / 2;
    tube_outer_rad = tube_inner_rad + wall_th/2;
      
    flex_w = small_dia/10;       // width of big ball cut to make it flexible (mm)
    flex_circle_dia = flex_w*2;  // big ball cut circle (mm)
      
    difference() {
        union() {
            sphere(r=big_rad, $fn=resolution);
            translate([0, 0, -balls_dis])
                sphere(r=small_rad*small_ball_tol, $fn=resolution);
            // add connecting tube:
            translate([0, 0, -big_rad])
                cylinder(h=small_dia, r=tube_outer_rad, $fn=resolution, center=true);
        }

        // cut off top and bottom end:
        translate([0, 0, big_rad])
            cube([big_dia, big_dia, (big_dia * big_cut) * 2], center=true);
        translate([0, 0, -(balls_dis + small_rad*small_ball_tol)])
            cube([small_dia, small_dia, (small_dia * small_cut) * 2], center=true);

        // subtract inner spheres (move second inner sphere a bit away from the big ball center to get thinner more flexible walls at the outer edge):
        sphere(r=small_rad, $fn=resolution);
        translate([0, 0, wall_th*big_dia/small_dia])
            sphere(r=small_rad, $fn=resolution);
        translate([0, 0, -balls_dis])
            sphere(r=small_rad*small_ball_tol - wall_th, $fn=resolution);

        // cut big ball along x-/y-axis:
        translate([0, 0, big_rad])
            cube([big_dia, flex_w, big_dia*flex_h*2], center=true);
        translate([0, 0, big_rad])
            rotate([0, 0, 90])
                cube([big_dia, flex_w, big_dia*flex_h*2], center=true);
        translate([0, 0, -big_dia*(flex_h-0.5)])
            rotate([90, 0, 0])
                cylinder(h=big_dia*2, r=flex_circle_dia/2, $fn=resolution, center=true);
        translate([0, 0, -big_dia*(flex_h-0.5)])
            rotate([90, 0, 90])
                cylinder(h=big_dia*2, r=flex_circle_dia/2, $fn=resolution, center=true);

        // subtract cable tube (from small ball):
        cylinder(h=big_dia+2*small_dia, r=tube_inner_rad, $fn=resolution, center=true);
    }
}
