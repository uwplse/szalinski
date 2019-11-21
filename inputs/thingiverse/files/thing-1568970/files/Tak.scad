// choose a piece to print
piece = "black capstone"; // [white flatstone,black flatstone,white capstone,black capstone]
// the width of your print bed (x axis)
print_bed_width = 108; // [20:1000]
// the depth of your print bed (y axis)
print_bed_depth = 108; // [20:1000]
// maximum number of pieces to print
print_count = 2; // [1:139]
// if it's too high, the flatstones won't be able to stand on edge
edge_roundness = 0.4; //[0:0.01:1]



// clamp function, ensures a value is within a certain range:
// [clamp(0,[3:5]), clamp(4,[3:5]), clamp(6,[3:5])]
// results in: [3,4,5]
function clamp(val,rng) = max(rng[0],min(rng[2],val));

// measurements
in = 254/10;

// The white flatstones: a flat trapezoidal prism
module tak_white_flatstone(roundness){
  r = clamp(roundness,[0:0.99999999])*3/16*in;
  color("white") minkowski(){
    translate([0,0,r]) linear_extrude(3/8*in-2*r){
      polygon([
        [0+r, 0+r],
        [5/4*in-r, 0+r],
        [1*in-r,1*in-r],
        [1/4*in+r,1*in-r]
      ]);
    }
    sphere(d=r*2, $fs=0.25);
  }
}

// the black flatstones; a circle with a flattened edge
module tak_black_flatstone(roundness){
  r = clamp(roundness,[0:0.99999999])*3/16*in;
  color("grey") minkowski(){
    translate([0,0,r]) intersection(){
      translate([5/8*in,3/8*in,0])
        cylinder(h=3/8*in-2*r, d=5/4*in-2*r, $fa=0.25);
      translate([0,r,0]) cube([2*in,2*in,2*in]);
    }
    sphere(d=r*2, $fs=0.25);
  }
}

// the white capstones, truncated pyramid
module tak_white_capstone(roundness){
  r = clamp(roundness,[0:0.99999999])*3/16*in;
  color("white") minkowski(){
    translate([5/8*in,5/8*in,r]) rotate([0,0,45])
      cylinder(
        d1=(5/4*in-2*r)*sqrt(2),
        d2=(3/4*in-2*r)*sqrt(2),
        h=1*in-2*r, $fn=4
      );
    sphere(d=r*2, $fs=0.25);
  }
}

// the black capstones, sphere with flattened base
module tak_black_capstone(roundness){
  r = clamp(roundness,[0:0.99999999])*3/16*in;
  color("grey") minkowski(){
    intersection(){
      translate([5/8*in,5/8*in,3/8*in]) sphere(d=5/4*in-2*r, $fa=0.25);
      translate([0,0,r]) cube([2*in,2*in,2*in]);
    }
    sphere(d=r*2, $fs=0.25);
  }
}

module tak_stone(type, roundness){
  if(type=="white flatstone")
    tak_white_flatstone(roundness=roundness);
  if(type=="black flatstone")
    tak_black_flatstone(roundness=roundness);
  if(type=="white capstone")
    tak_white_capstone(roundness=roundness);
  if(type=="black capstone")
    tak_black_capstone(roundness=roundness);
}

// lay them out
for(i=[0:print_count-1]){
  wc = floor(print_bed_width/(1.25*in+2)); // how many wide we can go (x axis)
  dc = floor(print_bed_depth/(1.25*in+2)); // maximum rows deep (y axis)
  pos = [i%wc, floor(i/wc),0];// grid position for this stone (x,y)
  if(i<wc*dc)
    translate(pos*(1.25*in+2)) tak_stone(piece, edge_roundness);
}
  
  