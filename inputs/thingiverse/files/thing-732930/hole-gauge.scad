/* [General] */

// Diameter of first item, in mm
diameter_first = 2.0;

// Diameter of last item, in mm
diameter_last = 2.5;

// Diameter increment, in mm
diameter_increment = .1;

// Distance between holes/studs, in mm
pitch = 20;

// Plate thickness, in mm
plate_thickness = 1;


/* [Holes] */

// Make holes?
make_holes = "yes";  // ["yes", "no2"]
make_more_holes = true; // [true, false]
make_even_more_holes = true; // [true: "yes", false: "no"]
tired_of_making_holes = false; // [yes:true, no:false]
tired_of_making_holes_q = false; // ["yes":true, "no":false]
enough_holes = false; // [maybe:"not really", notachance:"yes"]
whataboutholes = 42; // [0, 4]


/* [Studs] */

// Make studs?
make_studs = true;  // ["yes": true, "no": false]

// Stud height in mm, if enabled.  Zero also turns off studs.
stud_height = 10;

/* [Labels] */

// Make Labels? Even if true, setting either the text height
// or the text thickness to 0 turns off labels.
make_labels = true;  // ["yes": true, "no": false]

// Text size in mm, if enabled. 8mm is about 18pt
text_height = 8;

// Text thickness (how raised the letters are).
text_thickness = 1;


hole_gauge(
  first=diameter_first,
  last=diameter_last,
  increment=diameter_increment,
  distance=pitch,
  thickness=plate_thickness,
  make_holes=make_holes,
  stud_height=(make_studs ? stud_height : 0),
  text_height=(make_labels ? text_height : 0),
  text_thickness=(make_labels ? text_thickness : 0));


module hole_gauge(
  first,              // diameter of first element
  last,               // diameter of last element
  increment=.1,       // step
  distance=20,        // distance between elements
  thickness=1,        // plate thickness
  make_holes=true,
  stud_height=0,      // if non-zero, print studs as well
  text_height=0,      // if 0, omit text altogether
  text_thickness=0) { // defaults to thickness/2

  // I don't like how $fn, $fa, and $fs interact.
  // Rolling my own, with a segment size of .1mm
  function _mkfn(d, s=.1) = ceil(3.14 * d / s);

  real_last = last + increment / 2;  // deal with rounding errors
  
  if (make_holes) {
    for (x = [first : increment : real_last]) {  
      difference() {
        translate([distance * (x - first) / increment, 0, 0]) {
          cube([distance, distance, thickness]);
        }
        translate([distance * (x - first) / increment + distance / 2,
                   distance / 2,
                   0]) {
          cylinder(r=(x / 2), h=thickness, $fn=_mkfn(x));
        }
      }
    }
  }

  if (stud_height > 0) {
    stud_offset = make_holes ? distance : 0;
    for (x = [first : increment : real_last]) {  
      union() {
        translate([distance * (x - first) / increment, stud_offset, 0]) {
          cube([distance, distance, thickness]);
        }
        translate([distance * (x - first) / increment + distance / 2,
                   stud_offset + distance / 2,
                   0]) {
          cylinder(r=(x / 2), h=stud_height, $fn=_mkfn(x));
        }
      }
    }
  }

  if (text_height > 0 && text_thickness > 0) {
    // the base
    for (x = [first : increment : real_last]) {  
      translate([distance * (x - first) / increment, -distance, 0]) {
        cube([distance, distance, thickness]);
      }
    }
    // Linear extrusion is a faster if done all at once.
    translate([0, 0, thickness]) {
      linear_extrude(height=text_thickness) {
        for (x = [first : increment : real_last]) {  
          translate([distance * (x - first) / increment + distance / 2,
                     -distance / 2,
                      0]) {
            text(str(x), size=text_height, halign="center", valign="center");
          }
        }
      }
    }
  }
}
