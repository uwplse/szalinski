// Create an equivalent for rotate_extrude that does spirals
// This also allows sweeping of an angle, as that is only supported on
// versions after 2015.03, of which there are none
// Creative Commons - Attribution - Share Alike License
// http://creativecommons.org/licenses/by-sa/3.0/

/* [Parameters] */
// Angle to sweep through
angle = 720;
// Amount to offset the spiral over the entire sweep
offset = 50;
// Radius of sweep rotation
spiral_radius = 50;
// Scale radius during sweep
scale_radius = 1.5;
// Width of shape
shape_width = 10;
// Scale shape during sweep
scale_shape = 2.0;
// Twist shape during sweep
twist_angle = 720;
// Shape to extrude
join_type = "union"; // [union:Join child shapes,difference:Subtract later child shapes from the first one,intersection:Find the intersection of thechild shapes]
shape = "moebius"; // [semicircle:Semicircle(demonstrates intersection),square:Square(simple shape),diamond:Diamond(demonstrates simple rotated shape),tube:Tube(demonstrates difference),moebius:Moebius strip,ouroboros:Tube that swallows itself(unprintable but fun),spring:Spring(complex example),custom:Custom shape]
/* [Spring] */
// Diameter of Spring
spring_diameter = 30;
// Length of Spring
spring_length = 100;
// Diameter of Spring wire
spring_wire_diameter = 5;
// Number of close-packed coils at each end
spring_end_coils = 1.5;
// Spacing of middle coils (Approximate)
spring_spacing = 15;
/* [Custom] */
// Custom shape
custom_polygon = [[[-4,-4],[-4,4],[4,4],[4,-4]],[[0,1,2,3]]]; // [draw_polygon:10x10]

/* [Hidden] */
outer_circularity = 36;
inner_circularity = 12;

maxValue = 10000;

if (shape == "ouroboros") {
  rotate_extrude_helix(angle = 720, radius = spiral_radius, scaleRadius = 1, scaleShape = 8, twistAngle = 0, offset = 0, center = false, joinType = "difference") {
    circle(r = shape_width / 2);
    circle(r = shape_width / 2.5);
  }
} else if (shape == "spring") {
  shape_spring(diameter = spring_diameter, wireDiameter = spring_wire_diameter, length = spring_length, endCoils = spring_end_coils, coilSpacing = spring_spacing);
} else if (shape == "semicircle") {
  rotate_extrude_helix(angle = angle, radius = spiral_radius, scaleRadius = scale_radius, scaleShape = scale_shape, twistAngle = twist_angle, offset = offset, center = false, joinType = "intersection") {
    circle(r = shape_width / 2);
    translate([shape_width / 2, 0, 0]) {
      square(size = shape_width, center = true);
    }
  }
} else if (shape == "circle") {
  rotate_extrude_helix(angle = angle, radius = spiral_radius, scaleRadius = scale_radius, scaleShape = scale_shape, twistAngle = twist_angle, offset = offset, center = false, joinType = join_type) {
    circle(r = shape_width / 2);
  }
} else if (shape == "moebius") {
  rotate_extrude_helix(angle = 360, radius = spiral_radius, twistAngle = 180, center = false, joinType = join_type) {
    square(size = [shape_width, 3 * shape_width], center = true);
  }
} else if (shape == "square") {
  rotate_extrude_helix(angle = angle, radius = spiral_radius, scaleRadius = scale_radius, scaleShape = scale_shape, twistAngle = twist_angle, offset = offset, center = false, joinType = join_type) {
    square(size = shape_width, center = true);
  }
} else if (shape == "cross") {
  rotate_extrude_helix(angle = angle, radius = spiral_radius, scaleRadius = scale_radius, scaleShape = scale_shape, twistAngle = twist_angle, offset = offset, center = false, joinType = join_type) {
    square(size = [shape_width, shape_width / 3], center = true);
    square(size = [shape_width / 3, shape_width], center = true);
  }
} else if (shape == "diamond") {
  rotate_extrude_helix(angle = angle, radius = spiral_radius, scaleRadius = scale_radius, scaleShape = scale_shape, twistAngle = twist_angle, offset = offset, center = false, joinType = join_type) {
    rotate([0, 0, 45]) {
      square(size = shape_width / sqrt(2), center = true);
    }
  }
} else if (shape == "custom") {
  rotate_extrude_helix(angle = angle, radius = spiral_radius, scaleRadius = scale_radius, scaleShape = scale_shape, twistAngle = twist_angle, offset = offset, center = false, joinType = join_type) {
    for(poly = [custom_polygon[1]]) {
      polygon(custom_polygon[0], poly);
    }
  }
} else if (shape == "tube") {
  rotate_extrude_helix(angle = angle, radius = spiral_radius, scaleRadius = scale_radius, scaleShape = scale_shape, twistAngle = twist_angle, offset = offset, center = false, joinType = "difference") {
    circle(r = shape_width / 2);
    circle(r = shape_width / 2.5);
  }
}

