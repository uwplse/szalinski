tileHeight = 3; // [2:20]
tileWidth = 40;  // [10:300]

/* [Hidden] */
$vpr = 0;
$vpt = [0, 0, 0];
$vpd = 400;

module tri() {
  translate([tileWidth / 2, 0, 0])
   cylinder(r = tileWidth, h = tileHeight, $fn = 3);
}

module poly() {
  translate([0, 0, 0]) {
    tri();
    mirror([1, 0, 0]) tri();
  }
}

module lines(length, height, width = 1, step = 1, fn = 4, rotation = 0) {
  start = step / 2;
  end = ceil(length / step);
  rotate([90, 0, 0])
  translate([0, 0, -height])
  union() {
    for(i = [start:step:end]) {
      translate([i * step, width * 0.8, 0]) 
      rotate([0, 0, rotation])
      cylinder(height, width, center = false, $fn = fn);
    }  
  }
}

module grid(length, height, width = 1, step = 1, fn = 4, rotation = 0) {
  lines(length, height, width, step, fn, rotation);
  rotate([0, 0, 90])
  translate([0, -length, 0]) 
  lines(height, length, width, step, fn, rotation);
}

module rhombus1() {
  poly();
}

module rhombus2() {
  difference() {
    poly();
    translate([-tileWidth * 1.5, -tileWidth * 0.9, tileHeight - 1])
    grid(tileWidth * 3, tileWidth * 1.8, 0.8, 1.6, 4, 45);
  }
}

module rhombus3() {
  difference() {
    poly();
    translate([-tileWidth * 1.5, -tileWidth * 0.9, tileHeight - 1])
    lines(tileWidth * 3, tileWidth * 1.8, 1, 1.6, 4, 45);
  }
}

module tile() {
  offset = sqrt(3) * tileWidth / 2;
  union() {
    translate([0,  offset, 0])   rhombus1();
    rotate([0, 0, 120])   translate([0,  offset, 0])   rhombus3();
    rotate([0, 0,  60])   translate([0, -offset, 0])   rhombus2();
  }
}

tile();