////////////////////////////////////////////////////////////////
// PARAMETERS //////////////////////////////////////////////////


holeY = 4.5;       // Y hole dimension
holeX = 3.5;       // X hole dimension

holeYStep = 0.5;   // Increment of holeY for each iteration
count = 3;         // Number of iterations


setCount = 5;        // Number of sets

// Other variables that people don't get to choose : divide by 1 so they don't show up.

x = 11.7/1;
y = 14.2/1;
z = 6.1/1;

b = 1.5/1;
xmin = x - b;
ymin = y - 2.5 * b;

for(j = [0: 1 : setCount - 1]) {
  for(i = [holeY : holeYStep : holeY + holeYStep*(count - 1)]) {
    translate([j*(x + 3), (i - holeY) * 2  * (y + 3), 0])
      feeder(i);
  }
}

//feeder(holeY);

module feeder(holeY = holeY) {
  difference() {
    union() {
      cube([x, y, b]);
      translate([0, (y - ymin)/2, 0])
        cube([xmin, ymin, z]);
    }
    biseau(b);
    biseau(y + 2*b -0.24);
    translate([xmin + 20 -0.8, y/2, b]) {
      cylinder(r=20, h=z, $fn=80);
    }

    translate([23.6, y/2, 15.3]) {
      rotate([0, 135, 0]) {
        cylinder(r=20, h=z, $fn=80);
      }
    }
    color("yellow") {
      translate([-2.1, y/2 - holeY/2 -0.5, -3]) {
        rotate([-12, 10, 0])
          cube([holeX+1.5, holeY, z+20]);
        }
      translate([-2.1, y/2 - holeY/2, -3]) {
        rotate([0, 10, 0])
          cube([holeX+1.5, holeY, z+20]);
        }              
      translate([-2.1, y/2 - holeY/2 +0.5, -3]) {
        rotate([12, 10, 0])
          cube([holeX+1.5, holeY, z+20]);
        }
    }
    translate([holeX + 1.7, y/2, z-1])
      rotate(90, [0, 0, 1])    
        // text(text=str(holeY), size=4, valign="top", halign="center");
        linear_extrude(height = 1.1)
          text(text=str(holeY), size=3.5, valign="top", halign="center", font="Microsoft Sans Serif Normal:bold");
  }
  
}

module biseau(yt) {
  color("red") {
    translate([-1, yt, b]) {
    rotate([135, 0, 0])
      cube([x+2, b*2, b*2]);
    }
  }
}