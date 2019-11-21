wall_thickness = 1.3;
Radius = 90;
height = 150;
Hole_diameter = 14;

module half_cricle(rad) {
  difference() {
    difference() {
      circle(r=(rad + wall_thickness / 2));

      circle(r=(rad - wall_thickness / 2));
    }

    translate([0, 500, 0]){
      square([1000, 1000], center=true);
    }
  }
}

module Circle(rad, cutter) {
  difference() {
    circle(r=(rad + cutter / 1));

    circle(r=(rad - 0));
  }
}



difference() {
  union(){
    hull(){
      cylinder(r1=5, r2=5, h=2, center=false);
      intersection() {
        intersection() {
          linear_extrude( height=height, twist=0, scale=[1, 1], center=false){
            difference() {
              union(){
                union(){
                  translate([(0.6 * Radius), 0, 0]){
                    half_cricle(0.4 * Radius);
                  }
                  translate([(0.8 * Radius), 0, 0]){
                    half_cricle(1 * Radius);
                  }
                }
                mirror([0,1,0]){
                  mirror([1,0,0]){
                    union(){
                      translate([(0.6 * Radius), 0, 0]){
                        half_cricle(0.4 * Radius);
                      }
                      translate([(0.8 * Radius), 0, 0]){
                        half_cricle(1 * Radius);
                      }
                    }
                  }
                }
              }

              Circle(Radius - 1, 1000);
            }
          }

          linear_extrude( height=2, twist=0, scale=[1, 1], center=false){
            difference() {
              circle(r=(Radius / 2.7));

              circle(r=2.5);
            }
          }

        }

        linear_extrude( height=2, twist=0, scale=[1, 1], center=false){
          difference() {
            circle(r=(Radius / 2.7));

            circle(r=2.5);
          }
        }

      }
    }
    translate([0, 0, (height - 2)]){
      hull(){
        cylinder(r1=5, r2=5, h=2, center=false);
        intersection() {
          intersection() {
            linear_extrude( height=height, twist=0, scale=[1, 1], center=false){
              difference() {
                union(){
                  union(){
                    translate([(0.6 * Radius), 0, 0]){
                      half_cricle(0.4 * Radius);
                    }
                    translate([(0.8 * Radius), 0, 0]){
                      half_cricle(1 * Radius);
                    }
                  }
                  mirror([0,1,0]){
                    mirror([1,0,0]){
                      union(){
                        translate([(0.6 * Radius), 0, 0]){
                          half_cricle(0.4 * Radius);
                        }
                        translate([(0.8 * Radius), 0, 0]){
                          half_cricle(1 * Radius);
                        }
                      }
                    }
                  }
                }

                Circle(Radius - 1, 1000);
              }
            }

            linear_extrude( height=2, twist=0, scale=[1, 1], center=false){
              difference() {
                circle(r=(Radius / 2.7));

                circle(r=2.5);
              }
            }

          }

          linear_extrude( height=2, twist=0, scale=[1, 1], center=false){
            difference() {
              circle(r=(Radius / 2.7));

              circle(r=2.5);
            }
          }

        }
      }
    }
  }

  cylinder(r1=Hole_diameter/2, r2=Hole_diameter/2, h=10000, center=false);
}
linear_extrude( height=height, twist=0, scale=[1, 1], center=false){
  difference() {
    union(){
      union(){
        translate([(0.6 * Radius), 0, 0]){
          half_cricle(0.4 * Radius);
        }
        translate([(0.8 * Radius), 0, 0]){
          half_cricle(1 * Radius);
        }
      }
      mirror([0,1,0]){
        mirror([1,0,0]){
          union(){
            translate([(0.6 * Radius), 0, 0]){
              half_cricle(0.4 * Radius);
            }
            translate([(0.8 * Radius), 0, 0]){
              half_cricle(1 * Radius);
            }
          }
        }
      }
    }

    Circle(Radius - 1, 1000);
  }
}