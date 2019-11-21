
// Length of the sides in mm. Mesh is always square
side_length = 120;
// Height of the mesh in mm
height = 3;
// Diameter of each 'hole' in the mesh in mm
hole_diameter = 8;
// Amount of buffer space between the outer edge and the holes
border = 3.5;
// How close is each hole to neighbors
grid_spacing = 3; // [1:9]

// OpenSCAD variable for number of fragments in each hole - Below 7 will get you misc shapes while above makes circle approximations
$fn=10; // [3:30]

module mesh(side_length, height, hole_diameter, border, grid_spacing) {
  // Ensure the border is sane
  border = min(border, side_length / 2.5);
  size = side_length;

  // We can only place holes in the non-border, and 
  // each hole actually takes a bit of addl. spacing
  hole_footprint = hole_diameter * (1 + grid_spacing);
  s_avail = size - border*2;
  hole_count = ceil(s_avail / hole_footprint);  
  hole_r = hole_diameter / 2;

  // Diagnostic data
  echo(hole_footprint);
  echo(str("We have ", s_avail, "mm of space for holes"));
  echo(str("We will place ", hole_count, " holes"));
  echo(str("Each hole has a footprint of ", hole_footprint, "mm-squared"));

  union(){
    cube([size,border,height]);
    cube([border,size,height]);
    translate([size-border,0,0]) cube([border,size,height]);
    translate([0,size-border,0]) cube([size,border,height]);

    difference() {
      cube(size=[size, size, height]);
      
      translate([border + hole_r, border+hole_r, -1])
      for (x = [0:hole_count - 1]) {
        translate([x * hole_footprint, 0, 0])
        for (y = [0:hole_count - 1]) {
          translate([0, y * hole_footprint, 0])
          cylinder(r=hole_diameter / 2, h=height*4);
        }
      }
    }
  }
}

mesh(side_length, 
  height, 
  hole_diameter, 
  border, 
  grid_spacing / 10);


