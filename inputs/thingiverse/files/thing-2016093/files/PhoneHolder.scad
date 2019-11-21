phone_height = 120;
phone_width = 90;
phone_thickness = 20;
shelf_angle = 10;
shelf_width_percentage = 66;  // Recommend > 50
number_of_shelves = 6;
thickness = 1.6;
sides = 1;  // [0:No, 1:Left, 2:Right, 3:Both]
tabs = 1;  // [0:No, 1:Yes]
tab_width = 15;
tab_height = 20;
tab_hole_diameter = 4;

width_adjusted = phone_width * shelf_width_percentage / 100 + phone_thickness / tan(90 - shelf_angle);
echo(width_adjusted=width_adjusted);
height_adjusted = phone_thickness / sin(90 - shelf_angle);
echo(height_adjusted=height_adjusted);
bottom_tab_offset = -number_of_shelves * (height_adjusted + thickness);
$fn = 30;

module shelf(length, width, height, thickness, shelf_angle, sides) {
  delta_y = sin(shelf_angle) * width;
  echo(delta_y = delta_y);
  delta_z = cos(shelf_angle) * width;
  echo(delta_z = delta_z);
  polyhedron([
    [0, 0, thickness],
    [0, thickness, thickness],
    [length, thickness, thickness],
    [length, 0, thickness],
    [0, delta_y, thickness + delta_z],
    [0, delta_y + thickness, thickness + delta_z],
    [length, delta_y + thickness, thickness + delta_z],
    [length, delta_y, thickness + delta_z]],
    [
    [0, 3, 2, 1],  // Bottom
    [0, 1, 5, 4],  // Back
    [4, 5, 6, 7],  // Top
    [2, 3, 7, 6],  // Front
    [0, 4, 7, 3],  // Left
    [1, 2, 6, 5]]);  // Right
  if (sides == 1 || sides == 3) {
    polyhedron([
      [0, thickness, thickness],
      [0, thickness + height, thickness],
      [thickness, thickness + height, thickness],
      [thickness, thickness, thickness],
      [0, delta_y + thickness, thickness + delta_z],
      [0, delta_y + thickness + height, thickness + delta_z],
      [thickness, delta_y + thickness + height, thickness + delta_z],
      [thickness, delta_y + thickness, thickness + delta_z]],
      [
      [0, 3, 2, 1],  // Bottom
      [0, 1, 5, 4],  // Back
      [4, 5, 6, 7],  // Top
      [2, 3, 7, 6],  // Front
      [0, 4, 7, 3],  // Left
      [1, 2, 6, 5]]);  // Right
  }
  if (sides == 2 || sides == 3) {
    polyhedron([
      [length - thickness, thickness, thickness],
      [length - thickness, thickness + height, thickness],
      [length, thickness + height, thickness],
      [length, thickness, thickness],
      [length - thickness, delta_y + thickness, thickness + delta_z],
      [length - thickness, delta_y + thickness + height, thickness + delta_z],
      [length, delta_y + thickness + height, thickness + delta_z],
      [length, delta_y + thickness, thickness + delta_z]],
      [
      [0, 3, 2, 1],  // Bottom
      [0, 1, 5, 4],  // Back
      [4, 5, 6, 7],  // Top
      [2, 3, 7, 6],  // Front
      [0, 4, 7, 3],  // Left
      [1, 2, 6, 5]]);  // Right
  }
}

module tab(width, height, thickness, diameter, left_side) {
  difference() {
    union() {
      translate([left_side ? width * 0.5 : 0, 0, 0]) {
        cube([width * 0.5, height, thickness]);
      }
      translate([width * 0.5, height * 0.5, 0]) scale([width / height, 1, 1]) {
        cylinder(h=thickness, r=height * 0.5);
      }
    }
    translate([width * 0.5, height * 0.5, -thickness * 0.1]) {
      cylinder(h=thickness * 1.2, r=diameter * 0.5);
    }
  }
}


module left_tab(width, height, thickness, diameter) {
  tab(width, height, thickness, diameter, 1);
}


module right_tab(width, height, thickness, diameter) {
  tab(width, height, thickness, diameter, 0);
}


// Top shelf
shelf(phone_height + 2 * thickness, width_adjusted,
      height_adjusted, thickness, shelf_angle, 0);
cube([phone_height + 2 * thickness, thickness, thickness]);
if (tabs) {
  translate([-tab_width, thickness - tab_height, 0]) {
    left_tab(tab_width, tab_height, thickness, tab_hole_diameter);
  }
  translate([2 * thickness + phone_height, thickness - tab_height, 0]) {
    right_tab(tab_width, tab_height, thickness, tab_hole_diameter);
  }
}

for(ii = [1:number_of_shelves]) {
  translate([0, -ii * (height_adjusted + thickness), 0]) {
    cube([phone_height + 2 * thickness,
          height_adjusted + thickness, thickness]);
    shelf(phone_height + 2 * thickness, width_adjusted,
          height_adjusted, thickness, shelf_angle, sides);
  }
}
if (tabs) {
  translate([-tab_width, bottom_tab_offset, 0]) {
    left_tab(tab_width, tab_height, thickness, tab_hole_diameter);
  }
  translate([2 * thickness + phone_height, bottom_tab_offset, 0]) {
    right_tab(tab_width, tab_height, thickness, tab_hole_diameter);
  }
}