// The OD of the tube about which the bracket will be secured
tube_diameter=19;

// The thickness of the shelf
shelf_thickness=12;

// Diameter of the screw holes for securing the tube and the shelf
screw_hole_diameter=3;

// Diameter of the hole at the bottom of the bracket, to be used for torsional reinforcement.
wire_hole_diameter=5;

// The thickness of the walls of the bracket
wall_thickness=5;

// Total height of the printed bracket
bracket_height=60;

// Angle at which the bracket extends to support the shelf. (A larger angle may require supports to print)
support_angle=35;

/* [Hidden] */
fudge=1;

adj_len=bracket_height - shelf_thickness - wall_thickness;
op_len = adj_len * tan(support_angle);

$fn=50;

difference() {
 cylinder(bracket_height, d=tube_diameter + (wall_thickness * 2), center=true); 
 cylinder(bracket_height + fudge, d=tube_diameter, center=true);
 translate([0 - (tube_diameter / 2) - (wall_thickness / 2), 0, 0])
   rotate([0, 90, 0])
     cylinder(wall_thickness + fudge, d=screw_hole_diameter, center=true);
 translate([0, 0 - (tube_diameter / 2) - (wall_thickness / 2), 0])
   rotate([90, 0, 0])
     cylinder(wall_thickness + fudge, d=screw_hole_diameter, center=true);
}


difference() {
    
  translate([(bracket_height / 2) + (tube_diameter / 2) - (wall_thickness / 2),
          (bracket_height / 2) + (tube_diameter / 2) - (wall_thickness / 2), 0]) 
    difference() {
      cube([bracket_height, bracket_height, bracket_height], center=true);
      translate([wall_thickness, wall_thickness, bracket_height - shelf_thickness])
        cube(bracket_height, center=true);
      translate([0 - (bracket_height / 2) + (op_len / 1.5) + wall_thickness,
                   0 - (bracket_height / 2) + ((wall_thickness + fudge / 2) / 2),
                   (bracket_height / 2) - (shelf_thickness / 2)])
           rotate([90, 0, 0])
             cylinder(wall_thickness + fudge, d=screw_hole_diameter, center=true);
      translate([0 - (bracket_height / 2) + ((wall_thickness + fudge / 2) / 2),
                  0 - (bracket_height / 2) + (op_len / 1.5) + wall_thickness,
                 (bracket_height / 2) - (shelf_thickness / 2)])
           rotate([0, 90, 0])
             cylinder(wall_thickness + fudge, d=screw_hole_diameter, center=true);
      translate([0 - (bracket_height / 2)  + (wire_hole_diameter),
                  0 - (bracket_height / 2)  + (wire_hole_diameter),
                 0 - (bracket_height / 5)])
           rotate([45, 90, 0])
             cylinder(tube_diameter * 2, d=wire_hole_diameter, center=true);
    }

  rotate([0,0,45])
    translate([(bracket_height / 2) + (tube_diameter / 2) + (wall_thickness),
         0, 0 - (bracket_height / 2)])
      translate([0 - bracket_height / 2, 0, 0]) 
        rotate([0, support_angle, 0])
          translate([bracket_height / 2, 0, 0])
            cube([bracket_height, bracket_height * 2, bracket_height * 3], center=true);

  rotate([0, 0, 45])
    translate([(bracket_height / 2) + (tube_diameter / 2) + wall_thickness + op_len,
          0, 0]) 
      cube([bracket_height, bracket_height * 2, bracket_height * 2], center=true); 
}

