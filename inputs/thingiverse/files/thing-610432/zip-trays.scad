
// Number of cells in the x direction
num_cells_x = 5; // [1:12]

// Number of cells in the y direction
num_cells_y = 7; // [1:12]

// Inside size of each cell in the x direction
cell_size_x = 9; // [0:100]

// Inside size of each cell in the y direction
cell_size_y = 9; // [0:100]

// Max height of the tray (including bottom)
tray_max_height = 30; // [0:100]

// Height at front
height_at_front = 20; // [0:100]

// The width of the zip tie (add a couple of mm)
zip_width = 6; // [3:10]

// The thickness of the zip tie
zip_thickness = 2; // [1:5]

// Distance between the angled zip holes
distance_between_holes = 50; // [20:200]

// radius of rounding of the bottom (should be less than half the minimum cell dimension)
rounding = 3; // [1:50]

// thickness of the vertical walls
sidewall = 1.6;

// thickness of the bottom
bottom = 1.2;

// resolution used to render curved surfaces (experiment with low resolutions, and render the final results with higher resolution settings)
resolution = 16; // [30:Low (12 degrees), 60:Medium (6 degrees), 120:High (3 degrees)]


////////////////////////////////////////////////////////////

module roundedCube(x, y, z, fillet)
{
	if (fillet <= 0) {
		cube([x,y,z], center=true);
	} else {
    assign (x = x/2-fillet, y = y/2-fillet, z = z/2-fillet) {
			hull() {
				for(xx = [-x,x]) {
					for(yy = [-y,y]) {
						for(zz = [-z,z]) {
							translate([xx,yy,zz]) {
								sphere(fillet);
							}
						}
					}
				}
			}
		}
	}
}


module zip_hole(length, width, height)
{
  translate([-length/2, -5, 0])
  linear_extrude(height=height)
  polygon(points=[
      [0, 0],
      [0, width],
      [length, 10],
      [length, 10 - width]]);
}


mount_thickness = sidewall * 2;
back_addition = zip_thickness + mount_thickness;

xoutside = cell_size_x * num_cells_x + sidewall * (num_cells_x + 1) + back_addition;
youtside = cell_size_y * num_cells_y + sidewall * (num_cells_y + 1);

angled_mount_width = zip_thickness + 1;
mount1_height = tray_max_height/4;
mount2_height = tray_max_height/4*3;

difference() {
  translate([0, 0, tray_max_height])
  difference() {
    roundedCube(xoutside, youtside, tray_max_height*2, rounding);
    for (x = [0:num_cells_x-1]) {
      for (y = [0:num_cells_y-1]) {
        translate([
            -xoutside/2 + (sidewall + cell_size_x/2) + x * (sidewall + cell_size_x) + back_addition,
            -youtside/2 + (sidewall + cell_size_y/2) + y * (sidewall + cell_size_y), 0]) {
          roundedCube(cell_size_x, cell_size_y, (tray_max_height - bottom)*2, rounding - sidewall);
        }
      }
    }
    // Angled top
    translate([xoutside/2, youtside/2 + .5, -tray_max_height]) {
      rotate([0, -90, 90])
      linear_extrude(height=youtside + 1)
      polygon(points=[
          [height_at_front, 0],
          [height_at_front, -1],
          [tray_max_height*2 + 1, -1],
          [tray_max_height*2 + 1, xoutside + 1],
          [tray_max_height, xoutside + 1],
          [tray_max_height, xoutside - back_addition]]);
    }
  }
  // Ziptie paths
  translate([-xoutside/2 + mount_thickness, -youtside/2 - .5, 0]) {
    translate([0, 0, mount1_height])
      cube([zip_thickness, youtside + 1, zip_width]);
    translate([0, 0, mount2_height])
      cube([zip_thickness, youtside + 1, zip_width]);
  }
  translate([-(xoutside/2 - sidewall) , 0, 0]) {
    translate([0, 0, mount1_height]) {
      translate([0, -distance_between_holes/2, 0])
      zip_hole(back_addition, zip_thickness*2, zip_width);
      mirror([1, 0, 0])
      translate([0, distance_between_holes/2, 0])
      zip_hole(back_addition, zip_thickness*2, zip_width);
    }
    translate([0, 0, mount2_height]) {
      translate([0, -distance_between_holes/2, 0])
      zip_hole(back_addition, zip_thickness*2, zip_width);
      mirror([1, 0, 0])
      translate([0, distance_between_holes/2, 0])
      zip_hole(back_addition, zip_thickness*2, zip_width);
    }
  }
}