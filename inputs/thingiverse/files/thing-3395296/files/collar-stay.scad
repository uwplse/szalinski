// Super simple collar stay, a userful but super simple print.
// Remember to print two :)

// all measurements in mm

// thickness of collar stay, typically 1mm or a little more
thickness=1; 
// total length of collar stay. Try 60mm if unsure
total_length=60;
// length of the triangular tip. Try 15mm if unsure.
tip=15;
// width of collar stay. 10mm is typical, but I've seen 8mm - 12mm
width=10;

// Customizable variables end here


module collar_stay(_thickness, _total_length, _tip, _width) {
  end_radius=_width/2;
  cube_l=_total_length - end_radius - _tip;
  cylinder(r=end_radius, h=_thickness, center=true);
  translate([cube_l/2,0,0])
    cube([cube_l, _width, _thickness], center=true);
  translate([cube_l, 0, 0])
    linear_extrude(height=_thickness, center=true) polygon(points=[[0, -_width/2], [0, _width/2], [_tip, 0]]);
}

collar_stay(thickness, total_length, tip, width);