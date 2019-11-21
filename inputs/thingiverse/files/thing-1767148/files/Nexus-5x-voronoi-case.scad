use <nexus_5x_case.scad>;
use <voronoi.scad>;

n_points = 18;
seed = 70;

difference() {
  nexus_5x_cover();
      
  width = 72.5;

  min = 5;
  max = width-5;

  xs = rands(min, max, n_points, seed);
  ys = rands(min, max, n_points, seed+1);

  xys=[for (i = [0:n_points-1])  [xs[i], ys[i]]];
  lower_points = [
      [-5, 5],
      [5, -5],
      [width+5, 5],
      [width-5, -5],
  ];
  higher_points = [
     // Camera
//     [width/2, 126],
     // Scanner
  //   [width/2, 103.3],
     [28, 90],
     [23, 95],
     [22, 100],
     [23, 110],
     [24, 115],
     [26, 120],
//     [28, 128],
     [42, 90],
     [50, 95],
     [51, 100],
     [50, 110],
     [49, 115],
     [47, 120],
     [45, 128],

     [-10, 112],
     [-2, 123],
     [2, 137],
     [23, 146],
     [73, 142],
     [45, 138],
     [68, 145],
     [78, 115],
     [77, 127],
  ];
  point_set = 
    concat(
      lower_points,
/*
     [13, 20],
     [13, 60],
     [15, 40],
     [30, 30], 
     [32, 7],
     [36, 34],
     [40, 58],
     [45, 18],
     [53, 50],
     [53, 73],
     [62, 25],
  */
      xys,
      higher_points
    );
  echo(point_set);
  intersection() {
    translate([11,11,-5])
      round([72.5-23, 146.85-23, 10], 10);
    difference() {
      translate([0,0,-2])
        linear_extrude(4)
          voronoi(points=point_set, thickness=1.3, round=1.7, nuclei=false);
      // Camera
      translate([width/2, 126, -4])
        cylinder(d=26, h=8);
      // Fingerprint scanner
      translate([width/2, 103.3, -4])
        cylinder(d=22, h=8);
      // Flash
      translate([56, 126, -4])
        cube([17, 15, 8], center=true);
    }
  }
}
