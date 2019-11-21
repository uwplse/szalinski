/////////////////////////////////////////////////////////////////////////
//  
//  'Lighthouse' by Chris Molloy (http://chrismolloy.com/)
//  
//  Released under Creative Commons - Attribution - Share Alike licence
//  
/////////////////////////////////////////////////////////////////////////

// Radius of lighthouse stack bottom (in mm)
bottom_radius_mm = 100;

// Radius of lighthouse stack top (in mm). Should be smaller than bottom radius.
top_radius_mm = 50;

// Radius of lighthouse stack hollow centre (in mm). Should be smaller than top radius.
hole_radius_mm = 30;

// Height of lighthouse stack (in mm)
height_mm = 200;

// Number of courses (layers)
course_count = 10; // [3:100]

// Number of courses (layers) to skip from unit catenary (low number = more pronounced curve)
footer_skip = 2; // [1:100]

// Which single course (layer) to render. Useful if you want to create each course as an individual file. Zero = render all courses in a stack.
course_index = 0; // [0:100]

/* [Hidden] */
$fn = 100;
e = 2.718281828459045;

function cosh(x) = (pow(e, x) + pow(e, -x)) / 2;

function acosh(x) = ln(x + sqrt((x * x) - 1));

module lighthouse(bottomRadius = 10, topRadius = 5, holeRadius = 3, height = 20, courses = 10, footer = 2, course = 0) {
  bottomX = acosh(footer);
  topX = acosh(footer + courses);
  scaleZ = height / courses;
  scaleX = (bottomRadius - topRadius) / (topX - bottomX);
  centreX = (scaleX * topX) + topRadius;
  totalY = 0;

  scale([1, 1, scaleZ]) {
    if (course == 0) {
      for (z = [footer + 1: (footer + courses)]) {
        previousX = scaleX * acosh(z - 1);
        currentX = scaleX * acosh(z);
        color([z % 2, 1 - (z % 2), 0, 1]) {
          translate([0, 0, (z - 1) - footer]) {
            difference() {
              cylinder(h = 1, r1 = centreX - previousX, r2 = centreX - currentX);
              translate([0, 0, -0.5]) cylinder(h = 2, r = holeRadius);
            }
          }
        }
      }
    } else {
      z = footer + course;
      previousX = scaleX * acosh(z - 1);
      currentX = scaleX * acosh(z);
      difference() {
        cylinder(h = 1, r1 = centreX - previousX, r2 = centreX - currentX);
        translate([0, 0, -0.5]) cylinder(h = 2, r = holeRadius);
      }
    }
  }
}

lighthouse(bottomRadius = bottom_radius_mm, topRadius = top_radius_mm, holeRadius = hole_radius_mm, height = height_mm, courses = course_count, footer = footer_skip, course = course_index);

