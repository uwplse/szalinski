/* [Size] */

// AEmber mean radius
aemberRadius = 8; // [3:50]

/* [Grid Render] */

// Number of lines to render
lines = 6;

// Number of columns to render
columns = 6;

/* [Advanced] */

// Number of primitives to intersect
primitives = 20; // [3:50]

/* [Hidden] */

for(i=[0:lines - 1]) {
  for(j=[0:columns - 1]) {
    translate([aemberRadius * 2*i, aemberRadius * 2*j, 0]) difference(){
      intersection() {
        y=rands(aemberRadius * 4/3,aemberRadius * 2, primitives);
        z=rands(aemberRadius * 4/3,aemberRadius * 2, primitives);

        xr=rands(0,360,primitives);
        yr=rands(0,360,primitives);
        zr=rands(0,360,primitives);
        
        intersection_for(n = [0: primitives - 1]) {
          rotate([xr[n], yr[n], zr[n]]) cube([100, y[n], z[n]], center = true);
        }
        translate([0,0,0]) cube([100, 100, aemberRadius * 3], center = true);
      }
      translate([-50,-50,-aemberRadius * 2 + 1]) cube([100, 100, (aemberRadius * 2 - 1)*2/3]);
    }
  }
}