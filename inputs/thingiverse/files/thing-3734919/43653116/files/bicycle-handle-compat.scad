/* [Part] */

part = "handle"; // [handle,text]

/* [Measurements] */

// Handle inner diameter (measure your bicycle)
inner_diameter = 22;
// Handle thickness
thickness = 5;
// Handle groove depth
groove_depth = 2;
// Handle width
width_hold = 82;
// Hand protector diameter
protector_diameter = 42;
// Hand protector width
protector_width = 7;
// Cap text
cap_text = "TK";

/* [Quality] */

// Minimum angle for a fragment (STL was rendered with 10).
$fa = 20;
// Minimum size of a fragment (STL was rendered with 1).
$fs = 2.5;
// Handle groove delta angle (STL was rendered with 10).
da = 20;


/* [Hidden] */

inner_radius = inner_diameter / 2;
outer_radius = inner_radius + thickness;
groove_inner_radius = inner_radius + thickness - groove_depth;
protector_radius = protector_diameter / 2;


// **** geometry
if (part == "handle") {
  difference() {
    union() {

      // handle
      difference() {
        // outer cylinder
        cylinder(width_hold, outer_radius, outer_radius);

        // make hollow
        translate([0,0,width_hold * -0.05])
          cylinder(width_hold * 1.1, inner_radius, inner_radius);

        // make grooves (helix)
        groove_r = outer_radius + groove_depth * 0.5;
        groove_total_angle = 360*width_hold/10;
        union() {
          for (a = [0:da:groove_total_angle]) hull() {
            translate([cos(a)*outer_radius, sin(a)*groove_r, a / groove_total_angle * width_hold])
            sphere(groove_depth);
            translate([cos(a+da)*outer_radius, sin(a+da)*groove_r, (a+da) / groove_total_angle * width_hold])
            sphere(groove_depth);
          }
        }

        // make grooves (cylinders)
        union() {
        for (a = [0:45:360])
          translate([cos(a)*outer_radius, sin(a)*outer_radius, 0])
          translate([0,0,width_hold * -0.05])
            cylinder(width_hold * 1.1, groove_depth, groove_depth);
        }
      }

      // hand protector
      translate([0, 0, protector_width + width_hold])
        rotate_extrude(convexity = 10) {
          // 2d profile with fillets
          mirror([1,1])
          difference() {
            union() {
              square([protector_width, protector_radius], false);
              translate([protector_width,0,0])
              polygon(points = [[0,protector_radius], [protector_width/2,0], [0,0]]);
            }

            // fillet
            translate([-0.25 * protector_width, protector_radius - protector_width * 0.5])
              rotate([0,0,45])
              square(protector_width, false);
          }
        }
    }
      
    // carve text
    translate([0,0,protector_width + width_hold - protector_width * 0.3])
      linear_extrude(protector_width * 0.5)
        text(text = cap_text, size = 1 * protector_radius, font = "Impact", halign = "center", valign = "center", spacing = 1 );
  }
}
else if (part == "text") {
  linear_extrude(protector_width * 0.5)
    text(text = cap_text, size = 1 * protector_radius, font = "Impact", halign = "center", valign = "center", spacing = 1 );
}