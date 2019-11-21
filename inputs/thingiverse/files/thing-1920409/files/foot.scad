foot_l = 40.2;
foot_w = 15.5;
foot_h = 5;
plug_h = 15;
barb_w = 3;
wall_t = 1.4;

$fn=20;

union() {
     // plug
     short_wall();
     rotate([0, 0, 180])
          short_wall();

     long_wall();
     rotate([0, 0, 180])
          long_wall();

     // foot
     difference(){
          minkowski(){
               cube([foot_l-foot_h, foot_w-foot_h, foot_h], center=true);
               sphere(foot_h/2);
          }
          translate([0, 0, foot_h/2])
               cube([foot_l, foot_w, foot_h], center=true);
     }
}

module short_wall()
{
     translate([(foot_l / 2) - barb_w - wall_t, 0, 0])
          plug_wall(foot_w);
}

module long_wall()
{
     rotate([0, 0, 90])
          translate([(foot_w / 2) - barb_w - wall_t, 0, 0])
          plug_wall(foot_l - 2 * barb_w - 2 * wall_t);
}

module plug_wall(length)
{
     translate([0, (length - 4 * wall_t)/2, 0])
          rotate([90, 5, 0])
          linear_extrude(length - 4 * wall_t)
          polygon([[-barb_w/2,0], [0,plug_h], [barb_w, plug_h-(plug_h/8)], [barb_w/2, plug_h-(plug_h/4)], [barb_w, plug_h-(plug_h/2)], [barb_w/2, plug_h-(3*plug_h/4)], [barb_w-(barb_w/4), 0], [-barb_w/2,0]]);
}
