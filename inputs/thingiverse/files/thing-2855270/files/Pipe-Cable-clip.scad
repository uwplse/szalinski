// Diameter of drilling hols in mm
Hole_Diameter = 3;//[0:8.5]
// diameter of the pipe/cable in mm
pipe_diameter = 20;
//thickness of the clamb in mm
thickness = 1.2;
difference() {
  linear_extrude( height=10, twist=0, scale=[1, 1], center=false){
    union(){
      union(){
        translate([(pipe_diameter / -2), 0, 0]){
          difference() {
            circle(r=(pipe_diameter / 2 + thickness));

            circle(r=(pipe_diameter / 2));
            translate([500, 0, 0]){
              square([1000, 1000], center=true);
            }
          }
        }
        translate([(pipe_diameter / -2), (pipe_diameter / 2), 0]){
          square([(pipe_diameter / 2), thickness], center=false);
        }
        translate([(pipe_diameter / -2), (pipe_diameter / -2 - thickness), 0]){
          square([(pipe_diameter / 2), thickness], center=false);
        }
      }
      translate([0, (pipe_diameter / 2 + 5), 0]){
        square([thickness, 10], center=true);
      }
      translate([0, (pipe_diameter / -2 + -5), 0]){
        square([thickness, 10], center=true);
      }
    }
  }

  translate([0, (pipe_diameter / 2 + 5), 5]){
    rotate([0, 90, 0]){
      cylinder(r1=Hole_Diameter, r2=3, h=10, center=true);
    }
  }
  translate([0, (pipe_diameter / -2 + -5), 5]){
    rotate([0, 90, 0]){
      cylinder(r1=Hole_Diameter, r2=3, h=10, center=true);
    }
  }
}
//0;

//2;
