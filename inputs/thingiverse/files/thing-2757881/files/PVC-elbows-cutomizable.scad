/* [Parameters] */
Plugs = 3; // [2:5]
Outer_Diameter = 20;
Inner_Diameter = 17.2;
Angle1 = 180; // [0,45,72,90,135,180]
Angle2 = 90; // [0,45,72,90,135,180]

/* [Hidden] */
Inner_Radius = Inner_Diameter / 2; 
Outer_Radius = Outer_Diameter / 2;
taper = Inner_Radius - 2;
CutBox = Inner_Radius + 5;
InvCutBox = CutBox - (CutBox + CutBox);

GenPart(Outer_Diameter, Inner_Diameter, Plugs, Angle1, Angle2, Inner_Radius, Outer_Radius, taper, CutBox, InvCutBox);

module plug(OR, IR, TPR) {
  union(){
    cylinder(r1=IR, r2=IR, h=23, center=false);
    translate([0, 0, 23]){
      cylinder(r1=IR, r2=TPR, h=5, center=false);
    }
    cylinder(r1=OR, r2=OR, h=10, center=false);
  }
}

module my_135_endcap() {
  rotate([45, 0, 0]){
    translate([0, 0, 20]){
      cylinder(r1=10, r2=10, h=10, center=false);
    }
  }
}

module GenPart(OD, ID, P, A1, A2, IR, OR, TPR, CB, ICB) {
  if (P == 2) {
    if (A1 == 45) {
      my_2_way_45(OR, IR, TPR, CB);
    } else if (A1 == 0 || A2 == 180) {
      my_2_way_0_elbow2(OR, IR, TPR, CB);
    } else if (A1 == 135) {
      my_2_way_135_elbow(OR, IR, TPR, CB);
    } else if (A1 == 90) {
      my_2_way_90_elbow(OR, IR, TPR, ICB);
    }

  } else if (P == 3) {
    if (A1 == 90 && A2 == 90) {
      my_3_way_corner(OR, IR, TPR, CB);
    } else if (A1 == 45 && A2 == 90 || A1 == 90 && A2 == 45) {
      my_3_way_1_45(OR, IR, TPR, ICB);
    } else if (A1 == 90 && A2 == 135 || A1 == 135 && A2 == 90) {
      my_3_way_corner_135(OR, IR, TPR, CB);
    } else if (A1 == 120 && A2 == 120) {
      my_3_way_Star(OR, IR, TPR, CB);
    } else if (A1 == 90 && A2 == 180 || A1 == 180 && A2 == 90) {
      my_3_way_0_90_180_elbow(OR, IR, TPR, CB);
    }

  } else if (P == 4) {
    if (A1 == 90 && A2 == 90) {
      my_4_way_corner(OR, IR, TPR, CB);
    } else if (A1 == 90 && A2 == 180 || A1 == 180 && A2 == 90) {
      my_4_way_flat(OR, IR, TPR, CB);
    }

  } else if (P == 5) {
    if (A1 == 90 && A2 == 90) {
      my_5_way(OR, IR, TPR, CB);
    } else if (A1 == 72 && A2 == 0 || A1 == 0 && A2 == 72) {
      my_5_way_star(OR, IR, TPR, CB);
    }

  }

}

module my_135_Endcapped_Both() {
  union(){
    rotate([0, 90, 0]){
      translate([20, 0, 0]){
        my_135_endcapped_2();
      }
    }
    translate([50, 0, 0]){
      rotate([0, 270, 0]){
        translate([-20, 0, 0]){
          mirror([1,0,0]){
            my_135_endcapped_2();
          }
        }
      }
    }
  }
}

module my_135_endcapped_2() {
  difference() {
    union(){
      rotate([270, 0, 0]){
        translate([0, 0, 25]){
          // torus
          rotate_extrude($fn=32) {
            translate([Outer_Radius, 0, 0]) {
              circle(r=5, $fn=32);
            }
          }
        }
      }
      rotate([90, 0, 0]){
        translate([0, 0, -8]){
          // torus
          rotate_extrude($fn=32) {
            translate([Outer_Radius, 0, 0]) {
              circle(r=4, $fn=32);
            }
          }
        }
      }
      my_2_way_135_elbow(null, null, null, null);
    }

    translate([CutBox, 0, 0]){
      cube([10, 60, 60], center=true);
    }
  }
}

