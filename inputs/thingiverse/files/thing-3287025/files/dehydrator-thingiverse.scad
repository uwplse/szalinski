// This is a spacer for converting a food dehydrator into a filement dryer.
// Many of the available food dehydrators have the same shell diameter, 12 9/16" OD
// Mine is a Salton VitaPro, and I believe the Self-Mate is the same.
// I based this very heavily on: https://www.thingiverse.com/thing:3027142
// I had some issues with printing the inside curve, so I parameterised it to allow specifying
// curve resolutions for mating surfaces vs. non-mating surfaces
// I used my rotate-extrude-helix module heavily in this, it can be found at:
// https://www.thingiverse.com/thing:3252949
// Creative Commons - Attribution - Share Alike License
// http://creativecommons.org/licenses/by-sa/3.0/

// Thickness of the edge that inserts into the next layer
edge_thickness = 2.5;
// Height of the edge that inserts into the next layer
edge_height = 12.5;
// Thickness of the shell spacer section wall
shell_thickness = 3.5;
// Clearance between the mating surfaces between layers
shell_clearance = 0.5;
// Number of sides to the full circle for the non-mating surfaces
coarse_circularity = 48;
// Number of sides to the full circle for the mating surfaces, fine_circularity should be a multiple of coarse_circularity
fine_circularity = 144;
// Diameter of the centreline of the insert edge (12 9/16" OD)
sector_diameter = 310.5;
// Number of degrees in one section. If you had a big enough print surface, 360 would work
sector_angle = 60;
// Height between layers
sector_height = 100;
// Clearance between the mating surfaces of the tongue and groove joint between sections
joint_clearance = 0.3;
// Maximum thickness of the tongue and groove joint between sections
joint_outer_thickness = 7.0;
// Diameter of the 'tongue' section of the tongue and groove joint between sections
joint_inner_diameter = 3.0;
// Minimum thickness of the 'tongue' section of the tongue and groove joint between sections
joint_min_thickness = 1.4;
// Offset of the 'tongue' section of the tongue and groove joint between sections
joint_offset = 3.0;
// Diameter of the filament feed hole in mm. If zero, don't include it
feed_hole_diameter = 3;
// Angle of the filament feed hole in degrees
feed_hole_angle = 45;

/* [Hidden] */

sector(sectorAngle = sector_angle, sectorHeight = sector_height, sectorDiameter = sector_diameter, edgeThickness = edge_thickness, edgeHeight = edge_height, shellThickness = shell_thickness, shellClearance = shell_clearance, fineCircularity = fine_circularity, coarseCircularity = coarse_circularity, jointOffset = joint_offset, jointOuterThickness = joint_outer_thickness, jointMinThickness = joint_min_thickness, jointInnerDiameter = joint_inner_diameter, jointClearance = joint_clearance, feedHoleDiameter = feed_hole_diameter, feedHoleAngle = feed_hole_angle);

// The following modules are normally included, but the thingiverse customizer doesn't like that
//use <../helix/rotate-extrude-helix.scad>;

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

module rotate_extrude_helix(angle = 360, radius = 0, offset = 0, scaleShape = 1.0, scaleRadius = 1.0, twistAngle = 0, center = false, joinType = "union") {
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

function outerRadius(innerRadius, sides) = innerRadius / cos(180 / sides);

function shellRadius(sectorRadius, edgeThickness, shellThickness, coarseCircularity) = sectorRadius - edgeThickness / 2 + shellThickness / 2;

function outerShellRadius(shellRadius, shellThickness, shellClearance, edgeThickness) = shellRadius + (edgeThickness + shellThickness) / 2 + shellClearance;
function outerShoulderHeight(edgeHeight, shellClearance) = edgeHeight + shellClearance;
function innerShoulderHeight(edgeHeight, shellThickness, shellClearance) = outerShoulderHeight(edgeHeight, shellClearance) + shellThickness + shellClearance;

module sector(sectorAngle, sectorHeight, sectorDiameter, edgeThickness, edgeHeight, shellThickness, shellClearance, fineCircularity, coarseCircularity, jointOffset, jointOuterThickness, jointMinThickness, jointInnerDiameter, jointClearance, feedHoleDiameter, feedHoleAngle) {
  sectorRadius = sectorDiameter / 2;
  shellRadius = shellRadius(sectorRadius, edgeThickness, shellThickness, coarseCircularity);
  outerShellRadius = outerShellRadius(shellRadius, shellThickness, shellClearance, edgeThickness);
  outerShoulderHeight = outerShoulderHeight(edgeHeight, shellClearance);
  innerShoulderHeight = innerShoulderHeight(edgeHeight, shellThickness, shellClearance);
  shellHeight = sectorHeight - outerShoulderHeight;
  effectiveSectorAngle = sectorAngle >= 360 ? 360.1 : sectorAngle;

