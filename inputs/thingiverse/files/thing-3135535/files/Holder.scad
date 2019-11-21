// What is the greatest inside dimension?
MaxInsideDimension = 85; // [60:120]

// How thick should the outer walls be?
WallThickness = 3; // [2,3,4,5]

// Does the box have a bottom?
HasBottom = "yes"; // [yes,no]

// Bottom hole size (as percentage)
HoleSize = 66; // [0,33,66]

// Define the mounting hardware
// To eliminate the chamfer set Head Diameter <= Shank Diameter
ScrewHeadDiameter = 8.5; // [2,2.5,3,3.5,4,4.5,5,5.5,6,6.5,7,7.5,8,8.5,9,9.5,10]
ScrewShankDiameter = 5; // [2,2.5,3,3.5,4,4.5,5,5.5,6]

/* [Hidden] */

// Global curve smoothing
$fn = 120;

// library https://github.com/SolidCode/MCAD
include <MCAD/boxes.scad>

// Calc the minimum mounting support thickness
// add 1mm recess for 90deg screw head chamfer
// add 1mm minimum shank depth
MountThickness = max((.5 * ScrewHeadDiameter), WallThickness) + 2;

/*
    Module to create a mounting hole object
*/
module createMountingHole(){
  
  // create the recessed chamfer
  translate([0, 0, 1])
  cylinder(
    h = MountThickness,
    d1 = ScrewHeadDiameter,
    d2 = 0,
    center = true
  );
  
  // create the recess
  translate([0, 0, -.5 * (MountThickness - 1)])
  cylinder(
    h = 1.001,
    d = ScrewHeadDiameter,
    center = true
  );
    
  // create the shank bore
  cylinder(
    h = MountThickness + .001,
    d = ScrewShankDiameter,
    center = true
  );
}


/*
    Module to create the ring object
*/
module createHolder(){
  difference(){
    
    // Calc box dimensions
    innerX = MaxInsideDimension;
    innerY = innerX; // depth = width
    innerZ = innerX * .33; // height = 1/3 width

    inner = [ // Set inner box dimensions
      innerX,
      innerY,
      HasBottom == "yes" ? innerZ : innerZ + (2 * WallThickness)
    ];

    outer = [ // Set outer box dimensions
      innerX + (2 * WallThickness),
      innerY + WallThickness + MountThickness,
      innerZ + WallThickness
    ];
    
    // Set outer wall corner radius
    cornerRadius = 2;
    
    // make the outer box
    translate([
      0,
      .5 * (MountThickness - WallThickness),
      0
    ])
    roundedBox(
      size = outer,
      radius = cornerRadius,
      sidesonly = true
    );
    
    // remove the inner box
    translate([
      0,
      0,
      .5 * WallThickness + .001
    ])
    roundedBox(
      size = inner,
      radius = cornerRadius,
      sidesonly = true
    );
    
    // Chamfer the upper lip
    translate([
      0,
      0,
      2 * (innerZ + WallThickness)
    ]){
      polyX = innerX + (2 * WallThickness);
      rotate([180, 0, 0])
      difference(){
        polyhedron(
          points=[
            // the four base points
            [polyX, polyX, 0],
            [polyX, -polyX - MountThickness, 0],
            [-polyX, -polyX - MountThickness, 0],
            [-polyX, polyX, 0],
            // the apex point 
            [0,0,polyX]
          ],
          faces=[
            // each triangle side
            [0,1,4],[1,2,4],[2,3,4],[3,0,4],
            // two triangles for square base
            [1,0,3],[2,1,3]
          ]
        );
          cube([
            innerX/2,
            innerY/2,
            10*innerZ], // oversize the cutout
            center = true
          );
      }
    }
    
    // create the mounting holes
    translate([
      -.25 * innerX,
      .5 * (innerY + MountThickness),
      .25 * (innerZ / 2)
    ]){
      rotate([-90, 0, 0])
      createMountingHole();
    }
    translate([
      .25 * innerX,
      .5 * (innerY + MountThickness),
      .25 * (innerZ / 2)
    ]){
      rotate([-90, 0, 0])
      createMountingHole();
    }
    
    // remove material from bottom
    cylinder(
      2 * innerZ, // oversize the height
      d = innerX * (HoleSize / 100), // remove % of bottom
      center = true
    );
    
  }
}


/*
    Make it.
*/
createHolder();
