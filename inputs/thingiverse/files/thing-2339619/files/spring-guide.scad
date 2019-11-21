// adjust this depend of how precise your printer is
tolerance = 0.4;

// inner diameter of the spring guide, == your spring diameter
inner_dia = 5;

// diameter of the bold
bold_dia = 2.8;

// height of the spring guide
height = 6;

// wall thickness of the guide
thickness = 2;

$fn=50;

difference() {
    // define some value
    cylinder(height, d = inner_dia + thickness);
    translate([0, 0, thickness])
        cylinder(height - thickness, d = inner_dia + tolerance);
    cylinder(height, d = bold_dia + tolerance + 0.1);
}