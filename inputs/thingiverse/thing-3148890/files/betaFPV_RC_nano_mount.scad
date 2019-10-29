//#import("Z02_camera_mount.stl");

/* [General] */
// Amount of degrees the camera should have (35° is the BetaFPV default)
degrees = 30;

/* [Cam settings] */
camWidth = 14; //11.2
camLensDiameter = 10; //8.2
camDepth = 2.62;
camRoundedDepth = 1.42;
camDepthOffset = 1.42;
camHeight = 14;
wallsSide = 0.8; //1.21
wallBack = 1;
wallFront = 0.55;

depthBottomCutout = 7.1;

slitWidth = 3.2;
offsetSlit = 4.0;
offsetSlitX = camWidth / 2 - slitWidth - 0.7;

camMountInset = 4.75; // 0.75, 2.75
camMountInsetZ = 2; // 0.75

feetConnectorWidth = wallBack; // 1.5

frontThickness = 1.0;
frontOffset = 1.5;

//camDepthTotal = 4.05; // 5.05 // 6
camDepthTotal = 5.5;

/* [HIdden] */
outerDiameter = 6.5;
holeDiameter = 1.5;
mountHeight = 1.8;
roundnessSteps = 15;

$fn = 50;
outerRadius = outerDiameter / 2;
holeRadius = holeDiameter / 2;
camLensRadius = camLensDiameter / 2;

mountingFeet();
difference() {
  frame();

  translate([0, 12.91, 13.42])
    rotate([degrees, 0, 0])
      translate([0, -6.3 - camMountInset, -3.6 + camMountInsetZ])
        camMount();
}
camMountSlots();


module camMountSlots() {
  translate([0, 12.91, 13.42]) {
    rotate([degrees, 0, 0])
      // Translate point of rotation
      translate([0, -6.3 - camMountInset, -3.6 + camMountInsetZ]) {
        group() {
          difference() {
            group() {
              camMount();
              
              /*
              // Rotation Helper
              translate([-10, 6.3, 3.6])
                cube([20, 0.5, 0.5]);
              */
            }

            translate([0, -12 ,0]) {
              // Slit on the back
              translate([offsetSlitX, 10 - camDepthTotal + 4.05, -2 + offsetSlit]) {
                cube([slitWidth, 3.02, 20]);
              }
              
              // Main body cutout
              translate([-camWidth / 2, 14.2 + camDepthOffset*2 - camDepthTotal, -3]) {
                cube([camWidth, camDepthTotal - camDepthOffset, camHeight]);
              }
              
              // Cutout lens
              group() {
                translate([0, 14.5, 4.7])
                  rotate([270, 0, 0])
                    cylinder(r=camLensRadius, h = 5);
                
                translate([-camLensRadius, 14.5, 4.7])
                  cube([camLensDiameter, 5, 5]);
              }

              // Cutout main body, rounded
              hull() {
                translate([-(camWidth / 2) + 2, 17.03 - camRoundedDepth, -0.513])
                  rotate([270,0,0])
                    cylinder(r=2, h = camRoundedDepth);
                
                translate([(camWidth / 2) - 2, 17.03 - camRoundedDepth, -0.513])
                  rotate([270,0,0])
                    cylinder(r=2, h = camRoundedDepth);
                
                translate([-camWidth / 2, 17.03 - camRoundedDepth, camHeight - 4])
                  cube([camWidth, camRoundedDepth, 1]);
              }
              
              // Angled Top cut
              translate([-(camWidth + 2.8) / 2 - wallsSide, 13 + 4.05 - camDepthTotal, 7.5]) {
                difference() {
                  cube([camWidth + 2.8 + wallsSide * 2, camDepthTotal + wallFront + 1, 4]);

                  translate([0, 0, 0.92])
                    rotate([270 - degrees, 0, 0])
                      cube([camWidth + 2.8 + wallsSide * 2, 6, 4]);
                }
              }
            }
          }
        }
      }
  }
}

