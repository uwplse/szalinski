/* [Basic Settings] */

// The height of the entire item, from the bottom of the base to the top of the posts.
total_height = 32; // [20:40]

// The height of the base, not including the posts.
base_height = 5.25; // [2:0.25:10]

// The width of the item.
base_width = 23; // [20:30]

/* [Post Settings] */

// How thick should the posts be?
post_thickness = 5; // [3:10]

// How much distance between posts is needed for the door to slide through?
distance_between_posts = 38; // [20:50]

/* [Screw Hole Settings] */

// The radius of the pilot holes for the screws.
screw_hole_radius=2; // [1:0.25:3]

// The depth to sink the screw heads.
screw_sink_depth=2; // [1:0.25:4]

// The radius needed to sink the screw heads.
screw_sink_radius=4; // [1:0.25:5]

// calculated values
overlap_pad = 1*1;
base_padding = 5*1;
function center_post_dimensions() = [post_thickness,9,total_height+overlap_pad];
function outside_post_dimensions() = [base_width,post_thickness,total_height+overlap_pad];
base_length = center_post_dimensions()[1] + (outside_post_dimensions()[1]*2) + (distance_between_posts*2) + (base_padding*2);
radial_segments = 50*1;

module create_base()
  union () {
    translate([0, base_width/2, 0])
      cube([base_width, base_length, base_height]);
    translate([base_width/2, base_width/2, 0])
      cylinder(h=base_height,r=base_width/2,$fn=radial_segments);
    translate([base_width/2, base_width/2+base_length, 0])
      cylinder(h=base_height,r=base_width/2,$fn=radial_segments);
  }

module near_post()
  difference () {
    union () {
      translate([0, base_width/2+base_padding, base_height-overlap_pad])
        cube(outside_post_dimensions());
      translate([0, base_width/2, base_height-overlap_pad])
        cube([base_width, base_padding, base_padding+overlap_pad]);
    }
    translate([-1*overlap_pad,(base_width/2),base_height+base_padding])
      rotate([0,90,0])
        cylinder(h=base_width+(overlap_pad*2),r=(base_padding),$fn=radial_segments);
  }

module far_post()
  difference () {
    union () {
      translate([0, base_width/2+base_length-base_padding-outside_post_dimensions()[1],base_height-overlap_pad])
        cube(outside_post_dimensions());
      translate([0, base_width/2+base_length-base_padding,base_height-overlap_pad])
        cube([base_width, base_padding, base_padding+overlap_pad]);
    }
    translate([-1*overlap_pad,(base_width/2)+base_length,base_height+base_padding])
      rotate([0,90,0])
        cylinder(h=base_width+(overlap_pad*2),r=(base_padding),$fn=radial_segments);
  }

module center_posts()
  difference () {
    union () {
      translate([0, (base_width/2+base_length/2)-center_post_dimensions()[1]/2,base_height-overlap_pad])
        cube(center_post_dimensions());
      translate([base_width-center_post_dimensions()[0], (base_width/2+base_length/2)-center_post_dimensions()[1]/2,base_height-overlap_pad])
        cube(center_post_dimensions());
      translate([center_post_dimensions()[0]-overlap_pad, (base_width/2+base_length/2)-center_post_dimensions()[1]/2,base_height-overlap_pad])
        cube([(base_width-(center_post_dimensions()[0]-overlap_pad)*2), center_post_dimensions()[1], (base_width-center_post_dimensions()[0]*2)/2]);
    }
    translate([base_width/2, ((base_width/2+base_length/2)-center_post_dimensions()[1]/2)-overlap_pad,base_height+(base_width-center_post_dimensions()[0]*2)/2])
      rotate([270,0,0])
        cylinder(h=base_width+(overlap_pad*2),r=(base_width-center_post_dimensions()[0]*2)/2,$fn=radial_segments);

  }

module screw_holes()
  union () {
    translate([base_width/2,base_width/2-base_padding,0-overlap_pad])
      cylinder(h=base_height+(overlap_pad*10),r=screw_hole_radius,$fn=radial_segments);
    translate([base_width/2,base_width/2-base_padding,base_height-screw_sink_depth])
      cylinder(h=screw_sink_depth+10,r=screw_sink_radius,$fn=radial_segments);

    translate([base_width/2,base_width/2+base_length/2,0-overlap_pad])
      cylinder(h=base_height+(overlap_pad*10),r=screw_hole_radius,$fn=radial_segments);
    translate([base_width/2,base_width/2+base_length/2,base_height-screw_sink_depth])
      cylinder(h=screw_sink_depth+10,r=screw_sink_radius,$fn=radial_segments);

    translate([base_width/2,base_width/2+base_length+base_padding,0-overlap_pad])
      cylinder(h=base_height+(overlap_pad*10),r=screw_hole_radius,$fn=radial_segments);
    translate([base_width/2,base_width/2+base_length+base_padding,base_height-screw_sink_depth])
      cylinder(h=screw_sink_depth+10,r=screw_sink_radius,$fn=radial_segments);
  }

difference () {
  union () {
    create_base();
    near_post();
    far_post();
    center_posts();
  }
  screw_holes();
}