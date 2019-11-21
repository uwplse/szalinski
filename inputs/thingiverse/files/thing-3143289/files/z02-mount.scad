//#import("Z02_camera_mount.stl");

/* [General] */
// Amount of degrees the camera should have (35° is the BetaFPV default)
degrees = 25;

/* [HIdden] */
outerDiameter = 6.5;
holeDiameter = 1.5;
mountHeight = 1.8;

roundnessSteps = 15;


/* [Hidden] */
$fn = 64;
outerRadius = outerDiameter / 2;
holeRadius = holeDiameter / 2;

mountingFeet();
difference() {
  frame();

  translate([0, 12.91, 13.42])
    rotate([degrees, 0, 0])
      translate([0, -6.3, -3.6])
        camMount();
}
camMountSlots();


module camMountSlots() {
  translate([0, 12.91, 13.42]) {
    rotate([degrees, 0, 0])
      // Translate point of rotation
      translate([0, -6.3, -3.6]) {
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
              translate([-1.6, 10, -2])
                cube([3.2, 3.02, 20]);
              
              translate([-5.6, 13, -3])
                cube([11.2, 2.62, 20]);
              
              // Cutout lens
              group() {
                translate([0, 14.5, 4.7])
                  rotate([270, 0, 0])
                    cylinder(r=4.1, h = 5);
                
                translate([-4.1, 14.5, 4.7])
                  cube([8.2, 5, 5]);
              }

              hull() {
                translate([-3.6, 13.5, -0.513])
                  rotate([270,0,0])
                    cylinder(r=2, h = 3.53);
                
                translate([3.6, 13.5, -0.513])
                  rotate([270,0,0])
                    cylinder(r=2, h = 3.53);
                
                translate([-5.6, 13.5, 5])
                  cube([11.2, 3.53, 4]);
              }
              
              translate([-7, 13, 7.5]) {
                difference() {
                  cube([14, 6, 4]);
                  translate([0, 0, 0.92])
                  rotate([270 - degrees, 0, 0])
                    cube([14, 6, 4]);
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
      hull() {
        translate([-5.55, 5.57, 3.50])
          rotate([0,0,0])
            cylinder(r=1.25, h = 4);

        translate([5.55, 5.57, 3.50])
          rotate([0,0,0])
            cylinder(r=1.25, h = 4);

        for(a = [0:roundnessSteps:90]) {
          translate([-2.8, 5.57, -1.3])
            rotate([0, -a, 0])
              translate([-3 + 0.25, 0, 0])
                rotate([270,0,0])
                  sphere(r=1.25, h = 5.57);
        }

        for(a = [0:roundnessSteps:90]) {
          translate([2.8, 5.57, -1.3])
            rotate([0, a, 0])
              translate([3 - 0.25, 0, 0])
                rotate([270,0,0])
                  sphere(r=1.25, h = 5.57);
        }
      }

      hull() {
        translate([-5.81, 0, -4.3])
          rotate([270,0,0])
            cylinder(r=1, h = 4.03);
        
        translate([5.81, 0, -4.3])
          rotate([270,0,0])
            cylinder(r=1, h = 4.03);
        
        translate([-6.81, 0, 4.4])
          cube([13.62, 4.03, 4.1]);
      }
      
      hull() {
        for(a = [0:roundnessSteps:90]) {
          translate([-2.8, 0, -1.3])
            rotate([0, -a, 0])
              translate([-2.5, 0, 0])
                rotate([270,0,0])
                  cylinder(r=1.5, h = 5.6);
        }
        
        for(a = [0:roundnessSteps:90]) {
          translate([2.8, 0, -1.3])
            rotate([0, a, 0])
              translate([3, 0, 0])
                rotate([270,0,0])
                  cylinder(r=1, h = 5.6);
        }
        
        translate([-6.81, 0, 4.4])
          cube([13.62, 5.6, 4]);
      }
    }

    translate([0, -12 ,0]) {
      translate([-6.8 -1, 10, -6])
        cube([13.6 + 2, 3.02, 5.91]);
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

      translate([13.5, -outerRadius, 0])
        cube([1.5, outerDiameter + 2, 2.11 + 3.45 + 1]);

      difference() {
        translate([0, 13.5, 0])
          cube([8, 1.5, 2.11 + 3.45 + 1]);

        translate([2, 13.4, -0.73])
          rotate([0, 59.5, 0])
            cube([4, 1.5 + 0.2, 5 + 2]);
      }
      
      translate([0, 10.1, 2.11])
        cube([9, 4.5, 1]);
      
      // Connector feet to mount
      hull() {
        translate([13.5, -3.25, 6.5])
            cube([1.5, 3, 0.1]);
        
        translate([0, 12.91, 13.42]) {
          rotate([degrees, 0, 0]) {
            translate([5.31, -6.3, 1.91]) {
              cube([1.5, 0.1, 3]);
            }
          }
        }
      }
    }

    translate([15, -outerRadius - 1, 0])
      cube([10, outerDiameter + 4, 2.11 + 3.45 + 1 + 1]);
    
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
    
    translate([-1, 15, -1]) {
      cube([8 + 2, 1.5, 8]);
    }
  }
}

module mountingFeet() {
  translate([-18, 0, 0])
    mountHole();
  
  translate([18, 0, 0])
    rotate([0, 0, 180])
      mountHole();
  
  translate([0, 18, 0])
    rotate([0, 0, 270])
      mountHole();
}

module mountHole() {
  difference() {
    hull() {
      cylinder(h = mountHeight, r = outerRadius);
      translate([3.5, -outerRadius, 0])
        cube([1, outerDiameter, mountHeight]);
    }

    translate([0, 0, -1])
      cylinder(h = mountHeight + 2, r = holeRadius);
  }
  
  translate([3.5 - 1.5, -outerRadius, 0])
    difference() {
      cube([2.5, outerDiameter, mountHeight + 1.3]);
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