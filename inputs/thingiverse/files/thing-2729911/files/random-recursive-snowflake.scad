//!OpenSCAD

iterations = 3;
max_thickness = 0.6;
min_thickness = 0.3;
first_branch_position = 0.25;
last_branch_position = 1;
main_angle = 60;
branch_angle = 60;
height = 2;
thickness_scaling = 1;
// negative for unpredictable
random_seed = 2;

module snowflake() {
  next_seed = random(random_seed);
  for (i = [0 : abs(main_angle) : 359.9999]) {
    rotate([0, 0, i]){
      linear_extrude( height=height, twist=0, scale=[1, 1], center=false){
        branch(0, 1, next_seed);
      }
    }
  }

}

module branch(level, adj_thickness, seed) {
  r1 = random(seed);
  r2 = random(r1);
  r3 = random(r2);
  r4 = random(r3);
  r5 = random(r4);
  next_seed = r5;
  branch_pairs = random_choice(r1, level == 0 ? 2 : 1, 4);
  first_branch_ratio = random_range(r2, 0.2, 0.5);
  last_branch_ratio = random_range(r3, 0.1, 0.2);
  first_branch_position = random_range(r4, 0.1, 0.4);
  last_branch_position = random_range(r5, 0.7, 0.95);
  union(){
    cur_thickness = adj_thickness * interpolate(max_thickness, min_thickness, level / iterations);
    union(){
      translate([(-0.5 * cur_thickness), 0, 0]){
        square([cur_thickness, 30], center=false);
      }
      circle(r=(0.5 * cur_thickness));
      translate([0, 30, 0]){
        circle(r=(0.5 * cur_thickness));
      }
    }
    if (level < iterations) {
      for (i = [0 : abs(1) : branch_pairs - 1]) {
        t = i != 0 ? i / (branch_pairs - 1) : 0;
        translate([0, (30 * interpolate(first_branch_position, last_branch_position, t)), 0]){
          ratio = interpolate(first_branch_ratio, last_branch_ratio, t);
          scale([ratio, ratio, 1]){
            new_adj_thickness = (adj_thickness / ratio) * thickness_scaling;
            union(){
              rotate([0, 0, branch_angle]){
                branch(level + 1, new_adj_thickness, next_seed);
              }
              rotate([0, 0, (0 - branch_angle)]){
                branch(level + 1, new_adj_thickness, next_seed);
              }
            }
          }
        }
      }

    }

  }
}

// guaranteed < 1
function random_choice(seed, from, to) = from + seed % ((to + 1) - from);

function random(seed) = seed < 0 ? round(rands(0,4294967295,1)[0]) : ((seed + 1013904223) * 1664525) % 4294967296;

// guaranteed < 1
function random_fraction(seed) = seed / 4294967296;

// guaranteed < 1
function random_range(seed, from, to) = from + (to - from) * (seed / 4294967296);

function interpolate(a, b, t) = a * (1 - t) + b * t;

snowflake();