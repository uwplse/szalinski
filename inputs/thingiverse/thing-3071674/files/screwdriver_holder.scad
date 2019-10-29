// Diameter of the holes
innerDiameter = 7.8;
// Thickness of the walls of the holes
walls = 3;
// Amount of holes
holes = 3;
// Spacing between the holes 
spacing = 13;
// Height of the bottom plate
height = 3.75;
// Padding to the back of the wall
paddingWall = 7; //13

// Diameter of the pegboard holes
holeDiameter = 3.75;
// Spacing between the holes
holeSpacing = 25;
// Thickness of the board itself (oversize this a bit)
thickness = 5;

// Tolerance betwwen the hook and the base plate
tolerance = 0.1;

/* [HIDDEN] */
innerRadius = innerDiameter / 2;
outerDiameter = innerDiameter + walls * 2;
outerRadius = outerDiameter / 2;
totalLength = (spacing + outerDiameter) * (holes - 1) + outerDiameter;
totalWidth = paddingWall + outerRadius;
paddingSide = (totalLength % holeSpacing) / 2;

hookLength = (paddingWall + walls - innerDiameter) / 2;//-3.75;
hookHeight = height / 2 - holeDiameter / 8;

holeRadius = holeDiameter / 2;
step = 15;

$fn = 10;

translate([totalLength / 2, 0, height])
rotate([180, 0, 180])
holder();

//totalWidth;

if(totalLength > holeSpacing) {
  translate([totalLength / 2 + thickness * 2, -outerDiameter / 2, holeDiameter / 2]) {
    rotate([180, 0, 90])
      hook(holeRadius);
  }
}

translate([-(totalLength / 2 + thickness * 2), -outerDiameter / 2, holeDiameter / 2]) {
  rotate([0, 0, 90])
    hook(holeRadius);
}


module holder() {
  $fn = 50;
  difference() {
    group() {
      cube([totalLength, outerRadius + paddingWall, height]);
      for(a=[0:holes - 1]) {
        translate([outerRadius + (outerDiameter + spacing)  * a, 0, 0])
          cylinder(r = outerRadius, h = height);
      }
    }
    for(a=[0:holes - 1]) {
      translate([outerRadius + (outerDiameter + spacing)  * a, 0, -1])
        cylinder(r = innerRadius, h = height + 2);
    }

    translate([paddingSide, thickness + totalWidth - holeDiameter / 2, 0])
      rotate([180, 270, 0])
        hook(holeRadius + tolerance);

    translate([totalLength - paddingSide, thickness + totalWidth - holeDiameter / 2, 0])
      rotate([180, 270, 0])
        hook(holeRadius + tolerance);
    
    translate([paddingSide - tolerance - holeRadius, totalWidth - holeRadius, -1])
      cube([holeDiameter + tolerance * 2, holeDiameter + tolerance * 2, height + 2]);
    
    translate([totalLength - paddingSide - tolerance - holeRadius, totalWidth - holeRadius, -1])
      cube([holeDiameter + tolerance * 2, holeDiameter + tolerance * 2, height + 2]);
  }
}

module hook(holeRadius) {
  $fn = 10;
  hull() {
      sphere(r = holeRadius);
      translate([0, hookLength + thickness + holeDiameter, 0])
          sphere(r = holeRadius);
  }

  translate([0, hookLength + thickness + holeDiameter, 0]) {
      hull() {
          sphere(r = holeRadius);
          translate([hookHeight, 0, 0])
              sphere(r = holeRadius);
      }
  }

  translate([holeSpacing, thickness * 1 / 3, 0]) {
      hull() {
      sphere(r = holeRadius);
      translate([0, thickness * 2 / 3, 0])
          sphere(r = holeRadius);
      }
  }

  translate([holeSpacing + thickness, thickness * 1 / 3, 0]) {
      for(a = [step:step:(90)]) {  
          hull() {
              rotate([0, 0, 180 - a])
                  translate([0, thickness, 0])
                      sphere(r = holeRadius);
              rotate([0, 0, 180 - a + step])
                  translate([0, thickness, 0])
                      sphere(r = holeRadius);
          }
      }
  }

  translate([0, thickness, 0]) {
      hull() {
          sphere(r = holeRadius);
          translate([holeSpacing, 0, 0])
              sphere(r = holeRadius);
      }
  }
}