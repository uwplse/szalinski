// Script to create a knob for a fan, heater, etc.
// http://www.thingiverse.com/thing:2220561

// Number of sides for polygon cylinder approximation
$fn=30; 

/* [Test fit model parameters] */
// Whether a test fit model should be generated instead of the full model
test_fit_model = "no"; // [yes:Yes, no:No]
// Height of the test fit model generated
knob_test_height = 1; 

/* [Main body options and dimensions] */
// Total height of the knob excluding the rounded top if applicable
knob_height = 20; 
// Diameter of the bottom section of the knob
knob_diameter = 30; 
// Fraction of knob height below chamfer
knob_bot_height_fraction = .1; 
// Fraction of knob height used for chamfer
knob_chamfer_height_fraction = .05; 
// Fraction of knob_diameter to be used for the diameter of the top of the knob (>0.0)
knob_top_daimeter_fraction = .95; 
// To be equally spaced around the top of the knob's perimeter
number_of_cutouts = 16; 
// Fraction of the diameter of the knob (knob_diameter)
diameter_of_cutouts = .1;
rounded_top = "no"; // [yes:Yes, no:No]
rounded_top_radius_multiplier = 5;

/* [Hole/Shaft options and dimensions] */
hole_type = "circle"; // [circle:Circle, polygon:Polygon]
// Diameter or side length of the hole (absolute)
hole_dimension = 0; 
// Fraction of total height (knob_height not including rounded top)
hole_height_fraction = .5; 
/* [Polygon hole only options] */
// Number of sides for the hole polygon (>= 3)
n_polygon_sides = 4; // [3:10]
/* [Circle hole only options] */
circle_hole_subtype = "full"; // [full:Full, D:D, keyway:Keyway]
// Fraction of the circle to be cutoff if the D subtype is selected
hole_cutoff_fraction = .4; 
// Width of the keyway (absolute)
hole_key_width = .5;
// Depth at edge intersection with circle (positive to cut notch into cylinder, negative to add a notch on the outside of the cylinder) (absolute)
hole_key_depth = .5; 

/* [Location indicator mark options] */
// Yes will cut a half circle mark into the knob and no will add a half circle mark to the outside of the knob
mark_cutout = "yes"; // [yes:Yes, no:No]
top_location_mark = "yes"; // [yes:Yes, no:No]
side_bot_location_mark = "yes"; // [yes:Yes, no:No]
side_top_location_mark = "yes"; // [yes:Yes, no:No]
// Degrees starting from the x-axis (cutouts will be rotated so the mark falls between them)
mark_angle = 0; 
// Fraction of knob_diameter
mark_diameter_fraction = .05; 

// End data input
// Some calculated quantities
knob_r = knob_diameter / 2;
knob_r2 = knob_top_daimeter_fraction * knob_r;
cutout_angle = 360 / number_of_cutouts;
knob_bot_height = knob_height * knob_bot_height_fraction;
knob_chamfer_height = knob_height * knob_chamfer_height_fraction;
knob_chamfer_top_height = knob_bot_height + knob_chamfer_height;
knob_cutout_height = knob_height - knob_chamfer_top_height;
cutout_offset_angle = cutout_angle - mark_angle - cutout_angle*floor(mark_angle/cutout_angle) - cutout_angle/2;
chamfer_angle = atan((knob_r-knob_r2)/knob_chamfer_height);

rounded_top_radius = rounded_top_radius_multiplier*knob_r2;
// Calculate the z offset for the sphere so that just
//  the desired portion is above the z=0 plane
z_offset = sqrt(rounded_top_radius*rounded_top_radius - knob_r2*knob_r2);
// Calculate the height of the knob including the rounded top
knob_max_height = knob_height + rounded_top_radius - z_offset;