  translate([0, 0, sectorHeight + edgeHeight]) {
    scale([1, -1, -1]) {
      difference() {
        union() {
          outerEdge(effectiveSectorAngle, sectorRadius = sectorRadius, edgeThickness = edgeThickness, edgeHeight = edgeHeight, shellRadius = shellRadius, shellThickness = shellThickness, shellClearance = shellClearance, fineCircularity = fineCircularity, coarseCircularity = coarseCircularity);
          translate([0, 0, outerShoulderHeight]) {
            shell(effectiveSectorAngle, sectorRadius = sectorRadius, shellThickness = shellThickness, shellHeight = shellHeight, edgeThickness = edgeThickness, fineCircularity = fineCircularity, coarseCircularity = coarseCircularity);
          }
          translate([0, 0, sector_height]) {
            innerEdge(effectiveSectorAngle, sectorRadius = sectorRadius, edgeThickness = edgeThickness, edgeHeight = edgeHeight, fineCircularity = fineCircularity, coarseCircularity = coarseCircularity);
          }

          if (sectorAngle < 360) {
            rotate([0, 0, 0]) {
              translate([sectorRadius + (edgeThickness - jointOuterThickness) / 2, 0, outerShoulderHeight]) {
                jointBase(height = sectorHeight - shellClearance, offset = jointOffset, outerThickness = jointOuterThickness, minThickness = jointMinThickness, innerDiameter = jointInnerDiameter, clearance = jointClearance);
                jointMale(height = sectorHeight - shellClearance, offset = jointOffset, outerThickness = jointOuterThickness, minThickness = jointMinThickness, innerDiameter = jointInnerDiameter, clearance = jointClearance);
              }
            }
            rotate([0, 0, sectorAngle]) {
              scale([1, -1, 1]) {
                translate([sectorRadius + (edgeThickness - jointOuterThickness) / 2, 0, outerShoulderHeight]) {
                  jointBase(height = sectorHeight - shellClearance, offset = jointOffset, outerThickness = jointOuterThickness, minThickness = jointMinThickness, innerDiameter = jointInnerDiameter, clearance = jointClearance);
                }
              }
            }
          }
        }
        if (sectorAngle < 360) {
          rotate([0, 0, sectorAngle]) {
            scale([1, -1, 1]) {
              translate([sectorRadius + (edgeThickness - jointOuterThickness) / 2, 0, outerShoulderHeight]) {
                jointFemale(height = sectorHeight - shellClearance, offset = jointOffset, outerThickness = jointOuterThickness, minThickness = jointMinThickness, innerDiameter = jointInnerDiameter, clearance = jointClearance);
              }
            }
          }
        }
        if (feedHoleDiameter > 0) {
          rotate([0, 0, sectorAngle / 2]) {
            translate([sectorRadius, 0, (edgeHeight + sectorHeight) / 2]) {
              rotate([0, 90, 90 - feedHoleAngle]) {
                cylinder(r = feedHoleDiameter / 2, h = 100, center = true, $fn = 16);
              }
            }
          }
        }
      }
    }
  }
}

module outerEdge(sectorAngle, sectorRadius, edgeThickness, edgeHeight, shellRadius, shellThickness, shellClearance, fineCircularity, coarseCircularity) {
  outerShellRadius = outerShellRadius(shellRadius, shellThickness, shellClearance, edgeThickness);
  outerShoulderHeight = outerShoulderHeight(edgeHeight, shellClearance);
  innerShoulderHeight = innerShoulderHeight(edgeHeight, shellThickness, shellClearance);

