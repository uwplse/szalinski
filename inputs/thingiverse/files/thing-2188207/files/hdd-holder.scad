
// quality
$fn = 50;

// width of HDD case
hddWidth = 78;

// height of HDD case
hddHeight = 17;

// Thickness (height) of holder
thickness = 5;

// Wall thickness
wall = 4;

// Num of HDDs
count = 2;

// Spacing between HDDs
spacing = 10;

// Width of holder's base for one HDD
baseWidth = 30;

// Elevation of bottom of HDD
elevation = 10;


module holdersTopBase() {
  for (i = [0:count-1]) {
    translate([0, i * (spacing + hddHeight + 2*wall), 0])
    linear_extrude (height=thickness)
    difference() {
      offset (r=wall) square ([hddWidth, hddHeight], center=true);
      square ([hddWidth, hddHeight], center=true);
    }
  }
}

module holdersTop() {
  translate([0, -((count - 1) * (spacing + hddHeight + 2*wall))/2, -thickness/2])
  holdersTopBase();
}

module base() {
  hull() {
    translate([-hddWidth/2-1, 0, 0])
    cube ([1, (count - 1) * spacing + (count * (hddHeight + 2*wall)) - 1, thickness], center=true);

    translate([-hddWidth/2-wall-elevation, 0, 0])
    cube([1, count*(baseWidth + spacing), thickness], center=true);
  }
  
  if (count > 1) {
    translate([hddWidth/2+wall/2, 0, 0])
    cube ([wall, (count - 1) * (spacing + hddHeight + 2*wall), thickness], center=true);
  }
}

union() {
  holdersTop();
  base();
}
