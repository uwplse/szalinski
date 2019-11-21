/* [Dimensions] */
//In mm, how wide should the spacer be??
spacer_width = 33.5; //[1:0.5:200]

//In mm, how long should the spacer be??
spacer_length = 95; //[1:0.5:200]

//In mm, how tall should the spacer be??
spacer_height = 51; //[1:0.5:200]

/* [Advanced] */
//In mm, how thick should the walls be?
thickness_of_walls = 1.5; //[1:0.1:5]

//In mm, what should the radius of the honeycomb be?
honeycomb_radius = 9.9; //[1:0.1:100]

// ########## Project Space #########
w_offset = thickness_of_walls * 2;

difference() {
  cube([spacer_width, spacer_length, spacer_height]);
  translate([thickness_of_walls, thickness_of_walls, thickness_of_walls]) {
    cube([spacer_width - w_offset, spacer_length - w_offset, spacer_height]);
  }
}

linear_extrude(spacer_height) honeycomb_square([spacer_width, spacer_length], honeycomb_radius, thickness_of_walls, false);

// ############ Modules #############
module honeycomb(r, thickness=1, cols=0, rows=0, center=false) {
  translate([ // if center is true, calculate total size and translate accordingly
    center ? ( cols * r / tan(30) + (r + thickness) / tan(30) / 2 ) /-2 : 0,
    center ? ( rows * r * sin(30) + (rows+0.5) * r + thickness ) /-2 : 0
  ])
  translate([ (r+thickness/2) / 2 / tan(30), r+thickness/2])  // Move so it starts at 0, 0
  for (j = [ 0 : 1 : rows-1 ] ) {  // Iterate rows
    translate([ r / 2 / tan(30) * (j%2) , j * (r + r * sin(30)) ])
    for (i = [ 0 : 1 : cols-1 ]) { // Iterate columns
      translate([ i * ( r / tan(30) ) , 0]) rotate([0, 0, 90]) {

        // Make the hexagons
        if (thickness==0) {
          circle(r, $fn=6);
        }
        else {
          difference() {
            circle(r+thickness/2, $fn=6);
            circle(r-thickness/2, $fn=6);
          }
        }
      }
    }
  }
}

module honeycomb_square(dimensions = [10, 10], r=1, thickness=1, center=false) {
  
  intersection() {
    translate([r * -1, 0, 0])
    honeycomb(r=r, thickness=thickness,
      cols = (dimensions[0] - (r + thickness) / tan(30) / 2) / (r / tan(30)) + 2,
      rows = dimensions[1] / (r*2 - thickness) + 1,
      center=center);
   
    square(dimensions, center=center); 
  }
}
