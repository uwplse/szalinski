//parametric tri-spinner fidget toy
//2016-08-30 rev. 0001
// Set the values for the diameter and thickness of your bearings in millimeters
// Set the wall thickness if you want, default is 2mm
//2016-08-30 rev. 0002 - grahampheath
// Added smoothing.
// Converted some chunks to modules.
//2016-11-14 rev. 0003 - grahampheath
// Refactoring continues.
// Add support for 0 orbiting bearings.

// Default 3. number of arms
spinner_style = 3; // [5: Daisie, 4: Plus, 3:Tri, 2:Straight, 1:Half, 0:Um... Like a bearing holder? Oh maybe a ring. ]

// Default 22mm, same as 608 bearings.
bearing_diameter=22;

// Defuult 7mm, same as 608 bearings.
bearing_thickness=7;

// Default 2.5, the width of material around and between each of the bearings.
wall_thickness=2.5;

// Default 0. The default length of an is the diameter of the bearing plus wall thickness * 2. Negative can remove wall width between center and external bearing.
extra_arm_length=0; // [-10:0.1:10]

// Default 0.5. "is the minimum size of a fragment"
part_quality=.5; // [0.1:0.1:1]

// Default true.
smoothing=true;
// Default 0.333. 1 would be a contiunous curve around the edge, .5 still has half of the original height flat, and .3 is 90 percent flat, and only 10 % rounded.
smoothing_ratio=.333; // [0.05:0.01:1]
// Default 7. How many rounded faces are left after rounding.
smoothing_faces=7;// [3:1:100]

// Default 125. More faces makes for a smoother and more precise model, but also increases complexity. Suggested: 125.
bearing_faces=125; // [1:1:300]

/* [Hidden] */
minkowski=smoothing;
minkowski_ratio=smoothing_ratio;
minkowski_roundness=smoothing_faces * 2;// Times two because of "2 tri-s per face".

// Default=25. More faces makes for a smoother and more precise model, but also increases complexity. Suggestions: draft=14 good=24, more than that is up to you.
outer_wall_faces=12 * smoothing_faces; // [1:1:300]

$fa=1;
$fs=part_quality;

degree = 360 / spinner_style;
number = spinner_style;

outer=bearing_diameter / 2 + wall_thickness;
inner=bearing_diameter / 2;
arm=bearing_diameter + wall_thickness + extra_arm_length;

minkowski_size=bearing_thickness * minkowski_ratio;

module hardArm() {
  $fn=outer_wall_faces;
  cylinder(r=outer, h=bearing_thickness, center=false);
}

module softArm() {
  $fn=outer_wall_faces;
  cylinder(r=outer-minkowski_size, h=bearing_thickness - (minkowski_size * 2), center=false);
}
module softArm_old() {
  $fn=minkowski_roundness;
  minkowski(){
    $fn=outer_wall_faces;
    cylinder(r=outer-minkowski_size, h=bearing_thickness - (minkowski_size * 2), center=false);
    sphere(r=minkowski_size);
  }
}

module hardArms() {
  for(n = [1:number]) {
    rotate([0,0,n*degree]) {
      hull() {
        arm();
        translate([-arm,0,0]) {
          arm();
        }
      }
    }
  }
}


module softArms() {
  for(n = [1:number]) {
    rotate([0,0,n*degree]) {
      $fn=minkowski_roundness;
      minkowski(){
        hull() {
          softArm();
          translate([-arm,0,0]) {
            softArm();
          }
        }
        sphere(r=minkowski_size);
      }
    }
  }
}

module bearing() {
  $fn=bearing_faces;
  cylinder(r=inner,h=bearing_thickness);
}

module bearings () {
  for(n = [1:number]) {
    rotate([0,0,n*degree]) {
      translate([-arm,0,0]) {
        bearing();
      }
    }
  }
  cylinder(r=inner,h=bearing_thickness);
}


difference(){
  if(minkowski==true){
    translate([0,0,minkowski_size]) {
      if (number == 0) {
        difference() {
          $fn=minkowski_roundness;
          minkowski(){
            softArm();
            sphere(r=minkowski_size);
          }
          translate([0,0,-minkowski_size]) {
            bearing();
          }

        }
      } else {
        difference() {
          softArms();
          translate([0,0,-minkowski_size]) {
            bearings();
          }
        }
      }
    }
  } else {
    hardArms();
    if (number == 0) {
      difference() {
        hardArm();
        bearing();
      }
    } else {
      difference() {
        hardArms();
        bearings();
      }
    }


  }
}