module my_2_way_135_capped() {
  difference() {
    union(){
      rotate([45, 0, 0]){
        plug(null, null, null);
      }
      rotate([270, 0, 0]){
        plug(null, null, null);
      }
      sphere(r=10);
      my_135_endcap();
    }

    translate([13.45, 0, 0]){
      cube([10, 50, 50], center=true);
    }
    translate([-13.45, 0, 0]){
      cube([10, 50, 50], center=true);
    }
  }
}

module my_2_way_45(OR, IR, TPR, CB) {
  difference() {
    union(){
      rotate([0, 0, 0]){
        translate([0, 0, 15]){
          plug(OR, IR, TPR);
        }
        cylinder(r1=OR, r2=OR, h=20, center=false);
      }
      rotate([45, 0, 0]){
        translate([0, 0, 15]){
          plug(OR, IR, TPR);
        }
        cylinder(r1=OR, r2=OR, h=20, center=false);
      }
      sphere(r=OR);
    }

    translate([CB, 0, 0]){
      cube([10, 50, 50], center=true);
    }
  }
}

module my_5_way(OR, IR, TPR, CB) {
  difference() {
    union(){
      rotate([0, 0, 0]){
        plug(OR, IR, TPR);
      }
      rotate([270, 0, 0]){
        plug(OR, IR, TPR);
      }
      rotate([180, 0, 0]){
        plug(OR, IR, TPR);
      }
      rotate([90, 0, 0]){
        plug(OR, IR, TPR);
      }
      rotate([180, 90, 0]){
        plug(OR, IR, TPR);
      }
      sphere(r=OR);
    }

    translate([CB, 0, 0]){
      cube([10, 30, 30], center=true);
    }
  }
}

module my_2_way_0_elbow2(OR, IR, TPR, CB) {
  difference() {
    union(){
      translate([0, 5, 0]){
        rotate([90, 0, 0]){
          plug(OR, IR, TPR);
        }
      }
      translate([0, -5, 0]){
        rotate([270, 0, 0]){
          plug(OR, IR, TPR);
        }
      }
      sphere(r=OR);
    }

    translate([CB, 0, 0]){
      cube([10, 30, 30], center=true);
    }
  }
}

module my_2_way_90_elbow(OR, IR, TPR, ICB) {
  difference() {
    union(){
      rotate([180, 0, 0]){
        plug(OR, IR, TPR);
      }
      rotate([270, 0, 0]){
        plug(OR, IR, TPR);
      }
      sphere(r=OR);
    }

    translate([ICB, 0, 0]){
      cube([10, 30, 30], center=true);
    }
  }
}

module my_2_way_135_elbow(OR, IR, TPR, CB) {
  difference() {
    union(){
      rotate([45, 0, 0]){
        plug(OR, IR, TPR);
      }
      rotate([270, 0, 0]){
        plug(OR, IR, TPR);
      }
      sphere(r=OR);
    }

    translate([CB, 0, 0]){
      cube([10, 30, 30], center=true);
    }
  }
}

module my_3_way_corner(OR, IR, TPR, CB) {
  difference() {
    union(){
      rotate([180, 90, 0]){
        plug(OR, IR, TPR);
      }
      rotate([270, 0, 0]){
        plug(OR, IR, TPR);
      }
      rotate([180, 0, 0]){
        plug(OR, IR, TPR);
      }
      sphere(r=OR);
    }

    translate([CB, 0, 0]){
      cube([10, 30, 30], center=true);
    }
  }
}

module my_3_way_1_45(OR, IR, TPR, ICB) {
  difference() {
    union(){
      rotate([0, 0, 0]){
        translate([0, 0, 15]){
          plug(OR, IR, TPR);
        }
        cylinder(r1=OR, r2=OR, h=20, center=false);
      }
      rotate([45, 0, 0]){
        translate([0, 0, 15]){
          plug(OR, IR, TPR);
        }
        cylinder(r1=OR, r2=OR, h=20, center=false);
      }
      rotate([90, 0, 90]){
        translate([0, 0, 15]){
          plug(OR, IR, TPR);
        }
        cylinder(r1=OR, r2=OR, h=20, center=false);
      }
      sphere(r=OR);
    }

    translate([ICB, 0, 0]){
      cube([10, 50, 50], center=true);
    }
  }
}

