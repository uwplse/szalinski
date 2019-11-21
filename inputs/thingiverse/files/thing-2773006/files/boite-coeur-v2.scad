// heart box
// CC-by cquest
// January 2018

h = 50; // box height
cap = 10; // box cap height
spacing = 1; // between box and cap
thickness = 2; // wall thickness
base = 45; // heart square base
base_ext = 60 + thickness+2;
t = -30; // twist angle

// draw flat heart shape
 module flat_heart(b) {
  square(b);

  translate([b/2, b, 0])
  circle(b/2);

  translate([b, b/2, 0])
  circle(b/2);
}

// cap
translate([base*2,base/2,0]) rotate([180,0,0])  // comment to see result
rotate([180,0,0]) difference() {
    // outer part
    linear_extrude(height = h, twist=t, center = true,  $fn=100, slices=h)
    translate([-base/1.414,-base/1.414,0]) // center it
    flat_heart(base);

    // inner part
    difference() {
        linear_extrude(height = h, twist=t, center = true,  $fn=100, slices=h)
        offset(delta=-thickness)
        translate([-base/1.414,-base/1.414,0]) // center it
        flat_heart(base);

    // bottom side
        translate([-base,-base,-h/2]) cube([base*2,base*2,thickness]);
    }
 
    // bottom side
        translate([-base,-base,h/2-(h-cap)]) cube([base*2,base*2,h-cap]);
}

// box
color("red") rotate([180,0,0]) difference()  {
    // outer part
    linear_extrude(height = h, twist=t, center = true,  $fn=100, slices=h)
    offset(delta=-thickness-spacing)
    translate([-base/1.414,-base/1.414,0]) // center it
    flat_heart(base);
    
    // inner part
    difference() {
        linear_extrude(height = h, twist=t, center = true,  $fn=100, slices=h)
        offset(delta=-thickness-spacing-thickness)
        translate([-base/1.414,-base/1.414,0]) // center it
        flat_heart(base);

        // top side
        translate([-base,-base,+h/2-thickness]) cube([base*2,base*2,thickness]);
    }
        // bottom side
        translate([-base,-base,-h/2]) cube([base*2,base*2,thickness]);
}