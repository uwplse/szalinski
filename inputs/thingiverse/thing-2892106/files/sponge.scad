// Cutat the bottom, for no supports needed?
Bottom_cut = "yes";//[yes,no]
// Size of edge of sponge in mm
D=50;
// Fractal depth (number of iterations(cubes))
n=3;



module menger() {
  difference() {
    cube(D, center=true);
    for (v=[[0,0,0], [0,0,90], [0,90,0]])
      rotate(v) menger_negative(side=D, maxside=D, level=n);
  }
}

module menger_negative(side=1, maxside=1, level=1) {
  l=side/3;
  cube([maxside*1.1, l, l], center=true);
  if (level > 1) {
    for (i=[-1:1], j=[-1:1])
      if (i || j)
        translate([0, i*l, j*l])
          menger_negative(side=l, maxside=maxside, level=level-1);
  }
}


if (Bottom_cut == "yes"){
difference() {
  rotate([45, atan(1/sqrt(2)), 0]) menger();
  translate([0,0,-D]) cube(2*D, center=true);
}

}
else{
    menger();
}
