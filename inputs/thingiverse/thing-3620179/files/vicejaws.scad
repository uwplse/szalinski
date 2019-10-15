/*[ Jaws ]*/
// Vice jaw width
jawWidth = 100.5;
// Vice jaw height
jawHeight = 21.2;
// Angle one groove?
angledGroove = "no"; // [yes,no]
// Jaw top?
showTop = "yes"; // [yes, no]
// Jaw sides?
showSides = "yes"; // [yes, no]

/*[ Magnets ]*/
magnetDiameter = 8.25;
magnetHeight = 3.05;
numMagnets = 2;

/*[Hidden]*/
magnetRadius = magnetDiameter/2;
jawThickness = 12.0;
jawSideThickness = showSides=="yes" ? 3.5 : 0;
jawTopWidth = 15;
jawTopThickness = showTop=="yes" ? 3.5 : 0;

maxMagnets = min(numMagnets, floor((jawWidth - magnetDiameter)/magnetDiameter));

buffer = 0.2;

function steps( start, no_steps, end) = (no_steps==1) ? [(end-start)/2:1:(end-start)/2] : [start:(end-start)/(no_steps-1):end];

module rotate_about(rotation, pt) {
  translate(pt)
    rotate(rotation)
      translate(-pt)
        children();   
}

difference() {
  cube([jawWidth + jawSideThickness * 2, jawThickness + jawTopWidth, jawHeight + jawTopThickness]);
  
  // jaw pocket
  phBuffer = showSides == "yes" ? 0 : buffer;
  pvBuffer = showTop == "yes" ? 0 : buffer;

  translate([jawSideThickness - phBuffer, -buffer , -buffer]) {
    cube([jawWidth + phBuffer * 2, jawTopWidth + buffer, jawHeight + buffer + pvBuffer]);
  }
    
  // horizontal valley
  translate([-buffer, jawThickness + jawTopWidth, jawHeight/2]) {
    valley(jawWidth + jawSideThickness * 2, 10);
  }
  
  // vertical valleys
  rotate([0, 90, 0]) {
    translate([-(buffer + jawHeight + jawTopThickness), jawThickness + jawTopWidth, (jawWidth + jawSideThickness * 2)/2]) {
      valley(jawHeight + jawTopThickness, 10);
    }
    
    translate([-(buffer + jawHeight + jawTopThickness), jawThickness + jawTopWidth, (jawWidth + jawSideThickness * 2)/5]) {
      valley(jawHeight + jawTopThickness, 5);
    }
    
    translate([-(buffer + jawHeight + jawTopThickness), jawThickness + jawTopWidth, (jawWidth + jawSideThickness * 2)/5 * 4]) {
      if(angledGroove=="yes") {
        translate([-3.3, 0, 3.3 + (jawHeight + jawTopThickness * 2)/2]) {
          rotate([0, 45, 0]) {
            valley((jawHeight + jawTopThickness)*3, 5);
          }
        }
      } else {
        valley(jawHeight + jawTopThickness, 5);
      }
    }
  }

  // magnet holes
  translate([jawSideThickness, jawTopWidth + magnetHeight, jawHeight/2]) {
    for(i=steps(magnetDiameter, maxMagnets, jawWidth - magnetDiameter)) {
      rotate([90, 0, 0]) {
        translate([i, 0, 0]) {
          cylinder(r=magnetRadius, h=magnetHeight + buffer);
        }
      }
    }
  }
}

module valley(width, depth = 10) {
  translate([0, 0, -sqrt(depth*depth + depth*depth)/2]) {
    scale([1, 0.5, 1]) {
      rotate([45, 0, 0]) {
        cube([width + buffer *2, depth, depth]);
      }
    }
  }
}