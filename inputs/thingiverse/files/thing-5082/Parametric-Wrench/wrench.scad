include <MCAD/shapes.scad>

// http://www.engineersedge.com/iso_hex_head_screw.htm

size = 5.5;
height = 4;

bar_length = 10*size;

wall_size = max(4, size/4);



difference () {
 union () {
  // The outisde of the bit that actually holds the nut.
  rotate(a=30, v=[0, 0, 1])
   hexagon(height=height, size=size+wall_size*2);
  
  translate([0, size, 0])
   rotate(a=90, v=[0, 0, 1])
    cube([wall_size, size+wall_size*2, height], center=true);
  

  // The bar / handle
  translate([0, -bar_length/2, 0])
   cube([wall_size, bar_length, height], center=true);
 }
 
 union() {
  translate([-size/2, 0, -height/2-0.05])
   cube([size, size+wall_size, height+0.1]);

  rotate(a=30, v=[0, 0, 1])
   hexagon(height=height+0.1, size=size);
 }

}
