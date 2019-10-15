// Number of facets on each hole.
facets=100;

// The diameter of the smallest hole.
base_hole = 12.0;

// How much to increase the size of each hole.
step = 0.1;

// How many holes to make.
count = 4;

// How much space between each hole.
pad = 5;

// How thick should the block be.
block_thickness = 5;

// How wide the block should be.
// Big enough for the widest hole plus padding on each side.
block_width = base_hole + step*count + pad*2;

// How long the block should be.
// Size of the smallest hole * the number of holes +
// 1 pad for each hole (plus 1 more for the end) +
// the accumulated growth of each hole (sum of arithemetic sequence).
block_length = (base_hole + pad + (step + step*count)/2) * count + pad;

difference() {
  // The block
  cube([block_length,block_width,block_thickness], false);
  
  // The holes
  union() {
    for(i=[0:count-1]) {
      // Offset for each hole is the same as the length calculation
      // except for the current index instead of the total.
      translate([(base_hole + pad + (step + step*i)/2)*i + base_hole/2 + pad,block_width/2,-1]) {
        // Hole size is just the smallest hole size plus the step times
        // index.
        cylinder(d=base_hole+step*i, h=block_thickness+2, $fn=facets);
      }
    }
  }
}
