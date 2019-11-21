// EmpireSkyscraper.scad
// by David Phillip Oster
// https://www.thingiverse.com/thing:3653061
// Version 0.2  5/26/2019
//

// Scales the whole design
totalScaleFactor = 0.3333;

// ratio of a window in the building: Xcoordinate
primitiveFloorX = 3;

// ratio of a window in the building: Ycoordinate
primitiveFloorY = 3;

// ratio of a storyHeight in the building: Zcoordinate
primitiveFloorZ = 6;

// turn the windows off for faster rendering.
hasWindows = true; // [false, true]

floorX = primitiveFloorX * totalScaleFactor;
floorY = primitiveFloorY * totalScaleFactor;
floorZ = primitiveFloorZ * totalScaleFactor;

// x, y, z cube symmetric about the Z-axis.
module simpleFloors(x, y, z) {
  xx = floorX*x;
  yy = floorY*y;
  zz = floorZ*z;
  translate([-xx/2, -yy/2, 0]) {
    cube([xx, yy, zz]);
  }
}

// The window pattern on the vertical wall. Windows are cubes, 0.5 half into the wall.
module facade(x, z, hasCenteredWindows) {
  if (hasWindows) {
    facadeX = 3*floorX;
    numX = floor(x/facadeX);
    numZ = floor(z/floorZ);
    if (numX > 2 && numZ > 2) {
      dx = (x-(floor(x/facadeX)*facadeX))/2;
      for (zz = [1:numZ-2]) {
        for (xx = [1:numX-2]) {
          if (hasCenteredWindows || floor(xx/3) != xx/3) {  // skip every third. Slightly more interesting.
            translate([dx + facadeX*0.2 + xx*facadeX, -0.25, zz*floorZ]) {
              cube([facadeX*0.6, 0.5, floorZ*0.6]);
            }
          }
        }
      }
    }
  }
}


// texture the 3 outside walls of the cube with the window pattern.
module storey(x, y, z, hasCenteredWindows) {
  difference() {
    cube([x, y, z]);
    facade(x, z, hasCenteredWindows);
    translate([0, y, 0]) {
      facade(x, z, hasCenteredWindows);
    }
    rotate([0, 0, 90]) {
      facade(y, z, true);
    }
    // The fourth face will usually be hidden by another storey cube.
  }
}

// Split the storeys into two mirror-image translatedStorey "cubes" separated
// by gapX in X, where gapX can be zero.
module storeys(x, y, z, gapX = 0, hasCenteredWindows=false) {
  xx = floorX*x;
  yy = floorY*y;
  zz = floorZ*z;
  if (hasCenteredWindows && gapX == 0) {
    translate([-xx/2, -yy/2, 0]) {
      storey(xx, yy, zz, hasCenteredWindows);
    }
  } else {
    for(i = [0:1]) {
      rotate([0, 0, i*180]) {
        translate([-xx/2, -yy/2, 0]) {
          storey((xx-gapX)/2, yy, zz, hasCenteredWindows);
        }
      }
    }
  }
}

// One of the 4 fins around the central column on the cap.
module fin1() {
  translate([1, -5*floorX, 0]) {
    rotate([0, -90, 0]) {
      for(i = [0:3]) {
        translate([0, 0, i*0.25]) {
          linear_extrude(2 - (i/2)) {
            polygon(points = [[i*4,i*0.3], [4*(i+1),i*0.35], [6+(i*4),4], [(i*4),4]]);
          }
        }
      }
    }
  }
}

// The cap of the building.
module capper() {
  cylinder(d=5*floorX,h=9*floorZ, $fn=24);
  translate([0, 0, 9*floorZ]) {
    cylinder(d1=5*floorX, d2=0.001, h=3, $fn=24);
  }
  for(i = [0:3]) {
    rotate([0, 0, 90*i + 45]) {
      fin1();
    }
  }
}

// The entire building.
module building() {
  level1 = 5;
  level2 = level1 + 14;
  level3 = level2 + 4;
  level4 = level3 + 5;
  level5 = level4 + 40;
  level6 = level5 + 9;
  level7 = level6 + 4;
  level8 = level7 + 1;
  level9 = level8 + 1;
  level10 = level9 + 1;
  dimX=20;
  dimY=16;
  shaftX = dimX*floorX;
  shaftY = dimY*floorX;
  union() {
    storeys(73, 32, level1);
    storeys(54, 20, level2, 15);
    storeys(37, 26, level3, 15);
    storeys(37, 13, level4);

    storeys(20, 18, level4);
    storeys(30, 18, level5, 8);
    storeys(25, 17, level6, 8, hasCenteredWindows=true);
    storeys(19, 14, level7, hasCenteredWindows=true);
    simpleFloors(13, 13, level8);
    simpleFloors(12, 12, level9);
    simpleFloors(11, 11, level10);
    translate([0, 0, level10*floorZ]) {
        capper();
    }
  }
}

building();
