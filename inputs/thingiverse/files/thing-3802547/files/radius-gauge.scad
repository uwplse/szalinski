// preview[view:south, tilt:top]

// Gauge thickness
thickness = 2.2;
// Extra length to add to each gauge
extra_length = 0;
// Radius size list
sizes = [1,2,3,4,5,6,7,8,9,10];
// Box slot tolerance
tolerance = 0.1;
// Thickness of nub in each slot to increase friction on gauge
friction_fit = 0;

// You can use any of these - https://fonts.google.com/
font_family = "Arimo";
font_weight = "Bold";
font_size = 6;

font = str(font_family, ":style=", font_weight);

text_depth = 0.4;


/* [hidden] */
_fudge = 0.1;
_length = max(sizes) * 2 + font_size + 3 + extra_length;
_minBoxExposedGauge = 9;

// Keep inside curve of largest gauge slightly inside box, but at least 12 mm exposed
_boxHeight = _length - max(max(sizes), 12) + 4;

module drawGauge(radius, width) {
  _l = _length - radius;

  union() {
    difference() {
      union() {
        cube([_l, width, thickness]);
        // convex radius
        translate([_l, width/2, 0]) {
          difference() {
            cylinder(h=thickness, r=radius, $fa = 4, $fs = 0.5);
            translate([-radius, -radius, -_fudge]) {
              cube([radius, radius * 2, thickness+_fudge*2]);
            }
          }
        }
      }
      // draw text
      translate([0, width/2, thickness-text_depth]) {
        translate([radius+2, 0, 0]) {
          linear_extrude(height=text_depth+_fudge){
            text(text=str(radius), size=font_size, font=font, halign="left", valign="center");
          }
        }
      }

      // concave radius
      translate([0, width - radius - 2, -_fudge]) {
        cylinder(h=thickness + _fudge*2, r=radius, $fa = 4, $fs = 0.5);
      }

      // concave radius offset
      translate([-_fudge, -_fudge, -_fudge]) {
        cube([radius+_fudge, width-radius-2+_fudge, thickness + _fudge * 2], center=false);
      }
    }
  }
}

function gaugeWidth(radius) = max(radius * 2, font_size + 2);

module nextGauge(i) {
  if (i < len(sizes)) {
    radius = sizes[i];
    width = gaugeWidth(radius);
    drawGauge(radius, width);
    translate([0, width + 3, 0]) {
      nextGauge(i+ 1);
    }
  }
}

module createBox() {
  wall_thickness = thickness;
  bevel = 1;

  // put box off to the side
  translate([-(gaugeWidth(max(sizes))/2 + wall_thickness + 10), 0, 0]) {
    difference() {
      union() {
        for(i=[0:len(sizes)-2]) {
          current_width = gaugeWidth(sizes[i]);
          next_width = gaugeWidth(sizes[i+1]);
          hull() {
            translate([0, 2 + i * (thickness + 2), 0]) {
              // draw box around current slot
              translate([0, 0, _boxHeight/2]) {
                cube([current_width + wall_thickness/2  + tolerance + 4, wall_thickness * 3 + tolerance, _boxHeight], center=true);
              }

              // draw shorter, larger box around current slot for bevel
              translate([0, 0, (_boxHeight-bevel)/2]) {
                cube([current_width + wall_thickness/2  + tolerance + 4 + bevel * 2, wall_thickness * 3 + tolerance + bevel * 2, _boxHeight-bevel], center=true);
              }
            }

            translate([0,  2 + (i + 1) * (thickness+2), 0]) {
              // draw box around next slot
              translate([0, 0, _boxHeight/2]) {
                cube([next_width + wall_thickness/2 + tolerance + 4, wall_thickness * 3 + tolerance, _boxHeight], center=true);
              }

              // draw shorter, larger box around next slot for bevel
              translate([0, 0, (_boxHeight-bevel)/2]) {
                cube([next_width + wall_thickness/2 + tolerance + 4 + bevel * 2, wall_thickness * 3 + tolerance + bevel * 2, _boxHeight-bevel], center=true);
              }
            }
          }
        }
      }

      // cut out slots for gauges
      for(i=[0:len(sizes)-1]) {
        width = gaugeWidth(sizes[i]);
        slot_y = 2 + i * (thickness + 2) - (thickness + tolerance) / 2;

        difference() {
          translate([-(width/2 + tolerance), slot_y, 4]) {
            cube([width + 2 * tolerance, thickness + 2 * tolerance, _boxHeight], center=false);
          }

          if(friction_fit > 0) {
            translate([-1, slot_y, 4]) {
              cube([2, friction_fit, _boxHeight], center=false);
            }
          }
        }
      }
    }
  }
}

nextGauge(0);
createBox();
