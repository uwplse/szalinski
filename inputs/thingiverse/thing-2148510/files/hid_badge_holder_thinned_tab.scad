badge_thickness = 1;
clip_tab_thickness = 3;

/* [Hidden] */
badge_width = 56;
badge_height = 87;

holder_wall_size = 2;
holder_bezel_size = holder_wall_size + 3;

holder_height = badge_height + (holder_wall_size * 2);
holder_width = badge_width + (holder_wall_size * 2);
holder_thickness = badge_thickness  + (holder_wall_size * 2);
holder_radius = 4;

clip_hole_width = 15;
clip_hole_height = 4;

difference() {
  hull() {
    cube(size=[holder_height - holder_radius, holder_width, holder_thickness]);
    
    translate([holder_height - holder_radius, holder_radius, 0])
      cylinder(h=holder_thickness, r=holder_radius, $fn=50);
    translate([holder_height - holder_radius, holder_width - holder_radius, 0])
      cylinder(h=holder_thickness, r=holder_radius, $fn=50);
  }
  
  translate([holder_wall_size,holder_wall_size, holder_wall_size])
    cube(size=[badge_height, badge_width, badge_thickness]);
  
  translate([holder_wall_size,holder_wall_size, holder_wall_size])
    cube(size=[badge_height / 2.25, badge_width, holder_thickness * 2]);
  
  hull() {
    translate([holder_bezel_size + holder_radius, holder_bezel_size + holder_radius, 0])
      cylinder(h=holder_thickness, r=holder_radius, $fn=50);
    translate([holder_bezel_size + holder_radius, holder_width - holder_bezel_size - holder_radius, 0])
      cylinder(h=holder_thickness, r=holder_radius, $fn=50);
    translate([holder_height - holder_bezel_size - holder_radius, holder_bezel_size + holder_radius, 0])
      cylinder(h=holder_thickness, r=holder_radius, $fn=50);
    translate([holder_height - holder_bezel_size - holder_radius, holder_width - holder_bezel_size - holder_radius, 0])
      cylinder(h=holder_thickness, r=holder_radius, $fn=50);
  }
}

difference() {
  translate([holder_width - 8.05, holder_width / 2, holder_thickness / 2 - clip_tab_thickness / 2])
    cylinder(h=clip_tab_thickness, d=holder_width * 2, $fn=50);
  
  translate([0, holder_width * -1.5, -1])
    cube(holder_width * 3, holder_width * 3, 100);
  
  translate([(clip_hole_height / -2) - 1, (holder_width - (clip_hole_width + (clip_hole_height / 2))) / 2, -.5])
  hull() {
    translate([0,clip_hole_width,0])
      cylinder(h=holder_thickness + 1, d=clip_hole_height, $fn=50);
    cylinder(h=holder_thickness + 1, d=clip_hole_height, $fn=50);
  }
}