module main_body() {
  if (test_fit_model == "no") {
    difference() {
      union() {
        cylinder(r=knob_r, h=knob_bot_height);
        translate([0, 0, knob_bot_height])
          cylinder(r1=knob_r, r2=knob_r2, h=knob_chamfer_height);
        translate([0, 0, knob_chamfer_top_height])
          cylinder(r=knob_r2, h=knob_cutout_height);
        if (rounded_top == "yes") {
          translate([0, 0, knob_height])
            intersection() {
              translate([0, 0, -z_offset])
                sphere(r=rounded_top_radius, $fn=2*$fn);
              cylinder(r=knob_r2, h=knob_height);
            };
        };
      };
      if (knob_r >= knob_r2) {
        for(i = [0:number_of_cutouts-1]) {
          translate([knob_r2*cos(i*cutout_angle-cutout_offset_angle), knob_r2*sin(i*cutout_angle-cutout_offset_angle), knob_chamfer_top_height])
            cylinder(d=diameter_of_cutouts*knob_diameter, h= knob_cutout_height * 1.5);
        }
      }
      else {
        for(i = [0:number_of_cutouts-1]) {
          translate([knob_r2*cos(i*cutout_angle-cutout_offset_angle), knob_r2*sin(i*cutout_angle-cutout_offset_angle), knob_bot_height])
            cylinder(d=diameter_of_cutouts*knob_diameter, h= knob_height * 1.5);
        }
      }
    };
  }
  else {
    cylinder(r=knob_r, h=knob_test_height);
  }
};
//main_body();

module hole() {
  hole_dim = hole_dimension;
  hole_height = knob_height * hole_height_fraction;
  key_offset = sqrt((hole_dim*hole_dim-hole_key_width*hole_key_width)/4);
  if (hole_type == "circle") {
    difference() {
      union() {
        translate([0, 0, -.1])
          cylinder(d=hole_dim, h = hole_height+.1);
        if (circle_hole_subtype == "keyway" && hole_key_depth < 0) {
          translate([key_offset, -hole_key_width/2, -.1])
            cube([-hole_key_depth, hole_key_width, hole_height+.1]);
        }
      }
      if (circle_hole_subtype == "D") {
        translate([hole_dim/2 - hole_dim*hole_cutoff_fraction, -hole_dim/2, -.2])
          cube([hole_dim, hole_dim, hole_height+.4]);
      }
      else if (circle_hole_subtype == "keyway"){
        translate([key_offset - hole_key_depth, -hole_key_width/2, -.2])
          cube([hole_dim, hole_key_width, hole_height+.4]);
      }
    }
  }
//  else if (hole_type == "square") {
//    translate([-hole_dim/2, -hole_dim/2, -.1])
//    cube([hole_dim, hole_dim, hole_height+.1]);
//  }
  else if (hole_type == "polygon") {
    if (n_polygon_sides < 3) {
      DisplayText("ERROR - the number of polygon points must be at least 3 for polygon holes.");    
    }
//    // Determine the radius of the circle on which the polygon will be inscribed
    r_hole = hole_dim / (2*sin(180/n_polygon_sides));
//    angle1 = 360 / n_polygon_sides;
//    // Calculate the points of the polygon using trig  
//    poly_points = [for (i = [0:n_polygon_sides-1]) let (x = r_hole*cos(i*angle1), y = r_hole*sin(i*angle1)) [x, y] ];
//    linear_extrude(height=2*hole_height, center=true)
//      polygon(points=poly_points);
    cylinder(r=r_hole, h=2*hole_height, center=true, $fn=n_polygon_sides);
  }
}
//hole();

module marks() {
  mark_r = knob_r * mark_diameter_fraction;
  x_edge = knob_r*cos(mark_angle);
  y_edge = knob_r*sin(mark_angle);
  x_edge2 = knob_r2*cos(mark_angle);
  y_edge2 = knob_r2*sin(mark_angle);
  
  x_edge3 = (knob_r)*cos(mark_angle);
  y_edge3 = (knob_r)*sin(mark_angle);
  x_edge4 = (knob_r2)*cos(mark_angle);
  y_edge4 = (knob_r2)*sin(mark_angle);
  
