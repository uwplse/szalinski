// length of edge of cube in mm
size = 15;
// hole diameter in mm
hole = 4;

$fs = 0.2;

module burr_cube()
{  
  module rotcy(rot, r, h, shift) {
    translate(shift) 
        rotate(90, rot)
            cylinder(r = r, h = h, center = true);
  }
  
  cy_r = hole/2;
  cy_h = (size * 1.1);
  x = hole + 0.001;
  
  difference() {
    cube(size = size, center = true);
    rotcy([0, 0, 0], cy_r, cy_h, [0, x, 0]);
    rotcy([0, 0, 0], cy_r, cy_h, [0, -x, 0]);
      
    rotcy([1, 0, 0], cy_r, cy_h, [x, 0, 0]);
    rotcy([1, 0, 0], cy_r, cy_h, [-x, 0, 0]);  
      
    rotcy([0, 1, 0], cy_r, cy_h, [0, 0, x]);
    rotcy([0, 1, 0], cy_r, cy_h, [0, 0, -x]);  
  }

}

burr_cube();


