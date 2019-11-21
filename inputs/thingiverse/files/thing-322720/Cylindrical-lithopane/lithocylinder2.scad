// preview[view:west, tilt:top]

// Desired height of cylinder. Image will scaled to fit in the height, with the radius set so that the width takes up one half of it.
cylinder_height = 60;

// Desired thickness of embossed region.
image_thickness = 2;

// Select "outside" to get the image on the outside of the cylinder.
direction = "inside"; // [inside, outside]

// Use http://customizer.makerbot.com/image_surface?image_x=81&image_y=61 to generate.
// Check invert colors if printing on the inside. Leave uninverted for the outside.
surface_file = "surface.dat"; // [image_surface:81x61]

// Select "light" if your (uninverted) image has a light background.
background = "dark"; // [dark, light]

// Need to leave one extrusion width all the way around so there will be no holes.
extrusion_width = 0.4;

// More gives higher resolution cylinder, but takes longer and may crash OpenSCAD. Use an odd number.
n_facets = 21;

/* [Hidden] */
// Change these if you are providing a larger than default surface file.
image_width = 81;
image_height = 61;

slop = 0.1;
surface_width = cylinder_height / image_height * image_width;
cylinder_r = surface_width / PI;
step_distance = surface_width / n_facets;
step_degree = 180 / n_facets;
$fn = n_facets * 2;

module emboss(step = 0) {
  difference() {
    if (step < n_facets) rotate([0, 0, -step_degree]) emboss(step + 1) child();
    else child();

    image_surface(step * step_distance);
  }
}

// We want the non-image side to meld into the image, so for dark backgrounds
// we cut in full black, and for light backgrounds cut in full white.
module backside_cutter() {
  difference() {
    cylinder(h=cylinder_height + 4*slop, r=cylinder_r + slop, center=true);

    if (background == "dark" && direction == "inside" || background == "light" && direction == "outside") cylinder(h=cylinder_height + 6*slop, r=cylinder_r - image_thickness - extrusion_width, center=true);
    else cylinder(h=cylinder_height + 6*slop, r=cylinder_r - extrusion_width, center=true);

    translate([-cylinder_r - 2*slop, -cylinder_r - 2*slop, -cylinder_height/2 - 3*slop])
    cube([cylinder_r + 2*slop, 2 * (cylinder_r + 2*slop), cylinder_height + 6*slop]);
  }
}

module blank() {
  difference() {
    cylinder(h=cylinder_height + 2*slop, r=cylinder_r, center=true);
    backside_cutter();
  }
}

module scaled_surface() {
  rotate([90, 0, 0])
  // Translate inward by extrusion width so there can be no holes for pure white.
  translate([0, 0, extrusion_width])
  scale([surface_width/(image_width - 1), (cylinder_height + 2*slop)/(image_height - 1), image_thickness])
  translate([image_width - 1, 0, 0])
  mirror([1, 0, 0])
  surface(file=surface_file, convexity = 5);
}

module image_surface(x) {
  translate([-x, cylinder_r * cos(step_degree/2), -cylinder_height/2 - slop]) scaled_surface();
}

if (direction == "outside") {
  intersection() {
    difference() {
      emboss() blank();
      cylinder(h=cylinder_height + 2*slop, r=cylinder_r - image_thickness - 2*extrusion_width, center=true);
    }
    cube([2*(cylinder_r + slop), 2*(cylinder_r + slop), cylinder_height], center=true);
  }
}
else {
  difference() {
    cylinder(h=cylinder_height, r=cylinder_r, center=true);
    emboss() blank();
  }
}
