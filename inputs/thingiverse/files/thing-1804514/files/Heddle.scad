// A simple loom heddle

// Number of warp threads
warp_count = 29;

// Width of each thread (mm)
warp_diameter = 2;

// Total high of the heddle (mm)
heddle_height = 80;

// Edge-to-edge width of the heddle (mm)
heddle_width = 200;

// Thickness of the frame (horizontal) (mm)
heddle_frame_width_h = 5;

// Thickness of the frame (vertical) (mm)
heddle_frame_width_v = 5;

// 3D thickness (mm)
thickness_3d = 2;

//2D to make DXF files, 3D for STL
2Dv3D = "3D"; // [2D, 3D]

/* [Hidden] */
$fn = 60;
corner_radius = 4;
hole_size = warp_diameter * 2;

heddle_interior = [heddle_width - heddle_frame_width_h * 2,
                   heddle_height - heddle_frame_width_v * 2,
                   thickness_3d];
heddle_interior_offset = [heddle_frame_width_h, heddle_frame_width_v, 0];

tt = 0.1;

if (2Dv3D == "2D") {
  projection() heddle();
} else {
  heddle();
}

/**
 * A cube with rounded corners (in the x and y axes) of radius r.
 */
module cube_rounded_xy(size, r=1) {
  translate([r, r, 0]) {
    minkowski() {
      cube(size - [r*2, r*2, 0]);
      cylinder(r=r, h=0.00001);
    }
  }
}

module heddle() {
  // main heddle body
  difference() {
    cube_rounded_xy([heddle_width,
                     heddle_height,
                     thickness_3d],
                   corner_radius);

    for (i = [0 : warp_count - 1]) {
      x = i * (heddle_interior[0] - warp_diameter)/(warp_count-1);
      translate(heddle_interior_offset + [x, 0, -tt])
        if (i % 2 == 0) {
          cube_rounded_xy([warp_diameter,
                           heddle_interior[1],
                           thickness_3d + tt * 2],
                          warp_diameter/2.1);
        } else {
          translate([0, heddle_interior[1]/2 - hole_size/2, 0])
            cube_rounded_xy([warp_diameter,
                             hole_size,
                             thickness_3d + tt * 2],
                            warp_diameter/2.1);
        }
    }
  }
}
