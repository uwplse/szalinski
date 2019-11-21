/* [General Settings] */
// Resolution of mesh.  Smaller numbers make for smoother surface, but with increased STL file size.
resolution = 0.5; // [0.2:.1:5]
// Select which object(s) to display
display = "lid"; // ["lid", "cup", "both"]
// Show 2D section of object(s)
cross_section = 0; // [0: "no", 1:"yes"]


/* [Lid] */
// Thickness of lid top and sides
lidTh = 1.6;
// Amount of indentation along the radius to help catch on the lip.  Should affect how positive the snap of the lid is.
lidIndent = 0.4;
// Amount of extra radius to add, for an easier fit onto cup.  Depends on tolerances of the 3D printer.  This counteracts the lidIndent to some degree.
lidRadiusClearance = 0.25;


/* [Cup] */
// Total measured height of cup from top to bottom
totalHeight = 144;
// Outer Diameter of cup from top
topOD = 90;
// Outer Diameter of cup at bottom, before it is reduce by bottom radius
bottomOD = 69;
// Radius of bottom of cup
bottomRadius = 2.5;

// Width of lip measured from above.  The "lip" is feature at top of the cup that allows the lid to snap on.
lipWidth = 2.25;
// Height of top lip
lipHeight = 2.5;
// Radial depth from outside of top lip to outside of "ridge"
lipDepth = 1.4;

// Height of "ridge".  The ridge is what I'm calling the small straight section below the lip.
ridgeHeight = 16;
// Radial depth from outside of ridge to outside of cup wall below
ridgeDepth = 1.2;

main();

module main() {
  $fa = 0.1;
  $fs = resolution;
  if (display == "lid")
    lid(topOD, lipHeight, lipDepth, lidTh, lidIndent, lidRadiusClearance, cross_section);

  if (display == "both") {
    cup(totalHeight, topOD, bottomOD, bottomRadius,
        lipWidth, lipHeight, lipDepth,
        ridgeHeight, ridgeDepth, cross_section);

    if (cross_section) {
      rotate(180) translate([0,-totalHeight-lidTh]) 
        lid(topOD, lipHeight, lipDepth, lidTh, lidIndent, lidRadiusClearance, cross_section);
    } else {
      rotate([180,0]) translate([0,0,-totalHeight-lidTh]) 
        lid(topOD, lipHeight, lipDepth, lidTh, lidIndent, lidRadiusClearance, cross_section);
    }
  }

  if (display == "cup") {
  echo("FUCKO");
    cup(totalHeight, topOD, bottomOD, bottomRadius,
        lipWidth, lipHeight, lipDepth,
        ridgeHeight, ridgeDepth, cross_section);
  }
}

module cup(totalHeight, topOD, bottomOD, bottomRadius,
           lipWidth, lipHeight, lipDepth, 
           ridgeHeight, ridgeWidth, cross_section=false) {
  cupTh = lipWidth - lipDepth;
  lipTh = lipDepth / 2;

  y0 = totalHeight;
  y1 = y0 - lipHeight;
  y2 = y1 - ridgeHeight;

  x0 = topOD/2;
  x1 = x0 - lipDepth;
  x2 = x1 - ridgeDepth;

  points = concat(
    arc(r=bottomRadius, angle=90, offsetAngle=-90, c=[bottomOD / 2 - bottomRadius, bottomRadius]),
    [
      [x2, y2], [x1, y2],
      [x1, y0-lipTh], [x0 - cupTh, y0-lipTh], 
      [x0 - cupTh, y1], [x0, y1],
      [x0, y0], [x0 - lipWidth, y0],
      [x0 - lipWidth, y2 + cupTh], [x0 - lipWidth - cupTh, y2 + cupTh], 
      [bottomOD/2-cupTh, bottomRadius],
    ],
    arc(r=bottomRadius-cupTh, angle=-90, c=[bottomOD / 2 - bottomRadius, bottomRadius]),
    [ [0,cupTh], [0,0] ]
  );

  if (cross_section) {
    color("white") linear_extrude(height=0.1) 
      for(x=[0,1]) mirror([x,0])
      poly2d(points);
  } else {
    color("white") rotate_extrude() 
      poly2d(points);
  }
}

module lid(cupTopOD, cupLipHeight, cupLipDepth, lidTh, lidIndent, radiusClearance, cross_section=false) {
  r = cupTopOD/2+radiusClearance;
  points = [
    [0,0], [r+lidTh, 0],
    [r+lidTh, lidTh+cupLipHeight*2], [r, lidTh+cupLipHeight*2],
    [r-lidIndent, lidTh+cupLipHeight*1.5], [r, lidTh+cupLipHeight],
    [r, lidTh], [0, lidTh]
  ];

  if (cross_section) {
    color("red") for(x=[0,1]) mirror([x,0]) 
      linear_extrude(height=0.1) poly2d(points);
  } else {
    color("red") rotate_extrude()
      poly2d(points);
  }
}


// functions and modules below copied from my FunctionalOpenSCAD library
// http://github.com/thehans/FunctionalOpenSCAD

// based on get_fragments_from_r documented on wiki
// https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language
function fragments(r=1) = ($fn > 0) ? 
  ($fn >= 3 ? $fn : 3) : 
  ceil(max(min(360.0 / $fa, r*2*PI / $fs), 5));

// Generate a list of points for a circular arc with center c, radius r, etc.
// "center" parameter centers the sweep of the arc about the offsetAngle (half to each side of it)
// "internal" parameter enables polyhole radius correction
function arc(r=1, angle=360, offsetAngle=0, c=[0,0], center=false, internal=false, d) = 
  let (
    r1 = d==undef ? r : d/2,
    fragments = ceil((abs(angle) / 360) * fragments(r1,$fn)),
    step = angle / fragments,
    a = offsetAngle-(center ? angle/2 : 0),
    R = internal ? to_internal(r1) : r1,
    last = (abs(angle) == 360 ? 1 : 0)
  )
  [ for (i = [0:fragments-last] ) let(a2=i*step+a) c+R*[cos(a2), sin(a2)] ];

function depth(a,n=0) = len(a) == undef ? n : depth(a[0],n+1);
function is_poly_vector(poly) = depth(poly) > 3;

module poly2d(poly) {
  if (is_poly_vector(poly))
    for (p = poly) polygon(points=p[0], paths=p[1]);
  else {
    if (depth(poly) == 2)
      polygon(poly);
    else
      polygon(points=poly[0], paths=poly[1]);
  }
}