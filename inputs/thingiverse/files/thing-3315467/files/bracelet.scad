// Bracelet with grooves for hair elastics, designed by Valerie West
// Creative Commons - Attribution - Share Alike License
// http://creativecommons.org/licenses/by-sa/3.0/

/* [Parameters] */
// Minimum inside diameter of bracelet in mm
min_bracelet_diameter = 60;
// Ratio of maximum to minimum inside diameter of bracelet
bracelet_ovality = 1.33;
// Maximum thickness of band (without grooves) in mm
band_thickness = 4.5;
// Ratio of maximum to minimum diameter of band (before clipping to width)
band_ovality = 2.7;
// Width of band in mm
band_width = 22;
// Diameter of grooves in mm
groove_diameter = 3;
// Depth of thumb groove below the deepest grooves in mm
thumb_groove_depth = 1.6;
// Minimum diameter of thumb groove in mm
min_thumb_groove_diameter = 20;
// Ratio of maximum to minimum diameter of thumb groove
thumb_groove_ovality = 2.0;
// depth of inside chamfer to make iside corners less sharp in mm
inside_chamfer = 1.0;
/* [Circularity] */
bracelet_circularity = 72;
band_circularity = 36;
groove_circularity = 12;
thumb_groove_circularity = 72;

/* [Hidden] */
min_band_radius = band_thickness;
min_bracelet_radius = min_bracelet_diameter / 2;
groove_radius = groove_diameter / 2;
min_thumb_groove_radius = min_thumb_groove_diameter / 2;

angle = asin((band_width / (4 * band_ovality)) / (min_band_radius));
inner_groove_offset = cos(angle) * min_band_radius;
outer_groove_offset = min_band_radius;

translate([0, 0, band_width / 2]) {
  difference() {
    scale([bracelet_ovality, 1, 1]) {
      difference() {
        rotate_extrude(convexity = 10, $fn = bracelet_circularity) {
          translate([min_bracelet_radius, 0, 0]) {
            difference() {
              scale([1, band_ovality, 1]) {
                intersection() {
                  circle(r = min_band_radius, $fn = band_circularity);
                  translate([min_band_radius * 2, 0, 0]) {
                    square(size = [min_band_radius * 4, band_width / band_ovality], center = true);
                  }
                }
              }
              translate([outer_groove_offset, 0, 0]) {
                circle(r = groove_radius, $fn = groove_circularity);
              }
              translate([inner_groove_offset, band_width / 4, 0]) {
                circle(r = groove_radius, $fn = groove_circularity);
              }
              translate([inner_groove_offset, -band_width / 4, 0]) {
                circle(r = groove_radius, $fn = groove_circularity);
              }
            }
          }
        }
        translate([0, 0, band_width / 2 + 0.01 - inside_chamfer]) {
          cylinder(r1 = min_bracelet_radius - 0.01, r2 = min_bracelet_radius + inside_chamfer + 0.01, h = inside_chamfer + 0.02, $fn = bracelet_circularity);
        }
        translate([0, 0, 0.01 - band_width / 2]) {
          cylinder(r1 = min_bracelet_radius + inside_chamfer + 0.01, r2 = min_bracelet_radius - 0.01, h = inside_chamfer + 0.02, $fn = bracelet_circularity);
        }
      }
    }
    translate([0, -(min_bracelet_radius + min_thumb_groove_radius + inner_groove_offset - thumb_groove_depth), 0]) {
      scale([thumb_groove_ovality, 1, 1]) {
        cylinder(r = min_thumb_groove_radius, h = band_width, center = true, $fn = thumb_groove_circularity);
      }
    }
  }
}