  x_edge5 = mark_r*cos(mark_angle);
  y_edge5 = mark_r*sin(mark_angle);
  if (test_fit_model == "no") {
    if (top_location_mark == "yes") {
      if (rounded_top == "yes") {
        angle1 = 360*mark_r/(2*rounded_top_radius*PI);
        angle2 = atan((knob_r2)/z_offset)+angle1/2;
        echo(angle1, angle2);
        translate([0, 0, knob_max_height+mark_r])
          color("RoyalBlue")
            rotate([0, 0, mark_angle-90])
              rotate([0, -90, 0])
                wedge_slice(mark_r, rounded_top_radius, angle1, angle2);
        translate([x_edge5, y_edge5, knob_max_height])
          color("RoyalBlue")
            sphere(r=mark_r);
      }
      else {
        translate([x_edge2, y_edge2, knob_height])
          color("RoyalBlue")
            rotate([0, 0, 180+mark_angle])
              rotate([0, 90, 0])
                cylinder(r=mark_r, h=knob_r2-mark_r);
        translate([x_edge5, y_edge5, knob_height])
          color("RoyalBlue")
            sphere(r=mark_r);
      }
    }
    if (side_bot_location_mark == "yes") {
      translate([x_edge, y_edge, -.1])
        color("RoyalBlue")
          cylinder(r=mark_r, h=knob_bot_height+.1);
    }
    if (side_top_location_mark == "yes") {
      translate([x_edge2, y_edge2, knob_chamfer_top_height])
        color("RoyalBlue")
          cylinder(r=mark_r, h=knob_cutout_height+.1);
      translate([x_edge2, y_edge2, knob_height])
        color("RoyalBlue")
          sphere(r=mark_r);  
    }
    if (side_bot_location_mark == "yes" || side_top_location_mark == "yes") {
      difference() {
        union() {
          // Bottom shpere
          translate([x_edge3, y_edge3, knob_bot_height])
            color("RoyalBlue")
              sphere(r=mark_r);   
          // Top sphere
          translate([x_edge4, y_edge4, knob_chamfer_top_height])
            color("RoyalBlue")
              sphere(r=mark_r);
          // Chamfer mark cylinder
          translate([x_edge, y_edge, knob_bot_height])
            color("RoyalBlue")
              rotate([0, 0, 180+mark_angle])
                rotate([0, chamfer_angle, 0])
                  cylinder(r=mark_r, h=(knob_r-knob_r2)/sin(chamfer_angle));
        }
        if (side_top_location_mark == "no") {
          if (knob_r >= knob_r2) {
            cylinder(r=knob_r2, h=knob_height);
          }
          else {
            translate([0, 0, knob_chamfer_top_height])
              cylinder(r=knob_r2, h=knob_cutout_height);
          }
        }
      }
    }
  }
  else {
    // Top
    translate([x_edge, y_edge, knob_test_height])
      color("RoyalBlue")
        rotate([0, 0, 180+mark_angle])
          rotate([0, 90, 0])
            cylinder(r=mark_r, h=knob_r-mark_r);
    // Corner
    translate([x_edge3, y_edge3, knob_test_height])
      color("RoyalBlue")
        sphere(r=mark_r);
    // Side
    translate([x_edge, y_edge, -.1])
      color("RoyalBlue")
        cylinder(r=mark_r, h=knob_test_height+.1);
  }
}
//marks();

module wedge_slice(radius1, radius2, angle1, angle2) {
  // Generate a cylindrical wedge slice of requested radius and angle
  // New versions Openscad can do this trivially with the angle argument for rotate extrude...
//  rotate_extrude(angle=angle1)
//   translate([radius2, 0]) circle(r=radius1);
  wedge_length = (radius1+radius2);
  wedge_height1 = wedge_length*sin(angle1);
  wedge_height2 = wedge_length*sin(angle2);
  translate([-wedge_length, 0, 0])
    intersection() {
      rotate_extrude($fn=2*$fn) translate([radius2, 0]) circle(r=radius1);
      linear_extrude(height=2*radius1, center=true)
        polygon([[0, 0], [wedge_length, wedge_height2], [wedge_length, wedge_height1]]);
  }
}

module DisplayText(s) {
  // Borrowed from https://www.thingiverse.com/thing:1695289
  rotate([0,0,45])
    rotate([80,0,0])
      text(s, font = "Liberation Sans");
  echo();
  echo(s);
  echo();
}

module knob() {
  if (mark_cutout == "yes") {
    difference() {
      main_body();
      hole();
      difference() {
        marks();
        // Subtract off an enlarged hole to ensure the mark doesn't interfere with test fitting
        if (test_fit_model == "yes") scale([1.3, 1.3, 1]) hole();
      }
    }
  }
  else {
    difference() {
      union() {
        main_body();
        difference() {
          marks();
          if (test_fit_model == "yes") scale([1.3, 1.3, 1]) hole();
        }
      }
      hole();
    }
  }
}

knob();