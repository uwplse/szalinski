//diameter of the tool you want to use
tool_diameter = 17;
// type of the profile
profile_type = "2020 profile";//[2020 profile,custom]
// strength of the grabber
grabber_strength = 1;//[1:100]
// height of the plastic used in mm
plastic_tickness = 5;
/*[custom section]*/
// height of the profile in mm
height = 20;
// width of the profile in mm
width = 20;
/*[Hidden]*/
if (profile_type == "2020 profile") {
  difference() {
    linear_extrude( height=(tool_diameter + plastic_tickness * 2), twist=0, scale=[1, 1], center=false){
      union(){
        difference() {
          union(){
            difference() {
              square([(20 + plastic_tickness * 2), (20 + plastic_tickness * 2)], center=false);

              square([(20 + plastic_tickness * 1), (20 + plastic_tickness * 1)], center=false);
            }
            difference() {
              square([(20 + plastic_tickness), (20 + plastic_tickness)], center=false);

              translate([plastic_tickness, plastic_tickness, 0]){
                square([(20 - plastic_tickness * 1), (20 - plastic_tickness * 1)], center=false);
              }
              translate([(plastic_tickness * 1), (plastic_tickness * 1), 0]){
                square([(20 + plastic_tickness * 1), (20 + plastic_tickness * 1)], center=false);
              }
            }
          }

          translate([((grabber_strength / 1) * -1), ((grabber_strength + 0) * -1), 0]){
            square([20, 20], center=false);
          }
        }
        translate([((tool_diameter + plastic_tickness) * -1), (20 + plastic_tickness), 0]){
          square([(tool_diameter + plastic_tickness), plastic_tickness], center=false);
        }
      }
    }

    rotate([270, 0, 0]){
      translate([((tool_diameter / 2 + plastic_tickness * 1.5) * -1), ((tool_diameter / 2 + plastic_tickness) * -1), 0]){
        cylinder(r1=(tool_diameter / 2), r2=(tool_diameter / 2), h=1000, center=false);
      }
    }
  }
} else {
  difference() {
    linear_extrude( height=(tool_diameter + plastic_tickness * 2), twist=0, scale=[1, 1], center=false){
      union(){
        difference() {
          union(){
            difference() {
              square([(height + plastic_tickness * 2), (width + plastic_tickness * 2)], center=false);

              square([(height + plastic_tickness * 1), (width + plastic_tickness * 1)], center=false);
            }
            difference() {
              square([(height + plastic_tickness), (width + plastic_tickness)], center=false);

              translate([plastic_tickness, plastic_tickness, 0]){
                square([(height - plastic_tickness * 1), (width - plastic_tickness * 1)], center=false);
              }
              translate([(plastic_tickness * 1), (plastic_tickness * 1), 0]){
                square([(height + plastic_tickness * 1), (width + plastic_tickness * 1)], center=false);
              }
            }
          }

          translate([((grabber_strength / 1) * -1), ((grabber_strength + 0) * -1), 0]){
            square([height, width], center=false);
          }
        }
        translate([((tool_diameter + plastic_tickness) * -1), (width + plastic_tickness), 0]){
          square([(tool_diameter + plastic_tickness), plastic_tickness], center=false);
        }
      }
    }

    rotate([270, 0, 0]){
      translate([((tool_diameter / 2 + plastic_tickness * 1.5) * -1), ((tool_diameter / 2 + plastic_tickness) * -1), 0]){
        cylinder(r1=(tool_diameter / 2), r2=(tool_diameter / 2), h=1000, center=false);
      }
    }
  }
}

//20;

//20;
