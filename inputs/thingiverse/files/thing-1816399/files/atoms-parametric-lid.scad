// Here is a simple parametric lid generator with support
// for rounded edges and a lip at the top and bottom of the lid
// enjoy

/* [Dimensions] */

// inner diameter of lid in millimeters
lidDiameter = 128.5;

// inner height of lid in millimeters
lidHeight = 8.5; 

// thickness of top and sides in millimeters
wallThickness = 1.2;

// radius of top lip in millimeters
topLip = 1.2;

// radius of bottom lip in millimeters
bottomLip = 1.2;

/* [Components] */

// Enable the top
draw_top = 1; // [0:1]

// Enable the walls
draw_walls = 1; // [0:1]

// Enable the bottom lip
draw_bottom_lip = 0; // [0:1]

// Enable the bottom edge
draw_bottom_edge = 1; // [0:1]

/* [Hidden] */
$fn=60;



// top
if (draw_top) 
difference() {
    union() {
        rotate_extrude(convexity = 5, slices = 90)
            translate([lidDiameter / 2, 0, 0])
                circle(r = topLip);
        translate([0, 0, (wallThickness / 2) - topLip])
            cylinder(h = wallThickness,
                     r1 = lidDiameter / 2,
                     r2 = lidDiameter / 2,
                     center=true);
    } // union
    translate([0, 0, lidHeight / 2])
      cylinder(h = lidHeight - wallThickness,
       r1 = lidDiameter / 2,
       r2 = lidDiameter / 2,
       center = true);
} // difference

// walls
if (draw_walls)
translate([0, 0, lidHeight / 2])
  difference() {
    cylinder(h = lidHeight,
             r1 = lidDiameter / 2 + wallThickness,
             r2 = lidDiameter / 2 + wallThickness,
             center = true);
    cylinder(h = lidHeight + 1,
             r1 = lidDiameter / 2,
             r2 = lidDiameter / 2,
             center = true);
  } // difference

// bottom lip
if (draw_bottom_lip)
translate([0,0,lidHeight])
  rotate_extrude(convexity = 5, slices = 90)
    translate([lidDiameter / 2, 0, 0])
        circle(r = bottomLip);

// curved edge around bottom
if (draw_bottom_edge)
translate([0,0,lidHeight])
  rotate_extrude(convexity = 5, slices = 90)
    translate([(lidDiameter + wallThickness) / 2, 0, 0])
        circle(r = wallThickness / 2);