module camMount() {
  difference() {
    group() {
      // Decorative front
      hull() {
        translate([-(camWidth / 2) - wallsSide + 1.25, 5.57, 3.50])
          cylinder(r=1.25, h = 4);

        translate([(camWidth / 2) + wallsSide - 1.25, 5.57, 3.50])
          rotate([0,0,0])
            cylinder(r=1.25, h = 4);

        for(a = [0:roundnessSteps:90]) {
          translate([-camWidth / 2 + 2.8 - wallsSide + 1.21, 5.57, -1.3])
            rotate([0, -a, 0])
              translate([-3 + 0.25, 0, 0])
                rotate([270,0,0])
                  sphere(r=1.25, h = 5.57);
        }

        for(a = [0:roundnessSteps:90]) {
          translate([camWidth / 2 - 2.8 + wallsSide - 1.21, 5.57, -1.3])
            rotate([0, a, 0])
              translate([3 - 0.25, 0, 0])
                rotate([270,0,0])
                  sphere(r=1.25, h = 5.57);
        }
      }

      // Body outside
      hull() {
        translate([-(camWidth / 2 + wallsSide - 1), 0, -4.3])
          rotate([270,0,0])
            cylinder(r=1, h = 4.03);
        
      translate([camWidth / 2 + wallsSide - 1, 0, -4.3])
          rotate([270,0,0])
            cylinder(r=1, h = 4.03);
        
        translate([-(camWidth / 2) - wallsSide, 0, 4.4])
          cube([camWidth + wallsSide * 2, 4.03, 4]);
      }
      
      // Main body
     hull() {
        for(a = [0:roundnessSteps:90]) {
          translate([-camWidth / 2 - wallsSide + 2.8 + 1.21, -camDepthTotal + 4.05, -1.3])
            rotate([0, -a, 0])
              translate([-3, 0, 0])
                rotate([270,0,0])
                  cylinder(r=1, h = camDepthTotal + wallFront + wallBack);
        }
        
        for(a = [0:roundnessSteps:90]) {
          translate([camWidth / 2 + wallsSide - 2.8 - 1.21, -camDepthTotal + 4.05, -1.3])
            rotate([0, a, 0])
              translate([3, 0, 0])
                rotate([270,0,0])
                  cylinder(r=1, h = camDepthTotal + wallFront + wallBack);
        }
        
        translate([-(camWidth / 2) - wallsSide, -camDepthTotal + 4.05, 4.4])
          cube([camWidth + wallsSide * 2, camDepthTotal + wallFront + wallBack, 4]);
      }
    }

    // Bottom cutoff
    translate([0, -12 ,0]) {
      translate([-(camWidth / 2) - wallsSide - 1, 10  -camDepthTotal + 4.05, -6])
        cube([camWidth + wallsSide * 2 + 2, depthBottomCutout, 5.91]);
    }

  }
}

module frame() {
  frameHalf();
  
  mirror([1, 0, 0])
    frameHalf();
}

module frameHalf() {
  difference() {
    group(){
      translate([16.31, 0, 2.11]) {
        rotate([0, 0, 37.55]) {
          cube([1, 20, 4.457]);
          translate([-1, 0, 3.45])
            cube([2, 20, 1.0]);
        }
      }

      // Feet walls
      difference() {
        translate([13.5, -outerRadius, 0])
          cube([1.5, outerDiameter + 2, 2.11 + 3.45 + 1]);
        
        translate([12.5, -outerRadius - 1.9, 1])
        rotate([52, 0, 0])
          cube([3.5,10,5]);
      }

      // Front bottom
      difference() {
        translate([0, 13.5 + (1.5 - frontThickness) - frontOffset, 0])
          cube([8, frontThickness, 2.11 + 3.45 + 1]);

        translate([2, 13.4 + (1.5 - frontThickness) - frontOffset, -0.73])
          rotate([0, 59.5, 0])
            cube([4, frontThickness + 0.2, 5 + 2]);
      }
      
      translate([0, 10.1, 2.11])
        cube([9, 4.5, 1]);
      
      // Connector feet to mount
      hull() {
        translate([13.5, -0.8, 6.5])
            cube([1.5, 3, 0.1]);
        translate([0, 12.91, 13.42]) {
          rotate([degrees, 0, 0]) {
            translate([camWidth / 2 + wallsSide, -2.35 - camDepthTotal - camMountInset + 0.1, 1.8 + camMountInsetZ]) {
              cube([0.1, feetConnectorWidth, 3]);
            }
          }
        }
      }
    }

    translate([15, -outerRadius - 1, 0])
      cube([10, outerDiameter + 4, 2.11 + 3.45 + 1 + 1]);
    
    // Cutaway angled sides
    translate([17.57, 0, -1])
      rotate([0, 0, 37.55])
        cube([10, 20, 10]);

    translate([12.5, outerRadius, -1])
      cube([3.5, outerDiameter + 2, 4.1]);
    
    hull() {
      translate([8, 9.1, 2.1]){
        rotate([0, 90, 0])
          cylinder(r = 1, h = 5);
      
        translate([0, -6, -3.1])
          cube([5, 1, 4.1]);
      }
    }
    
    // Cutaway front
    translate([-1, 15 - frontOffset, -1]) {
      cube([8 + 2, 1.5 + frontOffset, 8]);
    }
  }
}

module mountingFeet() {
  translate([-18, 0, 0])
    mountHole(0, 0);

  translate([18, 0, 0])
    rotate([0, 0, 180])
      mountHole(0, 0);

  translate([0, 18, 0])
    rotate([0, 0, 270])
      mountHole(frontOffset, 1.5 - frontThickness);
}

module mountHole(extension, thickness) {
  difference() {
    hull() {
      cylinder(h = mountHeight, r = outerRadius);
      translate([3.5 + extension - thickness, -outerRadius, 0])
        cube([1, outerDiameter, mountHeight]);
    }

    translate([0, 0, -1])
      cylinder(h = mountHeight + 2, r = holeRadius);
  }
  
  translate([3.5 - 1.5 + extension, -outerRadius, 0])
    difference() {
      cube([2.5 - thickness, outerDiameter, mountHeight + 1.3]);
      translate([0, -1, 2.8]) {
        hull(){
          rotate([-90,0,0])
            cylinder(r = 1, h=outerDiameter + 2);
            translate([-1, 0, 0])
              cube([2, outerDiameter + 2, mountHeight]);
        }
      }
    }
}