module my_3_way_corner_135(OR, IR, TPR, CB) {
  difference() {
    union(){
      rotate([135, 90, 0]){
        plug(OR, IR, TPR);
      }
      rotate([270, 0, 0]){
        plug(OR, IR, TPR);
      }
      rotate([180, 0, 0]){
        plug(OR, IR, TPR);
      }
      sphere(r=OR);
    }

    rotate([0, 270, 0]){
      translate([CB, 0, 0]){
        cube([10, 30, 30], center=true);
      }
    }
  }
}

module my_3_way_Star(OR, IR, TPR, CB) {
  difference() {
    union(){
      rotate([0, 0, 0]){
        plug(OR, IR, TPR);
      }
      rotate([120, 0, 0]){
        plug(OR, IR, TPR);
      }
      sphere(r=10);
      rotate([240, 0, 0]){
        plug(OR, IR, TPR);
      }
    }

    translate([CB, 0, 0]){
      cube([10, 30, 30], center=true);
    }
  }
}

module my_3_way_0_90_180_elbow(OR, IR, TPR, CB) {
  difference() {
    union(){
      rotate([0, 0, 0]){
        plug(OR, IR, TPR);
      }
      rotate([270, 0, 0]){
        plug(OR, IR, TPR);
      }
      rotate([180, 0, 0]){
        plug(OR, IR, TPR);
      }
      sphere(r=OR);
    }

    translate([CB, 0, 0]){
      cube([10, 30, 30], center=true);
    }
  }
}

module my_4_way_corner(OR, IR, TPR, CB) {
  difference() {
    union(){
      rotate([0, 0, 0]){
        plug(OR, IR, TPR);
      }
      rotate([270, 0, 0]){
        plug(OR, IR, TPR);
      }
      rotate([180, 0, 0]){
        plug(OR, IR, TPR);
      }
      rotate([180, 90, 0]){
        plug(OR, IR, TPR);
      }
      sphere(r=OR);
    }

    translate([CB, 0, 0]){
      cube([10, 30, 30], center=true);
    }
  }
}

module my_4_way_flat(OR, IR, TPR, CB) {
  difference() {
    union(){
      rotate([0, 0, 0]){
        plug(OR, IR, TPR);
      }
      rotate([270, 0, 0]){
        plug(OR, IR, TPR);
      }
      rotate([180, 0, 0]){
        plug(OR, IR, TPR);
      }
      rotate([90, 0, 0]){
        plug(OR, IR, TPR);
      }
      sphere(r=OR);
    }

    translate([CB, 0, 0]){
      cube([10, 30, 30], center=true);
    }
  }
}

module my_5_way_star(OR, IR, TPR, CB) {
  difference() {
    union(){
      rotate([0, 0, 0]){
        translate([0, 0, 5]){
          plug(OR, IR, TPR);
        }
        cylinder(r1=OR, r2=10, h=15, center=false);
      }
      rotate([72, 0, 0]){
        translate([0, 0, 5]){
          plug(OR, IR, TPR);
        }
        cylinder(r1=OR, r2=10, h=15, center=false);
      }
      sphere(r=OR);
      rotate([144, 0, 0]){
        translate([0, 0, 5]){
          plug(OR, IR, TPR);
        }
        cylinder(r1=OR, r2=OR, h=15, center=false);
      }
      rotate([216, 0, 0]){
        translate([0, 0, 5]){
          plug(OR, IR, TPR);
        }
        cylinder(r1=OR, r2=OR, h=15, center=false);
      }
      rotate([288, 0, 0]){
        translate([0, 0, 5]){
          plug(OR, IR, TPR);
        }
        cylinder(r1=OR, r2=OR, h=15, center=false);
      }
    }

    translate([CB, 0, 0]){
      cube([10, 50, 50], center=true);
    }
  }
}

