// Width of the phone when held horizontally (Layout view)
phone_width = 130;
// Thickness of phone, including case
phone_thickness = 11.8;

/* [Advanced] */
phone_angle = 60;
// How far the phone sinks into stand
phone_insert_depth = 18;
// How much wiggle room to allow between phone and stand
slide_gap = 2;
// How far back to extend the rear supports
support_extends = 30;
// How thick to make the rear supports
support_thickness = 20;

/* [Hidden] */
phone_insert_height = phone_insert_depth * sin(phone_angle); // how far into block we need to go to achieve depth
stand_base_height = 7.5;
stand_height = stand_base_height + phone_insert_height;


side_wall_thickness = 5;
front_wall_thickness = 6;
front_wall_width = 15;
back_wall_thickness = 7;

phone_hole_width = phone_width + slide_gap;
phone_hole_thickness = phone_thickness + slide_gap;
phone_hole_height = phone_insert_depth * 4; // will extend out top

block_width = phone_hole_width + (side_wall_thickness * 2);
block_depth = phone_hole_thickness + back_wall_thickness + front_wall_thickness;
block_height = stand_height;

extra = 1;



stand();

translate([0, block_depth, 0])
support();

translate([block_width - support_thickness, block_depth, 0])
support();


module stand(){
  difference(){
    union(){
      cube([block_width, block_depth, block_height]);

      translate([0, -front_wall_thickness, 0])
        cube([block_width, front_wall_thickness, block_height]);
    }

    phone_insert();

    front_angle_shave();

    front_viewer();
  }
}

module support(){
  rotate([90,0,90])
  linear_extrude(height=support_thickness)
  polygon(points=[
    [0,0],
    [support_extends,0],
    [0, stand_height]
      ]);
}

backstop_base = phone_insert_depth * sin(90 - phone_angle);

module phone_insert(){
  // the extra thickness added to the bottom of the back wall, because of angled phone insert
  translate([side_wall_thickness, block_depth - back_wall_thickness - backstop_base, stand_base_height])
    rotate([(phone_angle-90), 0, 0])
    translate([0, -phone_hole_thickness, 0]) // to rotate around back left bottom corner
    cube([phone_hole_width, phone_hole_thickness, phone_hole_height]);
}

module front_angle_shave(){
  extra_sink = 5;
  shave_y_offset = (block_height + extra_sink) * sin(90-phone_angle) / sin(phone_angle);
    translate([-extra, -shave_y_offset, -extra_sink ])
    rotate([phone_angle-90, 0, 0])
    translate([0, -block_depth, 0])
    cube([block_width + 2 * extra, block_depth, block_height*5]);
}

module front_viewer(){
  viewer_inset = block_height * sin(90-phone_angle) / sin(phone_angle);

  // hole that extends out in front of phone, at same angle
  translate([front_wall_width,  block_depth - back_wall_thickness - backstop_base, stand_base_height])
  rotate([phone_angle-90, 0, 0])
  translate([0, -block_depth, 0])
    cube([block_width - (front_wall_width * 2), block_depth, block_height * 2]);

  // hole in between front walls
  translate([front_wall_width, -(front_wall_thickness + extra), -extra])
    cube([block_width - (front_wall_width * 2), front_wall_thickness + extra, block_height + extra * 2]);
}
