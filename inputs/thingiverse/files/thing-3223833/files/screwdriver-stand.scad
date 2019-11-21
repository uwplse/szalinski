$fn = 64;
$rows = 7;
$cols = 3;
$distance = 20;
$hole_dia = 6;

module rectangular_array(rows, cols, distance){
  for( i = [0:1:rows-1] ) {
    for( j = [0:1:cols-1] ) {
      translate([i*distance,j*distance,0])
      children();
    }
  }
}

difference() {
  minkowski() {
    cube([$rows*$distance,$cols*$distance,1]);
    sphere(1.5);
  }

  translate([10,10,-2])
    rectangular_array($rows,$cols,$distance)
      cylinder(8,d2=$hole_dia,d1=$hole_dia+2);
}

module leg() {
  minkowski() {
    difference() {
      cube([12,12,65]);
      translate([1,1,-2])
        cube([12,12,70]);
      translate([-1,-1,65])
        cube([14,14,2]);
      translate([13,-2,3]) rotate([0,-7,0]) cube([10,10,70]);
      translate([5,13,3]) rotate([0,-7,90]) cube([10,10,70]);
    }
    sphere(1.5);
  }
}

leg();
translate([$rows*$distance,0,0]) rotate([0,0,90]) leg();
translate([0,$cols*$distance,0]) rotate([0,0,-90]) leg();
translate([$rows*$distance,$cols*$distance,0]) rotate([0,0,180]) leg();

