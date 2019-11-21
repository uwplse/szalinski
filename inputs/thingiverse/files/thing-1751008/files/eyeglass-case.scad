// Eyeglass Case
// by HarlemSquirrel
// http://www.thingiverse.com/HarlemSquirrel

// *** Variables ***
// *****************

// The gap between the two halves in mm
buffer = 0.4; //[0.1:0.1:0.6]
// The height of each half in mm
inside_height = 100; //[50:150]
// The inside length in mm
inside_length = 50; //[10:60]
// The inside width in mm
inside_width = 30; //[10:60]
// The thickness of the walls
wall_thickness = 1; // [0.1:0.1:1]


// *** Modules ***
// ***************
module half(i_height, i_length, i_width) {
  difference() {
    resize([0,i_width+(wall_thickness*2),0])
    cylinder(h=i_height, d=i_length);
    
    translate([0,0,wall_thickness])
    resize([0,i_width,0])
    cylinder(
      h=i_height+wall_thickness, 
      d=i_length - (wall_thickness*2)
    );
  }
}

module make_halves() {
  //inside_half
  translate([0,-inside_width,0]) {
    half(inside_height, inside_length, inside_width);
    
    // lip
    linear_extrude(wall_thickness)
    resize([0, inside_width+(wall_thickness*4), 0])
    circle(d=inside_length+ (wall_thickness*2));
  }
  

  //outside_half
  translate([0,inside_width,0])
  half(
    inside_height, 
    inside_length + (wall_thickness*2) + buffer*2, 
    inside_width + (wall_thickness*2) + buffer*2
  );
}


make_halves();
//resize([0,40,0]) cylinder(h=100, d=20);