  difference() {
    rotate_extrude_helix(angle = sectorAngle, center = false, $fn = coarseCircularity) {
      polygon(points = [
        [0.1, 0],
        [outerShellRadius + shellThickness / 2, 0],
        [outerShellRadius + shellThickness / 2, outerShoulderHeight],
        [shellRadius + shellThickness / 2, innerShoulderHeight + 0.01],
        [0.1, innerShoulderHeight + 0.01]
      ]);
    }
    rotate([0, 0, -0.1]) {
      rotate_extrude_helix(angle = sectorAngle + 0.2, center = false, $fn = fineCircularity) {
        translate([0, -0.01, 0]) {
          square(size = [sectorRadius + shellClearance + edgeThickness / 2, outerShoulderHeight + 0.01], center = false);
        }
        translate([0, -0.01, 0]) {
          square(size = [sectorRadius - edgeThickness / 3, innerShoulderHeight + 0.03], center = false);
        }
      }
    }
  }
}

module shell(sectorAngle, sectorRadius, shellThickness, shellHeight, edgeThickness, fineCircularity, coarseCircularity) {
  shellRadius = shellRadius(sectorRadius, edgeThickness, shellThickness, coarseCircularity);
  difference() {
    rotate_extrude_helix(angle = sectorAngle, center = false, $fn = coarseCircularity, joinType = "difference") {
      translate([shellRadius, shellHeight / 2 + 0.01, 0]) {
        square(size = [shellThickness, shellHeight + 0.02], center = true);
      }
    }
    rotate([0, 0, -0.1]) {
      union() {
        rotate_extrude_helix(angle = sectorAngle + 0.2, center = false, $fn = fineCircularity) {
          polygon(points = [
            [sectorRadius + edgeThickness / 2 - shellThickness, shellHeight + shellThickness],
            [sectorRadius + edgeThickness / 2 + shellThickness, shellHeight + shellThickness],
            [sectorRadius + edgeThickness / 2 + shellThickness, shellHeight - shellThickness]
          ]);
        }
      }
    }
  }
}

module innerEdge(sectorAngle, sectorRadius, edgeThickness, edgeHeight, fineCircularity, coarseCircularity) {
  difference() {
    rotate_extrude_helix(angle = sectorAngle, radius = sectorRadius, center = false, $fn = fineCircularity) {
      translate([-edgeThickness / 2, edgeHeight / 2, 0]) {
        square(size = [2 * edgeThickness, edgeHeight], center = true);
      }
    }
    rotate_extrude_helix(angle = sectorAngle, radius = sectorRadius, center = false, $fn = coarseCircularity) {
      translate([-3 * edgeThickness / 2, edgeHeight / 2, 0]) {
        square(size = [2 * edgeThickness, edgeHeight + 0.02], center = true);
      }
    }
  }
}

module jointBase(height, offset, outerThickness, minThickness, innerDiameter, clearance) {
  linear_extrude(height = height, center = false) {
    union() {
      translate([0, offset / 2]) {
        square(size = [outerThickness, offset], center = true);
      }
      translate([0, offset]) {
        difference() {
          circle(r = outerThickness / 2, center = true, $fn = 16);
          translate([0, -3 * offset / 2]) {
            square(size = [outerThickness, offset], center = true);
      }
        }
      }
    }
  }
}

module jointMale(height, offset, outerThickness, minThickness, innerDiameter, clearance) {
  linear_extrude(height = height, center = false) {
    union() {
      translate([0, -offset / 2]) {
        square(size = [minThickness, offset + 0.02], center = true);
      }
      translate([0, -offset]) {
        circle(r = innerDiameter / 2, center = true, $fn = 16);
      }
    }
  }
}

module jointFemale(height, offset, outerThickness, minThickness, innerDiameter, clearance) {
  translate([0, 0, -0.01]) {
    linear_extrude(height = height + 0.02, center = false) {
      union() {
        translate([0, offset / 2]) {
          square(size = [minThickness + 2 * clearance, offset + 0.02], center = true);
        }
        translate([0, offset]) {
          circle(r = innerDiameter / 2 + clearance, center = true, $fn = 16);
        }
      }
    }
  }
}