module segment(radius, segmentIndex, deltaAngle, deltaOffset, deltaScaleShape, deltaScaleRadius, deltaTwistAngle, subtract = false) {
  angle1 = segmentIndex * deltaAngle - (subtract ? 0.01 : 0);
  offset1 = segmentIndex * deltaOffset;
  scaledRadius1 = (1.0 + segmentIndex * deltaScaleRadius) * radius;
  scaledScale1 = 1.0 + segmentIndex * deltaScaleShape;
  scaledTwist1 = segmentIndex * deltaTwistAngle;
  angle2 = (segmentIndex + 1) * deltaAngle + (subtract ? 0.01 : 0);
  offset2 = (segmentIndex + 1) * deltaOffset;
  scaledRadius2 = (1.0 + (segmentIndex + 1) * deltaScaleRadius) * radius;
  scaledScale2 = 1.0 + (segmentIndex + 1) * deltaScaleShape;
  scaledTwist2 = (segmentIndex + 1) * deltaTwistAngle;
  hull() {
    translate([0, 0, offset1]) {
      rotate([0, 0, angle1]) {
        rotate([90, 0, 0]) {
          linear_extrude(height = .01, center = true) {
            translate([scaledRadius1, 0, 0]) {
              scale([scaledScale1, scaledScale1, 1]) {
                rotate([0, 0, scaledTwist1]) {
                  children();
                }
              }
            }
          }
        }
      }
    }
    translate([0, 0, offset2]) {
      rotate([0, 0, angle2]) {
        rotate([90, 0, 0]) {
          linear_extrude(height = .01, center = true) {
            translate([scaledRadius2, 0, 0]) {
              scale([scaledScale2, scaledScale2, 1]) {
                rotate([0, 0, scaledTwist2]) {
                  children();
                }
              }
            }
          }
        }
      }
    }
  }
}

module rotate_extrude_helix(angle = 360, radius = 0, offset = 0, scaleShape = 1.0, scaleRadius = 1.0, twistAngle = 0, center = false, $fn = outer_circularity, joinType = "union") {
  n = max(2, ceil($fn * abs(angle) / 360));
 
  deltaAngle = angle / n;
  deltaTwistAngle = twistAngle / n;
  deltaOffset = offset / n;
  deltaScaleRadius = (scaleRadius - 1.0) / n;
  deltaScaleShape = (scaleShape - 1.0) / n;

  translate([0, 0, center ? -offset / 2 : 0]) {
    union() {
      if ($children > 0) {
        for (i = [0 : n - 1]) {
          if (joinType == "difference") {
            difference() {
              segment(radius, segmentIndex = i, deltaAngle = deltaAngle, deltaOffset = deltaOffset, deltaScaleShape = deltaScaleShape, deltaScaleRadius = deltaScaleRadius, deltaTwistAngle = deltaTwistAngle) {
                children(0);
              }
              if ($children > 1) {
                for (childIndex = [1 : $children - 1]) {
                  segment(radius, segmentIndex = i, deltaAngle = deltaAngle, deltaOffset = deltaOffset, deltaScaleShape = deltaScaleShape, deltaScaleRadius = deltaScaleRadius, deltaTwistAngle = deltaTwistAngle, subtract = true) {
                    children(childIndex);
                  }
                }
              }
            }
          } else if (joinType == "intersection") {
            intersection_for(childIndex = [0 : $children - 1]) {
              segment(radius, segmentIndex = i, deltaAngle = deltaAngle, deltaOffset = deltaOffset, deltaScaleShape = deltaScaleShape, deltaScaleRadius = deltaScaleRadius, deltaTwistAngle = deltaTwistAngle) {
                children(childIndex);
              }
            }
          } else {
            union() {
              for (childIndex = [0 : $children - 1]) {
                segment(radius, segmentIndex = i, deltaAngle = deltaAngle, deltaOffset = deltaOffset, deltaScaleShape = deltaScaleShape, deltaScaleRadius = deltaScaleRadius, deltaTwistAngle = deltaTwistAngle) {
                  children(childIndex);
                }
              }
            }
          }
        }
      }
    }
  }
}

module shape_spring(diameter, wireDiameter, length, endCoils, coilSpacing) {
  radius = diameter / 2;
  wireRadius = wireDiameter / 2;
  endSpacing = wireDiameter + .1;
  endLength = endCoils * endSpacing;
  tryCoilLength = length - endLength * 2;
  coils = max(1, floor(tryCoilLength / coilSpacing) - 1);
  coilLength = coils * coilSpacing;
  transitionLength = (length - coilLength) / 2 - endLength;
  transitionCoils = 2;
  transitionSpacing = transitionLength / transitionCoils;

  intersection() {
    union() {
      rotate_extrude_helix(angle = endCoils * 360 + .01, radius = radius, offset = endLength, center = false) {
        circle(r = wireRadius, $fn = inner_circularity);
      }
      translate([0, 0, endLength]) {
        rotate([0, 0, endCoils * 360]) {
          rotate_extrude_helix(angle = transitionCoils * 360 + .01, radius = radius, offset = transitionLength, center = false) {
            circle(r = wireRadius, $fn = inner_circularity);
          }
        }
      }
      translate([0, 0, endLength + transitionLength]) {
        rotate([0, 0, (endCoils + transitionCoils) * 360]) {
          rotate_extrude_helix(angle = coils * 360 + .01, radius = radius, offset = coilLength, center = false) {
            circle(r = wireRadius, $fn = inner_circularity);
          }
        }
      }
      translate([0, 0, endLength + transitionLength + coilLength]) {
        rotate([0, 0, (endCoils + transitionCoils + coils) * 360]) {
          rotate_extrude_helix(angle = transitionCoils * 360 + .01, radius = radius, offset = transitionLength, center = false) {
            circle(r = wireRadius, $fn = inner_circularity);
          }
        }
      }
      translate([0, 0, endLength + 2 * transitionLength + coilLength]) {
        rotate([0, 0, (endCoils + 2 * transitionCoils + coils) * 360]) {
          rotate_extrude_helix(angle = endCoils * 360, radius = radius, offset = endLength, center = false) {
            circle(r = wireRadius, $fn = inner_circularity);
          }
        }
      }
    }
    translate([0, 0, length / 2]) {
      cube([maxValue, maxValue, length], center = true);
    }
  }
}
