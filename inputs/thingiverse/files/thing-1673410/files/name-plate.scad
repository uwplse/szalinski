// name_plate.scad

echo(version=version());

// choose font
font = "Liberation Sans:style=Bold";

//define letter size and extrusion height

letter_size = 12;
letter_height = 3.5;

//Name variable

name = "Ruckus Employee #257";

//Create name

module letter(name) {
  // Use linear_extrude() to make the letters 3D objects as they
  // are only 2D shapes when only using text()
  linear_extrude(height = letter_height) {
    text(name, size = letter_size, font = font, halign = "center", valign = "center", $fn = 16);
  }
}


  union() {
    //Create plate and attach name 
     color("orange") linear_extrude(height = 1) {
            square([203, 50.8], center = true);}
   color("black") translate([0, 0, 0.5]) rotate([0, 0, 0]) letter(name);
   
  }