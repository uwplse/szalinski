/* Customizable rose algorithm :
 * http://en.wikipedia.org/wiki/Rose_(mathematics)
 */
// preview[view:south, tilt:top]

// Numerator of the coefficient value of the equation r=sin((n/d)theta)
n=8; // [1:100]
// Denumerator of the coefficient value of the equation r=sin((n/d)theta)
d=1; // [1:50]
// 3D effect to add to the rose (rose pattern will only appear if seen directly from above)
3d_effect="none"; // ["none":None, "cosinus":Cosinus, "sinus":Sinus, "sincos":Sinus and cosinus, "rose":Rose]
// Number of points to use for drawing the rose
points = 2000; // [0:5000]
// Enable this to avoid gaps between points in the curve, but it will take a lot longer to render
high_detail = "false"; // ["true":Enabled, "false":Disabled]
// The type of pencil to use to draw the rose
pencil="sphere"; // ["sphere":Sphere, "cylinder":Cylinder, "cube":Cube]
// Size in millimeters of the pencil used to draw the rose
pencil_size=1;
// The thickness in millimeters of the rose
rose_thickness=1;
// Size in millimeters of the radius of the generated rose
rose_radius=25;
// Resolution for curves
$fn = 10; // [5:25]

iterations=360 * d;
k = n / d;
 // Normalized tree can't have more than 4000 elements, otherwise openSCAD aborts the rendering
increment= iterations / points;

module object() {
  size = pencil_size / rose_radius;
  height = rose_thickness / rose_radius;
  if (pencil == "sphere") {
    hull() {
      sphere(size);
      translate([0, 0, height]) sphere(size);
    }
  } else if (pencil == "cube") {
    cube([size, size, height]);
  } else if (pencil == "cylinder") {
    cylinder(r=size, h=height);
  }
}

function z(t) = (3d_effect == "cosinus") ? cos(t) : 
  ((3d_effect == "sinus") ? sin(t) : 
   ((3d_effect == "sincos") ? cos(k) * sin(t) : 
    ((3d_effect == "rose") ? cos(k * t) * sin(k  * t) : 
     0)));

scale(rose_radius) {
  for (t = [0:increment:iterations]) {
    if (high_detail == "true") {
      hull () {
        translate([cos(k * t) * sin (t), cos(k * t) * cos(t), z(t)]) object();
        translate([cos(k * (t + increment)) * sin (t + increment),
                   cos(k * (t + increment)) * cos(t + increment),
                   z(t + increment)]) object();
      }
    } else {
      translate([cos(k * t) * sin (t), cos(k * t) * cos(t), z(t)]) object();
    }
  }
}

