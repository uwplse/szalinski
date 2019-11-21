//!OpenSCAD
iterations = 2;
max_thickness = 0.6;
min_thickness = 0.3;
first_branch_position = 0.2;
last_branch_position = 0.8;
first_branch_ratio = 0.35;
last_branch_ratio = 0.55;
main_angle = 60;
branch_pairs = 4;
branch_angle = 40;
height = 2;
thickness_scaling = 1;
line_style_changeover_level = 1;
node_width = 5;
node_slope = 45;

module snowflake() {
  for (i = [0 : abs(main_angle) : 359.9999]) {
    rotate([0, 0, i]){
      branch(0, 1);
    }
  }

}

module branch(level, adj_thickness) {
  union(){
    cur_thickness = adj_thickness * interpolate(max_thickness, min_thickness, level / iterations);
    line(level, cur_thickness, adj_thickness);
    if (level < iterations) {
      for (i = [0 : abs(1) : branch_pairs - 1]) {
        t = i / (branch_pairs - 1);
        translate([0, (30 * interpolate(first_branch_position, last_branch_position, t)), 0]){
          ratio = interpolate(first_branch_ratio, last_branch_ratio, t);
          scale([ratio, ratio, ratio]){
            new_adj_thickness = (adj_thickness / ratio) * thickness_scaling;
            union(){
              rotate([0, 0, branch_angle]){
                branch(level + 1, new_adj_thickness);
              }
              rotate([0, 0, (0 - branch_angle)]){
                branch(level + 1, new_adj_thickness);
              }
            }
          }
        }
      }

    }

  }
}

function interpolate(a, b, t) = a * (1 - t) + b * t;

module line(level, cur_thickness, scale_adjust) {
  adj_height = height * scale_adjust;
  intersection() {
    union(){
      if (level > line_style_changeover_level) {
        linear_extrude( height=adj_height, twist=0, scale=[1, 1], center=false){
          hull(){
            circle(r=0.1);
            translate([node_width, 20, 0]){
              circle(r=0.1);
            }
            translate([(0 - node_width), 20, 0]){
              circle(r=0.1);
            }
            translate([0, 30, 0]){
              circle(r=0.1);
            }
          }
        }
      }

      if (level <= line_style_changeover_level) {
        hull(){
          cylinder(r1=cur_thickness, r2=cur_thickness, h=adj_height, center=false);
          translate([0, 30, 0]){
            cylinder(r1=cur_thickness, r2=cur_thickness, h=adj_height, center=false);
          }
        }
      }

    }

    translate([0, 0, adj_height]){
      rotate([0, node_slope, 0]){
        translate([-50, 0, -100]){
          cube([100, 100, 100], center=false);
        }
      }
    }

    translate([0, 0, adj_height]){
      rotate([0, (0 - node_slope), 0]){
        translate([-50, 0, -100]){
          cube([100, 100, 100], center=false);
        }
      }
    }

  }
}


snowflake();